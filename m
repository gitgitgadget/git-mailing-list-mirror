Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5015358F
	for <git@vger.kernel.org>; Fri,  3 May 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742214; cv=none; b=k3RV88u/A6jpA4iGrRls8ljaPuHOBjqpIjlYzOajlETh8rtbkqetRliCsy3u1YbkeF1Df7nS5AENA6qlaeumus4p/Y4MkB82go4NMxvgFL/nmI/ghsDDMPFAo1OD1WQm3OUxNseiHT2PwW/PQayFxBcVdhMNW+DdjxNmMfNkpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742214; c=relaxed/simple;
	bh=snf0MnbZy2iacPVboeU0LwOnyYaQo8hy/Ff/YtmaJWs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TQJnX3ovwC0xeHGwuOnrFQywudB5EoYkqm3rgfwiTsjhVryzDXwLy0VLR1KKUh5VmXS+4mSJc2mOOWdB6OfwtqXztE0ycEleBdA786ntHJ0FxhQ6RGigduhDqriLksHj59glLgNk4iU7ZiOQudgs0B31lfyGK6IyrxHRE0WlXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 443DDkCK1885973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 13:13:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Karthik Nayak'" <karthik.188@gmail.com>,
        "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>
Cc: "'Kristoffer Haugsbakk'" <code@khaugsbakk.name>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "=?utf-8?Q?'Jean-No=C3=ABl_AVILA'?=" <jn.avila@free.fr>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im> <b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im> <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
In-Reply-To: <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
Subject: RE: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
Date: Fri, 3 May 2024 09:13:42 -0400
Organization: Nexbridge Inc.
Message-ID: <015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKBQTBe5e4gLvpUZ43kt8vf+F35UwHSzjW9AiAHsugCVIXXI7AF+Z6Q
Content-Language: en-ca

On Friday, May 3, 2024 9:09 AM. Karthik Nayak wrote:
>Patrick Steinhardt <ps@pks.im> writes:
>
>> While git-config(1) has several modes, those modes are not exposed
>> with subcommands but instead by specifying e.g. `--unset` or =
`--list`.
>> This
>
>s/specifying/specifying flags/ perhaps?
>
>> user interface is not really in line with how our more modern =
commands
>> work, where it is a lot more customary to say e.g. `git remote list`.
>
>Tangent: I totally agree with the patch, but it would be nice to have a
>'DesigningCommands' document which would highlight UX do's and don'ts.
>It would be nice to add that as reference in discussions.
>
>> Furthermore, to add to the confusion, git-config(1) also allows the
>> user to request modes implicitly by just specifying the correct =
number
>> of arguments. Thus, `git config foo.bar` will retrieve the value of
>> "foo.bar" while `git config foo.bar baz` will set it to "baz".
>>
>> Overall, this makes for a confusing interface that could really use a
>> makeover. It hurts discoverability of what you can do with
>> git-config(1) and is comparatively easy to get wrong. Converting the
>> command to have subcommands instead would go a long way to help =
address
>these issues.
>>
>> One concern in this context is backwards compatibility. Luckily, we
>> can introduce subcommands without breaking backwards compatibility at =
all.
>> This is because all the implicit modes of git-config(1) require that
>> the first argument is a properly formatted config key. And as config
>> keys _must_ have a dot in their name, any value without a dot would
>> have been discarded by git-config(1) previous to this change. Thus,
>> given that none of the subcommands do have a dot, they are =
unambiguous.
>>
>> Introduce the first such new subcommand, which is "git config list".
>> To retain backwards compatibility we only conditionally use
>> subcommands and will fall back to the old syntax in case no =
subcommand was
>detected.
>> This should help to transition to the new-style syntax until we
>> eventually deprecate and remove the old-style syntax.
>>
>> Note that the way we handle this we're duplicating some functionality
>> across old and new syntax. While this isn't pretty, it helps us to
>> ensure that there really is no change in behaviour for the old =
syntax.
>>
>> Amend tests such that we run them both with old and new style syntax.
>> As tests are now run twice, state from the first run may be still be
>> around in the second run and thus cause tests to fail. Add cleanup
>> logic as required to fix such tests.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  Documentation/git-config.txt |  26 ++++++---
>>  builtin/config.c             |  90 ++++++++++++++++++++++++----
>>  t/t1300-config.sh            | 110 =
+++++++++++++++++++++--------------
>>  3 files changed, 162 insertions(+), 64 deletions(-)
>>
>> diff --git a/Documentation/git-config.txt
>> b/Documentation/git-config.txt index ac61113fcc..c83c97cb7e 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -9,6 +9,7 @@ git-config - Get and set repository or global options
>> SYNOPSIS
>>  --------
>>  [verse]
>> +'git config list' [<file-option>] [<display-option>] [--includes]
>>  'git config' [<file-option>] [--type=3D<type>] =
[--comment=3D<message>]
>> [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name>
>> [<value> [<value-pattern>]]  'git config' [<file-option>]
>> [--type=3D<type>] [--comment=3D<message>] --add <name> <value>  'git
>> config' [<file-option>] [--type=3D<type>] [--comment=3D<message>]
>> [--fixed-value] --replace-all <name> <value> [<value-pattern>] @@
>> -20,7 +21,6 @@ SYNOPSIS  'git config' [<file-option>] [--fixed-value]
>> --unset-all <name> [<value-pattern>]  'git config' [<file-option>]
>> --rename-section <old-name> <new-name>  'git config' [<file-option>]
>> --remove-section <name> -'git config' [<file-option>] [--show-origin]
>> [--show-scope] [-z|--null] [--name-only] -l | --list  'git config'
>> [<file-option>] --get-color <name> [<default>]  'git config' =
[<file-option>] --get-
>colorbool <name> [<stdout-is-tty>]  'git config' [<file-option>] -e | =
--edit @@ -74,6
>+74,12 @@ On success, the command returns the exit code 0.
>>  A list of all available configuration variables can be obtained =
using
>> the  `git help --config` command.
>>
>> +COMMANDS
>> +--------
>> +
>> +list::
>> +	List all variables set in config file, along with their values.
>> +
>>  [[OPTIONS]]
>>  OPTIONS
>>  -------
>> @@ -190,10 +196,6 @@ See also <<FILES>>.
>>  --unset-all::
>>  	Remove all lines matching the key from config file.
>>
>> --l::
>> ---list::
>> -	List all variables set in config file, along with their values.
>> -
>>  --fixed-value::
>>  	When used with the `value-pattern` argument, treat `value-pattern` =
as
>>  	an exact string instead of a regular expression. This will restrict
>> @@ -248,7 +250,7 @@ Valid `<type>`'s include:
>>  	contain line breaks.
>>
>>  --name-only::
>> -	Output only the names of config variables for `--list` or
>> +	Output only the names of config variables for `list` or
>>  	`--get-regexp`.
>>
>>  --show-origin::
>> @@ -300,10 +302,20 @@ Valid `<type>`'s include:
>>    When using `--get`, and the requested variable is not found, =
behave as if
>>    <value> were the value assigned to that variable.
>>
>> +DEPRECATED MODES
>> +----------------
>> +
>> +The following modes have been deprecated in favor of subcommands. It
>> +is recommended to migrate to the new syntax.
>> +
>> +-l::
>> +--list::
>> +	Replaced by `git config list`.
>> +
>>  CONFIGURATION
>>  -------------
>>  `pager.config` is only respected when listing configuration, i.e.,
>> when -using `--list` or any of the `--get-*` which may return =
multiple results.
>> +using `list` or any of the `--get-*` which may return multiple =
results.
>>  The default is to use a pager.
>>
>>  [[FILES]]
>> diff --git a/builtin/config.c b/builtin/config.c index
>> 59877065f8..f89ddce8da 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -16,10 +16,16 @@
>>  #include "worktree.h"
>>
>>  static const char *const builtin_config_usage[] =3D {
>> +	N_("git config list [<file-option>] [<display-option>]
>> +[--includes]"),
>>  	N_("git config [<options>]"),
>>  	NULL
>>  };
>>
>> +static const char *const builtin_config_list_usage[] =3D {
>> +	N_("git config list [<file-option>] [<display-option>] =
[--includes]"),
>> +	NULL
>> +};
>> +
>>  static char *key;
>>  static regex_t *key_regexp;
>>  static const char *value_pattern;
>> @@ -33,6 +39,7 @@ static char delim =3D '=3D';  static char key_delim =
=3D '
>> ';  static char term =3D '\n';
>>
>> +static parse_opt_subcommand_fn *subcommand;
>>  static int use_global_config, use_system_config, use_local_config;
>> static int use_worktree_config;  static struct git_config_source
>> given_config_source; @@ -706,14 +713,24 @@ static void
>> handle_nul(void) {
>>  	}
>>  }
>>
>> +#define CONFIG_LOCATION_OPTIONS \
>> +	OPT_GROUP(N_("Config file location")), \
>> +	OPT_BOOL(0, "global", &use_global_config, N_("use global config =
file")), \
>> +	OPT_BOOL(0, "system", &use_system_config, N_("use system config
>file")), \
>> +	OPT_BOOL(0, "local", &use_local_config, N_("use repository config =
file")), \
>> +	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree
>config file")), \
>> +	OPT_STRING('f', "file", &given_config_source.file, N_("file"), =
N_("use given
>config file")), \
>> +	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"),
>> +N_("read config from given blob object"))
>> +
>> +#define CONFIG_DISPLAY_OPTIONS \
>> +	OPT_GROUP(N_("Display options")), \
>> +	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL =
byte")), \
>> +	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names
>only")), \
>> +	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config =
(file,
>standard input, blob, command line)")), \
>> +	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config
>> +(worktree, local, global, system, command)"))
>> +
>>  static struct option builtin_config_options[] =3D {
>> -	OPT_GROUP(N_("Config file location")),
>> -	OPT_BOOL(0, "global", &use_global_config, N_("use global config =
file")),
>> -	OPT_BOOL(0, "system", &use_system_config, N_("use system config
>file")),
>> -	OPT_BOOL(0, "local", &use_local_config, N_("use repository config =
file")),
>> -	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree
>config file")),
>> -	OPT_STRING('f', "file", &given_config_source.file, N_("file"), =
N_("use given
>config file")),
>> -	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"),
>N_("read config from given blob object")),
>> +	CONFIG_LOCATION_OPTIONS,
>>  	OPT_GROUP(N_("Action")),
>>  	OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-
>pattern>]"), ACTION_GET),
>>  	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key
>> [<value-pattern>]"), ACTION_GET_ALL), @@ -737,15 +754,12 @@ static =
struct
>option builtin_config_options[] =3D {
>>  	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or
>string"), TYPE_BOOL_OR_STR),
>>  	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or
>directory name)"), TYPE_PATH),
>>  	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry
>> date"), TYPE_EXPIRY_DATE),
>> +	CONFIG_DISPLAY_OPTIONS,
>>  	OPT_GROUP(N_("Other")),
>> -	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL =
byte")),
>> -	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names
>only")),
>> -	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include
>directives on lookup")),
>> -	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config =
(file,
>standard input, blob, command line)")),
>> -	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config
>(worktree, local, global, system, command)")),
>>  	OPT_STRING(0, "default", &default_value, N_("value"), N_("with =
--get, use
>default value when missing entry")),
>>  	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-
>readable comment string (# will be prepended as needed)")),
>>  	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality
>> when comparing values to 'value-pattern'")),
>> +	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include
>> +directives on lookup")),
>>  	OPT_END(),
>>  };
>>
>> @@ -754,6 +768,42 @@ static NORETURN void usage_builtin_config(void)
>>  	usage_with_options(builtin_config_usage, builtin_config_options);  =
}
>>
>> +static int cmd_config_list(int argc, const char **argv, const char
>> +*prefix) {
>> +	struct option opts[] =3D {
>> +		CONFIG_LOCATION_OPTIONS,
>> +		CONFIG_DISPLAY_OPTIONS,
>> +		OPT_GROUP(N_("Other")),
>> +		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect
>include directives on lookup")),
>> +		OPT_END(),
>> +	};
>> +
>> +	argc =3D parse_options(argc, argv, prefix, opts, =
builtin_config_list_usage, 0);
>> +	check_argc(argc, 0, 0);
>> +
>> +	handle_config_location(prefix);
>> +	handle_nul();
>> +
>> +	setup_auto_pager("config", 1);
>> +
>> +	if (config_with_options(show_all_config, NULL,
>> +				&given_config_source, the_repository,
>> +				&config_options) < 0) {
>> +		if (given_config_source.file)
>> +			die_errno(_("unable to read config file '%s'"),
>> +				  given_config_source.file);
>> +		else
>> +			die(_("error processing config file(s)"));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct option builtin_subcommand_options[] =3D {
>> +	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
>> +	OPT_END(),
>> +};
>> +
>>  int cmd_config(int argc, const char **argv, const char *prefix)  {
>>  	char *value =3D NULL, *comment =3D NULL; @@ -763,6 +813,22 @@ int
>> cmd_config(int argc, const char **argv, const char *prefix)
>>
>>  	given_config_source.file =3D
>> xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
>>
>> +	/*
>> +	 * This is somewhat hacky: we first parse the command line while
>> +	 * keeping all args intact in order to determine whether a =
subcommand
>> +	 * has been specified. If so, we re-parse it a second time, but =
this
>> +	 * time we drop KEEP_ARGV0. This is so that we don't munge the =
command
>> +	 * line in case no subcommand was given, which would otherwise =
confuse
>> +	 * us when parsing the legacy-style modes that don't use =
subcommands.
>> +	 */
>> +	argc =3D parse_options(argc, argv, prefix, =
builtin_subcommand_options,
>builtin_config_usage,
>> +
>PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARSE
>_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_UNKNOWN_OPT);
>> +	if (subcommand) {
>> +		argc =3D parse_options(argc, argv, prefix,
>builtin_subcommand_options, builtin_config_usage,
>> +
>PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARSE
>_OPT_KEEP_UNKNOWN_OPT);
>> +		return subcommand(argc, argv, prefix);
>> +	}
>> +
>>  	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
>>  			     builtin_config_usage,
>>  			     PARSE_OPT_STOP_AT_NON_OPTION); diff --git
>a/t/t1300-config.sh
>> b/t/t1300-config.sh index 86dc70769a..f77d2f7847 100755
>> --- a/t/t1300-config.sh
>> +++ b/t/t1300-config.sh
>> @@ -11,6 +11,20 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>  TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>  . ./test-lib.sh
>>
>> +for mode in legacy subcommands
>> +do
>> +
>> +case "$mode" in
>> +legacy)
>> +	mode_prefix=3D"--"
>> +	;;
>> +subcommands)
>> +	mode_prefix=3D""
>> +	;;
>> +*)
>> +	BUG "unknown mode $mode";;
>> +esac
>> +
>>  test_expect_success 'setup whitespace config' '
>>  	sed -e "s/^|//" \
>>  	    -e "s/[$]$//" \
>> @@ -460,11 +474,11 @@ version.1.2.3eX.alpha=3Dbeta  EOF
>>
>>  test_expect_success 'working --list' '
>> -	git config --list > output &&
>> +	git config ${mode_prefix}list > output &&
>>  	test_cmp expect output
>>  '
>>  test_expect_success '--list without repo produces empty output' '
>> -	git --git-dir=3Dnonexistent config --list >output &&
>> +	git --git-dir=3Dnonexistent config ${mode_prefix}list >output &&
>>  	test_must_be_empty output
>>  '
>>
>> @@ -476,7 +490,7 @@ version.1.2.3eX.alpha  EOF
>>
>>  test_expect_success '--name-only --list' '
>> -	git config --name-only --list >output &&
>> +	git config ${mode_prefix}list --name-only >output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -614,17 +628,17 @@ ein.bahn=3Dstrasse  EOF
>>
>>  test_expect_success 'alternative GIT_CONFIG' '
>> -	GIT_CONFIG=3Dother-config git config --list >output &&
>> +	GIT_CONFIG=3Dother-config git config ${mode_prefix}list >output &&
>>  	test_cmp expect output
>>  '
>>
>>  test_expect_success 'alternative GIT_CONFIG (--file)' '
>> -	git config --file other-config --list >output &&
>> +	git config ${mode_prefix}list --file other-config >output &&
>>  	test_cmp expect output
>>  '
>>
>>  test_expect_success 'alternative GIT_CONFIG (--file=3D-)' '
>> -	git config --file - --list <other-config >output &&
>> +	git config ${mode_prefix}list --file - <other-config >output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -637,6 +651,7 @@ test_expect_success 'editing stdin is an error' '
>>  '
>>
>>  test_expect_success 'refer config from subdirectory' '
>> +	test_when_finished "rm -r x" &&
>>  	mkdir x &&
>>  	test_cmp_config -C x strasse --file=3D../other-config --get =
ein.bahn
>> '
>> @@ -847,7 +862,7 @@ test_expect_success 'line number is reported =
correctly' '
>>  '
>>
>>  test_expect_success 'invalid stdin config' '
>> -	echo "[broken" | test_must_fail git config --list --file - >output =
2>&1 &&
>> +	echo "[broken" | test_must_fail git config ${mode_prefix}list =
--file
>> +- >output 2>&1 &&
>>  	test_grep "bad config line 1 in standard input" output  '
>>
>> @@ -1139,7 +1154,7 @@ section.quotecont=3Dcont;inued  EOF
>>
>>  test_expect_success 'value continued on next line' '
>> -	git config --list > result &&
>> +	git config ${mode_prefix}list > result &&
>>  	test_cmp expect result
>>  '
>>
>> @@ -1163,7 +1178,7 @@ Qsection.sub=3Dsection.val4
>> Qsection.sub=3Dsection.val5Q  EOF  test_expect_success '--null =
--list' '
>> -	git config --null --list >result.raw &&
>> +	git config ${mode_prefix}list --null >result.raw &&
>>  	nul_to_q <result.raw >result &&
>>  	echo >>result &&
>>  	test_cmp expect result
>> @@ -1198,6 +1213,7 @@ test_expect_success 'inner whitespace kept =
verbatim,
>horizontal tabs and spaces'
>>  '
>>
>>  test_expect_success SYMLINKS 'symlinked configuration' '
>> +	test_when_finished "rm myconfig" &&
>>  	ln -s notyet myconfig &&
>>  	git config --file=3Dmyconfig test.frotz nitfol &&
>>  	test -h myconfig &&
>> @@ -1218,10 +1234,11 @@ test_expect_success SYMLINKS 'symlinked
>configuration' '
>>  '
>>
>>  test_expect_success SYMLINKS 'symlink to nonexistent configuration' =
'
>> +	test_when_finished "rm linktonada linktolinktonada" &&
>>  	ln -s doesnotexist linktonada &&
>>  	ln -s linktonada linktolinktonada &&
>> -	test_must_fail git config --file=3Dlinktonada --list &&
>> -	test_must_fail git config --file=3Dlinktolinktonada --list
>> +	test_must_fail git config ${mode_prefix}list --file=3Dlinktonada &&
>> +	test_must_fail git config ${mode_prefix}list =
--file=3Dlinktolinktonada
>>  '
>>
>>  test_expect_success 'check split_cmdline return' '
>> @@ -1478,7 +1495,7 @@ do
>>  done
>>
>>  test_expect_success 'git -c is not confused by empty environment' '
>> -	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config --list
>> +	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config =
${mode_prefix}list
>>  '
>>
>>  test_expect_success 'GIT_CONFIG_PARAMETERS handles old-style =
entries' '
>> @@ -1669,31 +1686,31 @@ test_expect_success 'git config ignores pairs =
with
>empty count' '
>>  '
>>
>>  test_expect_success 'git config fails with invalid count' '
>> -	test_must_fail env GIT_CONFIG_COUNT=3D10a git config --list 2>error =
&&
>> +	test_must_fail env GIT_CONFIG_COUNT=3D10a git config
>> +${mode_prefix}list 2>error &&
>>  	test_grep "bogus count" error &&
>> -	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config =
--
>list 2>error &&
>> +	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config
>> +${mode_prefix}list 2>error &&
>>  	test_grep "too many entries" error
>>  '
>>
>>  test_expect_success 'git config fails with missing config key' '
>>  	test_must_fail env GIT_CONFIG_COUNT=3D1 =
GIT_CONFIG_VALUE_0=3D"value"
>\
>> -		git config --list 2>error &&
>> +		git config ${mode_prefix}list 2>error &&
>>  	test_grep "missing config key" error  '
>>
>>  test_expect_success 'git config fails with missing config value' '
>>  	test_must_fail env GIT_CONFIG_COUNT=3D1 =
GIT_CONFIG_KEY_0=3D"pair.one" \
>> -		git config --list 2>error &&
>> +		git config ${mode_prefix}list 2>error &&
>>  	test_grep "missing config value" error  '
>>
>>  test_expect_success 'git config fails with invalid config pair key' =
'
>>  	test_must_fail env GIT_CONFIG_COUNT=3D1 \
>>  		GIT_CONFIG_KEY_0=3D GIT_CONFIG_VALUE_0=3Dvalue \
>> -		git config --list &&
>> +		git config ${mode_prefix}list &&
>>  	test_must_fail env GIT_CONFIG_COUNT=3D1 \
>>  		GIT_CONFIG_KEY_0=3Dmissing-section GIT_CONFIG_VALUE_0=3Dvalue
>\
>> -		git config --list
>> +		git config ${mode_prefix}list
>>  '
>>
>>  test_expect_success 'environment overrides config file' '
>> @@ -1733,7 +1750,7 @@ test_expect_success 'git config --edit works' '
>>  	git config -f tmp test.value no &&
>>  	echo test.value=3Dyes >expect &&
>>  	GIT_EDITOR=3D"echo [test]value=3Dyes >" git config -f tmp --edit &&
>> -	git config -f tmp --list >actual &&
>> +	git config ${mode_prefix}list -f tmp >actual &&
>>  	test_cmp expect actual
>>  '
>>
>> @@ -1742,7 +1759,7 @@ test_expect_success 'git config --edit respects
>core.editor' '
>>  	echo test.value=3Dyes >expect &&
>>  	test_config core.editor "echo [test]value=3Dyes >" &&
>>  	git config -f tmp --edit &&
>> -	git config -f tmp --list >actual &&
>> +	git config ${mode_prefix}list -f tmp >actual &&
>>  	test_cmp expect actual
>>  '
>>
>> @@ -2093,7 +2110,7 @@ test_expect_success '--show-origin with --list' =
'
>>  	command line:	user.cmdline=3Dtrue
>>  	EOF
>>  	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Duser.environ
>GIT_CONFIG_VALUE_0=3Dtrue\
>> -		git -c user.cmdline=3Dtrue config --list --show-origin >output &&
>> +		git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-origin
>> +>output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -2110,7 +2127,7 @@ test_expect_success '--show-origin with --list =
--null' '
>>  	includeQcommand line:Quser.cmdline
>>  	trueQ
>>  	EOF
>> -	git -c user.cmdline=3Dtrue config --null --list --show-origin =
>output.raw &&
>> +	git -c user.cmdline=3Dtrue config ${mode_prefix}list --null
>> +--show-origin >output.raw &&
>>  	nul_to_q <output.raw >output &&
>>  	# The here-doc above adds a newline that the --null output would =
not
>>  	# include. Add it here to make the two comparable.
>> @@ -2124,7 +2141,7 @@ test_expect_success '--show-origin with single =
file' '
>>  	file:.git/config	user.override=3Dlocal
>>  	file:.git/config	include.path=3D../include/relative.include
>>  	EOF
>> -	git config --local --list --show-origin >output &&
>> +	git config ${mode_prefix}list --local --show-origin >output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -2162,7 +2179,7 @@ test_expect_success !MINGW '--show-origin =
escape
>special file name characters' '
>>  	cat >expect <<-\EOF &&
>>  	file:"file\" (dq) and spaces.conf"	user.custom=3Dtrue
>>  	EOF
>> -	git config --file "$WEIRDLY_NAMED_FILE" --show-origin --list =
>output &&
>> +	git config ${mode_prefix}list --file "$WEIRDLY_NAMED_FILE"
>> +--show-origin >output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -2170,7 +2187,7 @@ test_expect_success '--show-origin stdin' '
>>  	cat >expect <<-\EOF &&
>>  	standard input:	user.custom=3Dtrue
>>  	EOF
>> -	git config --file - --show-origin --list <"$CUSTOM_CONFIG_FILE" =
>output
>&&
>> +	git config ${mode_prefix}list --file - --show-origin
>> +<"$CUSTOM_CONFIG_FILE" >output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -2197,7 +2214,7 @@ test_expect_success '--show-origin blob' '
>>  		cat >expect <<-EOF &&
>>  		blob:$blob	user.custom=3Dtrue
>>  		EOF
>> -		git config --blob=3D$blob --show-origin --list >output &&
>> +		git config ${mode_prefix}list --blob=3D$blob --show-origin >output
>&&
>>  		test_cmp expect output
>>  	)
>>  '
>> @@ -2213,7 +2230,7 @@ test_expect_success '--show-origin blob ref' '
>>  		cp "$CUSTOM_CONFIG_FILE" custom.conf &&
>>  		git add custom.conf &&
>>  		git commit -m "new config file" &&
>> -		git config --blob=3Dmain:custom.conf --show-origin --list >output =
&&
>> +		git config ${mode_prefix}list --blob=3Dmain:custom.conf --show-
>origin
>> +>output &&
>>  		test_cmp expect output
>>  	)
>>  '
>> @@ -2239,13 +2256,14 @@ test_expect_success '--show-scope with =
--list' '
>>  	worktree	user.worktree=3Dtrue
>>  	command	user.cmdline=3Dtrue
>>  	EOF
>> +	test_when_finished "git worktree remove wt1" &&
>>  	git worktree add wt1 &&
>>  	# We need these to test for worktree scope, but outside of this
>>  	# test, this is just noise
>>  	test_config core.repositoryformatversion 1 &&
>>  	test_config extensions.worktreeConfig true &&
>>  	git config --worktree user.worktree true &&
>> -	git -c user.cmdline=3Dtrue config --list --show-scope >output &&
>> +	git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-scope
>> +>output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -2254,7 +2272,7 @@ test_expect_success !MINGW '--show-scope with =
--
>blob' '
>>  	cat >expect <<-EOF &&
>>  	command	user.custom=3Dtrue
>>  	EOF
>> -	git config --blob=3D$blob --show-scope --list >output &&
>> +	git config ${mode_prefix}list --blob=3D$blob --show-scope >output =
&&
>>  	test_cmp expect output
>>  '
>>
>> @@ -2264,7 +2282,7 @@ test_expect_success '--show-scope with --local' =
'
>>  	local	user.override=3Dlocal
>>  	local	include.path=3D../include/relative.include
>>  	EOF
>> -	git config --local --list --show-scope >output &&
>> +	git config ${mode_prefix}list --local --show-scope >output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -2288,7 +2306,7 @@ test_expect_success '--show-scope with =
--show-origin'
>'
>>  	local	file:.git/../include/relative.include	user.relative=3Dinclude
>>  	command	command line:	user.cmdline=3Dtrue
>>  	EOF
>> -	git -c user.cmdline=3Dtrue config --list --show-origin --show-scope =
>output
>&&
>> +	git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-origin
>> +--show-scope >output &&
>>  	test_cmp expect output
>>  '
>>
>> @@ -2329,7 +2347,7 @@ test_expect_success 'override global and system
>config' '
>>  	global	home.config=3Dtrue
>>  	local	local.config=3Dtrue
>>  	EOF
>> -	git config --show-scope --list >output &&
>> +	git config ${mode_prefix}list --show-scope >output &&
>>  	test_cmp expect output &&
>>
>>  	cat >expect <<-EOF &&
>> @@ -2338,20 +2356,20 @@ test_expect_success 'override global and =
system
>config' '
>>  	local	local.config=3Dtrue
>>  	EOF
>>  	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3Dcustom-system-
>config GIT_CONFIG_GLOBAL=3Dcustom-global-config \
>> -		git config --show-scope --list >output &&
>> +		git config ${mode_prefix}list --show-scope >output &&
>>  	test_cmp expect output &&
>>
>>  	cat >expect <<-EOF &&
>>  	local	local.config=3Dtrue
>>  	EOF
>>  	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3D/dev/null
>GIT_CONFIG_GLOBAL=3D/dev/null \
>> -		git config --show-scope --list >output &&
>> +		git config ${mode_prefix}list --show-scope >output &&
>>  	test_cmp expect output
>>  '
>>
>>  test_expect_success 'override global and system config with missing =
file' '
>> -	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist
>GIT_CONFIG_SYSTEM=3D/dev/null git config --global --list &&
>> -	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null
>GIT_CONFIG_SYSTEM=3Ddoes-not-exist git config --system --list &&
>> +	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist
>GIT_CONFIG_SYSTEM=3D/dev/null git config ${mode_prefix}list --global &&
>> +	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null
>> +GIT_CONFIG_SYSTEM=3Ddoes-not-exist git config ${mode_prefix}list
>> +--system &&
>>  	GIT_CONFIG_GLOBAL=3Ddoes-not-exist =
GIT_CONFIG_SYSTEM=3Ddoes-not-exist
>> git version  '
>>
>> @@ -2478,7 +2496,7 @@ test_expect_success 'set all config with =
value-pattern' '
>>  	# no match =3D> add new entry
>>  	cp initial config &&
>>  	git config --file=3Dconfig abc.key two a+ &&
>> -	git config --file=3Dconfig --list >actual &&
>> +	git config ${mode_prefix}list --file=3Dconfig >actual &&
>>  	cat >expect <<-\EOF &&
>>  	abc.key=3Done
>>  	abc.key=3Dtwo
>> @@ -2491,7 +2509,7 @@ test_expect_success 'set all config with =
value-pattern' '
>>
>>  	# multiple values, no match =3D> add
>>  	git config --file=3Dconfig abc.key three a+ &&
>> -	git config --file=3Dconfig --list >actual &&
>> +	git config ${mode_prefix}list --file=3Dconfig >actual &&
>>  	cat >expect <<-\EOF &&
>>  	abc.key=3Done
>>  	abc.key=3Dtwo
>> @@ -2501,7 +2519,7 @@ test_expect_success 'set all config with =
value-pattern' '
>>
>>  	# single match =3D> replace
>>  	git config --file=3Dconfig abc.key four h+ &&
>> -	git config --file=3Dconfig --list >actual &&
>> +	git config ${mode_prefix}list --file=3Dconfig >actual &&
>>  	cat >expect <<-\EOF &&
>>  	abc.key=3Done
>>  	abc.key=3Dtwo
>> @@ -2516,7 +2534,7 @@ test_expect_success '--replace-all and =
value-pattern' '
>>  	git config --file=3Dconfig --add abc.key two &&
>>  	git config --file=3Dconfig --add abc.key three &&
>>  	git config --file=3Dconfig --replace-all abc.key four "o+" &&
>> -	git config --file=3Dconfig --list >actual &&
>> +	git config ${mode_prefix}list --file=3Dconfig >actual &&
>>  	cat >expect <<-\EOF &&
>>  	abc.key=3Dfour
>>  	abc.key=3Dthree
>> @@ -2534,7 +2552,7 @@ test_expect_success 'refuse --fixed-value for
>incompatible actions' '
>>  	test_must_fail git config --file=3Dconfig --fixed-value =
--get-urlmatch dev.null
>bogus &&
>>  	test_must_fail git config --file=3Dconfig --fixed-value =
--rename-section dev null
>&&
>>  	test_must_fail git config --file=3Dconfig --fixed-value =
--remove-section dev &&
>> -	test_must_fail git config --file=3Dconfig --fixed-value --list &&
>> +	test_must_fail git config ${mode_prefix}list --file=3Dconfig
>> +--fixed-value &&
>>  	test_must_fail git config --file=3Dconfig --fixed-value --get-color =
dev.null &&
>>  	test_must_fail git config --file=3Dconfig --fixed-value
>> --get-colorbool dev.null &&
>>
>> @@ -2555,7 +2573,7 @@ test_expect_success '--fixed-value uses exact =
string
>matching' '
>>
>>  	cp initial config &&
>>  	git config --file=3Dconfig fixed.test bogus "$META" &&
>> -	git config --file=3Dconfig --list >actual &&
>> +	git config ${mode_prefix}list --file=3Dconfig >actual &&
>>  	cat >expect <<-EOF &&
>>  	fixed.test=3D$META
>>  	fixed.test=3Dbogus
>> @@ -2564,7 +2582,7 @@ test_expect_success '--fixed-value uses exact =
string
>matching' '
>>
>>  	cp initial config &&
>>  	git config --file=3Dconfig --fixed-value fixed.test bogus "$META" =
&&
>> -	git config --file=3Dconfig --list >actual &&
>> +	git config ${mode_prefix}list --file=3Dconfig >actual &&
>>  	cat >expect <<-\EOF &&
>>  	fixed.test=3Dbogus
>>  	EOF
>> @@ -2582,7 +2600,7 @@ test_expect_success '--fixed-value uses exact =
string
>matching' '
>>
>>  	cp initial config &&
>>  	git config --file=3Dconfig --replace-all fixed.test bogus "$META" =
&&
>> -	git config --file=3Dconfig --list >actual &&
>> +	git config ${mode_prefix}list --file=3Dconfig >actual &&
>>  	cat >expect <<-EOF &&
>>  	fixed.test=3D$META
>>  	fixed.test=3Dbogus
>> @@ -2590,7 +2608,7 @@ test_expect_success '--fixed-value uses exact =
string
>matching' '
>>  	test_cmp expect actual &&
>>
>>  	git config --file=3Dconfig --fixed-value --replace-all fixed.test =
bogus "$META"
>&&
>> -	git config --file=3Dconfig --list >actual &&
>> +	git config ${mode_prefix}list --file=3Dconfig >actual &&
>>  	cat >expect <<-EOF &&
>>  	fixed.test=3Dbogus
>>  	fixed.test=3Dbogus
>> @@ -2751,4 +2769,6 @@ test_expect_success 'specifying multiple modes =
causes
>failure' '
>>  	test_cmp expect err
>>  '
>>
>> +done
>> +
>>
>Nit: Wouldn't it be better if the tests are indented here? That way you =
know it's part
>of a loop.

Removing the --list option is going to break backward compatibility for =
users who script the use of config for things like setup, clone =
automation, etc. Adding list as a sub-command could (but should not) =
cause ambiguities between a list and configuration value. If you are =
going to add 'list', please do not remove '--list'. That is a breaking =
change.

Thanks,
Randall

