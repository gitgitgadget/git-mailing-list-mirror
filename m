From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH 7/7 (v5)] graft awareness
Date: Mon, 05 Apr 2010 20:58:51 +0100
Message-ID: <4BBA40FB.6040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail
X-From: git-owner@vger.kernel.org Mon Apr 05 21:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NysRj-0001h7-1B
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab0DET6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:58:53 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:33419 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412Ab0DET6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:58:51 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so121824ewy.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=PPMT5mE/k/OClUuvrA2SNVfxKYx3eZiclIswnwOXExE=;
        b=E+NTf1Mcly4wb+yKOSrgjzGfJqkAD0CobtIxNlab375ZxdGVmQYVQQ7SQhitdO3if/
         Dpi0VQUSAUWB2PaYUyR1AJBHPw/u3wmqGkqhksPLM/SujyOzWw4WuoDobEJGqYWet9fL
         edwZCPJJ1Nix9X9j145i0dMW/CTOq7mzSFkFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=XYY1VtcmodrrNYp+SqeCQANSHz+I7ZrhJXpl26HhdKy2kxkjZJzlonz5i9ucCkQbgG
         cn5L9f7uBgNG9yRAujehIYPdeqLcPqUi4Y8GgRd+2NSV5r7bf8ulfGxxObptN0Wv1QGQ
         5/HuUN/MVfPU6z8DNOSUX1qyH5CjQdmw0WpC8=
Received: by 10.213.42.78 with SMTP id r14mr3265691ebe.11.1270497531161;
        Mon, 05 Apr 2010 12:58:51 -0700 (PDT)
Received: from [192.168.55.86] (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 13sm6452019ewy.13.2010.04.05.12.58.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 12:58:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144065>

Adds support for graft commits in rev-cache (w/ test), and slightly alters
graft mechanism.  Before, parse_commit() checked the graft list on every
commit.  Now register_commit_graft() preemptively loads graft commits into
memory, and sets a new 'graft' flag in the object.  This allows awareness of
the commits' medical history without searching a (normally private) array upon
each commit.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 builtin/rev-cache.c       |   14 ++++++++++++--
 commit.c                  |   34 +++++++++++++++++++++++++++++++---
 object.h                  |    3 ++-
 rev-cache.c               |   32 ++++++++++++++++++++++++++++++++
 t/t6019-rev-cache-list.sh |    7 +++++++
 5 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/builtin/rev-cache.c b/builtin/rev-cache.c
index 59fc833..404e48c 100644
--- a/builtin/rev-cache.c
+++ b/builtin/rev-cache.c
@@ -102,8 +102,18 @@ static int test_rev_list(int argc, const char *argv[])
 			flags ^= UNINTERESTING;
 		else if (!strcmp(argv[i], "--objects"))
 			revs.tree_objects = revs.blob_objects = 1;
-		else
-			handle_revision_arg(argv[i], &revs, flags, 1);
+		else {
+			struct commit_graft graft;
+
+			if (argv[i][0] == ':') {
+				handle_revision_arg(argv[i] + 1, &revs, flags, 1);
+
+				hashcpy(graft.sha1, revs.pending.objects[revs.pending.nr - 1].item->sha1);
+				graft.nr_parent = -1;
+				register_commit_graft(&graft, 0);
+			} else
+				handle_revision_arg(argv[i], &revs, flags, 1);
+		}
 	}
 
 	setup_revisions(0, 0, &revs, 0);
diff --git a/commit.c b/commit.c
index 263dd74..23f3bb9 100644
--- a/commit.c
+++ b/commit.c
@@ -100,6 +100,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
+	struct commit *commit;
 	int pos = commit_graft_pos(graft->sha1);
 
 	if (0 <= pos) {
@@ -124,6 +125,17 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 			(commit_graft_nr - pos - 1) *
 			sizeof(*commit_graft));
 	commit_graft[pos] = graft;
+
+	commit = lookup_commit(graft->sha1);
+	commit->object.graft = 1;
+	if (commit->object.parsed) {
+		/* we don't want to call this from a parse_commit(), but
+		 * we should ensure commit's parents are "correct"
+		 */
+		commit->object.parsed = 0;
+		parse_commit(commit);
+	}
+
 	return 0;
 }
 
@@ -220,6 +232,7 @@ int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
 
 int unregister_shallow(const unsigned char *sha1)
 {
+	struct commit *commit;
 	int pos = commit_graft_pos(sha1);
 	if (pos < 0)
 		return -1;
@@ -228,6 +241,12 @@ int unregister_shallow(const unsigned char *sha1)
 				sizeof(struct commit_graft *)
 				* (commit_graft_nr - pos - 1));
 	commit_graft_nr--;
+
+	commit = lookup_commit(sha1);
+	commit->object.graft = 0;
+	commit->object.parsed = 0;
+	parse_commit(commit);
+
 	return 0;
 }
 
@@ -241,7 +260,6 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 
 	if (item->object.parsed)
 		return 0;
-	item->object.parsed = 1;
 	tail += size;
 	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
@@ -254,7 +272,13 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	while (pop_commit(pptr))
 		; /* clear anything from cache */
 
-	graft = lookup_commit_graft(item->object.sha1);
+	/* make sure .graft flag is initialized */
+	prepare_commit_graft();
+	if (item->object.graft)
+		graft = lookup_commit_graft(item->object.sha1);
+	else
+		graft = 0;
+
 	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
@@ -282,8 +306,12 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 		}
-	}
+		item->object.graft = 1;
+	} else
+		item->object.graft = 0;
+
 	item->date = parse_commit_date(bufptr, tail);
+	item->object.parsed = 1;
 
 	return 0;
 }
diff --git a/object.h b/object.h
index 82877c8..8123824 100644
--- a/object.h
+++ b/object.h
@@ -22,7 +22,7 @@ struct object_array {
 };
 
 #define TYPE_BITS   3
-#define FLAG_BITS  27
+#define FLAG_BITS  26
 
 /*
  * The object type is stored in 3 bits.
@@ -30,6 +30,7 @@ struct object_array {
 struct object {
 	unsigned parsed : 1;
 	unsigned used : 1;
+	unsigned graft : 1;
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
 	unsigned char sha1[20];
diff --git a/rev-cache.c b/rev-cache.c
index 4f1ea34..dfb3212 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -754,9 +754,41 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
 			}
 		} else if (!ipath_nr && co->date <= date)
 			slop--;
+		else if (!ipath_nr && !upath_nr)
+			break;
 		else
 			slop = SLOP;
 
+		/* before opening further topo-relations, check if the parenting has had medical attention */
+		if (obj->graft) {
+			struct commit_list *list;
+
+			parse_commit(co);
+			obj->flags &= ~FACE_VALUE;
+			last_objects[path] = 0;
+
+			/* we're only interested in its indirect influence */
+			for (list = co->parents; list; list = list->next) {
+				struct rc_index_entry *iep;
+				struct object *po = &list->item->object;
+
+				iep = search_index(po->sha1);
+				if (!iep || hashcmp(idx_caches + 20 * iep->cache_index, head->sha1)) {
+					if (!(obj->flags & UNINTERESTING) && !(po->flags & UNINTERESTING))
+						ioutside = 1;
+				}
+			}
+
+			/* an abrupt end */
+			myworkp = &commit_list_insert(co, myworkp)->next;
+			if (uninteresting)
+				upath_nr--;
+			else
+				ipath_nr--;
+			paths[path] = 0;
+			continue;
+		}
+
 		/* open parents */
 		if (entry->merge_nr) {
 			int j, off = index + OBJECT_ENTRY_SIZE;
diff --git a/t/t6019-rev-cache-list.sh b/t/t6019-rev-cache-list.sh
index b7eff3f..5664de7 100644
--- a/t/t6019-rev-cache-list.sh
+++ b/t/t6019-rev-cache-list.sh
@@ -92,6 +92,7 @@ git rev-list --topo-order HEAD --not HEAD~2 >proper_commit_list_limited2
 git rev-list --topo-order HEAD >proper_commit_list
 git rev-list --objects HEAD >proper_object_list
 git rev-list HEAD --max-age=$min_date --min-age=$max_date >proper_list_date_limited
+git rev-cache test HEAD :HEAD~2 >proper_shallow_list 2>/dev/null
 
 cache_sha1=`git rev-cache add HEAD 2>output.err`
 
@@ -252,5 +253,11 @@ test_expect_success 'test --ignore-size function in fuse' '
 	test -e .git/rev-cache/$cache_sha1
 '
 
+#test graft handling
+test_expect_success 'check graft handling' '
+	git rev-cache test HEAD :HEAD~2 >list
+	test_cmp list proper_shallow_list
+'
+
 test_done
 
-- 
tg: (68204ac..) t/rc/graft (depends on: t/rc/names)
