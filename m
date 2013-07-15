From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v5 0/5] config: add support for http.<url>.* settings
Date: Mon, 15 Jul 2013 02:50:57 -0700
Message-ID: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfR6-0006UY-Tb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab3GOJvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:51:13 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40430 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3GOJvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:51:12 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so10936418pac.40
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oSAxwI3S+AAEWAsJgbDWHYVpTDkCYeDoX2dgilL8Hn0=;
        b=SljUGE++m5r3n35DQ5eIVxqJkGYn5rVLepLVN5rvawmDYyAQGJ4ZqSfWLm7nPcyZiG
         O0gULy5jP+huO8zRW3RhmEiPniKJnBuUCAHyGr3dcoLGxoLHpx/m7AfgFYOkSgckfY7Q
         rOHv2ujZ2KllbxKi4fgf/gg2i+K/NIIjsxGTMZFLG4Pk6jUKFalWafrqvWdv9hNy7ZQz
         iAP7ip8BU9be0gZwQvzLoI2muuVs+AZe6cEMZyrt5daZSK2xvi6DnQZ2rvHz+pc5Wa3P
         2wemnDvbNU6uFJBUU2yXBiSKrz6IYxRKTNUod8tqJ4TcKaE36AN+Dz/+4P5jKh1DmmHt
         ydWw==
X-Received: by 10.68.189.228 with SMTP id gl4mr5894128pbc.57.1373881871788;
        Mon, 15 Jul 2013 02:51:11 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wr9sm60041274pbc.7.2013.07.15.02.51.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 02:51:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230449>

This patch series adds support for url-specific http.* settings.

It has been suggested that a preparatory patch to address the way the
http.sslCertPasswordProtected variable is handled be included.

I'm not sure if the intent was to make that a separate patch or include it
in a patch series together with the http.<url>.* settings updates.  I have,
however, included it here this time along with a second patch that does the
same thing for the GIT_SSL_CERT_PASSWORD_PROTECTED environment variable.

There is talk about possibly altering GIT_SSL_NO_VERIFY, GIT_CURL_FTP_NO_EPSV
and GIT_CURL_VERBOSE to behave similarly.  No patch is included here for that.

The http.<url>.* settings support addresses various feedback.  To better
support matching URLs that are equivalent but spelled differently, a
url_normalize function has been added.  Currently this patch leaves it in
http.c as http_options_url_normalize as I am unclear whether it should go into
url.{h,c} at this time since only http.c uses.

Since the url_normalize function's behavior is non-trivial, it is presented as
a separate patch on top of the basic http.<url>.* settings support.  A new test
for it has also been included as the final patch.  I am unclear on the proper
number for this test, but have gone ahead and put it with the other http tests
since this patch series places the url_normalize function into http.c.

Junio C Hamano (1):
  http.c: fix parsing of http.sslCertPasswordProtected variable

Kyle J. McKay (4):
  http.c: fix parsing of GIT_SSL_CERT_PASSWORD_PROTECTED variable
  config: add support for http.<url>.* settings
  config: improve support for http.<url>.* settings
  tests: add new test for the url_normalize function

 .gitignore               |   1 +
 Documentation/config.txt |  14 ++
 Makefile                 |   5 +
 http.c                   | 397 ++++++++++++++++++++++++++++++++++++++++++++---
 t/t5200-url-normalize.sh | 109 +++++++++++++
 test-url-normalize.c     |  62 ++++++++
 6 files changed, 565 insertions(+), 23 deletions(-)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 test-url-normalize.c

-- 
1.8.3
