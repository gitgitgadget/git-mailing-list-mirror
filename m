Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2681C2A3
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918921; cv=none; b=V0oWZ8r1O8R3zTLJFoQgbr7GGdsypv9eh8XUreV2C18OFNHm0f3h2kbMfRheFYrt6CGlYjrVBLhL7GJKLLUy+7DN2QpJMp49eh02teAoxlMvuaU83q6RSdXxJo+3jT1vxEDWKatleugb2jjXJr7mNli00Yky40HlGQlV1caNmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918921; c=relaxed/simple;
	bh=cHOLHbj3WikykLBzJlI84zhX0kpIi8lTVuNo20juVls=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HnfHDXu1eRFtP/8r/ml9GMCFOdUJNWfKEP7FM5TjsjQPBTyAH6TfeY1FtNPk50vtUxNC1L8/rOSXcB/5fRKSNFao8n0vheM0n2Sgn8j/4wG8sx4Baf21gKTJ4+OP7Db5QSLd4PxB2O1YP/ooAqix08++DKoYqSoXEfLQ0XhDIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=fGo85c+5; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fGo85c+5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717918905; x=1718523705; i=l.s.r@web.de;
	bh=aaWZQPiq5fUEiV6WDmWGIXu8RZbcFTirUZIhtKDOsJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fGo85c+5QZt7NHnKi8Juk4XZ+gs5JHy+2EiZ0swYRZuwa3PBvL6bKb7RQAppddKB
	 Eo9Wd2+kvqE3SQXajZ+EiHvLwVs4NHUC5YbfVR3eEAqmgQ0zjK/OMUsENaLAc/sib
	 cACRXg6SgWZEBH41ZzmjIMH85kA86XiOcIBYrFhP3ysgwBGivKBfWTrAE24IaKiyE
	 5z11mOI+HtLqpau4cm4KZ/d0Lp6/k4VS4BFb7AIuN0ujPQHTIM+yBCb3dbB34/EGW
	 8PxRa23ninIOLCQUfAf3ept8EMudH8o8ZZZta/57seJbWa1PuAnWinVmOgAa1gQDf
	 TeNOWJJd2PLf6AWpnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9479-1sSfcM1x8Z-00yhKb; Sun, 09
 Jun 2024 09:41:45 +0200
Message-ID: <6ed75dd5-f4e7-4dac-a8e8-a0c44376e5af@web.de>
Date: Sun, 9 Jun 2024 09:41:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/3] diff: let external diffs report that changes are
 uninteresting
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Johannes Sixt <j6t@kdbg.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Content-Language: en-US
In-Reply-To: <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vNNL/KQCHOTJPZa4ucozqPL/1BoQfa5NCAe97lLYb5jF68N5sMv
 levtjNq/UHso4d/VpoD0azGblPPztDiD3WjyfH1Qbf/w+//MgVAq5qs2+NlfnPWy62bpHjQ
 eRisX77dDFz6X92MgpevxqzFbZsi6gDCFBsK856fnpZCCt0UThP5iu0MWTl1IBDNYl5SjGk
 grPbRYZBtSGBl+32UFmXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yQWebd9bHnI=;urgWiqZrqXCrLdK4hTC8lYxWX+J
 BydyblqIMWiSKkc+MeoHoS3xeHwPANm0Hc+ryRXQLcmgE9zR8tVx71+Py4RPBb3a+J++tjEb2
 fABC9lE4f0xYRvGvyHDGayUZ0QY5C1LfAEc2TljRSPKLR16ROsNa26J6Jo5FDSuT7y09xjIZN
 vLiK/B//fEpQ9BAzOzk4Grh7fYxAjhO4Uhpc2AiQNNyXOBChNN6A/dVBJcCRSBeRhMP0DfVn/
 2PuX+/sgPEDON1WKcCAKm512ZTaWBTHnp1pNTCBSaj/1DqTsPLTXEF3AbZJ83TK1PeUXM56+4
 xIBbOTayNubslX17vuuFu+UVEQSBRicXixGsvcRdYc71+vXd+BxTswM4wuIhIwLh+9Mf4EJrL
 vcGzX7Ta0zS374Olv3Uw9qzQQwhErwinWlKfSTKeT6gLSkdz2w5wyfyUtjeCYZ1R7Gk92YQto
 UPd+fjxqpfdXoz36qyMTGiIsEVwfp/K0yPk6YL2p6LTAs6pRZPNHaBAbNQUkdRMzjqjJ/S3az
 8WiQRpeO02bXXlUwLcL0TgcPK/2U6zVXKxGIF8IBVU/ZEOLyydoioP0PzCCiMkMcn9R52b7Va
 cS2pCYZT2G7zJdZgadz7OgMRZwM638KiL8Qn+vMcV1dYRfDfUMrsMN9Z0jImgqhDcxStUHWNG
 20MldlCwKRMZpf4qgq5st1+gwKmMJRWtnY6oZxpuViKS7x5v8wmx1M54g3CJx25wEznHX/rGJ
 vzPnY8IdKlY4WzFYDw+b7o+0HH9ED5u9dQTPbflgIlVS5YldCc/AtNf30x7koo6igLgrOsNvH
 vj23QpeXxBUVVwfnXpFm4hxkd6yl2fpIhW/JqFIapfxSA=

The options --exit-code and --quiet instruct git diff to indicate
whether it found any significant changes by exiting with code 1 if it
did and 0 if there were none.  Currently this doesn't work if external
diff programs are involved, as we have no way to learn what they found.

Add that ability in the form of the new configuration options
diff.trustExitCode and diff.<driver>.trustExitCode and the environment
variable GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE.  They pair with the config
options diff.external and diff.<driver>.command and the environment
variable GIT_EXTERNAL_DIFF, respectively.

The new options are off by default, keeping the old behavior.  Enabling
them indicates that the external diff returns exit code 1 if it finds
significant changes and 0 if it doesn't, like diff(1).

The name of the new options is taken from the git difftool and mergetool
options of similar purpose.  (There they enable passing on the exit code
of a diff tool and to infer whether a merge done by a merge tool is
successful.)

The new feature sets the diff flag diff_from_contents in
diff_setup_done() if we need the exit code and are allowed to call
external diffs.  This disables the optimization that avoids calling the
program with --quiet.  Add it back by skipping the call if the external
diff is not able to report empty diffs.  We can only do that check after
evaluating the file-specific attributes in run_external_diff().

If we do run the external diff with --quiet, send its output to
/dev/null.

I considered checking the output of the external diff to check whether
its empty.  It was added as 11be65cfa4 (diff: fix --exit-code with
external diff, 2024-05-05) and quickly reverted, as it does not work
with external diffs that do not write to stdout.  There's no reason why
a graphical diff tool would even need to write anything there at all.

I also considered using a non-zero exit code for empty diffs, which
could be done without adding new configuration options.  We'd need to
disable the optimization that allows git diff --quiet to skip calling
external diffs, though -- that might be quite surprising if graphical
diff programs are involved.  And assigning the opposite meaning of the
exit codes compared to diff(1) and git diff --exit-code to the external
diff can cause unnecessary confusion.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/config/diff.txt   | 18 +++++++++++++++++
 Documentation/diff-options.txt  |  6 +++++-
 Documentation/git.txt           | 10 +++++++++
 Documentation/gitattributes.txt |  5 +++++
 diff.c                          | 36 ++++++++++++++++++++++++++++++++-
 t/t4020-diff-external.sh        | 33 +++++++++++++++++++++---------
 userdiff.c                      |  4 ++++
 userdiff.h                      |  1 +
 8 files changed, 101 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 5ce7b91f1d..190bda17e5 100644
=2D-- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -79,6 +79,15 @@ diff.external::
 	you want to use an external diff program only on a subset of
 	your files, you might want to use linkgit:gitattributes[5] instead.

+diff.trustExitCode::
+	If this boolean value is set to true then the
+	`diff.external` command is expected to return exit code
+	0 if it considers the input files to be equal or 1 if it
+	considers them to be different, like `diff(1)`.
+	If it is set to false, which is the default, then the command
+	is expected to return exit code 0 regardless of equality.
+	Any other exit code causes Git to report a fatal error.
+
 diff.ignoreSubmodules::
 	Sets the default value of --ignore-submodules. Note that this
 	affects only 'git diff' Porcelain, and not lower level 'diff'
@@ -164,6 +173,15 @@ diff.<driver>.command::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.

+diff.<driver>.trustExitCode::
+	If this boolean value is set to true then the
+	`diff.<driver>.command` command is expected to return exit code
+	0 if it considers the input files to be equal or 1 if it
+	considers them to be different, like `diff(1)`.
+	If it is set to false, which is the default, then the command
+	is expected to return exit code 0 regardless of equality.
+	Any other exit code causes Git to report a fatal error.
+
 diff.<driver>.xfuncname::
 	The regular expression that the diff driver should use to
 	recognize the hunk header.  A built-in pattern may also be used.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.t=
xt
index 6b73daf540..cd0b81adbb 100644
=2D-- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -820,7 +820,11 @@ ifndef::git-log[]

 --quiet::
 	Disable all output of the program. Implies `--exit-code`.
-	Disables execution of external diff helpers.
+	Disables execution of external diff helpers whose exit code
+	is not trusted, i.e. their respective configuration option
+	`diff.trustExitCode` or `diff.<driver>.trustExitCode` or
+	environment variable `GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE` is
+	false.
 endif::git-log[]
 endif::git-format-patch[]

diff --git a/Documentation/git.txt b/Documentation/git.txt
index a31a70acca..4489e2297a 100644
=2D-- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -644,6 +644,16 @@ parameter, <path>.
 For each path `GIT_EXTERNAL_DIFF` is called, two environment variables,
 `GIT_DIFF_PATH_COUNTER` and `GIT_DIFF_PATH_TOTAL` are set.

+`GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE`::
+	If this Boolean environment variable is set to true then the
+	`GIT_EXTERNAL_DIFF` command is expected to return exit code
+	0 if it considers the input files to be equal or 1 if it
+	considers them to be different, like `diff(1)`.
+	If it is set to false, which is the default, then the command
+	is expected to return exit code 0 regardless of equality.
+	Any other exit code causes Git to report a fatal error.
+
+
 `GIT_DIFF_PATH_COUNTER`::
 	A 1-based counter incremented by one for every path.

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes=
.txt
index 4338d023d9..80cae17f37 100644
=2D-- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -776,6 +776,11 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.

+If the program is able to ignore certain changes (similar to
+`git diff --ignore-space-change`), then also set the option
+`trustExitCode` to true.  It is then expected to return exit code 1 if
+it finds significant changes and 0 if it doesn't.
+
 Setting the internal diff algorithm
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

diff --git a/diff.c b/diff.c
index 4b86c61631..39ba842049 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -432,6 +432,10 @@ int git_diff_ui_config(const char *var, const char *v=
alue,
 	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cfg.cmd, var, value);
+	if (!strcmp(var, "diff.trustexitcode")) {
+		external_diff_cfg.trust_exit_code =3D git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
 	if (!strcmp(var, "diff.orderfile"))
@@ -556,6 +560,8 @@ static const struct external_diff *external_diff(void)
 	if (done_preparing)
 		return external_diff_ptr;
 	external_diff_env.cmd =3D xstrdup_or_null(getenv("GIT_EXTERNAL_DIFF"));
+	if (git_env_bool("GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE", 0))
+		external_diff_env.trust_exit_code =3D 1;
 	if (external_diff_env.cmd)
 		external_diff_ptr =3D &external_diff_env;
 	else if (external_diff_cfg.cmd)
@@ -4387,6 +4393,19 @@ static void run_external_diff(const struct external=
_diff *pgm,
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
+	int quiet =3D !(o->output_format & DIFF_FORMAT_PATCH);
+	int rc;
+
+	/*
+	 * Trivial equality is handled by diff_unmodified_pair() before
+	 * we get here.  If we don't need to show the diff and the
+	 * external diff program lacks the ability to tell us whether
+	 * it's empty then we consider it non-empty without even asking.
+	 */
+	if (!pgm->trust_exit_code && quiet) {
+		o->found_changes =3D 1;
+		return;
+	}

 	strvec_push(&cmd.args, pgm->cmd);
 	strvec_push(&cmd.args, name);
@@ -4408,7 +4427,15 @@ static void run_external_diff(const struct external=
_diff *pgm,
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	cmd.use_shell =3D 1;
-	if (run_command(&cmd))
+	cmd.no_stdout =3D quiet;
+	rc =3D run_command(&cmd);
+	if (!pgm->trust_exit_code && rc =3D=3D 0)
+		o->found_changes =3D 1;
+	else if (pgm->trust_exit_code && rc =3D=3D 0)
+		; /* nothing */
+	else if (pgm->trust_exit_code && rc =3D=3D 1)
+		o->found_changes =3D 1;
+	else
 		die(_("external diff died, stopping at %s"), name);

 	remove_tempfile();
@@ -4926,6 +4953,13 @@ void diff_setup_done(struct diff_options *options)
 		options->flags.exit_with_status =3D 1;
 	}

+	/*
+	 * External diffs could declare non-identical contents equal
+	 * (think diff --ignore-space-change).
+	 */
+	if (options->flags.allow_external && options->flags.exit_with_status)
+		options->flags.diff_from_contents =3D 1;
+
 	options->diff_path_counter =3D 0;

 	if (options->flags.follow_renames)
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 4070523cdb..3baa52a9bf 100755
=2D-- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -177,15 +177,17 @@ check_external_diff () {
 	expect_out=3D$2
 	expect_err=3D$3
 	command_code=3D$4
-	shift 4
+	trust_exit_code=3D$5
+	shift 5
 	options=3D"$@"

 	command=3D"echo output; exit $command_code;"
-	desc=3D"external diff '$command'"
+	desc=3D"external diff '$command' with trustExitCode=3D$trust_exit_code"
 	with_options=3D"${options:+ with }$options"

 	test_expect_success "$desc via attribute$with_options" "
 		test_config diff.foo.command \"$command\" &&
+		test_config diff.foo.trustExitCode $trust_exit_code &&
 		echo \"file diff=3Dfoo\" >.gitattributes &&
 		test_expect_code $expect_code git diff $options >out 2>err &&
 		test_cmp $expect_out out &&
@@ -194,6 +196,7 @@ check_external_diff () {

 	test_expect_success "$desc via diff.external$with_options" "
 		test_config diff.external \"$command\" &&
+		test_config diff.trustExitCode $trust_exit_code &&
 		>.gitattributes &&
 		test_expect_code $expect_code git diff $options >out 2>err &&
 		test_cmp $expect_out out &&
@@ -204,6 +207,7 @@ check_external_diff () {
 		>.gitattributes &&
 		test_expect_code $expect_code env \
 			GIT_EXTERNAL_DIFF=3D\"$command\" \
+			GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE=3D$trust_exit_code \
 			git diff $options >out 2>err &&
 		test_cmp $expect_out out &&
 		test_cmp $expect_err err
@@ -216,14 +220,23 @@ test_expect_success 'setup output files' '
 	echo "fatal: external diff died, stopping at file" >error
 '

-check_external_diff   0 output empty 0
-check_external_diff 128 output error 1
-
-check_external_diff   1 output empty 0 --exit-code
-check_external_diff 128 output error 1 --exit-code
-
-check_external_diff   1 empty  empty 0 --quiet
-check_external_diff   1 empty  empty 1 --quiet # we don't even call the p=
rogram
+check_external_diff   0 output empty 0 off
+check_external_diff 128 output error 1 off
+check_external_diff   0 output empty 0 on
+check_external_diff   0 output empty 1 on
+check_external_diff 128 output error 2 on
+
+check_external_diff   1 output empty 0 off --exit-code
+check_external_diff 128 output error 1 off --exit-code
+check_external_diff   0 output empty 0 on  --exit-code
+check_external_diff   1 output empty 1 on  --exit-code
+check_external_diff 128 output error 2 on  --exit-code
+
+check_external_diff   1 empty  empty 0 off --quiet
+check_external_diff   1 empty  empty 1 off --quiet # we don't even call t=
he program
+check_external_diff   0 empty  empty 0 on  --quiet
+check_external_diff   1 empty  empty 1 on  --quiet
+check_external_diff 128 empty  error 2 on  --quiet

 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file

diff --git a/userdiff.c b/userdiff.c
index f47e2d9f36..6cdfb147c3 100644
=2D-- a/userdiff.c
+++ b/userdiff.c
@@ -446,6 +446,10 @@ int userdiff_config(const char *k, const char *v)
 		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
 		return git_config_string(&drv->external.cmd, k, v);
+	if (!strcmp(type, "trustexitcode")) {
+		drv->external.trust_exit_code =3D git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(type, "textconv"))
 		return git_config_string(&drv->textconv, k, v);
 	if (!strcmp(type, "cachetextconv"))
diff --git a/userdiff.h b/userdiff.h
index 2d59a8fc56..f5cb53d0d4 100644
=2D-- a/userdiff.h
+++ b/userdiff.h
@@ -13,6 +13,7 @@ struct userdiff_funcname {

 struct external_diff {
 	char *cmd;
+	unsigned trust_exit_code:1;
 };

 struct userdiff_driver {
=2D-
2.45.2
