Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DE18C3D
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918558; cv=none; b=IFiienOzWPXfT/dQzmwCMVj7sgmQH13BqPs/kMFu4iC+X+tWQR6awCUmtJxKXJRxDgU81iKVhvp/P9Bf2H6A9JvbwIsUTOE1vH4z6CqjECW33+p/kIS6xMEn8duiMjEFICLkQeTilC4jRrtg41qyhxlWmJlKSTjHrbrdWHg8RTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918558; c=relaxed/simple;
	bh=iL0dhD10t8WSSWsA3TtCY1BdaGFwCbh22yucxQfLrHg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l9AxDQM3YkWY/rOjnjrL4uP1s9cIUW1MB69HhneUq2fA8WzN8BkFvpFQ7ZSOVpjAvvM0g4FTBZkIqaFJDq3nAKe4uWM+qwUhSZuowCE8WEG744KiOA72F4EoxRnqSYQHYwmUzI3YyZHtoCdtIAzCd56iDwFM0XymI5CPzFD8Hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SBS1gmAF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SBS1gmAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717918541; x=1718523341; i=l.s.r@web.de;
	bh=+46SVAOrHpNn547pmHSKUZBIRsZqDGMZrK0IU8+XiXo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SBS1gmAFp3LAlkX2NTB4vsv3NUQOelSx6VvsxX7k2PMWtoLLWt0N+py9ODOhsOBE
	 1NXlcsj41YkdKYJqNCsMV6c0gGFVHnrnPz7Xe87J7IUjVA/Mkphic4gJ8AKCNx2/o
	 Aig6SXDhnr3tQ0AizaCUuK6dcxCiYfTmKHnvhMBDQxSnANUhDrAxEUOV0gL2Vg9Ap
	 56JCdlb2zlndw9p5h+2YmmpCLNIE0HzhuENu67iQoywPFAacpRRh2Vt9/5RkwOBuF
	 NB+JNR9lwwApHGSjJp8XUYCtG2y+fkp11F9F3CzxQv+/CwcrO3wZDuZolfGW+LR+v
	 rbeeKA8IiiTbiXyg/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8TBM-1sKaoG4ACW-00GItQ; Sun, 09
 Jun 2024 09:35:41 +0200
Message-ID: <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Date: Sun, 9 Jun 2024 09:35:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/3] diff: fix --exit-code with external diff
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Johannes Sixt <j6t@kdbg.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
Content-Language: en-US
In-Reply-To: <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nAQJ6YEdVn302IONwuuVkbNGrkfIoC2oL6vtw2SnZC+xWsnJJiu
 onv5KLRILACTwp7yTmX3yeJm0C31q+A5IsfkGWpj6z+TALX63Mtu/bCg2cyNnswGnKhFw+t
 S6DIQuhP/Wn0UfJvYjMKisTobgBY4kGk63PFAWlsSPwdHHb3rcb5SabB3b51gUz37zOh4Dx
 TjTR1Fq8xXX/9OXpR8lkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8WalB4eWUC0=;pn2n5yg9Pqi6numG8BWPmSj+Idm
 xVTisG28GDlnYKz74s9uzUWGcHNXpPR2NRvafur+KXtpFJ5FY9Fqv5/5p9gAkaAAcjsSbeK7U
 E36l6ohewTIlPDMDW/afJvrfZo8lk8kDk9Ocvfpwq9rUaFuBIffrF7aGyvnzC9qjvDvqadvkW
 GP03/T/+It0GO0QMVaOEM3YSSPaldJ6mGj8H+d4TgKo6OKnRSSuCLaM3a17/PUfyeXOvtcSDj
 K1O0uawMsnEFyqaqW9dgqSVeGeLivKVxxZXsLBZKJaJ9FteA4h6R55CsYa5Z6BLuZVYAqTnSS
 ZxOfFRfV+VMBAMIl+VC1+fb5r5oKA1onuy8g6aYFrzHo2cOBs7NFPD9+M6u1Fc+bdvjR1DEOa
 H69tTM0SP9A57DuzoIz/gPV9Yuoyc1iX93EX3oA3uCyyLGqh3zjD58wmxQ6CMjfBq7MtjElP9
 /m/8qy6aGM9CW/bO1P6U7VO+Uxr57GZT8fneaP79y01RcIEZaVU/VlogOR6BvmusK/hc6zx9u
 audHci1Bf574ID3i8FWstdJouQWUQBpAYw69+Dqhchm3vbQUZzO0mypNiZg9Vy5oKb/zILQMo
 uUm/9nC5Wmz1QEnJe1kAHOSRqYkq4FADw0ZmaimjF74BYErrlm3v8Ostgg+dKyvsl6eEbbZ6Z
 7GVLfE8avWghguNrBwmhiKLEywxGot0uTBET7Frav9G9BVnxcAMhuxXGdOGLEHuQauw/iVqGN
 DqiMDPTSQ50Lxwae4y/xjxXWUq+eHKZ3xp7pxJHwwIZ/HukEu0ZDXzaVftOX+tCSMa7lChrly
 o82EehmvdBgSsS6fjkHZ0zq+nS/tohrTjEpe+iOGcEaL8=

Changes since v2:
- rebase; config strings are no longer const
- document the handling of unexpected exit codes
- document that external diffs are skipped with --quiet and trustExitCode=off
- silence external diff output with --quiet
- check output in tests
- test diff runs without --exit-code and --quiet as well
- slightly untangle the exit code handling code to make it easier to read
- fix copy/paste error in documentation of diff.<driver>.trustExitCode

  t4020: test exit code with external diffs
  userdiff: add and use struct external_diff
  diff: let external diffs report that changes are uninteresting

 Documentation/config/diff.txt   | 18 +++++++++
 Documentation/diff-options.txt  |  5 +++
 Documentation/git.txt           | 10 +++++
 Documentation/gitattributes.txt |  5 +++
 diff.c                          | 68 +++++++++++++++++++++++++--------
 t/t4020-diff-external.sh        | 66 ++++++++++++++++++++++++++++++++
 userdiff.c                      |  8 +++-
 userdiff.h                      |  7 +++-
 8 files changed, 168 insertions(+), 19 deletions(-)

Range-Diff gegen v2:
1:  118aba667b < -:  ---------- t4020: test exit code with external diffs
-:  ---------- > 1:  d59f0c6fdf t4020: test exit code with external diffs
2:  0b4dabebe1 ! 2:  4ad160ab1f userdiff: add and use struct external_diff
    @@ diff.c
     @@ diff.c: static int diff_color_moved_ws_default;
      static int diff_context_default = 3;
      static int diff_interhunk_context_default;
    - static const char *diff_word_regex_cfg;
    --static const char *external_diff_cmd_cfg;
    + static char *diff_word_regex_cfg;
    +-static char *external_diff_cmd_cfg;
     +static struct external_diff external_diff_cfg;
    - static const char *diff_order_file_cfg;
    + static char *diff_order_file_cfg;
      int diff_auto_refresh_index = 1;
      static int diff_mnemonic_prefix;
     @@ diff.c: int git_diff_ui_config(const char *var, const char *value,
    @@ userdiff.h: struct userdiff_funcname {
      };

     +struct external_diff {
    -+	const char *cmd;
    ++	char *cmd;
     +};
     +
      struct userdiff_driver {
      	const char *name;
    --	const char *external;
    +-	char *external;
     +	struct external_diff external;
    - 	const char *algorithm;
    + 	char *algorithm;
      	int binary;
      	struct userdiff_funcname funcname;
3:  4d54ca8281 ! 3:  29c8d3b61a diff: let external diffs report that changes are uninteresting
    @@ Commit message
         diff is not able to report empty diffs.  We can only do that check after
         evaluating the file-specific attributes in run_external_diff().

    +    If we do run the external diff with --quiet, send its output to
    +    /dev/null.
    +
         I considered checking the output of the external diff to check whether
         its empty.  It was added as 11be65cfa4 (diff: fix --exit-code with
         external diff, 2024-05-05) and quickly reverted, as it does not work
    @@ Documentation/config/diff.txt: diff.external::
      	your files, you might want to use linkgit:gitattributes[5] instead.

     +diff.trustExitCode::
    -+	If this boolean value is set to true then the `diff.external`
    -+	command is expected to return exit code 1 if it finds
    -+	significant changes and 0 if it doesn't, like diff(1).  If it's
    -+	false then the `diff.external` command is expected to always
    -+	return exit code 0.  Defaults to false.
    ++	If this boolean value is set to true then the
    ++	`diff.external` command is expected to return exit code
    ++	0 if it considers the input files to be equal or 1 if it
    ++	considers them to be different, like `diff(1)`.
    ++	If it is set to false, which is the default, then the command
    ++	is expected to return exit code 0 regardless of equality.
    ++	Any other exit code causes Git to report a fatal error.
     +
      diff.ignoreSubmodules::
      	Sets the default value of --ignore-submodules. Note that this
    @@ Documentation/config/diff.txt: diff.<driver>.command::
     +diff.<driver>.trustExitCode::
     +	If this boolean value is set to true then the
     +	`diff.<driver>.command` command is expected to return exit code
    -+	1 if it finds significant changes and 0 if it doesn't, like
    -+	diff(1).  If it's false then the `diff.external` command is
    -+	expected to always return exit code 0.  Defaults to false.
    ++	0 if it considers the input files to be equal or 1 if it
    ++	considers them to be different, like `diff(1)`.
    ++	If it is set to false, which is the default, then the command
    ++	is expected to return exit code 0 regardless of equality.
    ++	Any other exit code causes Git to report a fatal error.
     +
      diff.<driver>.xfuncname::
      	The regular expression that the diff driver should use to
      	recognize the hunk header.  A built-in pattern may also be used.

    + ## Documentation/diff-options.txt ##
    +@@ Documentation/diff-options.txt: ifndef::git-log[]
    +
    + --quiet::
    + 	Disable all output of the program. Implies `--exit-code`.
    +-	Disables execution of external diff helpers.
    ++	Disables execution of external diff helpers whose exit code
    ++	is not trusted, i.e. their respective configuration option
    ++	`diff.trustExitCode` or `diff.<driver>.trustExitCode` or
    ++	environment variable `GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE` is
    ++	false.
    + endif::git-log[]
    + endif::git-format-patch[]
    +
    +
      ## Documentation/git.txt ##
     @@ Documentation/git.txt: parameter, <path>.
      For each path `GIT_EXTERNAL_DIFF` is called, two environment variables,
      `GIT_DIFF_PATH_COUNTER` and `GIT_DIFF_PATH_TOTAL` are set.

     +`GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE`::
    -+	Setting this environment variable indicates the the program
    -+	specified with `GIT_EXTERNAL_DIFF` returns exit code 1 if it
    -+	finds significant changes and 0 if it doesn't, like diff(1).
    -+	If it's not set, the program is expected to always return
    -+	exit code 0.
    ++	If this Boolean environment variable is set to true then the
    ++	`GIT_EXTERNAL_DIFF` command is expected to return exit code
    ++	0 if it considers the input files to be equal or 1 if it
    ++	considers them to be different, like `diff(1)`.
    ++	If it is set to false, which is the default, then the command
    ++	is expected to return exit code 0 regardless of equality.
    ++	Any other exit code causes Git to report a fatal error.
    ++
     +
      `GIT_DIFF_PATH_COUNTER`::
      	A 1-based counter incremented by one for every path.
    @@ diff.c: static void run_external_diff(const struct external_diff *pgm,
      {
      	struct child_process cmd = CHILD_PROCESS_INIT;
      	struct diff_queue_struct *q = &diff_queued_diff;
    ++	int quiet = !(o->output_format & DIFF_FORMAT_PATCH);
     +	int rc;
     +
     +	/*
    @@ diff.c: static void run_external_diff(const struct external_diff *pgm,
     +	 * external diff program lacks the ability to tell us whether
     +	 * it's empty then we consider it non-empty without even asking.
     +	 */
    -+	if (!(o->output_format & DIFF_FORMAT_PATCH) && !pgm->trust_exit_code) {
    ++	if (!pgm->trust_exit_code && quiet) {
     +		o->found_changes = 1;
     +		return;
     +	}
    @@ diff.c: static void run_external_diff(const struct external_diff *pgm,
      	diff_free_filespec_data(two);
      	cmd.use_shell = 1;
     -	if (run_command(&cmd))
    ++	cmd.no_stdout = quiet;
     +	rc = run_command(&cmd);
    -+	if ((!pgm->trust_exit_code && !rc) || (pgm->trust_exit_code && rc == 1))
    ++	if (!pgm->trust_exit_code && rc == 0)
    ++		o->found_changes = 1;
    ++	else if (pgm->trust_exit_code && rc == 0)
    ++		; /* nothing */
    ++	else if (pgm->trust_exit_code && rc == 1)
     +		o->found_changes = 1;
    -+	else if (!pgm->trust_exit_code || rc)
    ++	else
      		die(_("external diff died, stopping at %s"), name);

      	remove_tempfile();
    @@ diff.c: void diff_setup_done(struct diff_options *options)
      	if (options->flags.follow_renames)

      ## t/t4020-diff-external.sh ##
    -@@ t/t4020-diff-external.sh: test_expect_success 'no diff with -diff' '
    - check_external_exit_code () {
    - 	expect_code=$1
    - 	command_code=$2
    --	option=$3
    -+	trust_exit_code=$3
    -+	option=$4
    -
    - 	command="exit $command_code;"
    +@@ t/t4020-diff-external.sh: check_external_diff () {
    + 	expect_out=$2
    + 	expect_err=$3
    + 	command_code=$4
    +-	shift 4
    ++	trust_exit_code=$5
    ++	shift 5
    + 	options="$@"
    +
    + 	command="echo output; exit $command_code;"
     -	desc="external diff '$command'"
     +	desc="external diff '$command' with trustExitCode=$trust_exit_code"
    + 	with_options="${options:+ with }$options"

    - 	test_expect_success "$desc via attribute with $option" "
    + 	test_expect_success "$desc via attribute$with_options" "
      		test_config diff.foo.command \"$command\" &&
     +		test_config diff.foo.trustExitCode $trust_exit_code &&
      		echo \"file diff=foo\" >.gitattributes &&
    - 		test_expect_code $expect_code git diff $option
    - 	"
    + 		test_expect_code $expect_code git diff $options >out 2>err &&
    + 		test_cmp $expect_out out &&
    +@@ t/t4020-diff-external.sh: check_external_diff () {

    - 	test_expect_success "$desc via diff.external with $option" "
    + 	test_expect_success "$desc via diff.external$with_options" "
      		test_config diff.external \"$command\" &&
     +		test_config diff.trustExitCode $trust_exit_code &&
      		>.gitattributes &&
    - 		test_expect_code $expect_code git diff $option
    - 	"
    -@@ t/t4020-diff-external.sh: check_external_exit_code () {
    + 		test_expect_code $expect_code git diff $options >out 2>err &&
    + 		test_cmp $expect_out out &&
    +@@ t/t4020-diff-external.sh: check_external_diff () {
      		>.gitattributes &&
      		test_expect_code $expect_code env \
      			GIT_EXTERNAL_DIFF=\"$command\" \
     +			GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE=$trust_exit_code \
    - 			git diff $option
    - 	"
    - }
    -
    --check_external_exit_code   1 0 --exit-code
    --check_external_exit_code   1 0 --quiet
    --check_external_exit_code 128 1 --exit-code
    --check_external_exit_code   1 1 --quiet # we don't even call the program
    -+check_external_exit_code   1 0 off --exit-code
    -+check_external_exit_code   1 0 off --quiet
    -+check_external_exit_code 128 1 off --exit-code
    -+check_external_exit_code   1 1 off --quiet # we don't even call the program
    + 			git diff $options >out 2>err &&
    + 		test_cmp $expect_out out &&
    + 		test_cmp $expect_err err
    +@@ t/t4020-diff-external.sh: test_expect_success 'setup output files' '
    + 	echo "fatal: external diff died, stopping at file" >error
    + '
    +
    +-check_external_diff   0 output empty 0
    +-check_external_diff 128 output error 1
    +-
    +-check_external_diff   1 output empty 0 --exit-code
    +-check_external_diff 128 output error 1 --exit-code
    +-
    +-check_external_diff   1 empty  empty 0 --quiet
    +-check_external_diff   1 empty  empty 1 --quiet # we don't even call the program
    ++check_external_diff   0 output empty 0 off
    ++check_external_diff 128 output error 1 off
    ++check_external_diff   0 output empty 0 on
    ++check_external_diff   0 output empty 1 on
    ++check_external_diff 128 output error 2 on
    ++
    ++check_external_diff   1 output empty 0 off --exit-code
    ++check_external_diff 128 output error 1 off --exit-code
    ++check_external_diff   0 output empty 0 on  --exit-code
    ++check_external_diff   1 output empty 1 on  --exit-code
    ++check_external_diff 128 output error 2 on  --exit-code
     +
    -+check_external_exit_code   0 0 on --exit-code
    -+check_external_exit_code   0 0 on --quiet
    -+check_external_exit_code   1 1 on --exit-code
    -+check_external_exit_code   1 1 on --quiet
    -+check_external_exit_code 128 2 on --exit-code
    -+check_external_exit_code 128 2 on --quiet
    ++check_external_diff   1 empty  empty 0 off --quiet
    ++check_external_diff   1 empty  empty 1 off --quiet # we don't even call the program
    ++check_external_diff   0 empty  empty 0 on  --quiet
    ++check_external_diff   1 empty  empty 1 on  --quiet
    ++check_external_diff 128 empty  error 2 on  --quiet

      echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file

    @@ userdiff.h
     @@ userdiff.h: struct userdiff_funcname {

      struct external_diff {
    - 	const char *cmd;
    + 	char *cmd;
     +	unsigned trust_exit_code:1;
      };

--
2.45.2
