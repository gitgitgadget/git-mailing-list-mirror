From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] sha1_name: allow to add @{...} alias via config
Date: Wed,  8 Sep 2010 14:04:01 +1000
Message-ID: <1283918641-3662-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 06:04:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtBtT-0001cV-Ep
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 06:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab0IHEEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 00:04:13 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48386 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab0IHEEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 00:04:12 -0400
Received: by pwi3 with SMTP id 3so1672189pwi.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 21:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=esM6vTERq+FioYoU22MkINYtr0COKhEDyx289QEX9ls=;
        b=TLwSuXRd5n6ra3vQfLSyroJRLnWpmiAFQ4Fuxc0IUnpv+GKbWiqvtCu5KifQa2TQKQ
         G8GqRf5pEZ5UITqEY/SYtxmbVuVmaZaOP0gF/4rko2HIouGcZ//GY/axgGIiv9PIpfCF
         w/GQjMgltxkMjUua0C7enI/xWYHZ47O4nSyi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Q7gA9K+WWzm6ftjRBL/6bzKxYbOz8sCEcfvL+cD18DnngJY8fLn+KmlvIw9Fu4z47J
         0GnFaojtZ4eAXJXmJMCSO3Wm59/D7H9P1Pab7BD8iXeZXKOEn18JtksCBWC7pj72u4W5
         zxvG23dEVKCgL72h9S52Tbk/gIm+hZ1Crlm1Q=
Received: by 10.114.75.17 with SMTP id x17mr724290waa.177.1283918651146;
        Tue, 07 Sep 2010 21:04:11 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 33sm14769610wad.6.2010.09.07.21.04.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 21:04:09 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Sep 2010 14:04:02 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155764>

This allows users to add new @{..} alias via ref-at.* config
variables. The rewrite rule is printf-alike.

My itch is I usually work on a topic and only want to see commits in
that topic. So I make a tag to the topic's base, then do

git log base/my-topic..

That is a lot of keystrokes, and my mind is small enough sometimes I
don't even remember the topic name, stucking at "base/  what?"

Now I have "ref-at.base =3D base/%(tip)" in my gitconfig and I only nee=
d
to do "git log @{base}..".

This is probably not the best way to do though. Any advice?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    3 ++
 config.c    |    3 ++
 sha1_name.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 3 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index be02a42..bad577d 100644
--- a/cache.h
+++ b/cache.h
@@ -1112,4 +1112,7 @@ extern struct startup_info *startup_info;
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned ch=
ar *to);
=20
+/* sha1_name.c */
+extern int git_ref_at_config(const char *var, const char *value);
+
 #endif /* CACHE_H */
diff --git a/config.c b/config.c
index cdcf583..b560f51 100644
--- a/config.c
+++ b/config.c
@@ -720,6 +720,9 @@ int git_default_config(const char *var, const char =
*value, void *dummy)
 	if (!prefixcmp(var, "advice."))
 		return git_default_advice_config(var, value);
=20
+	if (!strncmp(var, "ref-at.", 7))
+		return git_ref_at_config(var, value);
+
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color =3D git_config_bool(var,value);
 		return 0;
diff --git a/sha1_name.c b/sha1_name.c
index 7b7e617..c9987f4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,6 +7,84 @@
 #include "refs.h"
 #include "remote.h"
=20
+struct ref_at {
+	const char *mark;
+	const char *format;
+};
+
+static struct ref_at *ref_at;
+static int ref_at_nr;
+
+int git_ref_at_config(const char *var, const char *value)
+{
+	ref_at_nr++;
+	ref_at =3D xrealloc(ref_at, sizeof(*ref_at)*ref_at_nr);
+	ref_at[ref_at_nr-1].mark =3D xstrdup(var+7); /* ref-at. */
+	ref_at[ref_at_nr-1].format =3D xstrdup(value);
+	return 0;
+}
+
+static int substitute_ref_at(struct strbuf *sb, const char *name)
+{
+	int i;
+	const char *at =3D strchr(name, '@');
+	const char *p, *p2;
+
+	if (!at || at[1] !=3D '{')
+		return -1;
+	for (i =3D 0; i < ref_at_nr; i++) {
+		int len =3D strlen(ref_at[i].mark);
+		if (!(at[len+2] =3D=3D '}' && !strncmp(at+2, ref_at[i].mark, len)))
+			continue;
+
+		p =3D ref_at[i].format;
+		while (*p) {
+			if (*p !=3D '%') {
+				strbuf_addch(sb, *p);
+				p++;
+				continue;
+			}
+			if (p[1] =3D=3D '%') {
+				strbuf_addch(sb, '%');
+				p +=3D 2;
+				continue;
+			}
+			if (p[1] !=3D '(') {
+				error("ref-at.%s: '%%%c' not supported", ref_at[i].mark, p[1]);
+				return -1;
+			}
+			p +=3D 2;
+			p2 =3D strchr(p, ')');
+			if (!p2)
+				return -1;
+			if (!strncmp(p, "branch", p2-p)) {
+				strbuf_add(sb, name, at-name);
+				p =3D p2+1;
+				continue;
+			}
+			if (!strncmp(p, "tip", p2-p)) {
+				if (at =3D=3D name || !strncmp(name, "HEAD", at-name)) {
+					unsigned char sha1[20];
+					int flag;
+					const char *real_ref =3D resolve_ref("HEAD", sha1, 0, &flag);
+					if (!strncmp(real_ref, "refs/heads/", 11))
+						strbuf_addstr(sb, real_ref+11);
+					else
+						strbuf_addstr(sb, real_ref);
+				}
+				else
+					strbuf_add(sb, name, p2-p);
+				p =3D p2+1;
+				continue;
+			}
+			error("ref-at.%s: '%%(%.*s)' is not supported", ref_at[i].mark, p2-=
p, p);
+			return -1;
+		}
+		return 1;
+	}
+	return 0;
+}
+
 static int find_short_object_filename(int len, const char *name, unsig=
ned char *sha1)
 {
 	struct alternate_object_database *alt;
@@ -346,6 +424,7 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1)
 	char *real_ref =3D NULL;
 	int refs_found =3D 0;
 	int at, reflog_len;
+	struct strbuf new_str =3D STRBUF_INIT;
=20
 	if (len =3D=3D 40 && !get_sha1_hex(str, sha1))
 		return 0;
@@ -355,6 +434,11 @@ static int get_sha1_basic(const char *str, int len=
, unsigned char *sha1)
 	if (len && str[len-1] =3D=3D '}') {
 		for (at =3D len-2; at >=3D 0; at--) {
 			if (str[at] =3D=3D '@' && str[at+1] =3D=3D '{') {
+				if (substitute_ref_at(&new_str, str) >=3D 0) {
+					str =3D new_str.buf;
+					len =3D new_str.len;
+					break;
+				}
 				if (!upstream_mark(str + at, len - at)) {
 					reflog_len =3D (len-1) - (at+2);
 					len =3D at;
@@ -366,7 +450,7 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1)
=20
 	/* Accept only unambiguous ref paths. */
 	if (len && ambiguous_path(str, len))
-		return -1;
+		goto failed;
=20
 	if (!len && reflog_len) {
 		struct strbuf buf =3D STRBUF_INIT;
@@ -374,10 +458,11 @@ static int get_sha1_basic(const char *str, int le=
n, unsigned char *sha1)
 		/* try the @{-N} syntax for n-th checkout */
 		ret =3D interpret_branch_name(str+at, &buf);
 		if (ret > 0) {
+			strbuf_release(&new_str);
 			/* substitute this branch name and restart */
 			return get_sha1_1(buf.buf, buf.len, sha1);
 		} else if (ret =3D=3D 0) {
-			return -1;
+			goto failed;
 		}
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found =3D dwim_ref("HEAD", 4, sha1, &real_ref);
@@ -387,7 +472,7 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1)
 		refs_found =3D dwim_ref(str, len, sha1, &real_ref);
=20
 	if (!refs_found)
-		return -1;
+		goto failed;
=20
 	if (warn_ambiguous_refs && refs_found > 1)
 		warning(warn_msg, len, str);
@@ -400,7 +485,7 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1)
=20
 		/* a @{-N} placed anywhere except the start is an error */
 		if (str[at+2] =3D=3D '-')
-			return -1;
+			goto failed;
=20
 		/* Is it asking for N-th entry, or approxidate? */
 		for (i =3D nth =3D 0; 0 <=3D nth && i < reflog_len; i++) {
@@ -421,7 +506,7 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1)
 			at_time =3D approxidate_careful(tmp, &errors);
 			free(tmp);
 			if (errors)
-				return -1;
+				goto failed;
 		}
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
@@ -438,7 +523,12 @@ static int get_sha1_basic(const char *str, int len=
, unsigned char *sha1)
 	}
=20
 	free(real_ref);
+	strbuf_release(&new_str);
 	return 0;
+
+failed:
+	strbuf_release(&new_str);
+	return -1;
 }
=20
 static int get_parent(const char *name, int len,
--=20
1.7.1.rc1.69.g24c2f7
