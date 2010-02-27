From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v3 2/5] apply: Remove the quick rejection test
Date: Sat, 27 Feb 2010 14:52:08 +0100
Message-ID: <4B892388.6060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 14:52:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlN5e-0007A0-OR
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 14:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968347Ab0B0NwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 08:52:12 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:55312 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968320Ab0B0NwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 08:52:10 -0500
Received: by mail-ew0-f220.google.com with SMTP id 20so535804ewy.21
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 05:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Ow+c8E7KqxUKXeKFxvpChxfa4mCHGT33QfAF3d23p/o=;
        b=RdepaSN/pLs91jMeNCdUS+CjPfaJLBhLoddKpcg6F8BC5pntDusGopmO/dRx0C6JGN
         1sVuk4aBkGPWYZ7tvxcP7eFgWCOXmm6jXrmk7uUoU0Sdf9lrJo/YHH7T4M59iv0dfDRG
         ffnxCk5Pn9OyNmWMPCgUpfUwsjJ8FdbAbWtMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=iGT+Z6zklmCVFvTKqHDbEQofycqSrphYp0ZJqX9IAT53CsFV8Ki2N5YFKkzNQt2tmu
         QaAa/zzEjrlEzXdMUO9HidW7HchaFGbsTkyxYws3nMfEk0QEOaAa08m2EyB5Mt6uQS5V
         qGnPxtwF42k8XzKqZ1lOoWUV6eQ4R10PUeDD8=
Received: by 10.213.77.76 with SMTP id f12mr988757ebk.5.1267278729661;
        Sat, 27 Feb 2010 05:52:09 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm5015389eyf.19.2010.02.27.05.52.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 05:52:09 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141209>

In the next commit, we will make it possible for blank context
lines to match beyond the end of the file. That means that a hunk
with a preimage that has more lines than present in the file may
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
 builtin-apply.c           |   12 +++++++-----
 t/t4104-apply-boundary.sh |    9 +++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index fc6c708..9641a64 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1997,11 +1997,8 @@ static int find_pos(struct image *img,
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
@@ -2010,7 +2007,12 @@ static int find_pos(struct image *img,
 	else if (match_end)
 		line =3D img->nr - preimage->nr;
=20
-	if (line > img->nr)
+	/*
+	 * Because the comparison is unsigned, the following test
+	 * will also take care of a negative line number that can
+	 * result when match_end and preimage is larger than the target.
+	 */
+	if ((size_t) line > img->nr)
 		line =3D img->nr;
=20
 	try =3D 0;
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 0e3ce36..c617c2a 100755
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
+	>file &&
+	test_must_fail git apply patch
+'
+
 test_done
--=20
1.7.0
