From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] commit: switch core.commentChar if it's found in existing commit
Date: Fri, 16 May 2014 17:59:42 +0700
Message-ID: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8DSqeAnCMCawsh-58=B1z93tBCVb+x8XAAUZ17Y1ZaJKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Stasa <michal.stasa@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 12:59:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlFrb-0002Wa-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 12:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbaEPK7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 06:59:40 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:51262 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583AbaEPK7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 06:59:39 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so2466172pbc.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dOSTEgc7DUlarhm4G6FQzrT2Og84jysx9tj84XCXDFc=;
        b=IQR131WxVNV6PJRJNLAcF84nojBVqRNiyYyxIvRMScQNz8m+QsG7y4/vxCv0WeSBc0
         ue5nzRneXmb8XRzqaSbUCCqA9hdz7cdF+PAO+YNyMc0HF9d/2UIiUQT8th47SwPTdPJn
         O0rcKvJpBuQ0ov4fHUZHrdqN+FYx0KIcJBolRotS5wiiXZs9AtqWxhVy0xmxuTZTs1dp
         R1SrNTbTK4V4fRBW5M8m9XwTpndGWNAEWdqDizscnAN3KngnuO6ZR/TUqO9UcO9T782P
         3uhP1jXTykpAyNqIiofsK2/KmqtBqB7DXFXvqKAGOJSVYNRh1raZOjr5xlQbLVf93NX4
         4frg==
X-Received: by 10.68.141.102 with SMTP id rn6mr20116098pbb.43.1400237978824;
        Fri, 16 May 2014 03:59:38 -0700 (PDT)
Received: from lanh ([115.73.241.6])
        by mx.google.com with ESMTPSA id gr10sm13928691pbc.84.2014.05.16.03.59.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 03:59:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 16 May 2014 17:59:47 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <CACsJy8DSqeAnCMCawsh-58=B1z93tBCVb+x8XAAUZ17Y1ZaJKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249296>

If we need to use core.commentChar and it's already in the prepared
message, find another char among a small subset. This should stop
surprises because git strips some lines unexpectedly. Of course if
candicate characters happen to be all out, this change does not help.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, May 16, 2014 at 5:28 PM, Duy Nguyen <pclouds@gmail.com> wrote:
 > But maybe git should detect that the
 > current commit message has leading '#' and automatically switch to
 > another character..

 Something like this. Lightly tested.. I know there's a small bug..

 builtin/commit.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..70ceb61 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -593,6 +593,32 @@ static char *cut_ident_timestamp_part(char *string=
)
 	return ket;
 }
=20
+static void adjust_comment_line_char(const struct strbuf *sb)
+{
+	char candidates[] =3D " !@#$%^&|:;~";
+	char *candidate;
+	const char *p;
+	if (!sb->len)
+		return;
+	candidates[0] =3D comment_line_char;
+	p =3D sb->buf;
+	do {
+		candidate =3D strchr(candidates, *p);
+		if (candidate)
+			*candidate =3D ' ';
+		p =3D strchrnul(p, '\n');
+		if (*p)
+			p++;
+	} while (*p);
+	if (strchr(candidates, comment_line_char)) {
+		p =3D candidates;
+		while (*p && *p =3D=3D ' ')
+			p++;
+		if (*p)
+			comment_line_char =3D *p;
+	}
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefi=
x,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -748,6 +774,9 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
=20
+	if (use_editor && include_status)
+		adjust_comment_line_char(&sb);
+
 	strbuf_release(&sb);
=20
 	/* This checks if committer ident is explicitly given */
--=20
1.9.1.346.ga2b5940
