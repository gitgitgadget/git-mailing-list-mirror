From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 1/4] format-patch: Always generate a patch
Date: Sat, 07 Nov 2009 10:51:56 +0100
Message-ID: <4AF5433C.8030309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 10:52:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6hyL-0002vU-5H
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 10:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbZKGJvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 04:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZKGJvy
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 04:51:54 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61250 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZKGJvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 04:51:53 -0500
Received: by ewy3 with SMTP id 3so1772604ewy.37
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=xRAHHEeKUdGKJcg3kge7T9UhM8ojB81n+MPqsQ6s5vk=;
        b=ZsYZ3bhLZnHD7e5Cxm84qr5v+dCeAWTDdsMu60dZs1aOB/hjOBOUc1dv3009Dm4cpu
         3yOvvTmkB1xuLxHUgQVNuUa9tyUe78yUyDA3Xl4kyboVACucevCxHzLIQX9EeJOQxLss
         1th3XTsWjC5wj/GK9KFMAP2xthe8/Rkndcrd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=CM+olC80ehNiSLn29yPX0AnnGbooIyu5Z6fcC6OJ4osVsKFvj7LAgQLPPFHi7v9xfP
         NqLzho0tv3/q1FtRdo3cV/hPZrzuGSrYAe9siwAgUP12O57zfDTVTs07Sd9WNZyHhdYl
         drT63G6TCNjXyO0kP/Pguqh41zSBlHC4/r58c=
Received: by 10.213.1.5 with SMTP id 5mr526580ebd.71.1257587517652;
        Sat, 07 Nov 2009 01:51:57 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm820703eyb.32.2009.11.07.01.51.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 01:51:57 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132355>

Jeff King recently reinstated -p to suppress the default diffstat
(as -p used to work before 68daa64, about 14 months ago).

However, -p is also needed in combination with certain options
(e.g. --stat or --numstat) in order to produce any patch at all.
The documentation does not mention this.

Since the purpose of format-patch is to produce a patch that
can be emailed, it does not make sense that certain combination
of options will suppress the generation of the patch itself.

Therefore:

* Update 'git format-patch' to always generate a patch.

* Since the --name-only, --name-status, and --check suppresses
  the generation of the patch, disallow those options,
  and remove the description of them in the documentation.

* Remove the reference to -p in the description of -U.

* Remove the descriptions of the options that are synonyms for -p
  plus another option (--patch-with-raw and --patch-with-stat).

* While at it, slightly tweak the description of -p itself
  to say that it generates "plain patches", so that you can
  think of -p as "plain patch" as an mnemonic aid.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
Compared to my previous patch, most of the changes are in
the commit message. It was straightforward to combine my
previous changes in the code with Peff's version. In the
documentation, -p is now included.

 Documentation/diff-options.txt |   16 +++++++++++++---
 builtin-log.c                  |   21 ++++++++++++++++-----
 t/t4014-format-patch.sh        |   18 ++++++++++++++++++
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 9276fae..c58d085 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -14,7 +14,7 @@ endif::git-format-patch[]
=20
 ifdef::git-format-patch[]
 -p::
-	Generate patches without diffstat.
+	Generate plain patches without any diffstats.
 endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
@@ -27,14 +27,19 @@ endif::git-format-patch[]
 -U<n>::
 --unified=3D<n>::
 	Generate diffs with <n> lines of context instead of
-	the usual three. Implies "-p".
+	the usual three.
+ifndef::git-format-patch[]
+	Implies "-p".
+endif::git-format-patch[]
=20
 --raw::
 	Generate the raw format.
 	{git-diff-core? This is the default.}
=20
+ifndef::git-format-patch[]
 --patch-with-raw::
 	Synonym for "-p --raw".
+endif::git-format-patch[]
=20
 --patience::
 	Generate a diff using the "patience diff" algorithm.
@@ -71,21 +76,24 @@ endif::git-format-patch[]
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
=20
+ifndef::git-format-patch[]
 --patch-with-stat::
 	Synonym for "-p --stat".
-	{git-format-patch? This is the default.}
+endif::git-format-patch[]
=20
 -z::
 	NUL-line termination on output.  This affects the --raw
 	output field terminator.  Also output from commands such
 	as "git-log" will be delimited with NUL between commits.
=20
+ifndef::git-format-patch[]
 --name-only::
 	Show only names of changed files.
=20
 --name-status::
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.
+endif::git-format-patch[]
=20
 --color::
 	Show colored diff.
@@ -115,11 +123,13 @@ override configuration settings.
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
=20
+ifndef::git-format-patch[]
 --check::
 	Warn if changes introduce trailing whitespace
 	or an indent that uses a space before a tab. Exits with
 	non-zero status if problems are found. Not compatible with
 	--exit-code.
+endif::git-format-patch[]
=20
 --full-index::
 	Instead of the first handful of characters, show the full
diff --git a/builtin-log.c b/builtin-log.c
index 7b91c91..9df8dac 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -925,6 +925,8 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 			"show patch format instead of default (patch + stat)"),
 		OPT_BOOLEAN(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
 			    "don't include a patch matching a commit upstream"),
+		OPT_BOOLEAN('p', NULL, &use_patch_format,
+			"show patch format instead of default (patch + stat)"),
 		OPT_GROUP("Messaging"),
 		{ OPTION_CALLBACK, 0, "add-header", NULL, "header",
 			    "add email header", PARSE_OPT_NONEG,
@@ -1030,11 +1032,20 @@ int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
=20
-	if (use_patch_format)
-		rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
-	else if (!rev.diffopt.output_format ||
-		  rev.diffopt.output_format =3D=3D DIFF_FORMAT_PATCH)
-		rev.diffopt.output_format =3D DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUM=
MARY | DIFF_FORMAT_PATCH;
+	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
+		die("--name-only does not make sense");
+	if (rev.diffopt.output_format & DIFF_FORMAT_NAME_STATUS)
+		die("--name-status does not make sense");
+	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
+		die("--check does not make sense");
+
+	if (!use_patch_format &&
+		(!rev.diffopt.output_format ||
+		 rev.diffopt.output_format =3D=3D DIFF_FORMAT_PATCH))
+		rev.diffopt.output_format =3D DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUM=
MARY;
+
+	/* Always generate a patch */
+	rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
=20
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index cab6ce2..5689d59 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -536,4 +536,22 @@ test_expect_success 'format-patch --signoff' '
 	grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 '
=20
+echo "fatal: --name-only does not make sense" > expect.name-only
+echo "fatal: --name-status does not make sense" > expect.name-status
+echo "fatal: --check does not make sense" > expect.check
+
+test_expect_success 'options no longer allowed for format-patch' '
+	test_must_fail git format-patch --name-only 2> output &&
+	test_cmp expect.name-only output &&
+	test_must_fail git format-patch --name-status 2> output &&
+	test_cmp expect.name-status output &&
+	test_must_fail git format-patch --check 2> output &&
+	test_cmp expect.check output'
+
+test_expect_success 'format-patch --numstat should produce a patch' '
+	git format-patch --numstat --stdout master..side |
+	grep "^diff --git a/" |
+	wc -l |
+	xargs test 6 =3D '
+
 test_done
--=20
1.6.5.1.69.g36942
