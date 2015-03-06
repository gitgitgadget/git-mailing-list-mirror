From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] http: Include locale.h when using setlocale()
Date: Fri,  6 Mar 2015 16:13:58 +0000
Message-ID: <1425658438-1004-1-git-send-email-avarab@gmail.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 17:14:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTutN-0000MC-5p
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 17:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbbCFQOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 11:14:20 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33352 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbbCFQOT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 11:14:19 -0500
Received: by widem10 with SMTP id em10so4497907wid.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Qxc6WnRxCt3y2uVgr3Y27iGTWhM8XODyMIRRIdP4mbg=;
        b=Hf/48ngpXrtAQa+kh9bay7S79iRXqJDPGrC5DpCAm618rVsRlMGAaVkiQg9gpTFasG
         OJl07W8/+0FpaphUVFnEb8KhDDRZ16UAFiFKRexsHxhx6loaCa/xGviBv0g8VNhdTJW3
         u9OVpUxqABYd2d++4cdgjeep5ar7UUuVJwOKwysiilG5ljP/0zO38PhbgXlme9b4iTUc
         ugDf1ww3j31A0y4x2Kb2wsCBOLq110fE4i/6s/RmR7grMBFVygH75oU/hRV4XreoUUhb
         vKrMwGr2grNnnOzUJHQ2fMK/RbnPEAJnIqioSuneb0l+cq8Uj3XDAyoBOVyZH3u2qpGl
         OvZg==
X-Received: by 10.194.85.46 with SMTP id e14mr30145848wjz.110.1425658458262;
        Fri, 06 Mar 2015 08:14:18 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by mx.google.com with ESMTPSA id fo9sm2837738wib.16.2015.03.06.08.14.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Mar 2015 08:14:17 -0800 (PST)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264935>

Since v2.3.0-rc1-37-gf18604b we've been using setlocale() here without
importing locale.h. Oddly enough this only causes issues for me under
-O0 on GCC & Clang. I.e. if I do:

    $ git clean -dxf; make -j 1 V=3D1 CFLAGS=3D"-g -O0 -Wall" http.o

I'll get this on clang 3.5.0-6 & GCC 4.9.1-19 on Debian:

    http.c: In function =E2=80=98get_preferred_languages=E2=80=99:
    http.c:1021:2: warning: implicit declaration of function =E2=80=98s=
etlocale=E2=80=99 [-Wimplicit-function-declaration]
      retval =3D setlocale(LC_MESSAGES, NULL);
      ^
    http.c:1021:21: error: =E2=80=98LC_MESSAGES=E2=80=99 undeclared (fi=
rst use in this function)
      retval =3D setlocale(LC_MESSAGES, NULL);

But changing -O0 to -O1 or another optimization level makes the issue g=
o
away. Odd, but in any case we should be including this header if we're
going to use the function, so just do that.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 http.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http.c b/http.c
index 0153fb0..0606e6c 100644
--- a/http.c
+++ b/http.c
@@ -8,6 +8,9 @@
 #include "credential.h"
 #include "version.h"
 #include "pkt-line.h"
+#ifndef NO_GETTEXT
+#	include <locale.h>
+#endif
=20
 int active_requests;
 int http_is_verbose;
--=20
2.1.3
