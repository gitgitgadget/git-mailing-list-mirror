From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Fri, 12 Jan 2007 14:06:57 +0100
Message-ID: <871wm08kcu.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 12 14:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5M8W-0007xa-6z
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 14:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbXALNHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 08:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbXALNHe
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 08:07:34 -0500
Received: from main.gmane.org ([80.91.229.2]:48483 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbXALNHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 08:07:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5M7k-0003dT-Tq
	for git@vger.kernel.org; Fri, 12 Jan 2007 14:07:12 +0100
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 14:07:12 +0100
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 14:07:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:8VRmKSVxvm/pcmNkv1H7G6tBGk8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36670>

The add_user_info function formats the commit as a mail message, and
uses add_rfc2047 to format the From: line.  The add_rfc2047 assumes
that the string is encoded as utf-8.
---
 builtin-mailinfo.c |    2 +-
 commit.c           |   10 +++++++++-
 utf8.c             |    9 +++++++--
 utf8.h             |    2 +-
 4 files changed, 18 insertions(+), 5 deletions(-)

I was hit by this problem when working with an old repository where I
had used latin1, and I tried to use "git rebase".

Another option would have been to use the correct encoding in the
RFC2047 header, but this was a quicker solution.

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 583da38..3fd8e00 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -513,7 +513,7 @@ static void convert_to_utf8(char *line, char *chars=
et)
 {
 	static char latin_one[] =3D "latin1";
 	char *input_charset =3D *charset ? charset : latin_one;
-	char *out =3D reencode_string(line, metainfo_charset, input_charset);
+	char *out =3D reencode_string(line, metainfo_charset, input_charset, =
NULL);
=20
 	if (!out)
 		die("cannot convert from %s to %s\n",
diff --git a/commit.c b/commit.c
index 496d37a..8477fa7 100644
--- a/commit.c
+++ b/commit.c
@@ -486,6 +486,10 @@ static int add_rfc2047(char *buf, const char *line=
, int len)
 	if (!needquote)
 		return sprintf(buf, "%.*s", len, line);
=20
+        if (git_commit_encoding)
+                line =3D reencode_string(line, "utf-8",
+                                       git_commit_encoding, &len);
+
 	memcpy(bp, q_utf8, sizeof(q_utf8)-1);
 	bp +=3D sizeof(q_utf8)-1;
 	for (i =3D 0; i < len; i++) {
@@ -501,6 +505,10 @@ static int add_rfc2047(char *buf, const char *line=
, int len)
 	}
 	memcpy(bp, "?=3D", 2);
 	bp +=3D 2;
+
+        if (git_commit_encoding)
+                free((char *)line);
+
 	return bp - buf;
 }
=20
@@ -687,7 +695,7 @@ static char *logmsg_reencode(const struct commit *c=
ommit)
 		out =3D strdup(commit->buffer);
 	else
 		out =3D reencode_string(commit->buffer,
-				      output_encoding, encoding);
+				      output_encoding, encoding, NULL);
 	if (out)
 		out =3D replace_encoding_header(out, output_encoding);
=20
diff --git a/utf8.c b/utf8.c
index 7c80eec..ee9f514 100644
--- a/utf8.c
+++ b/utf8.c
@@ -291,7 +291,7 @@ int is_encoding_utf8(const char *name)
  * with iconv.  If the conversion fails, returns NULL.
  */
 #ifndef NO_ICONV
-char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding)
+char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding, int *len)
 {
 	iconv_t conv;
 	size_t insz, outsz, outalloc;
@@ -302,7 +302,10 @@ char *reencode_string(const char *in, const char *=
out_encoding, const char *in_e
 	conv =3D iconv_open(out_encoding, in_encoding);
 	if (conv =3D=3D (iconv_t) -1)
 		return NULL;
-	insz =3D strlen(in);
+        if (len)
+                insz =3D *len;
+        else
+                insz =3D strlen(in);
 	outsz =3D insz;
 	outalloc =3D outsz + 1; /* for terminating NUL */
 	out =3D xmalloc(outalloc);
@@ -332,6 +335,8 @@ char *reencode_string(const char *in, const char *o=
ut_encoding, const char *in_e
 		}
 		else {
 			*outpos =3D '\0';
+                        if (len)
+                                *len =3D outpos - out;
 			break;
 		}
 	}
diff --git a/utf8.h b/utf8.h
index a07c5a8..eb64d46 100644
--- a/utf8.h
+++ b/utf8.h
@@ -8,7 +8,7 @@ int is_encoding_utf8(const char *name);
 void print_wrapped_text(const char *text, int indent, int indent2, int=
 len);
=20
 #ifndef NO_ICONV
-char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding);
+char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding, int *len);
 #else
 #define reencode_string(a,b,c) NULL
 #endif
--=20
1.4.4.4.ge10a-dirty


--=20
David K=C3=A5gedal
