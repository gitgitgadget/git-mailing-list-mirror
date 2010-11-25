From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] git apply: apply patches with -pN (N>1) properly for some
 cases.
Date: Thu, 25 Nov 2010 10:58:43 +0800
Message-ID: <4CEDD0E3.6050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 03:58:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLS2w-00005C-CF
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 03:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab0KYC6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 21:58:49 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56789 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab0KYC6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 21:58:48 -0500
Received: by pva4 with SMTP id 4so99323pva.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 18:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=nMhv/wiTe/Wad34MM1yE055bO8OFRwT3q6zHeWSnjgI=;
        b=wMthKaDiWNNSLgbXrXFyC5yoT4jL6hlRJbDXEnPj80pAq3hHj66eH7OkgNLX+f+vZG
         ZSOGKtGBZG0bkDnIl6CFErBGM4mABcudNd48+sD9+5ZkO3FgqVr+SRj3AYSxVfmVi9Qx
         Y+F7fhwQxdKr+HV7VQGZ55Rp1QEDYMDh8cpjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=DDv0WErCWU/xu/gq0gCIVQV+7NpOgb+AKBTvatDvAwPLGbkcPHP7cQoBR0KzjZXfgf
         Z3NY23iHm2i6L6CN0VmMAtDS0qCKjbtjLoLRoGsCykMLJjOyDXeW5rYV+AkTThL4zp+R
         Uv4rU4OlX9bbK7EvssbeVQGbbmZkwoMvgBn08=
Received: by 10.142.187.14 with SMTP id k14mr116638wff.431.1290653928368;
        Wed, 24 Nov 2010 18:58:48 -0800 (PST)
Received: from [192.168.0.50] ([123.115.150.125])
        by mx.google.com with ESMTPS id p8sm283052wff.4.2010.11.24.18.58.45
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 18:58:47 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); zh-CN; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162100>

In some cases when apply patch, there maybe no '--- path/to/old'
and '+++ path/to/new' lines in the patch file, and the only way
to get filename is from the 'diff --git path/to/old path/to/new'
line in the patch header. For example, differ of binary files,
pure mode changes, removing or adding empty files.

The function 'git_header_name' is broken and casue patch apply
failed with -pN (N>1) for these cases. This patch fixed it and
provide a testcase. I also add a testcase for fancy filename.

Signed-off-by: Jiang Xin <jiangxin@ossxp.com>
---
 builtin/apply.c       |    3 ++-
 t/t4120-apply-popt.sh |   11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..d603e37 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1126,6 +1126,7 @@ static char *git_header_name(char *line, int llen)
 	 * form.
 	 */
 	for (len = 0 ; ; len++) {
+		int nslash = p_value;
 		switch (name[len]) {
 		default:
 			continue;
@@ -1137,7 +1138,7 @@ static char *git_header_name(char *line, int llen)
 				char c = *second++;
 				if (c == '\n')
 					return NULL;
-				if (c == '/')
+				if (c == '/' && --nslash <= 0)
 					break;
 			}
 			if (second[len] == '\n' && !memcmp(name, second, len)) {
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 2b2d00b..8a1e80e 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -50,10 +50,21 @@ test_expect_success 'apply (-p2) traditional diff with funny filenames' '
 	test_cmp expected file1
 '
 
+test_expect_success 'apply git diff with -p2 and fancy filename' '
+	cp file1.saved file1 &&
+	git apply -p2 patch.escaped
+'
+
 test_expect_success 'apply with too large -p and fancy filename' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.escaped 2>err &&
 	grep "removing 3 leading" err
 '
 
+test_expect_success 'apply git diff with -p2 and use default name from header' '
+	sed -e "/^\(---\|+++\) / d" patch.file > patch.newheader &&
+	cp file1.saved file1 &&
+	git apply -p2 patch.newheader
+'
+
 test_done
-- 
1.7.3.2.245.g03276.dirty
