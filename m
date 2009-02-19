From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Really slow 'git gc'
Date: Thu, 19 Feb 2009 13:34:32 -0800
Message-ID: <7vk57mkt5j.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0902191200010.21686@localhost.localdomain>
 <7vr61uku2f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 22:36:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaGZ3-0005KW-Pu
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755AbZBSVel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756638AbZBSVek
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:34:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbZBSVej (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 16:34:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D568E2B7F3;
	Thu, 19 Feb 2009 16:34:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D99BA2B7E7; Thu,
 19 Feb 2009 16:34:33 -0500 (EST)
In-Reply-To: <7vr61uku2f.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 19 Feb 2009 13:14:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1B2A7CA6-FECD-11DD-A0D7-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110760>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> The real reason _seems_ to be the "--unpacked=pack-....pack" arguments. I 
>> literally had 232 pack-files, and it looks like a lot of the time was 
>> spent in that silly loop oer 'ignore_packed' in find_pack_entry(), when 
>> revision.c does that "has_sha1_pack()" thing. You get a O(n**2) effect in 
>> number of pack-files: for each commit we look over every pack-file, and 
>> for every pack-file we look at, we look over each ignore_pack entry.
>
> I think we can add a single bit to "struct packed_git" and in the middle
> of setup_revisions() perform the O(N**2) once, so that find_pack_entry()
> can check the bit without looping.

Roughly like this, although we probably should change the API because most
of the callers pass NULL to it.  Also we may need a way to say "I am done
with ignoring, please clear the pack_ignore bits from all of them" API.

---

 cache.h     |    4 +++-
 revision.c  |    2 ++
 sha1_file.c |   31 +++++++++++++++++++++++--------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 37dfb1c..7e8c008 100644
--- a/cache.h
+++ b/cache.h
@@ -759,7 +759,8 @@ extern struct packed_git {
 	time_t mtime;
 	int pack_fd;
 	unsigned pack_local:1,
-		 pack_keep:1;
+		 pack_keep:1,
+		 pack_ignore:1;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
@@ -817,6 +818,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1);
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
+extern void mark_ignore_packed(const char **);
 
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
diff --git a/revision.c b/revision.c
index 286e416..86f80da 100644
--- a/revision.c
+++ b/revision.c
@@ -1342,6 +1342,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		object = get_reference(revs, revs->def, sha1, 0);
 		add_pending_object_with_mode(revs, object, revs->def, mode);
 	}
+	if (revs->ignore_packed)
+		mark_ignore_packed(revs->ignore_packed);
 
 	/* Did the user ask for any diff output? Run the diff! */
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
diff --git a/sha1_file.c b/sha1_file.c
index 5b6e0f6..4a804c7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1937,6 +1937,27 @@ int matches_pack_name(struct packed_git *p, const char *name)
 	return 0;
 }
 
+void mark_ignore_packed(const char **ignore_packed)
+{
+	struct packed_git *p;
+
+	if (!ignore_packed || !*ignore_packed)
+		return;
+
+	prepare_packed_git();
+	if (!packed_git)
+		return;
+
+	for (p = packed_git; p; p = p->next) {
+		const char **ig;
+		for (ig = ignore_packed; *ig; ig++)
+			if (matches_pack_name(p, *ig)) {
+				p->pack_ignore = 1;
+				break;
+			}
+	}
+}
+
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
 {
 	static struct packed_git *last_found = (void *)1;
@@ -1949,14 +1970,8 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 	p = (last_found == (void *)1) ? packed_git : last_found;
 
 	do {
-		if (ignore_packed) {
-			const char **ig;
-			for (ig = ignore_packed; *ig; ig++)
-				if (matches_pack_name(p, *ig))
-					break;
-			if (*ig)
-				goto next;
-		}
+		if (ignore_packed && p->pack_ignore)
+			goto next;
 
 		if (p->num_bad_objects) {
 			unsigned i;
