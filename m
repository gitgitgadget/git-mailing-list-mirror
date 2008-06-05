From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] blame: show "previous" information in
 --porcelain/--incremental format
Date: Wed, 04 Jun 2008 23:09:46 -0700
Message-ID: <7v4p884dlh.fsf_-_@gitster.siamese.dyndns.org>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com>
 <200806032331.44514.jnareb@gmail.com>
 <7v3ant213k.fsf@gitster.siamese.dyndns.org>
 <200806041603.49555.jnareb@gmail.com>
 <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:10:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K48gc-0007IV-21
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 08:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYFEGKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 02:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYFEGKE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 02:10:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbYFEGKC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 02:10:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2496A3E2B;
	Thu,  5 Jun 2008 02:10:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9DD9A3DFA; Thu,  5 Jun 2008 02:09:53 -0400 (EDT)
In-Reply-To: <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Jun 2008 23:07:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 077A7996-32C6-11DD-8469-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83863>

When the final blame is laid for a line to a <commit, path> pair, it also
gives a "previous" information to --porcelain and --incremental output
format.  It gives the parent commit of the blamed commit, _and_ a path in
that parent commit that corresponds to the blamed path --- in short, it is
the origin that would have been blamed (or passed blame through) for the
line _if_ the blamed commit did not change that line.

This unfortunately makes sanity checking of refcount quite complex, so I
ripped it out for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c |   42 ++++++++++++------------------------------
 1 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 4b9c601..a46e402 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -82,6 +82,7 @@ static unsigned blame_copy_score;
  */
 struct origin {
 	int refcnt;
+	struct origin *previous;
 	struct commit *commit;
 	mmfile_t file;
 	unsigned char blob_sha1[20];
@@ -123,6 +124,8 @@ static inline struct origin *origin_incref(struct origin *o)
 static void origin_decref(struct origin *o)
 {
 	if (o && --o->refcnt <= 0) {
+		if (o->previous)
+			origin_decref(o->previous);
 		free(o->file.ptr);
 		free(o);
 	}
@@ -1280,6 +1283,10 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		struct origin *porigin = sg_origin[i];
 		if (!porigin)
 			continue;
+		if (!origin->previous) {
+			origin_incref(porigin);
+			origin->previous = porigin;
+		}
 		if (pass_blame_to_parent(sb, origin, porigin))
 			goto finish;
 	}
@@ -1503,6 +1510,11 @@ static int emit_one_suspect_detail(struct origin *suspect)
 	printf("summary %s\n", ci.summary);
 	if (suspect->commit->object.flags & UNINTERESTING)
 		printf("boundary\n");
+	if (suspect->previous) {
+		struct origin *prev = suspect->previous;
+		printf("previous %s ", sha1_to_hex(prev->commit->object.sha1));
+		write_name_quoted(prev->path, stdout, '\n');
+	}
 	return 1;
 }
 
@@ -1866,36 +1878,6 @@ static void sanity_check_refcnt(struct scoreboard *sb)
 			baa = 1;
 		}
 	}
-	for (ent = sb->ent; ent; ent = ent->next) {
-		/* Mark the ones that haven't been checked */
-		if (0 < ent->suspect->refcnt)
-			ent->suspect->refcnt = -ent->suspect->refcnt;
-	}
-	for (ent = sb->ent; ent; ent = ent->next) {
-		/*
-		 * ... then pick each and see if they have the the
-		 * correct refcnt.
-		 */
-		int found;
-		struct blame_entry *e;
-		struct origin *suspect = ent->suspect;
-
-		if (0 < suspect->refcnt)
-			continue;
-		suspect->refcnt = -suspect->refcnt; /* Unmark */
-		for (found = 0, e = sb->ent; e; e = e->next) {
-			if (e->suspect != suspect)
-				continue;
-			found++;
-		}
-		if (suspect->refcnt != found) {
-			fprintf(stderr, "%s in %s has refcnt %d, not %d\n",
-				ent->suspect->path,
-				sha1_to_hex(ent->suspect->commit->object.sha1),
-				ent->suspect->refcnt, found);
-			baa = 2;
-		}
-	}
 	if (baa) {
 		int opt = 0160;
 		find_alignment(sb, &opt);
-- 
1.5.6.rc1.12.g7f718
