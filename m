From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] git-compat-util: suppress unavoidable Apple-specific deprecation warnings
Date: Tue, 16 Dec 2014 18:19:36 -0500
Message-ID: <1418771976-15060-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 00:20:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y11Pj-0007ii-N9
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 00:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaLPXUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 18:20:19 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:57788 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbaLPXUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 18:20:18 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so7790775igb.5
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 15:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1G2tAquoiYjtBAbBhPTc2LWyy+P/3UmbGycrRoPaiLk=;
        b=vHsJKYvYfu6/hvBNjoZQAFvWT7IwCyYuTjSqz1Ojk/zare2J+uABBopKkLa3zCRkgL
         svT9QhW7t7p8GeUv/Qsb8pfiNtotI25qRYbz2HYVvnpAZ5vu72FTLOXMUANcmrbyMya6
         oiczinCHDyXZWtFof9ZIqv0tIY/DCoyMMjfQSRMAzXJ0v86P29opK8sr1VI4DWkKrxIF
         fA8YJKuIBOpd7lPhlX6A8f2sW3dXedsbCtmWnJX8r/5DO022F/iUPcdsWzZIJZ4ZGka3
         +/zdBHI7f9fH/YPz06Dod4aG4lfQn87015ZwyW1ovgO/d40vzJys1NWKY4JikntsrsZs
         qu7w==
X-Received: by 10.50.154.72 with SMTP id vm8mr5319464igb.47.1418772017585;
        Tue, 16 Dec 2014 15:20:17 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id 137sm940715ioo.23.2014.12.16.15.20.16
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Dec 2014 15:20:17 -0800 (PST)
X-Mailer: git-send-email 2.2.0.209.gd6426a0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261472>

With the release of Mac OS X 10.7 in July 2011, Apple deprecated all
openssl.h functionality due to OpenSSL ABI (application binary
interface) instability, resulting in an explosion of compilation
warnings about deprecated SSL, SHA1, and X509 functions (among others).

61067954ce (cache.h: eliminate SHA-1 deprecation warnings on Mac OS X;
2013-05-19) and be4c828b76 (imap-send: eliminate HMAC deprecation
warnings on Mac OS X; 2013-05-19) attempted to ameliorate the situation
by taken advantage of drop-in replacement functionality provided by
Apple's (ABI-stable) CommonCrypto facility, however CommonCrypto
supplies only a subset of deprecated OpenSSL functionality, thus a host
of warnings remain.

Despite this shortcoming, it was hoped that Apple would ultimately
provide CommonCrypto replacements for all deprecated OpenSSL
functionality, and that the effort started by 61067954ce and be4c828b76
would be continued and eventually eliminate all deprecation warnings.
However, now 3.5 years later, and with Mac OS X at 10.10, the hoped-for
CommonCrypto replacements have not yet materialized, nor is there any
indication that they will be forthcoming.

These Apple-specific warnings are pure noise: they don't tell us
anything useful and we have no control over them, nor is Apple likely to
provide replacements any time soon. Such noise may obscure other
legitimate warnings, therefore silence them.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Related discussion:
http://thread.gmane.org/gmane.comp.version-control.git/260463/

 git-compat-util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 400e921..433b8f2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -211,8 +211,12 @@ extern char *gitbasename(char *);
 #endif
 
 #ifndef NO_OPENSSL
+#define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
+#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
 #include <openssl/ssl.h>
 #include <openssl/err.h>
+#undef MAC_OS_X_VERSION_MIN_REQUIRED
+#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
 #endif
 
 /* On most systems <netdb.h> would have given us this, but
-- 
2.2.0.209.gd6426a0
