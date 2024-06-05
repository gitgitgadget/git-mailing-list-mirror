Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329F1946A3
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576729; cv=none; b=RKGgMxeRD1QYT3q1OX7nYV9K7ZAIZ56Y/ah/z4ojK6VFDuzBooYJOxTooo2K0nTJHcXC71Ik2yHPmGnw35Os9gmhpXQTRcVehTTdQvRY+wvaRj7RrkEQEyLBpyAlBpxMO2j+Z85c14kjjXTfVfC0ETeqHIRgGhDU7I6bt+W2DfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576729; c=relaxed/simple;
	bh=uA3WMB75sNcei0BfRApI0sz/EgUJzP8Tj+/7hFL1/Wg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kyg2uP5itBeDFdkmO4WfULFT9P+PHrpwy5PzNwfGC5V6NjimojDbXi88sjocNWImp9XlsjkEW8W+N9DeOkilhYHaQXfrO/nyjPSRQQkXWd0fOYOI+3Z8qlJsPpgmcQKOVGeAKiO0cO9X9MiXWmWqsVxbBHO7iHS+D9ZgRE6fLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HgG7CZpG; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HgG7CZpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717576717; x=1718181517; i=l.s.r@web.de;
	bh=6LJnKN4mRnaiH0MHZf/sdWqAZzW0Q/7AEjEqTMPDyUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HgG7CZpGrECnL8/8PH3/vsKDepnN1xzNBJw67p89ZTHWYkZr0HDvuUFiCBxs/4+3
	 ftr+JW6UeU2jf+1V7ogSV93LZ1pvZbJRpCjTV/DKrQfOSptstVBrOQc4B19/4x5B+
	 gPZNAZhLvj6uNGtyD24SvVnlOoFJvrXQYSifLKF0AnbbhABW8g+IiGiW1ZvJp8yvF
	 xDOyZ4FoXdwiFKnzKLYZNFJP2HIDAtXch34oDOFWXix2/qGxRa0K5ao95KmXvju91
	 xBOxDAHxwK1zBjiQ1/WqNnOO/jJjT72eArrwHOS2cufc7i/grnCMvCdA/WpqcKYD7
	 yv2GZF4ujb+F8MXSzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwsB-1sl4Bs26B3-00nwvs; Wed, 05
 Jun 2024 10:38:37 +0200
Message-ID: <99a99e5c-4fe4-413a-9281-363e280716b8@web.de>
Date: Wed, 5 Jun 2024 10:38:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] diff: let external diffs report that changes are
 uninteresting
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
Content-Language: en-US
In-Reply-To: <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ce+A1KTLH04F+a/+UruzBFm/0tGMJS7wsGB3R9WeICLcSPASjN5
 KfRblfiXVj5ZIa+YcRtnMCqsVGhQqf5pEk3i4WHrc2dF4PiLz7WMBbLUj1zdjDJbPsV/rVi
 tjttDx1MT2txpqwe7FkRv7CpuDiVwQBvfWMTWgcVmkbGHHiHPxKastlRZPGbEJlCHxezWIo
 siS9EwEiGCVb+AxpX+Zpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/xzsbpSc/7k=;CGrZ5M9vRt2S1L56om2N7zcdKav
 Cv2bA6SaSBpWRmvzQISEuByJzEv9l+Kf1EBfgDQDAIPFZ9CU3b4p9hg2MrFRzQ+D0uElNgKpF
 slcrtcf1Tqy9TG1AteUyVWxlsBrMQdVGZzViZOkfhr3XRd3+0l0x0pmY1+/DEykAoqsRrknVR
 dmLWFpvTTXR7Tb9Ukb26kbsKtQ+/GIfWgKAYfT4ZNqkiL3v5u1FZBQKH45hcJGBFNI8RcrNZ9
 5+pRtqSrAV6u/qcNn/ljjQ+UNkuioUdSPJwJ2Ef11QvRrG//6f5SjxEuXodIz2XLoSZecySif
 iWKphc2j/nNla1rX06VJce2BXBk8KY6rt9EMzm3hocNA0TOtUISEBvriBg67FtswXh0a9DAYx
 P/Dx6PakhQpP0Fv2KtocMKqDzxFKbR6ifJNGVGqiklDExmaX40QfObewNBpefx5HOG+h0Y80g
 R3x64eL+tLsAPe2SJbHh6c+uxt7LxlLoGQIGiFvgkLgv++Xx7pnn7bKO4ybe9aNEIRNNPNxk1
 IgGnoSNoMzz6ZDwli4dbrs4AwBCgJ+DZeNu5e9Fieaa6lUr3FSr5VUJDSDkHcSymAX/yLfR3X
 s6cDBGeZ597N2apIOgI/T6qeRL+W9wwDeo8k0uXIDsqJnkZ4zeTie4AEBs/LGx5v7eFyxQkJ2
 xabC8uzlmMUa3GUM0Q18KC9LK4qrEQhEkdhutl+qlygBt+P3cvstzahd5LJ3eBkENAreWonoa
 LeoxOTcB7sAfEiZcCGv4c+8Y/j6xUiUDxzIjkJpIjIbZ02BCzwLOUYpoOuODpu5QNxyzgkUn3
 OYAHNxRgNM6notVKatxCw69K77dKDU697VbJNQJQzkmYE=

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
 Documentation/config/diff.txt   | 14 ++++++++++++++
 Documentation/git.txt           |  7 +++++++
 Documentation/gitattributes.txt |  5 +++++
 diff.c                          | 30 +++++++++++++++++++++++++++++-
 t/t4020-diff-external.sh        | 23 +++++++++++++++++------
 userdiff.c                      |  4 ++++
 userdiff.h                      |  1 +
 7 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 5ce7b91f1d..485a13236d 100644
=2D-- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -79,6 +79,13 @@ diff.external::
 	you want to use an external diff program only on a subset of
 	your files, you might want to use linkgit:gitattributes[5] instead.

+diff.trustExitCode::
+	If this boolean value is set to true then the `diff.external`
+	command is expected to return exit code 1 if it finds
+	significant changes and 0 if it doesn't, like diff(1).  If it's
+	false then the `diff.external` command is expected to always
+	return exit code 0.  Defaults to false.
+
 diff.ignoreSubmodules::
 	Sets the default value of --ignore-submodules. Note that this
 	affects only 'git diff' Porcelain, and not lower level 'diff'
@@ -164,6 +171,13 @@ diff.<driver>.command::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.

+diff.<driver>.trustExitCode::
+	If this boolean value is set to true then the
+	`diff.<driver>.command` command is expected to return exit code
+	1 if it finds significant changes and 0 if it doesn't, like
+	diff(1).  If it's false then the `diff.external` command is
+	expected to always return exit code 0.  Defaults to false.
+
 diff.<driver>.xfuncname::
 	The regular expression that the diff driver should use to
 	recognize the hunk header.  A built-in pattern may also be used.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a31a70acca..81b806416c 100644
=2D-- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -644,6 +644,13 @@ parameter, <path>.
 For each path `GIT_EXTERNAL_DIFF` is called, two environment variables,
 `GIT_DIFF_PATH_COUNTER` and `GIT_DIFF_PATH_TOTAL` are set.

+`GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE`::
+	Setting this environment variable indicates the the program
+	specified with `GIT_EXTERNAL_DIFF` returns exit code 1 if it
+	finds significant changes and 0 if it doesn't, like diff(1).
+	If it's not set, the program is expected to always return
+	exit code 0.
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
index 286d093bfa..3dff81ec7d 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -430,6 +430,10 @@ int git_diff_ui_config(const char *var, const char *v=
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
@@ -554,6 +558,8 @@ static const struct external_diff *external_diff(void)
 	if (done_preparing)
 		return external_diff_ptr;
 	external_diff_env.cmd =3D xstrdup_or_null(getenv("GIT_EXTERNAL_DIFF"));
+	if (git_env_bool("GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE", 0))
+		external_diff_env.trust_exit_code =3D 1;
 	if (external_diff_env.cmd)
 		external_diff_ptr =3D &external_diff_env;
 	else if (external_diff_cfg.cmd)
@@ -4385,6 +4391,18 @@ static void run_external_diff(const struct external=
_diff *pgm,
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
+	int rc;
+
+	/*
+	 * Trivial equality is handled by diff_unmodified_pair() before
+	 * we get here.  If we don't need to show the diff and the
+	 * external diff program lacks the ability to tell us whether
+	 * it's empty then we consider it non-empty without even asking.
+	 */
+	if (!(o->output_format & DIFF_FORMAT_PATCH) && !pgm->trust_exit_code) {
+		o->found_changes =3D 1;
+		return;
+	}

 	strvec_push(&cmd.args, pgm->cmd);
 	strvec_push(&cmd.args, name);
@@ -4406,7 +4424,10 @@ static void run_external_diff(const struct external=
_diff *pgm,
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	cmd.use_shell =3D 1;
-	if (run_command(&cmd))
+	rc =3D run_command(&cmd);
+	if ((!pgm->trust_exit_code && !rc) || (pgm->trust_exit_code && rc =3D=3D=
 1))
+		o->found_changes =3D 1;
+	else if (!pgm->trust_exit_code || rc)
 		die(_("external diff died, stopping at %s"), name);

 	remove_tempfile();
@@ -4924,6 +4945,13 @@ void diff_setup_done(struct diff_options *options)
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
index bed640b2b1..bbb49b8a0a 100755
=2D-- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -175,19 +175,22 @@ test_expect_success 'no diff with -diff' '
 check_external_exit_code () {
 	expect_code=3D$1
 	command_code=3D$2
-	option=3D$3
+	trust_exit_code=3D$3
+	option=3D$4

 	command=3D"exit $command_code;"
-	desc=3D"external diff '$command'"
+	desc=3D"external diff '$command' with trustExitCode=3D$trust_exit_code"

 	test_expect_success "$desc via attribute with $option" "
 		test_config diff.foo.command \"$command\" &&
+		test_config diff.foo.trustExitCode $trust_exit_code &&
 		echo \"file diff=3Dfoo\" >.gitattributes &&
 		test_expect_code $expect_code git diff $option
 	"

 	test_expect_success "$desc via diff.external with $option" "
 		test_config diff.external \"$command\" &&
+		test_config diff.trustExitCode $trust_exit_code &&
 		>.gitattributes &&
 		test_expect_code $expect_code git diff $option
 	"
@@ -196,14 +199,22 @@ check_external_exit_code () {
 		>.gitattributes &&
 		test_expect_code $expect_code env \
 			GIT_EXTERNAL_DIFF=3D\"$command\" \
+			GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE=3D$trust_exit_code \
 			git diff $option
 	"
 }

-check_external_exit_code   1 0 --exit-code
-check_external_exit_code   1 0 --quiet
-check_external_exit_code 128 1 --exit-code
-check_external_exit_code   1 1 --quiet # we don't even call the program
+check_external_exit_code   1 0 off --exit-code
+check_external_exit_code   1 0 off --quiet
+check_external_exit_code 128 1 off --exit-code
+check_external_exit_code   1 1 off --quiet # we don't even call the progr=
am
+
+check_external_exit_code   0 0 on --exit-code
+check_external_exit_code   0 0 on --quiet
+check_external_exit_code   1 1 on --exit-code
+check_external_exit_code   1 1 on --quiet
+check_external_exit_code 128 2 on --exit-code
+check_external_exit_code 128 2 on --quiet

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
index 7e2b28e88d..5f1c8cc49c 100644
=2D-- a/userdiff.h
+++ b/userdiff.h
@@ -13,6 +13,7 @@ struct userdiff_funcname {

 struct external_diff {
 	const char *cmd;
+	unsigned trust_exit_code:1;
 };

 struct userdiff_driver {
=2D-
2.45.2
