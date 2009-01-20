From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] Rename detection: Avoid repeated filespec population
Date: Tue, 20 Jan 2009 16:59:57 +0100
Message-ID: <20090120155957.GA23237@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJ2u-0001rh-2v
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbZATQAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 11:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755294AbZATQAJ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:00:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:37512 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754967AbZATQAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 11:00:08 -0500
Received: (qmail invoked by alias); 20 Jan 2009 16:00:04 -0000
Received: from i577BBE4F.versanet.de (EHLO atjola.local) [87.123.190.79]
  by mail.gmx.net (mp045) with SMTP; 20 Jan 2009 17:00:04 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19NpoxPs1NN2n66IKH0cRLvKaXvXC0Ly4ZVof2zl9
	+5bmYE1Q6G0sbl
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In diffcore_rename, we assume that the blob contents in the filespec
aren't required anymore after estimate_similarity has been called and t=
hus
we free it. But estimate_similarity might return early when the file si=
zes
differ too much. In that case, cnt_data is never set and the next call =
to
estimate_similarity will populate the filespec again, eventually reread=
ing
the same blob over and over again.

To fix that, we first get the blob sizes and only when the blob content=
s
are actually required, and when cnt_data will be set, the full filespec=
 is
populated, once.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
This actually affects the copy detection way more than the pure
rename detection, due to the larger number of candidates, but it's the
same code, and I only realized that when I reran the stuff to get some
numbers to show off. ;-)

Test with linux-2.6.git and hot caches:
git diff-tree -p db30c705758^2..db30c705758

	| unpatched | patched
------------------------------
plain	|        3s |     3s
-M	|        4s |     3s
-C	|    2m 25s |     9s
-C -C	|    4m 30s |    24s


 diffcore-rename.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 168a95b..0b0d6b8 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -153,9 +153,9 @@ static int estimate_similarity(struct diff_filespec=
 *src,
 	 * is a possible size - we really should have a flag to
 	 * say whether the size is valid or not!)
 	 */
-	if (!src->cnt_data && diff_populate_filespec(src, 0))
+	if (!src->cnt_data && diff_populate_filespec(src, 1))
 		return 0;
-	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
+	if (!dst->cnt_data && diff_populate_filespec(dst, 1))
 		return 0;
=20
 	max_size =3D ((src->size > dst->size) ? src->size : dst->size);
@@ -173,6 +173,11 @@ static int estimate_similarity(struct diff_filespe=
c *src,
 	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
=20
+	if (!src->cnt_data && diff_populate_filespec(src, 0))
+		return 0;
+	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
+		return 0;
+
 	delta_limit =3D (unsigned long)
 		(base_size * (MAX_SCORE-minimum_score) / MAX_SCORE);
 	if (diffcore_count_changes(src, dst,
--=20
1.6.1.135.g3cf3b
