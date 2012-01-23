From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20Don=27t=20search=20files=20with=20an=20unset=20=22grep=22=20attribute?=
Date: Mon, 23 Jan 2012 14:59:15 -0800
Message-ID: <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Conrad Irwin <conrad.irwin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 23:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpSrM-0001Tq-5A
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab2AWW7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 17:59:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35261 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab2AWW7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:59:24 -0500
Received: by mail-iy0-f174.google.com with SMTP id b35so4382395iac.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=htSvg3bxFXI3VmkNpoqRynEuJ9pcsp5hbGhe46ZYMGg=;
        b=sSdbuuEcxWs2MEWG0JkOEzxFmDs8oeplVTUUumArVF69Yre/Pj05A0kLWL6VTnDHtv
         Pl2gdw0QRheiBUJ9/xi1pcws33KSGqVDvWiAPv7Cl+YkF0damuB5W+EIjRGosiiebwYP
         y+udPNRQCZ8DvGT46h4LG84iDYo1JmD90n/nE=
Received: by 10.50.15.231 with SMTP id a7mr11833767igd.8.1327359564175;
        Mon, 23 Jan 2012 14:59:24 -0800 (PST)
Received: from monteverdi.rapportive.com (173-228-114-254.static.sonic.net. [173.228.114.254])
        by mx.google.com with ESMTPS id gd2sm19271724igc.1.2012.01.23.14.59.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jan 2012 14:59:21 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.1.g1fdd3
In-Reply-To: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189024>

Junio C Hamano <gitster <at> pobox.com> writes:
> Please reword this to describe the problem being solved first (why it
> needs to be solved, in what situation you cannot live without the
> feature), and then describe the approach you used to solve it.
>=20

Done =E2=80=94 I also removed the extraneous braces from the patch.

>=20
> in order to avoid uselessly spewing garbage at you while reminding yo=
u
> that the command is not showing the whole truth and you _might_ want =
to
> look into the elided file if you wanted to with "grep -a world hello.=
o".
> Compared to this, it feels that the result your patch goes too far an=
d
> hides the truth a bit too much to my taste. Maybe it is just me.

I used to use this approach, hooking into the "diff" attribute directly=
 to mark
a file as binary, however that was clearly a hack. When developing this=
 patch I
went through a few iterations, one in which -grep meant "treat this fil=
e as
binary", however explaining that in the man page is subtle and ugly: "H=
INT: you
might want to set a file as binary because you don't want to see result=
s from it
when grepping".  It's much more obvious to have -grep mean "don't show =
me
results".

A nicer alternative could be to allow "grep=3Dbinary" (and for complete=
ness
"grep=3Dtext") in addition to "-grep". Then people who want to see matc=
hes but not
the contents of the matches can tell grep that their files are "binary"=
=2E It
would also make sense to add "grep=3Dbinary" to the binary macro-attrib=
ute. We
could even extend the system arbitrarily to allow something like the te=
xtconv
attributes of git-diff... one step at a time is probably better though.

> Perhaps you, or all participants of your particular project, usually =
do
> not want to see any grep hits from minified.js, but you may still wan=
t to
> be able to say "I want to dig deeper and make sure I have copyright
> strings in all files", for example.  It is unclear how you envision t=
o
> support such a use case building on top of this patch.

I think that it would be very reasonable to add a flag to grep to tell =
it to
ignore the attribute temporarily (like --no-textconv on git-diff) and u=
pdate the
"-a" shorthand to imply "--text --no-exclude-attribute".

Yours,
Conrad

---8<---

Git grep is used by developers to search the code stored in their repos=
itories,
however it can give noisy results when the repository contains files th=
at are
not of direct interest to development. Examples of such files include t=
est
fixtures, dlls, or minified source code.

To help these developers search efficiently, git grep will now use the
gitattributes mechanism to ignore all files with an unset "grep" attrib=
ute.

Another approach considered was to allow an --exclude flag to grep at r=
untime,
however this is more clunky to use when the set of files to be excluded=
 is
fixed.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-grep.txt      |    7 +++++++
 Documentation/gitattributes.txt |    9 +++++++++
 builtin/grep.c                  |    6 ++++++
 grep.c                          |   21 +++++++++++++++++++++
 grep.h                          |    1 +
 t/t7810-grep.sh                 |   30 ++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6a8b1e3..7c74165 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -242,6 +242,13 @@ OPTIONS
 	If given, limit the search to paths matching at least one pattern.
 	Both leading paths match and glob(7) patterns are supported.
=20
+ATTRIBUTES
+----------
+
+grep::
+	If the grep attribute is unset on a file using the linkgit:gitattribu=
tes[1]
+	mechanism, then that file will not be searched.
+
 Examples
 --------
=20
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index a85b187..3ffcec7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -869,6 +869,15 @@ If this attribute is not set or has an invalid val=
ue, the value of the
 `gui.encoding` configuration variable is used instead
 (See linkgit:git-config[1]).
=20
+Configuring files to search
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`grep`
+^^^^^^
+
+If the attribute `grep` is unset for a file then linkgit:git-grep[1]
+will ignore that file while searching for matches.
+
=20
 USING MACRO ATTRIBUTES
 ----------------------
diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..a7817fe 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -398,6 +398,9 @@ static int grep_sha1(struct grep_opt *opt, const un=
signed char *sha1,
 	struct strbuf pathbuf =3D STRBUF_INIT;
 	char *name;
=20
+	if (!should_grep_path(opt, filename + tree_name_len))
+		return 0;
+
 	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
 				    opt->prefix);
@@ -464,6 +467,9 @@ static int grep_file(struct grep_opt *opt, const ch=
ar *filename)
 	struct strbuf buf =3D STRBUF_INIT;
 	char *name;
=20
+	if (!should_grep_path(opt, filename))
+		return 0;
+
 	if (opt->relative && opt->prefix_length)
 		quote_path_relative(filename, -1, &buf, opt->prefix);
 	else
diff --git a/grep.c b/grep.c
index 486230b..e948576 100644
--- a/grep.c
+++ b/grep.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "grep.h"
+#include "attr.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
=20
@@ -829,6 +830,26 @@ static inline void grep_attr_unlock(struct grep_op=
t *opt)
 #define grep_attr_unlock(opt)
 #endif
=20
+static struct git_attr_check attr_check[1];
+static void setup_attr_check(void)
+{
+	if (attr_check[0].attr)
+		return; /* already done */
+	attr_check[0].attr =3D git_attr("grep");
+}
+int should_grep_path(struct grep_opt *opt, const char *name) {
+	int ret =3D 1;
+
+	grep_attr_lock(opt);
+	setup_attr_check();
+	git_check_attr(name, 1, attr_check);
+	if (ATTR_FALSE(attr_check[0].value))
+		ret =3D 0;
+	grep_attr_unlock(opt);
+
+	return ret;
+}
+
 static int match_funcname(struct grep_opt *opt, const char *name, char=
 *bol, char *eol)
 {
 	xdemitconf_t *xecfg =3D opt->priv;
diff --git a/grep.h b/grep.h
index fb205f3..266002d 100644
--- a/grep.h
+++ b/grep.h
@@ -129,6 +129,7 @@ extern void append_header_grep_pattern(struct grep_=
opt *, enum grep_header_field
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, const char *name, char *b=
uf, unsigned long size);
+extern int should_grep_path(struct grep_opt *opt, const char *name);
=20
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7ba5b16..c991518 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -871,4 +871,34 @@ test_expect_success 'mimic ack-grep --group' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'with -grep attribute' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf &&
+	rm .gitattributes
+'
+
+test_expect_success 'with -grep attribute on specific file' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf hello.c &&
+	rm .gitattributes
+'
+
+test_expect_success 'with -grep attribute on specific revision' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf HEAD &&
+	rm .gitattributes
+'
+
+test_expect_success 'with -grep attribute on specific file/revision' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf HEAD hello.c &&
+	rm .gitattributes
+'
+
+test_expect_failure 'with -grep attribute on specific tree' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf HEAD:hello.c &&
+	rm .gitattributes
+'
+
 test_done
--=20
1.7.9.rc2.1.g1fdd3
