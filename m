From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] for-each-ref: add option to omit newlines
Date: Thu, 13 Feb 2014 19:00:29 +0100
Message-ID: <1392314429-15281-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 13 19:00:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE0ae-0003RS-3j
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 19:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbaBMSAn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Feb 2014 13:00:43 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:40312 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbaBMSAm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 13:00:42 -0500
Received: by mail-we0-f178.google.com with SMTP id q59so7685342wes.23
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=6tZxypBjmAPZ2f6lU0jbm/bBHX3fchkNGfuY3s/WD48=;
        b=tx7hE+t5OUD1MVBjpUYPd9JhduBM9Lh2YG6H5dOioA1PvIOE8oxcsT+Y7k/gG/fpFv
         v12HQGnUUdPEeZr1c49SGcxcma5BH/GgUIP3gUspzpL35oQOz/RS4N4tZ3zfn/zrD+Xy
         l9F/TpsLMXy/TELly8Ko/dyAHA0hqtqY/txwCOJbBeqZrr4ZX6sT9cXn9ZEq39ZqTpdI
         hO9JmZwdjQ4kkTlew2SKbBphORynvcUlIr3Il3YqTQlgGsy+Q1Btur8wNQIfernsaEMn
         f5etVGWsbKJqZwguPavcb4eUplnTvtUMOn2aJleft2JCYjvhEdjjlgPU/L4PPmOopJO/
         3VRw==
X-Received: by 10.180.108.199 with SMTP id hm7mr7538174wib.1.1392314440909;
        Thu, 13 Feb 2014 10:00:40 -0800 (PST)
Received: from localhost.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id jw4sm6285610wjc.20.2014.02.13.10.00.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2014 10:00:39 -0800 (PST)
X-Mailer: git-send-email 1.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242068>

Even when having specified a format string for-each-ref still prints a
newline after printing each ref according to the format. This breaks
splitting the output on newlines, for example.

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
I was somewhat surprised by this behaviour; I expected to be in full co=
ntrol of
the output but I could not get rid of the newlines.

As far as I'm *personally* concerned the line "putchar('\n');" could ju=
st as
well be removed completely and an '\n' appended to the default format s=
tring.
But since this command (and this behaviour) as been around since 2006 I=
 assume
that it's in Git's best interest to not change the default behaviour. H=
ence the
introduction of this option. Although I was taken aback by this behavio=
ur, is
it patch-worthy? The fix isn't very pretty.

On to the patch itself: I contemplated putting '\n' in the default form=
at and
removing it if -n was given, which would get rid of the need to pass an=
 exta
argument to show_ref(). But that means we would need to *insert it* whe=
n a
format is given and -n is not...

I've changed how the default format is assigned so that we can check if=
 it's
NULL after option parsing to spit out an error. Alternatively we could =
just
allow it.

 Documentation/git-for-each-ref.txt |  3 +++
 builtin/for-each-ref.c             | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index 4240875..805914a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -62,6 +62,9 @@ OPTIONS
 	the specified host language.  This is meant to produce
 	a scriptlet that can directly be `eval`ed.
=20
+-n::
+--no-newlines::
+	Do not print a newline after printing each formatted ref.
=20
 FIELD NAMES
 -----------
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 51798b4..32d6b12 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -998,7 +998,8 @@ static void emit(const char *cp, const char *ep)
 	}
 }
=20
-static void show_ref(struct refinfo *info, const char *format, int quo=
te_style)
+static void show_ref(struct refinfo *info, const char *format, int quo=
te_style,
+		     int no_newlines)
 {
 	const char *cp, *sp, *ep;
=20
@@ -1023,7 +1024,8 @@ static void show_ref(struct refinfo *info, const =
char *format, int quote_style)
 		resetv.s =3D color;
 		print_value(&resetv, quote_style);
 	}
-	putchar('\n');
+	if (!no_newlines)
+		putchar('\n');
 }
=20
 static struct ref_sort *default_sort(void)
@@ -1067,9 +1069,9 @@ static char const * const for_each_ref_usage[] =3D=
 {
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i, num_refs;
-	const char *format =3D "%(objectname) %(objecttype)\t%(refname)";
+	const char *format =3D NULL;
 	struct ref_sort *sort =3D NULL, **sort_tail =3D &sort;
-	int maxcount =3D 0, quote_style =3D 0;
+	int maxcount =3D 0, quote_style =3D 0, no_newlines =3D 0;
 	struct refinfo **refs;
 	struct grab_ref_cbdata cbdata;
=20
@@ -1082,6 +1084,8 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
 		OPT_BIT(0 , "tcl",  &quote_style,
 			N_("quote placeholders suitably for tcl"), QUOTE_TCL),
+		OPT_BOOL('n' , "no-newlines",  &no_newlines,
+			N_("do not output a newline after each ref")),
=20
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs"=
)),
@@ -1100,6 +1104,12 @@ int cmd_for_each_ref(int argc, const char **argv=
, const char *prefix)
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
+	if (no_newlines && !format) {
+		error("--no-newlines without --format does not make sense");
+		usage_with_options(for_each_ref_usage, opts);
+	}
+	if (!format)
+		format =3D "%(objectname) %(objecttype)\t%(refname)";
 	if (verify_format(format))
 		usage_with_options(for_each_ref_usage, opts);
=20
@@ -1120,6 +1130,6 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 	if (!maxcount || num_refs < maxcount)
 		maxcount =3D num_refs;
 	for (i =3D 0; i < maxcount; i++)
-		show_ref(refs[i], format, quote_style);
+		show_ref(refs[i], format, quote_style, no_newlines);
 	return 0;
 }
--=20
1.8.5
