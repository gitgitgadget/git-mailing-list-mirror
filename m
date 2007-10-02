From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] for-each-ref: fix %(numparent) and %(parent)
Date: Tue, 02 Oct 2007 15:12:55 -0700
Message-ID: <7v8x6ljhco.fsf@gitster.siamese.dyndns.org>
References: <200710021202.42452.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 00:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icpzl-0006GW-F7
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 00:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbXJBWNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbXJBWNI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 18:13:08 -0400
Received: from rune.pobox.com ([208.210.124.79]:57540 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755505AbXJBWNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 18:13:06 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 31D4D1406E9;
	Tue,  2 Oct 2007 18:13:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 82B561403D9;
	Tue,  2 Oct 2007 18:13:19 -0400 (EDT)
In-Reply-To: <200710021202.42452.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 2 Oct 2007 12:02:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59749>

The string value of %(numparent) was not returned correctly.
Also %(parent) misbehaved for the root commits (returned garbage)
and merge commits (returned first parent, followed by a space).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I noticed this while playing with Andy's patch to enhance the
   date format string we saw recently on the list.

   Andy does not have anything to do with the breakage; this
   patch is against 'maint' to fix the bug that has always been
   there from the very beginning of this code.

 builtin-for-each-ref.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 0afa1c5..29f70aa 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -43,7 +43,7 @@ static struct {
 	{ "objectsize", FIELD_ULONG },
 	{ "objectname" },
 	{ "tree" },
-	{ "parent" }, /* NEEDSWORK: how to address 2nd and later parents? */
+	{ "parent" },
 	{ "numparent", FIELD_ULONG },
 	{ "object" },
 	{ "type" },
@@ -262,24 +262,26 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		}
 		if (!strcmp(name, "numparent")) {
 			char *s = xmalloc(40);
+			v->ul = num_parents(commit);
 			sprintf(s, "%lu", v->ul);
 			v->s = s;
-			v->ul = num_parents(commit);
 		}
 		else if (!strcmp(name, "parent")) {
 			int num = num_parents(commit);
 			int i;
 			struct commit_list *parents;
-			char *s = xmalloc(42 * num);
+			char *s = xmalloc(41 * num + 1);
 			v->s = s;
 			for (i = 0, parents = commit->parents;
 			     parents;
-			     parents = parents->next, i = i + 42) {
+			     parents = parents->next, i = i + 41) {
 				struct commit *parent = parents->item;
 				strcpy(s+i, sha1_to_hex(parent->object.sha1));
 				if (parents->next)
 					s[i+40] = ' ';
 			}
+			if (!i)
+				*s = '\0';
 		}
 	}
 }
-- 
1.5.3.3.1144.gf10f2
