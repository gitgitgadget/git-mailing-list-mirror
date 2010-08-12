From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
Date: Thu, 12 Aug 2010 22:08:15 +0000
Message-ID: <1281650895-7449-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 00:08:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojfwq-0000Jq-7n
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab0HLWIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:08:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43621 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab0HLWIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:08:22 -0400
Received: by wyb32 with SMTP id 32so1906193wyb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Uno5NW0QpwDBBRBhU1kYrcSUA57/WjFXzhC9aHBxP5A=;
        b=w8NwSUQdZzcTIr5lUYHKpvxQrQubEGX8YoH8djuEfGBLzuVdXQHEFUu1aHwqs5vfAU
         lqhb+pSe4b5eemIlQc3su9qs0KqA4+4QZiKj0T8/UBRIpsrYEXhDuBaCB+d0AY+mRA8P
         LLEnx+2XM8dlu+FM88L5eDIPeq6eW6U4VtjE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=TWkSM7cPM3RJS9UcgNfeXAXNokVctAfhpRpoYgPThDa9ikcjUKR+2JufaNCtYBCXbK
         lUHdT5NoqcT3qUf1v3YD3ej9iRpY4DxGWIuR15BI3dMXxqeaS2YO+k+HZcmGKGK6xq0d
         6kPHUlm/82ojQwsPWJySMmSOXcK72+Fb1fHJg=
Received: by 10.227.156.66 with SMTP id v2mr647843wbw.136.1281650901037;
        Thu, 12 Aug 2010 15:08:21 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm1648543wbb.14.2010.08.12.15.08.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 15:08:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.327.gfb40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153426>

Remove the setlocale/LC_CTYPE call from gettext.c, we only need
setlocale/LC_MESSAGES to use the message catalog, and setting LC_CTYPE
from the environment breaks Git's assumptions about C library
functions.

Under a non-C locale functions like vsnprintf become locale sensitive,
so that they'll e.g. refuse to process ISO-8895-1 data under a UTF-8
locale.

This triggered a "your vsnprintf is broken" error on Git's own
repository when inspecting v0.99.6~1 under a UTF-8 locale.

That commit contains a ISO-8859-1 encoded author name, which the
locale aware vsnprintf(3) won't interpolate in the format argument,
due to mismatch between the data encoding and the locale.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This goes on top of the ab/i18n series in pu.

 gettext.c                           |    1 -
 t/t0203-gettext-setlocale-sanity.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)
 create mode 100755 t/t0203-gettext-setlocale-sanity.sh

diff --git a/gettext.c b/gettext.c
index 7ae5cae..db99742 100644
--- a/gettext.c
+++ b/gettext.c
@@ -17,6 +17,5 @@ extern void git_setup_gettext(void) {
 	}
=20
 	(void)setlocale(LC_MESSAGES, "");
-	(void)setlocale(LC_CTYPE, "");
 	(void)textdomain("git");
 }
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setl=
ocale-sanity.sh
new file mode 100755
index 0000000..a212460
--- /dev/null
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D"The Git C functions aren't broken by setlocale(3)"
+
+. ./lib-gettext.sh
+
+test_expect_success 'git show a ISO-8859-1 commit under C locale' '
+	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	test_commit "iso-c-commit" iso-under-c &&
+	git show >out 2>err &&
+	! test -s err &&
+	grep -q "iso-c-commit" out
+'
+
+test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-1 commit under=
 a UTF-8 locale' '
+	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	test_commit "iso-utf8-commit" iso-under-utf8 &&
+	LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" git show >out 2>err &&
+	! test -s err &&
+	grep -q "iso-utf8-commit" out
+'
+
+test_done
--=20
1.7.2.1.327.gfb40
