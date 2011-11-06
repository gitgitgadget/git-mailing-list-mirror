From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/3] apply: get rid of useless x < 0 comparison on a size_t type
Date: Sun,  6 Nov 2011 13:06:22 +0100
Message-ID: <1320581184-4557-2-git-send-email-avarab@gmail.com>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 13:06:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN1V0-00074D-OA
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 13:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab1KFMGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 07:06:48 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49619 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab1KFMGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 07:06:46 -0500
Received: by mail-fx0-f46.google.com with SMTP id o14so4247439faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DAKDukU5Uvvvg+QA1C5JlLvcbUYG0Z3B/eb55nzjcJk=;
        b=khe4Pe95lz7+2Yv9YZ76DU9QB9PNTgmwswItjkdUH0/uAi7/f6uofMa4mf3LNyUtQx
         Zlfd/YDp98p6vty+grtiVA+KG1BRt+yi5udxf8NlNiV1Mo1D1d91l/6TLlUF/te7mH1p
         WWD9oIeAJ6Y0JlI9QuNUHxSmb5Mq5xgQoAupQ=
Received: by 10.223.76.197 with SMTP id d5mr39156454fak.13.1320581206166;
        Sun, 06 Nov 2011 04:06:46 -0800 (PST)
Received: from snth.ams7.corp.booking.com ([62.140.137.119])
        by mx.google.com with ESMTPS id f14sm3038218fah.6.2011.11.06.04.06.44
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 04:06:45 -0800 (PST)
X-Mailer: git-send-email 1.7.6.3
In-Reply-To: <1320581184-4557-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184910>

According to the C standard size_t is always unsigned, therefore the
comparison "n1 < 0 || n2 < 0" when n1 and n2 are size_t will always be
false.

This was raised by clang 2.9 which throws this warning when compiling
apply.c:

    builtin/apply.c:253:9: warning: comparison of unsigned expression <=
 0 is always false [-Wtautological-compare]
            if (n1 < 0 || n2 < 0)
                ~~ ^ ~
    builtin/apply.c:253:19: warning: comparison of unsigned expression =
< 0 is always false [-Wtautological-compare]
            if (n1 < 0 || n2 < 0)
                          ~~ ^ ~

This check was originally added in v1.6.5-rc0~53^2 by Giuseppe Bilotta
while adding an option to git-apply to ignore whitespace differences.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/apply.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 84a8a0b..b3b59db 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -250,9 +250,6 @@ static int fuzzy_matchlines(const char *s1, size_t =
n1,
 	const char *last2 =3D s2 + n2 - 1;
 	int result =3D 0;
=20
-	if (n1 < 0 || n2 < 0)
-		return 0;
-
 	/* ignore line endings */
 	while ((*last1 =3D=3D '\r') || (*last1 =3D=3D '\n'))
 		last1--;
--=20
1.7.6.3
