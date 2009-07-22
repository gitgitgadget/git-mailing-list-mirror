From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] combine-diff.c: fix performance problem when folding
 common deleted lines
Date: Wed, 22 Jul 2009 14:48:28 -0700
Message-ID: <1248299309-10579-2-git-send-email-gitster@pobox.com>
References: <1248299309-10579-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjg5-0006GE-8Q
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbZGVVsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 17:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbZGVVse
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:48:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbZGVVsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:48:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 65064E18E
	for <git@vger.kernel.org>; Wed, 22 Jul 2009 17:48:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B7B82E18D for
 <git@vger.kernel.org>; Wed, 22 Jul 2009 17:48:32 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.rc1.10.g2a679
In-Reply-To: <1248299309-10579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 66FAC348-7709-11DE-B6EA-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123787>

=46or a deleted line in a patch with the parent we are looking at, the
append_lost() function finds the same line among a run of lines that we=
re
deleted from the same location by patches from parents we previously
checked.  This is so that patches with two parents

    @@ -1,4 +1,3 @@    @@ -1,4 +1,3 @@
     one                   one
    -two                  -two
     three                 three
    -quatro               -fyra
    +four                 +four

can be coalesced into this sequence, reusing one line that describes th=
e
removal of "two" for both parents.

   @@@ -1,4 -1,4 +1,3 @@@
     one
   --two
     three
   - quatro
    -frya
   ++four

While reading the second patch (that removes "two" and then "fyra"), af=
ter
finding where removal of the "two" matches, we need to find existing
removal of "fyra" (if exists) in the removal list, but the match has to
happen after all the existing matches (in this case "two").  The code u=
sed
a na=C3=AFve O(n^2) algorithm to compute this by scanning the whole rem=
oval
list over and over again.

This patch remembers where the next scan should be started in the exist=
ing
removal list to avoid this.

Noticed by Linus Torvalds.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 combine-diff.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 60d0367..b82f46c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -80,6 +80,7 @@ struct lline {
 /* Lines surviving in the merge result */
 struct sline {
 	struct lline *lost_head, **lost_tail;
+	struct lline *next_lost;
 	char *bol;
 	int len;
 	/* bit 0 up to (N-1) are on if the parent has this line (i.e.
@@ -121,18 +122,12 @@ static void append_lost(struct sline *sline, int =
n, const char *line, int len)
=20
 	/* Check to see if we can squash things */
 	if (sline->lost_head) {
-		struct lline *last_one =3D NULL;
-		/* We cannot squash it with earlier one */
-		for (lline =3D sline->lost_head;
-		     lline;
-		     lline =3D lline->next)
-			if (lline->parent_map & this_mask)
-				last_one =3D lline;
-		lline =3D last_one ? last_one->next : sline->lost_head;
+		lline =3D sline->next_lost;
 		while (lline) {
 			if (lline->len =3D=3D len &&
 			    !memcmp(lline->line, line, len)) {
 				lline->parent_map |=3D this_mask;
+				sline->next_lost =3D lline->next;
 				return;
 			}
 			lline =3D lline->next;
@@ -147,6 +142,7 @@ static void append_lost(struct sline *sline, int n,=
 const char *line, int len)
 	lline->line[len] =3D 0;
 	*sline->lost_tail =3D lline;
 	sline->lost_tail =3D &lline->next;
+	sline->next_lost =3D NULL;
 }
=20
 struct combine_diff_state {
@@ -187,6 +183,7 @@ static void consume_line(void *state_, char *line, =
unsigned long len)
 				xcalloc(state->num_parent,
 					sizeof(unsigned long));
 		state->sline[state->nb-1].p_lno[state->n] =3D state->ob;
+		state->lost_bucket->next_lost =3D state->lost_bucket->lost_head;
 		return;
 	}
 	if (!state->lost_bucket)
--=20
1.6.4.rc1.10.g2a679
