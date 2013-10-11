From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: [PATCH v2] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Fri, 11 Oct 2013 16:07:30 +0300
Message-ID: <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 11 15:07:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUcRQ-0000qw-6y
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 15:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab3JKNHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Oct 2013 09:07:36 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:57922 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab3JKNHf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Oct 2013 09:07:35 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so3332277lbd.40
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=siBGdSHhXodRTxGUON6Zm2vXRjAXQwVlDLbKrywwgbk=;
        b=s7PIacRe93d39MGOtYA2fCyzhIGjbQ+aw/YcoDRjBHS9mFl0P1rnXPF7qpzHYSpJPY
         YNOtpjai/9O5MYo1Viqekgb32JEcmfYb863qjHuwgpUAkeElw6rBgJM7/kNXMBZ2lDqr
         rzjYEn2fccaA+PuJtF1es7F6tcXKiEWlhRxWoCrHhS91WhnFiDEoO+1VxXx/NlUArbJ/
         HGGCxMybmEfIdInQmj8k3dQEDfxuyO6B+Vi37fyspcs+94tM51uEGClDlJw6cCIHiKF1
         BTqPeiikeVLgWrJbXFx8pPtmNA3y0wFa7BrkyqdAdTYJk6uyiQmi8Vl42XKb0KLzGbjL
         93qA==
X-Received: by 10.152.170.233 with SMTP id ap9mr443746lac.51.1381496854058;
        Fri, 11 Oct 2013 06:07:34 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id ua4sm33379981lbb.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 06:07:33 -0700 (PDT)
In-Reply-To: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235904>

"git diff -M --stat" can detect rename and show renamed file name like
"foofoofoo =3D> barbarbar", but if destination filename is long the lin=
e
is shortened like "...barbarbar" so there is no way to know whether the
file is renamed or existed in the source commit.
This commit makes it visible like "...foo =3D> ...bar".

Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
---
 diff.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index a04a34d..3aeaf3e 100644
--- a/diff.c
+++ b/diff.c
@@ -1643,13 +1643,57 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 		len =3D name_width;
 		name_len =3D strlen(name);
 		if (name_width < name_len) {
-			char *slash;
-			prefix =3D "...";
-			len -=3D 3;
-			name +=3D name_len - len;
-			slash =3D strchr(name, '/');
-			if (slash)
-				name =3D slash;
+			char *arrow =3D strstr(name, " =3D> ");
+			if (arrow) {
+				int prefix_len =3D (name_width - 4) / 2;
+				int f_omit;
+				int f_brace =3D 0;
+				char *pre_arrow =3D alloca(name_width + 10);
+				char *post_arrow =3D arrow + 4;
+				char *prefix_buf =3D alloca(name_width + 10);
+				char *pre_arrow_slash =3D NULL;
+
+				if (arrow - name < prefix_len) {
+					prefix_len =3D (int)(arrow - name);
+					f_omit =3D 0;
+				} else {
+					prefix_len -=3D 3;
+					f_omit =3D 1;
+					if (name[0] =3D=3D '{') {
+						prefix_len -=3D 1;
+						f_brace =3D 1;
+					}
+				}
+				prefix_len =3D ((prefix_len >=3D 0) ? prefix_len : 0);
+				strncpy(pre_arrow, arrow - prefix_len, prefix_len);
+				pre_arrow[prefix_len] =3D '=A50';
+				pre_arrow_slash =3D strchr(pre_arrow, '/');
+				if (f_omit && pre_arrow_slash)
+					pre_arrow =3D pre_arrow_slash;
+				sprintf(prefix_buf, "%s%s%s =3D> ", (f_brace ? "{" : ""), (f_omit =
? "..." : ""), pre_arrow);
+				prefix =3D prefix_buf;
+
+				if (strlen(post_arrow) > name_width - strlen(prefix)) {
+					char *post_arrow_slash =3D NULL;
+
+					post_arrow +=3D strlen(post_arrow) - (name_width - strlen(prefix)=
 - 3);
+					strcat(prefix_buf, "...");
+					post_arrow_slash =3D strchr(post_arrow, '/');
+					if (post_arrow_slash)
+						post_arrow =3D post_arrow_slash;
+					name =3D post_arrow;
+					name_len =3D (int) (name_width - strlen(prefix));
+				}
+				len -=3D strlen(prefix);
+			} else {
+				char *slash =3D NULL;
+				prefix =3D "...";
+				len -=3D 3;
+				name +=3D name_len - len;
+				slash =3D strchr(name, '/');
+				if (slash)
+					name =3D slash;
+			}
 		}
=20
 		if (file->is_binary) {
--=20
1.8.4.475.g867697c
