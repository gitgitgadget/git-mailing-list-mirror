From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] test-lib.sh - cygwin does not have usable FIFOs
Date: Thu,  4 Jul 2013 18:04:30 -0400
Message-ID: <1372975470-13573-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 00:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uure1-00083D-PH
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 00:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816Ab3GDWEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 18:04:50 -0400
Received: from mail-vb0-f51.google.com ([209.85.212.51]:39242 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab3GDWEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 18:04:49 -0400
Received: by mail-vb0-f51.google.com with SMTP id x17so1255676vbf.38
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=IeYRMfCEv2VleiXlqIF2kClYFrHz7E9CIKyLxqscFQM=;
        b=JOsVWXZ2ZX0Z6/KsLLvseGkupBw5ku1JOeNN4Kckc0xOwrmicPDcydY/c7W6yiMD8b
         LQ474m5jZEZRmO2pH+gxJqaSk/y6stNP61hv1FoGKK6CBB3vNJ6aCNpLpBRuBaXLY2DP
         fPgEyA2nP900kSwny0KhxmR2+Xz3/E/2jOkx7ijSDrnFRTC1xEmb2pvAihLZ6ASNFnPA
         exh0F+MAC2MNVunCgudiYd2LAFEjIps0jmODADJIqm6p9HIKwI0fxX0PXWVIHQR5bfeK
         ACy0tfG+kJPBtfow5KksBsiBaCZjzfOt5DgLqLqj0N68cAswArBkr1hAnKtUBDHx3CQ4
         VVLw==
X-Received: by 10.220.195.195 with SMTP id ed3mr4499524vcb.33.1372975488610;
        Thu, 04 Jul 2013 15:04:48 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id sr7sm2756144vdc.2.2013.07.04.15.04.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 15:04:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229620>

Do not use FIFOs on cygwin, they do not work. Cygwin includes
coreutils, so has mkfifo, and that command does something. However,
the resultant named pipe is known (on the Cygwin mailing list at
least) to not work correctly.

This disables PIPE for Cygwin, allowing t0008.sh to complete (all other
tests in that file work correctly).

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 t/test-lib.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9753641..2d63307 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -885,7 +885,14 @@ test_i18ngrep () {
 
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
-	rm -f testfifo && mkfifo testfifo
+	case $(uname -s) in
+	CYGWIN*)
+		false
+		;;
+	*)
+		rm -f testfifo && mkfifo testfifo
+		;;
+	esac
 '
 
 test_lazy_prereq SYMLINKS '
-- 
1.8.3.2.0.13
