From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 01:28:18 -0800
Message-ID: <7vab8pweod.fsf@gitster.siamese.dyndns.org>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 10:29:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYGqS-0000xX-GW
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 10:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbZBNJ2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 04:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbZBNJ23
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 04:28:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZBNJ21 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 04:28:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 189B599251;
	Sat, 14 Feb 2009 04:28:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 067EF9924B; Sat,
 14 Feb 2009 04:28:19 -0500 (EST)
In-Reply-To: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat, 14 Feb 2009 04:05:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D44CCEE4-FA79-11DD-8C91-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109848>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Reorganizing the code to use parseopt as suggested by Johannes
> Schindelin.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin-config.c |  422 +++++++++++++++++++++++++++---------------------------
>  1 files changed, 210 insertions(+), 212 deletions(-)

Whew.  That's a lot of changes.

Is this just "I am using parseopt because I can", or "I want to do this
first because I am planning to do such and such things to this program,
and the current mess needs to be cleaned up first before doing so"?

I am asking this _not_ because I'd want to reject the patch if the answer
is former.

> diff --git a/builtin-config.c b/builtin-config.c
> index afc4393..f774902 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -1,9 +1,12 @@
>  #include "builtin.h"
>  #include "cache.h"
>  #include "color.h"
> +#include "parse-options.h"
>  
> -static const char git_config_set_usage[] =
> -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
> +static const char *const builtin_config_usage[] = {
> +	"git config [options]",
> +	NULL
> +};
>  
>  static char *key;
>  static regex_t *key_regexp;
> @@ -18,6 +21,42 @@ static char key_delim = ' ';
>  static char term = '\n';
>  static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
>  
> +static int use_global_config, use_system_config;
> +static const char *given_config_file;
> +static int do_list, do_edit, do_add, do_get, do_get_all, do_get_regexp, do_replace_all;
> +static int do_unset, do_unset_all, do_rename_section, do_remove_section;
> +static int type_int, type_bool, type_bool_or_int;

You can have either (no type specified, int, bool, bool-or-int) at the
end.  Using three independent variables does not feel right.

Hint: OPTION_SET_INT.

> +static const char *get_color_name, *get_colorbool_name;
> +static int end_null;
> +
> +static struct option builtin_config_options[] = {
> +	OPT_GROUP("Config file location"),
> +	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
> +	OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
> +	OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),

Why CAPS?

> +	OPT_GROUP("Action"),
> +	OPT_BOOLEAN(0, "get", &do_get, "get value: name [value-regex]"),
> +	OPT_BOOLEAN(0, "get-all", &do_get_all, "get all values: key [value-regex]"),
> +	OPT_BOOLEAN(0, "get-regexp", &do_get_regexp, "get values for regexp: name-regex [value-regex]"),
> +	OPT_BOOLEAN(0, "replace-all", &do_replace_all, "replace all options: name [value [value_regex]"),

all matching variables?

> +	OPT_BOOLEAN(0, "add", &do_add, "adds a new option: name value"),

new variable?

> +	OPT_BOOLEAN(0, "unset", &do_unset, "removes an option: name [value-regex]"),

Please don't introduce a new noun "option" that has never been used to
mean a "configuration variable" in git documentation.  It unnecessarily
confuses everybody.

> +	OPT_BOOLEAN(0, "unset-all", &do_unset_all, "removes all matches: name [value-regex]"),
> +	OPT_BOOLEAN(0, "rename-section", &do_rename_section, "rename section: old-name new-name"),
> +	OPT_BOOLEAN(0, "remove-section", &do_remove_section, "remove a section: name"),
> +	OPT_BOOLEAN('l', "list", &do_list, "list all"),
> +	OPT_STRING(0, "get-color", &get_color_name, "name", "find the color configured: [default]"),

get-color is used to get the defined color for a given slot.  Please do not
rename it to "name" (see the original).

> +	OPT_STRING(0, "get-colorbool", &get_colorbool_name, "name", "find the color setting: [stdout-is-tty]"),

get-colorbool is used to get the boolean setting for a given configuration
variable.  Please do not rename it to "name" (see the original).

> +	OPT_BOOLEAN('e', "edit", &do_edit, "opens an editor"),
> +	OPT_GROUP("Type"),
> +	OPT_BOOLEAN(0, "bool", &type_bool, "value is \"true\" or \"false\""),
> +	OPT_BOOLEAN(0, "int", &type_int, "value is decimal number"),
> +	OPT_BOOLEAN(0, "bool-or-int", &type_bool_or_int, NULL),
> +	OPT_GROUP("Other"),
> +	OPT_BOOLEAN('z', "null", &end_null, "end values with null character"),

The name of the character is NUL (with a single el).  I'd prefer this to
say either "use machine readable output format", or "terminate values with NUL byte".

> +	OPT_END(),
> +};
> +
>  static int show_all_config(const char *key_, const char *value_, void *cb)
>  {
>  	if (value_)
> @@ -177,12 +216,11 @@ static char *normalize_value(const char *key, const char *value)
>  }
>  
>  static int get_color_found;
> -static const char *get_color_slot;
> +static const char *get_color_name;

Why?

> @@ -289,151 +258,180 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> ...
> +	{
> +		int action_sum;
> +		action_sum = do_unset + do_unset_all + do_get + do_get_all + \
> +			     do_get_regexp + do_add + do_list + do_edit + \
> +			     do_rename_section + do_remove_section + do_replace_all;
> +		if (action_sum > 1)
> +			die ("Can't execute two actions at the same time.");

Hmph.  I wonder if use of OPT_BIT() and HAS_MULTI_BITS() make this simpler.

> +	else if (do_add) {
> +		if (argc > 2)
> +			die("Too many arguments.");
> +		if (argc != 2)
> +			die("Need name value.");
> +		value = normalize_value(argv[0], argv[1]);
> +		return git_config_set_multivar(argv[0], value, "^$", 0);

This part did not lose argc error checking, but...

> +	}
> +	else if (do_replace_all) {
> +		value = normalize_value(argv[0], argv[1]);
> +		return git_config_set_multivar(argv[0], value, (argc == 3 ? argv[2] : NULL), 1);

You do not check argc here (nor in many "else if" below) to make sure you
have sufficient number of arguments.  "git config --unset" is now allowed
to segfault, and "git config --unset a b c d e f" can silently ignore
excess arguments for example?

> +	}
> +	else if (do_get)
> +		return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
> +	else if (do_get_all) {
> +		do_all = 1;
> +		return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
> +	}
> +	else if (do_get_regexp) {
> +		show_keys = 1;
> +		use_key_regexp = 1;
> +		do_all = 1;
> +		return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
> +	}
> +	else if (do_unset) {
> +		if (argc == 2)
> +			return git_config_set_multivar(argv[0], NULL, argv[1], 0);
> +		else
> +			return git_config_set(argv[0], NULL);
> +	}
> ... similar error-ridden parts omitted ...

> +	else if (get_color_name) {
> +		const char *def_color = NULL;
> +
> +		switch (argc) {
> +		case 2:
> +			def_color = argv[1];
> +			/* fallthru */
> +		case 1:
> +			get_color_name = argv[0];
>  			break;
> +		default:
> +			die("Too many arguments.");
> +		}
> +
> +		get_color_found = 0;
> +		parsed_color[0] = '\0';
> +		git_config(git_get_color_config, NULL);
> +
> +		if (!get_color_found && def_color)
> +			color_parse(def_color, "command line", parsed_color);
> +
> +		fputs(parsed_color, stdout);

This is actively worse than the original that uses a separate helper
function in readability.

>  	}
> +	else if (get_colorbool_name) {
> +		if (argc == 1)
> +			stdout_is_tty = git_config_bool("command line", argv[0]);
> +		else if (argc == 0)
> +			stdout_is_tty = isatty(1);
> +		else
> +			die("Too many options.");
>  
> +		get_colorbool_found = -1;
> +		get_diff_color_found = -1;
> +		git_config(git_get_colorbool_config, NULL);
> +
> +		if (get_colorbool_found < 0) {
> +			if (!strcmp(get_colorbool_name, "color.diff"))
> +				get_colorbool_found = get_diff_color_found;
> +			if (get_colorbool_found < 0)
> +				get_colorbool_found = git_use_color_default;
>  		}
> +
> +		if (argc == 0) {
> +			return get_colorbool_found ? 0 : 1;
>  		} else {
> +			printf("%s\n", get_colorbool_found ? "true" : "false");
> +			return 0;
>  		}

Likewise.

Overall, with the same number of lines, we lost a lot of error checking in
exchange for an ability to say "git config --remove-sec" instead of "git
config --remove-section", and "git config --help" may give an easier to
read message.

Given that "git config" is primarily meant for script use, this particular
round does not look like a good tradeoff to me.
