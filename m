From: Dmitry Marakasov <amdmi3@amdmi3.ru>
Subject: [PATCH] configure.ac: link with -liconv for locale_charset()
Date: Tue, 11 Mar 2014 22:35:29 +0400
Message-ID: <20140311183529.GA73693@hades.panopticon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: wxs@FreeBSD.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 19:51:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNRmI-0002bh-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 19:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbaCKSvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 14:51:46 -0400
Received: from smtpout6.timeweb.ru ([92.53.117.39]:22953 "EHLO
	smtpout6.timeweb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaCKSvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 14:51:45 -0400
X-Greylist: delayed 971 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Mar 2014 14:51:45 EDT
Received: from [213.148.20.85] (helo=hive.panopticon)
	by smtp.timeweb.ru with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.76)
	(envelope-from <amdmi3@amdmi3.ru>)
	id 1WNRWT-0002z4-Ny; Tue, 11 Mar 2014 22:35:29 +0400
Received: from hades.panopticon (hades.panopticon [192.168.0.32])
	by hive.panopticon (Postfix) with ESMTP id 63C5069B;
	Tue, 11 Mar 2014 22:35:29 +0400 (MSK)
Received: by hades.panopticon (Postfix, from userid 1000)
	id 4B120B219; Tue, 11 Mar 2014 22:35:29 +0400 (MSK)
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243879>

On e.g. FreeBSD 10.x, the following situation is common:
- there's iconv implementation in libc, which has no locale_charset()
  function
- there's GNU libiconv installed from Ports Collection

Git build process
- detects that iconv is in libc and thus -liconv is not needed for it
- detects locale_charset in -liconv, but for some reason doesn't add it
  to CHARSET_LIB (as it would do with -lcharset if locale_charset() was
  found there instead of -liconv)
- git doesn't build due to unresolved external locale_charset()

Fix this by adding -liconv to CHARSET_LIB if locale_charset() is
detected in this library.

Signed-off-by: Dmitry Marakasov <amdmi3@amdmi3.ru>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git configure.ac configure.ac
index 2f43393..3f5c644 100644
--- configure.ac
+++ configure.ac
@@ -890,7 +890,7 @@ GIT_CONF_SUBST([HAVE_STRINGS_H])
 # and libcharset does
 CHARSET_LIB=
 AC_CHECK_LIB([iconv], [locale_charset],
-       [],
+       [CHARSET_LIB=-liconv],
        [AC_CHECK_LIB([charset], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
-- 
1.9.0
