From: Johan Herland <johan@herland.net>
Subject: [PATCH 07/15] git-note: (Almost plumbing) Add support for git notes to
 git-pack-refs and git-fsck
Date: Sun, 27 May 2007 16:13:36 +0200
Message-ID: <200705271613.36648.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJVP-0007Fu-58
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbXE0ONy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbXE0ONy
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:13:54 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50085 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697AbXE0ONx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:13:53 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP0000HE74B200@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:13:52 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP0001AE6P7F00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:13:37 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00008E6OJ760@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:13:37 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48547>

Teach git-pack-refs to pack note refs in the same way that regular
tag refs are packed. Also, make sure to clean up empty subdirs in
refs/notes after packing note refs.

Teach git-fsck some extra checking of note refs.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-fsck.c      |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin-pack-refs.c |    5 +++-
 2 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cbbcaf0..edbb976 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -522,9 +522,70 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 	return 0;
 }
 
+static int fsck_handle_note_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	/*
+	 * - Verify that refname has format $object/$note
+	 * - Verify that contents of $object/$note == $note
+	 * - Verify that $object/$note references a tag object
+	 * - Verify that the tag object points to $object
+	 * - Verify that $object exists. (already done by fsck_tag())
+	 */
+	 /* Even on error, we still return 0 to keep for_each_ref() going. */
+
+	const char *object_name = refname;
+	const char *note_name = strchr(object_name, '/');
+	size_t object_name_len, note_name_len;
+	unsigned char object_sha1[20], note_sha1[20];
+	struct object *note_obj;
+	struct tag *note;
+
+	if (!note_name) {
+		error("%s: invalid note refname; missing note part", refname);
+		return 0;
+	}
+	object_name_len = note_name - object_name;
+	note_name_len = strlen(++note_name);
+	if (object_name_len != 40 || get_sha1_hex(object_name, object_sha1)) {
+		error("%s: invalid note refname; object part not valid SHA1 sum", refname);
+		return 0;
+	}
+	if (note_name_len != 40 || get_sha1_hex(note_name, note_sha1)) {
+		error("%s: invalid note refname; note part not valid SHA1 sum", refname);
+		return 0;
+	}
+	if (hashcmp(note_sha1, sha1)) {
+		error("%s: invalid note ref; note part not identical to note's SHA1 sum (%s)",
+			refname, sha1_to_hex(sha1));
+		return 0;
+	}
+	note_obj = lookup_object(sha1);
+	if (!note_obj) { /* Couldn't find note object... */
+		if (!has_sha1_file(sha1)) /* ...and it's not hidden in a pack */
+			error("%s: invalid note ref; must point at a valid object",
+				refname);
+		return 0; /* Return even if in a pack. */
+	}
+	if (note_obj->type != OBJ_TAG) {
+		error("%s: invalid note ref; must point at tag object (type == %s)",
+			refname, typename(note_obj->type));
+		return 0;
+	}
+	note = (struct tag *) parse_object(sha1);
+	if (hashcmp(note->tagged->sha1, object_sha1)) {
+		error("%s: invalid note ref; "
+			"object part not identical to tagged object (%s)",
+			refname, sha1_to_hex(note->tagged->sha1));
+		return 0;
+	}
+
+	return 0;
+}
+
 static void get_default_heads(void)
 {
 	for_each_ref(fsck_handle_ref, NULL);
+	for_each_note_ref(fsck_handle_note_ref, NULL);
 	if (include_reflogs)
 		for_each_reflog(fsck_handle_reflog, NULL);
 
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 1952950..57b9fee 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -39,6 +39,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 	if ((flags & REF_ISSYMREF))
 		return 0;
 	is_tag_ref = !prefixcmp(path, "refs/tags/");
+	is_tag_ref |= !prefixcmp(path, "refs/notes/");
 
 	/* ALWAYS pack refs that were already packed or are tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
@@ -109,8 +110,10 @@ static int pack_refs(unsigned int flags)
 		die("failed to write ref-pack file (%s)", strerror(errno));
 	if (commit_lock_file(&packed) < 0)
 		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
-	if (cbdata.flags & PACK_REFS_PRUNE)
+	if (cbdata.flags & PACK_REFS_PRUNE) {
 		prune_refs(cbdata.ref_to_prune);
+		cleanup_notes_subdirs();
+	}
 	return 0;
 }
 
-- 
1.5.2.101.gee49f
