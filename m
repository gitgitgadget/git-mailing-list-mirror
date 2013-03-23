From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Sat, 23 Mar 2013 19:57:30 +0100
Message-ID: <514DFB1A.8040102@lsrfire.ath.cx>
References: <20130322161837.GG3083@sigill.intra.peff.net> <20130322162155.GB25857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 23 19:58:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJTdr-0004T1-MV
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 19:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab3CWS5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 14:57:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:50076 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab3CWS5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 14:57:43 -0400
Received: from [192.168.2.105] (p4FFDBB95.dip.t-dialin.net [79.253.187.149])
	by india601.server4you.de (Postfix) with ESMTPSA id 13615323;
	Sat, 23 Mar 2013 19:57:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130322162155.GB25857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218925>

Am 22.03.2013 17:21, schrieb Jeff King:
> Of the 8 patches, this is the one I find the least satisfying, if only
> because I do not think gcc's failure is because of complicated control
> flow, and rearranging the code would only hurt readability.

Hmm, let's see if we can help the compiler follow the code without
making it harder for people to understand.  The patch looks a bit
jumbled, but the resulting code is OK in my biased opinion.

-- >8 --
There are two ways we can spot missing entries, i.e. added or removed
files: By reaching the end of one of the trees while the other still
has entries, or in the middle of the two lists with base_name_compare().
Missing files are handled the same in either case, but the code is
duplicated.

Unify the handling by just setting cmp appropriately when running off
a tree instead of handling the case on the spot.  If both trees contain
entries, call base_name_compare() as usual.

This make the code slightly shorter, and also helps gcc 4.6 to
understand that none of the variables in the loop are used without
initialization.  Therefore we can remove the trick to initialize them
using themselves, which was used to squelch false warnings.

[Stolen from Jeff King:]
While we're in the area, let's also update the loop
condition to use logical-OR rather than bitwise-OR. They should
be equivalent in this case, and the use of the latter was
probably a typo.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 match-trees.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 26f7ed1..c0c66bb 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -71,34 +71,26 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
 	if (type != OBJ_TREE)
 		die("%s is not a tree", sha1_to_hex(hash2));
 	init_tree_desc(&two, two_buf, size);
-	while (one.size | two.size) {
-		const unsigned char *elem1 = elem1;
-		const unsigned char *elem2 = elem2;
-		const char *path1 = path1;
-		const char *path2 = path2;
-		unsigned mode1 = mode1;
-		unsigned mode2 = mode2;
-		int cmp;
+	while (one.size || two.size) {
+		const unsigned char *elem1, *elem2;
+		const char *path1, *path2;
+		unsigned mode1, mode2;
+		int cmp = 0;
 
 		if (one.size)
 			elem1 = tree_entry_extract(&one, &path1, &mode1);
+		else
+			/* two has more entries */
+			cmp = 1;
 		if (two.size)
 			elem2 = tree_entry_extract(&two, &path2, &mode2);
-
-		if (!one.size) {
-			/* two has more entries */
-			score += score_missing(mode2, path2);
-			update_tree_entry(&two);
-			continue;
-		}
-		if (!two.size) {
+		else
 			/* two lacks this entry */
-			score += score_missing(mode1, path1);
-			update_tree_entry(&one);
-			continue;
-		}
-		cmp = base_name_compare(path1, strlen(path1), mode1,
-					path2, strlen(path2), mode2);
+			cmp = -1;
+
+		if (!cmp)
+			cmp = base_name_compare(path1, strlen(path1), mode1,
+						path2, strlen(path2), mode2);
 		if (cmp < 0) {
 			/* path1 does not appear in two */
 			score += score_missing(mode1, path1);
-- 
1.8.2
