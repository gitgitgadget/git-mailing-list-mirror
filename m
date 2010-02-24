From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v2 1/4] apply: Remove the quick rejection test
Date: Wed, 24 Feb 2010 20:24:11 +0100
Message-ID: <4B857CDB.3070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 20:24:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMqK-0007ES-P1
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667Ab0BXTYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 14:24:16 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:63598 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757640Ab0BXTYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:24:15 -0500
Received: by ey-out-2122.google.com with SMTP id 25so25818eya.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 11:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=sYoETukcy3+SVw+psNTxG9/BXoAmyZqW7BbxQQoALuY=;
        b=t2C6iz+ZvRBaBNGzIPjMJtLDnmmkbvFidb0KcafiaCEfXZy+Mv07d1QOHTAYCScb1m
         CCarQrT1E5QpZLAB9KSIzmQF4oqv7AKooO85kZUMRgytD7RNxYbc1Wf9Q1wxQcSFlN3v
         XvpaVNXRBlJUTuv/zaGro3lFb7UXAtQziLYbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=xTVw+NLUk5rldkB4eAYo1yisYBfR3MP9CMZj+SCNWhEvs5P64/Xe4pOtCPF0S2r7hN
         y6PaST0JLBIL3ZEVHOiRcLpiL68Sm2JoF25Ka2k1dqQGVTQIV+6QxEdUeKdS++YqybwL
         Jmxw39hKVTxDlr59Wti8x8/oq3TSzBy2aZdfI=
Received: by 10.213.107.143 with SMTP id b15mr157630ebp.72.1267039453501;
        Wed, 24 Feb 2010 11:24:13 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm277413eyf.11.2010.02.24.11.24.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 11:24:13 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140974>

In the next commit, we will make it possible for blank context
lines to match beyond of the file. That means that a hunk with
a preimage that has more lines than present in the file may
be possible to successfully apply. Therefore, we must remove
the quick rejection test in find_pos().

find_pos() will already work correctly without the quick
rejection test, but that might not be obvious. Therefore,
comment the test for handling out-of-range line numbers in
find_pos() and cast the "line" variable to the same (unsigned)
type as img->nr.

What are performance implications of removing the quick
rejection test?

It can only help "git apply" to reject a patch faster. For example,
if I have a file with one million lines and a patch that removes
slightly more than 50 percent of the lines and try to apply that
patch twice, the second attempt will fail slightly faster
with the test than without (based on actual measurements).

However, there is the pathological case of a patch with many
more context lines than the default three, and applying that patch
using "git apply -C1". Without the rejection test, the running
time will be roughly proportional to the number of context lines
times the size of the file. That could be handled by writing
a more complicated rejection test (it would have to count the
number of blanks at the end of the preimage), but I don't find
that worth doing until there is a real-world use case that
would benfit from it.

It would be possible to keep the quick rejection test if
--whitespace=3Dfix is not given, but I don't like that from
a testing point of view.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-apply.c           |   11 ++++++-----
 t/t4104-apply-boundary.sh |    9 +++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2a1004d..e1f849d 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2002,11 +2002,8 @@ static int find_pos(struct image *img,
 	unsigned long backwards, forwards, try;
 	int backwards_lno, forwards_lno, try_lno;
=20
-	if (preimage->nr > img->nr)
-		return -1;
-
 	/*
-	 * If match_begining or match_end is specified, there is no
+	 * If match_beginning or match_end is specified, there is no
 	 * point starting from a wrong line that will never match and
 	 * wander around and wait for a match at the specified end.
 	 */
@@ -2015,7 +2012,11 @@ static int find_pos(struct image *img,
 	else if (match_end)
 		line =3D img->nr - preimage->nr;
=20
-	if (line > img->nr)
+	/*
+	 * Because the comparison is unsigned, the following test
+	 * will also take care of a negative line number.
+	 */
+	if ((size_t) line > img->nr)
 		line =3D img->nr;
=20
 	try =3D 0;
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 0e3ce36..1a74248 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -134,4 +134,13 @@ test_expect_success 'two lines' '
=20
 '
=20
+test_expect_success 'apply patch with 3 context lines matching at end'=
 '
+	{ echo a; echo b; echo c; echo d; } >file &&
+	git add file &&
+	echo e >>file &&
+	git diff >patch &&
+	>file &&=09
+	test_must_fail git apply patch
+'
+
 test_done
--=20
1.7.0
