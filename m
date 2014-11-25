From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/2] git-mailinfo: add --message-id
Date: Tue, 25 Nov 2014 15:00:55 +0100
Message-ID: <1416924056-29993-2-git-send-email-bonzini@gnu.org>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 15:01:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtGg7-0007nP-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 15:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbaKYOBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 09:01:09 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35411 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaKYOBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 09:01:07 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so1540940wiv.1
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 06:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jFiAGELWAe4c172DF+85y+ZrF3qtdPJscq0SV/g3Nu8=;
        b=i8CHKrviWnTgQ/aBAaDTZ9gZsEmAQd1riksg2rDt3BMaVg4EbL6zKhiSz8b16EsNsJ
         v8hEE0wjwlZ4LynHdGbVVoYebsK8UyUUQ+skahQS1LBArLvccINQknPG9mUE9/NbYqnt
         BqoIOnnSW+hQR6q7aQ1sYNHCQv43aKq+ukue/Ry5ihyVrtGR0Bj89ZyraAQfw47WFmi1
         7VIAcfSoVg+3juEUs3Ti5tZ8FPTusG6LmnfFgxeF2bbJgILE49pcEGsOPYgbdy+aCIqF
         eG+SPcbi/A7OTGm6Ucr1CWn4PKN8y1YqeGht9kwutJn6FA7X7YDaToJsqD390L5Is/WG
         lROw==
X-Received: by 10.180.88.33 with SMTP id bd1mr31425508wib.10.1416924065227;
        Tue, 25 Nov 2014 06:01:05 -0800 (PST)
Received: from donizetti.redhat.com (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id d5sm2009054wjb.34.2014.11.25.06.01.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 06:01:04 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260219>

=46rom: Paolo Bonzini <pbonzini@redhat.com>

This option adds the content of the Message-Id header at the end of the
commit message prepared by git-mailinfo.  This is useful in order to
associate commit messages automatically with mailing list discussions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/git-mailinfo.txt |  5 +++++
 builtin/mailinfo.c             | 22 +++++++++++++++++++++-
 t/t5100-mailinfo.sh            |  4 ++++
 t/t5100/info0012--message-id   |  5 +++++
 t/t5100/msg0012--message-id    |  8 ++++++++
 t/t5100/patch0012--message-id  | 30 ++++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 t/t5100/info0012--message-id
 create mode 100644 t/t5100/msg0012--message-id
 create mode 100644 t/t5100/patch0012--message-id

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinf=
o.txt
index 164a3c6..2e99603 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -66,6 +66,11 @@ conversion, even with this flag.
 -n::
 	Disable all charset re-coding of the metadata.
=20
+-m::
+--message-id::
+	Copy the Message-ID header at the end of the commit message.  This=20
+	is useful in order to associate commits with mailing list discussions=
=2E
+
 --scissors::
 	Remove everything in body before a scissors line.  A line that
 	mainly consists of scissors (either ">8" or "8<") and perforation
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 6a14d29..c8a47c1 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -15,6 +15,7 @@ static const char *metainfo_charset;
 static struct strbuf line =3D STRBUF_INIT;
 static struct strbuf name =3D STRBUF_INIT;
 static struct strbuf email =3D STRBUF_INIT;
+static char *message_id;
=20
 static enum  {
 	TE_DONTCARE, TE_QP, TE_BASE64
@@ -24,6 +25,7 @@ static struct strbuf charset =3D STRBUF_INIT;
 static int patch_lines;
 static struct strbuf **p_hdr_data, **s_hdr_data;
 static int use_scissors;
+static int add_message_id;
 static int use_inbody_headers =3D 1;
=20
 #define MAX_HDR_PARSED 10
@@ -198,6 +200,12 @@ static void handle_content_type(struct strbuf *lin=
e)
 	}
 }
=20
+static void handle_message_id(const struct strbuf *line)
+{
+	if (add_message_id)
+		message_id =3D strdup(line->buf);
+}
+
 static void handle_content_transfer_encoding(const struct strbuf *line=
)
 {
 	if (strcasestr(line->buf, "base64"))
@@ -342,6 +350,14 @@ static int check_header(const struct strbuf *line,
 		ret =3D 1;
 		goto check_header_out;
 	}
+	if (cmp_header(line, "Message-Id")) {
+		len =3D strlen("Message-Id: ");
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		decode_header(&sb);
+		handle_message_id(&sb);
+		ret =3D 1;
+		goto check_header_out;
+	}
=20
 	/* for inbody stuff */
 	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
@@ -816,6 +832,8 @@ static int handle_commit_msg(struct strbuf *line)
 	}
=20
 	if (patchbreak(line)) {
+		if (message_id)
+			fprintf(cmitmsg, "Message-Id: %s\n", message_id);
 		fclose(cmitmsg);
 		cmitmsg =3D NULL;
 		return 1;
@@ -1013,7 +1031,7 @@ static int git_mailinfo_config(const char *var, c=
onst char *value, void *unused)
 }
=20
 static const char mailinfo_usage[] =3D
-	"git mailinfo [-k|-b] [-u | --encoding=3D<encoding> | -n] [--scissors=
 | --no-scissors] msg patch < mail >info";
+	"git mailinfo [-k|-b] [-m | --message-id] [-u | --encoding=3D<encodin=
g> | -n] [--scissors | --no-scissors] msg patch < mail >info";
=20
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -1032,6 +1050,8 @@ int cmd_mailinfo(int argc, const char **argv, con=
st char *prefix)
 			keep_subject =3D 1;
 		else if (!strcmp(argv[1], "-b"))
 			keep_non_patch_brackets_in_subject =3D 1;
+		else if (!strcmp(argv[1], "-m") || !strcmp(argv[1], "--message-id"))
+			add_message_id =3D 1;
 		else if (!strcmp(argv[1], "-u"))
 			metainfo_charset =3D def_charset;
 		else if (!strcmp(argv[1], "-n"))
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 9e1ad1c..60df10f 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -35,6 +35,10 @@ do
 		then
 			check_mailinfo $mail --no-inbody-headers
 		fi
+		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--message-id
+		then
+			check_mailinfo $mail --message-id
+		fi
 	'
 done
=20
diff --git a/t/t5100/info0012--message-id b/t/t5100/info0012--message-i=
d
new file mode 100644
index 0000000..ac1216f
--- /dev/null
+++ b/t/t5100/info0012--message-id
@@ -0,0 +1,5 @@
+Author: Dmitriy Blinov
+Email: bda@mnsspb.ru
+Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8
+Date: Wed, 12 Nov 2008 17:54:41 +0300
+
diff --git a/t/t5100/msg0012--message-id b/t/t5100/msg0012--message-id
new file mode 100644
index 0000000..376e26e
--- /dev/null
+++ b/t/t5100/msg0012--message-id
@@ -0,0 +1,8 @@
+textlive-* =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D1=8B=
 =D0=BD=D0=B0 texlive-*
+docutils =D0=B7=D0=B0=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D0=BD=D0=B0 pytho=
n-docutils
+
+=D0=94=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=
=D0=BE, =D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BB=D0=BE=D1=81=D1=8C, =D1=87=D1=
=82=D0=BE rest2web =D0=B2=D1=8B=D1=82=D1=8F=D0=B3=D0=B8=D0=B2=D0=B0=D0=B5=
=D1=82 =D0=B7=D0=B0 =D1=81=D0=BE=D0=B1=D0=BE=D0=B9
+python-docutils. =D0=92 =D1=82=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=
=BA=D0=B0=D0=BA =D1=81=D0=B0=D0=BC rest2web =D0=BD=D0=B5 =D0=BD=D1=83=D0=
=B6=D0=B5=D0=BD.
+
+Signed-off-by: Dmitriy Blinov <bda@mnsspb.ru>
+Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
diff --git a/t/t5100/patch0012--message-id b/t/t5100/patch0012--message=
-id
new file mode 100644
index 0000000..36a0b68
--- /dev/null
+++ b/t/t5100/patch0012--message-id
@@ -0,0 +1,30 @@
+---
+ howto/build_navy.txt |    6 +++---
+ 1 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/howto/build_navy.txt b/howto/build_navy.txt
+index 3fd3afb..0ee807e 100644
+--- a/howto/build_navy.txt
++++ b/howto/build_navy.txt
+@@ -119,8 +119,8 @@
+    - libxv-dev
+    - libusplash-dev
+    - latex-make
+-   - textlive-lang-cyrillic
+-   - textlive-latex-extra
++   - texlive-lang-cyrillic
++   - texlive-latex-extra
+    - dia
+    - python-pyrex
+    - libtool
+@@ -128,7 +128,7 @@
+    - sox
+    - cython
+    - imagemagick
+-   - docutils
++   - python-docutils
+=20
+ #. =D0=BD=D0=B0 =D0=BC=D0=B0=D1=88=D0=B8=D0=BD=D0=B5 dinar: =D0=B4=D0=
=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BE=
=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8B=D0=B9 ssh-=D0=BA=D0=BB=D1=8E=D1=87=
 =D0=B2 authorized_keys2 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=
=D1=82=D0=B5=D0=BB=D1=8F ddev
+ #. =D0=BD=D0=B0 =D1=81=D0=B2=D0=BE=D0=B5=D0=B9 =D0=BC=D0=B0=D1=88=D0=B8=
=D0=BD=D0=B5: =D0=BE=D1=82=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=
=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C /etc/sudoers (=D0=BA=D0=BE=D0=BC=D0=B0=
=D0=BD=D0=B4=D0=B0 ``visudo``) =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80=D0=BD=
=D0=BE =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=BC =D0=BE=D0=
=B1=D1=80=D0=B0=D0=B7=D0=BE=D0=BC::
+--=20
+1.5.6.5
--=20
2.1.0
