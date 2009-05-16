From: Matt Graham <mdg149@gmail.com>
Subject: [PATCH] new test fails "add -p" for adds on the top line
Date: Fri, 15 May 2009 23:10:19 -0400
Message-ID: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 16 05:10:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5AIB-0004te-9c
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbZEPDKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755390AbZEPDKU
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:10:20 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:41089 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396AbZEPDKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:10:19 -0400
Received: by gxk10 with SMTP id 10so4338490gxk.13
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=CDDHLHKyAnYSzHewLoa6bVV2B4fKakz/61fSJsKyz1E=;
        b=tsBtGpnoU7QGM0hVjPMEnLOWpfD35bxItd4XvjItd+VmMwIJkg0tVTcXFrUUbuNhgV
         TshH0BqqW41VZB6Uh6eGyoIAYepu4IbSJ0sOjFDZGh2Ae2OltLwl9PBYbP2wxnvK1gZc
         ME62fWDdXbiVoWZK3vntRpGwwa7+qM8Px8D90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=V/4EQV2XwbObHkAi8b62D05FUsQrLgD0/oqTY0YPCw4uCf4X8SJFQMKbRpkfVQ62d6
         G1145WkKQliJKKtM+g1Mpv2VQTHjnqTrG8FsZoCs4cmyYzDqW31N6O6BSkcq8m+ENiV5
         aIEjHUb6aThAxhWYJUiAoKlFOlU5b98rB1A3M=
Received: by 10.151.75.7 with SMTP id c7mr7400623ybl.236.1242443420010; Fri, 
	15 May 2009 20:10:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119320>

add -p doesn't work for some diffs.  diffs adding a new line at the top of
the file with other adds later in the file are one way to trigger the problem.

during add -p, split the diff and then answer y for all segments.  the file
won't have been added to the index.

Signed-off-by: Matthew Graham <mdg149@gmail.com>
---
 t/t3701-add-interactive.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index dfc6560..45da6c8 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -163,6 +163,38 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
 	git diff          file | grep "+content"
 '

+# Write the patch file with a new line at the top and bottom
+cat >patch <<EOF
+index 180b47c..b6f2c08 100644
+--- a/file
++++ b/file
+@@ -1,2 +1,4 @@
++firstline
+ baseline
+ content
++lastline
+EOF
+# Expected output, similar to the patch but w/ diff at the top
+cat >expected <<EOF
+diff --git a/file b/file
+index b6f2c08..61b9053 100755
+--- a/file
++++ b/file
+@@ -1,2 +1,4 @@
++firstline
+ baseline
+ content
++lastline
+EOF
+# Test splitting the first patch, then adding both
+test_expect_failure 'add first line works' '
+	git commit -am "clear local changes" &&
+	git apply patch &&
+	(echo s; echo y; echo y) | git add -p file &&
+	git diff --cached > diff &&
+	test_cmp expected diff
+'
+
 # end of tests disabled when filemode is not usable

 test_done
-- 
1.6.3.9.g6345
