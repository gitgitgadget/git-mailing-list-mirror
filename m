Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A0D1BC22
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762062; cv=none; b=rlkC5WYKF/GxOIq1QziCbOQOrv7y+veK+CT7dq7V+4tiGxemZYSXGLCKfWtJ+8ti63FCWB6MnNaxJpQ0a3U27VVupuIBByhm2Q04GRtonhrVM3GyihYR5UZu2AonZtn2bCGFqI+dG1xoq3yHkeTCR6oETjpWNlmDANt1c/IYZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762062; c=relaxed/simple;
	bh=oRe2qJ1ajIJizBeSDl4kNrzaBcIQ833/3eaeg6VZVoI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcKrrHjgTrBuu8U+EyLz1tWAw3CH+fhCXsCP7vZ2b2ZpLSuNHKbJb7e/FZxR4fcZKjX0bz3NEmKbqEXMBVb1d7Q/PYBuDnYtV6iw2+s9kF3bu4LqXNHfnFb8kQYmszqhlRfti19rNfnV9pWpX/+AUtI2sSHi+rsJQkS3Fe7z6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=M7q9+0XZ; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="M7q9+0XZ"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 8CB22DF8A7B
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 22:54:10 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:ecb6:2cf4:2b4c:20b7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 26B79B0037C;
	Wed,  6 Mar 2024 22:54:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1709762043;
	bh=oRe2qJ1ajIJizBeSDl4kNrzaBcIQ833/3eaeg6VZVoI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M7q9+0XZ2BFgE/9UQfCUWoS8uOatov/XmWGKrKf6RL3b78EJSxzVdCHlL+YW84ayk
	 Uc5ygqghi3LAhMBaCUBGTkihBhteb02fGQ0msXHLu/kvQ8jlNwmlAQzzJb3cLNkDW6
	 js38N39AvrNd04xYk4fYssR0Pvu+QRsqoqpGgTSxR8QvIOKJRoNSXKSZrrTxb8sC7U
	 WKZa4jz9mJMiDci2KzYyV3+VHrCQlfPpefdedkEDxgEdgcX5sbc4Nw80aljIZLC6x6
	 E2+z+WMdfyB844lAG1ObXHjQ52Xxbgzn4ZBkeVBRcpmbb9NJR+RiQSSReWzM839kSf
	 y1vVTp1rRa0UQ==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 5/8] builtin/config: track subcommands by action
Date: Wed, 06 Mar 2024 22:54:01 +0100
Message-ID: <6044285.lOV4Wx5bFT@cayenne>
In-Reply-To:
 <e39774d6495767c6505999bdc33110678139e347.1709724089.git.ps@pks.im>
References:
 <cover.1709724089.git.ps@pks.im>
 <e39774d6495767c6505999bdc33110678139e347.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le mercredi 6 mars 2024, 12:31:50 CET Patrick Steinhardt a =E9crit :
> Part of `cmd_config()` is a rather unwieldy switch statement that
> invokes the correct subcommand function based on which action has been
> requested by the user. Now that we have converted actions to be tracked
> via a `OPT_CMDMODE()`, we know that the `actions` variable will
> only ever have at most one bit set. This allows us to convert the
> variable to use an `enum` instead, and thus to create an array that maps
> from this newly introduced `enum` to the corresponding subcommand
> function.
>=20
> Refactor the code to do so. Besides allowing us to get rid of the giant
> switch statement, this refactoring will also make it easier to introduce
> proper subcommands to git-config(1).
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/config.c | 207 +++++++++++++++++++++++------------------------
>  1 file changed, 99 insertions(+), 108 deletions(-)
>=20
> diff --git a/builtin/config.c b/builtin/config.c
> index a6ab9b8204..0d58397ef5 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -20,6 +20,26 @@ static const char *const builtin_config_usage[] =3D {
>  	NULL
>  };
> =20
> +enum config_action {
> +	ACTION_NONE,
> +	ACTION_GET,
> +	ACTION_GET_ALL,
> +	ACTION_GET_REGEXP,
> +	ACTION_REPLACE_ALL,
> +	ACTION_ADD,
> +	ACTION_UNSET,
> +	ACTION_UNSET_ALL,
> +	ACTION_RENAME_SECTION,
> +	ACTION_REMOVE_SECTION,
> +	ACTION_LIST,
> +	ACTION_EDIT,
> +	ACTION_SET,
> +	ACTION_SET_ALL,
> +	ACTION_GET_COLOR,
> +	ACTION_GET_COLORBOOL,
> +	ACTION_GET_URLMATCH,
> +};
> +
>  static char *key;
>  static regex_t *key_regexp;
>  static const char *value_pattern;
> @@ -33,10 +53,12 @@ static char delim =3D '=3D';
>  static char key_delim =3D ' ';
>  static char term =3D '\n';
> =20
> +static parse_opt_subcommand_fn *subcommand;
> +static enum config_action action =3D ACTION_NONE;
>  static int use_global_config, use_system_config, use_local_config;
>  static int use_worktree_config;
>  static struct git_config_source given_config_source;
> -static int actions, type;
> +static int type;
>  static char *default_value;
>  static int end_nul;
>  static int respect_includes_opt =3D -1;
> @@ -46,30 +68,6 @@ static int show_scope;
>  static int fixed_value;
>  static int config_flags;
> =20
> -#define ACTION_GET (1<<0)
> -#define ACTION_GET_ALL (1<<1)
> -#define ACTION_GET_REGEXP (1<<2)
> -#define ACTION_REPLACE_ALL (1<<3)
> -#define ACTION_ADD (1<<4)
> -#define ACTION_UNSET (1<<5)
> -#define ACTION_UNSET_ALL (1<<6)
> -#define ACTION_RENAME_SECTION (1<<7)
> -#define ACTION_REMOVE_SECTION (1<<8)
> -#define ACTION_LIST (1<<9)
> -#define ACTION_EDIT (1<<10)
> -#define ACTION_SET (1<<11)
> -#define ACTION_SET_ALL (1<<12)
> -#define ACTION_GET_COLOR (1<<13)
> -#define ACTION_GET_COLORBOOL (1<<14)
> -#define ACTION_GET_URLMATCH (1<<15)
> -
> -/*
> - * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
> - * one line of output and which should therefore be paged.
> - */
> -#define PAGING_ACTIONS (ACTION_LIST | ACTION_GET_ALL | \
> -			ACTION_GET_REGEXP | ACTION_GET_URLMATCH)
> -
>  #define TYPE_BOOL		1
>  #define TYPE_INT		2
>  #define TYPE_BOOL_OR_INT	3
> @@ -842,6 +840,25 @@ static int cmd_config_get_colorbool(int argc, const =
char **argv, const char *pre
>  	return get_colorbool(argv[0], argc =3D=3D 2);
>  }
> =20
> +static parse_opt_subcommand_fn *subcommands_by_action[] =3D {
> +	[ACTION_LIST] =3D cmd_config_list,
> +	[ACTION_EDIT] =3D cmd_config_edit,
> +	[ACTION_SET] =3D cmd_config_set,
> +	[ACTION_SET_ALL] =3D cmd_config_set_all,
> +	[ACTION_ADD] =3D cmd_config_add,
> +	[ACTION_REPLACE_ALL] =3D cmd_config_replace_all,
> +	[ACTION_GET] =3D cmd_config_get,
> +	[ACTION_GET_ALL] =3D cmd_config_get_all,
> +	[ACTION_GET_REGEXP] =3D cmd_config_get_regexp,
> +	[ACTION_GET_URLMATCH] =3D cmd_config_get_urlmatch,
> +	[ACTION_UNSET] =3D cmd_config_unset,
> +	[ACTION_UNSET_ALL] =3D cmd_config_unset_all,
> +	[ACTION_RENAME_SECTION] =3D cmd_config_rename_section,
> +	[ACTION_REMOVE_SECTION] =3D cmd_config_remove_section,
> +	[ACTION_GET_COLOR] =3D cmd_config_get_color,
> +	[ACTION_GET_COLORBOOL] =3D cmd_config_get_colorbool,
> +};
> +
>  static struct option builtin_config_options[] =3D {
>  	OPT_GROUP(N_("Config file location")),
>  	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
> @@ -851,20 +868,20 @@ static struct option builtin_config_options[] =3D {
>  	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use =
given config file")),
>  	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("rea=
d config from given blob object")),
>  	OPT_GROUP(N_("Action")),
> -	OPT_CMDMODE(0, "get", &actions, N_("get value: name [value-pattern]"), =
ACTION_GET),
> -	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [value-patt=
ern]"), ACTION_GET_ALL),
> -	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-=
regex [value-pattern]"), ACTION_GET_REGEXP),
> -	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the=
 URL: section[.var] URL"), ACTION_GET_URLMATCH),
> -	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variab=
les: name value [value-pattern]"), ACTION_REPLACE_ALL),
> -	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), A=
CTION_ADD),
> -	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [value-pa=
ttern]"), ACTION_UNSET),
> -	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [val=
ue-pattern]"), ACTION_UNSET_ALL),
> -	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name=
 new-name"), ACTION_RENAME_SECTION),
> -	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name")=
, ACTION_REMOVE_SECTION),
> -	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
> -	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> -	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: sl=
ot [default]"), ACTION_GET_COLOR),
> -	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: s=
lot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
> +	OPT_CMDMODE(0, "get", &action, N_("get value: name [value-pattern]"), A=
CTION_GET),

I guess value-pattern is a placeholder. So for uniformity with the style gu=
idelines, it should be formatted  <value-pattern>.
This also applies to other placeholders below.

> +	OPT_CMDMODE(0, "get-all", &action, N_("get all values: key [value-patte=
rn]"), ACTION_GET_ALL),
> +	OPT_CMDMODE(0, "get-regexp", &action, N_("get values for regexp: name-r=
egex [value-pattern]"), ACTION_GET_REGEXP),
> +	OPT_CMDMODE(0, "get-urlmatch", &action, N_("get value specific for the =
URL: section[.var] URL"), ACTION_GET_URLMATCH),
> +	OPT_CMDMODE(0, "replace-all", &action, N_("replace all matching variabl=
es: name value [value-pattern]"), ACTION_REPLACE_ALL),
> +	OPT_CMDMODE(0, "add", &action, N_("add a new variable: name value"), AC=
TION_ADD),
> +	OPT_CMDMODE(0, "unset", &action, N_("remove a variable: name [value-pat=
tern]"), ACTION_UNSET),
> +	OPT_CMDMODE(0, "unset-all", &action, N_("remove all matches: name [valu=
e-pattern]"), ACTION_UNSET_ALL),
> +	OPT_CMDMODE(0, "rename-section", &action, N_("rename section: old-name =
new-name"), ACTION_RENAME_SECTION),
> +	OPT_CMDMODE(0, "remove-section", &action, N_("remove a section: name"),=
 ACTION_REMOVE_SECTION),
> +	OPT_CMDMODE('l', "list", &action, N_("list all"), ACTION_LIST),
> +	OPT_CMDMODE('e', "edit", &action, N_("open an editor"), ACTION_EDIT),
> +	OPT_CMDMODE(0, "get-color", &action, N_("find the color configured: slo=
t [default]"), ACTION_GET_COLOR),
> +	OPT_CMDMODE(0, "get-colorbool", &action, N_("find the color setting: sl=
ot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
>  	OPT_GROUP(N_("Type")),
>  	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this ty=
pe"), option_parse_type),
>  	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"=
"), TYPE_BOOL),
> @@ -976,33 +993,43 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
>  		key_delim =3D '\n';
>  	}
> =20




