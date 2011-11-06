From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum member
Date: Sun,  6 Nov 2011 13:06:24 +0100
Message-ID: <1320581184-4557-4-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Nov 06 13:07:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN1VS-0007Dy-7m
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 13:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab1KFMHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 07:07:16 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49619 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1KFMHP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 07:07:15 -0500
Received: by mail-fx0-f46.google.com with SMTP id o14so4247439faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kQf4uzM4gMwUnEzW/7T6oXzSp55MshymIymi+fWIYq8=;
        b=PvinoO4/PYuxjLQlQOqophzHUe8rEjR9eOp5jrXQ4hf3wKTIuBLUzTqyEz4BwTqgxA
         Fpnk1thxp2SZM/Vduj3FfRth6DDAP69u6jngTwgWKzb84sKLdN5U8EpZkLuLAX8H7p3+
         Tnzim8hr384RV6D5XHmHXOYoyiflpLmOUL99s=
Received: by 10.223.92.135 with SMTP id r7mr24072289fam.35.1320581235111;
        Sun, 06 Nov 2011 04:07:15 -0800 (PST)
Received: from snth.ams7.corp.booking.com ([62.140.137.119])
        by mx.google.com with ESMTPS id f14sm3038218fah.6.2011.11.06.04.07.13
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 04:07:14 -0800 (PST)
X-Mailer: git-send-email 1.7.6.3
In-Reply-To: <1320581184-4557-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184911>

Remove an "p->field < 0" comparison in grep.c that'll always be
false. In this case "p" is a "grep_pat" where "field" is defined as:

	enum grep_header_field field;

And grep_header_field is in turn defined as:

    enum grep_header_field {
    	GREP_HEADER_AUTHOR =3D 0,
    	GREP_HEADER_COMMITTER
    };

Meaning that this comparison will always be false. This was spotted by
clang 2.9 which produced the following warning while compiling grep.c:

    grep.c:330:16: warning: comparison of unsigned enum expression < 0 =
is always false [-Wtautological-compare]
                    if (p->field < 0 || GREP_HEADER_FIELD_MAX <=3D p->f=
ield)
                        ~~~~~~~~ ^ ~

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 grep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index b29d09c..025d3f8 100644
--- a/grep.c
+++ b/grep.c
@@ -327,7 +327,7 @@ static struct grep_expr *prep_header_patterns(struc=
t grep_opt *opt)
 	for (p =3D opt->header_list; p; p =3D p->next) {
 		if (p->token !=3D GREP_PATTERN_HEAD)
 			die("bug: a non-header pattern in grep header list.");
-		if (p->field < 0 || GREP_HEADER_FIELD_MAX <=3D p->field)
+		if (GREP_HEADER_FIELD_MAX <=3D p->field)
 			die("bug: unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
--=20
1.7.6.3
