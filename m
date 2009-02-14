From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 12:37:23 +0200
Message-ID: <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 11:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYHwE-0002Nd-HE
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 11:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbZBNKh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 05:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbZBNKh1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 05:37:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:11495 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZBNKhZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Feb 2009 05:37:25 -0500
Received: by fg-out-1718.google.com with SMTP id 16so37891fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 02:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OyFOZWk6z9gjoWE4/vDnnMwCtfGHnPYu0lzS7aWFCBo=;
        b=AoUnDqc87de+nt3VuAOaILvFOJ0yACu5TjrJHJJz95aASKx+3IT7FuKqHIZmM9xeNE
         sjB+1nCTFddJy51Uhj1xzLQKEbQozkVbvkBQtpRo6JJJny+qvhdRek7t6OwwZRPTQxNC
         Uq+Lg5CUbaAKljTfb64RuUS7gzVomC3D5im7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iGDYQF2K0VKdCo5adjMKy0esb3rnpy0YziIbGGAXaSFW1DSpzZSxv3bZO3IVdJvfZX
         382xOsFuhAv5IuGBfM7yG4fN5Sw+6Hte91yZyLSpVdwAZTS7rxA2eBc/HRowGU2vIm5c
         7r0pHLU6/j+9JRbjdqnU/jB6KV1aag1yvT4tE=
Received: by 10.86.61.13 with SMTP id j13mr266298fga.6.1234607843545; Sat, 14 
	Feb 2009 02:37:23 -0800 (PST)
In-Reply-To: <7vab8pweod.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109857>

On Sat, Feb 14, 2009 at 11:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Reorganizing the code to use parseopt as suggested by Johannes
>> Schindelin.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin-config.c |  422 +++++++++++++++++++++++++++---------------------------
>>  1 files changed, 210 insertions(+), 212 deletions(-)
>
> Whew.  That's a lot of changes.
>
> Is this just "I am using parseopt because I can", or "I want to do this
> first because I am planning to do such and such things to this program,
> and the current mess needs to be cleaned up first before doing so"?
>
> I am asking this _not_ because I'd want to reject the patch if the answer
> is former.

Then why are you asking?

This is more a "I would like to increase the chances of my patches
being accepted so I'd do some chores to gain the trust of some
developers", and Johannes Schindelin was pushing me to do this.

Also it's a bit of "I would like to improve git and learn the API
while doing so".

>> diff --git a/builtin-config.c b/builtin-config.c
>> index afc4393..f774902 100644
>> --- a/builtin-config.c
>> +++ b/builtin-config.c
>> @@ -1,9 +1,12 @@
>>  #include "builtin.h"
>>  #include "cache.h"
>>  #include "color.h"
>> +#include "parse-options.h"
>>
>> -static const char git_config_set_usage[] =
>> -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
>> +static const char *const builtin_config_usage[] = {
>> +     "git config [options]",
>> +     NULL
>> +};
>>
>>  static char *key;
>>  static regex_t *key_regexp;
>> @@ -18,6 +21,42 @@ static char key_delim = ' ';
>>  static char term = '\n';
>>  static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
>>
>> +static int use_global_config, use_system_config;
>> +static const char *given_config_file;
>> +static int do_list, do_edit, do_add, do_get, do_get_all, do_get_regexp, do_replace_all;
>> +static int do_unset, do_unset_all, do_rename_section, do_remove_section;
>> +static int type_int, type_bool, type_bool_or_int;
>
> You can have either (no type specified, int, bool, bool-or-int) at the
> end.  Using three independent variables does not feel right.
>
> Hint: OPTION_SET_INT.

That definitely makes things easier, it would have been nice to see an
example of this; I didn't knew it was there.

The only problem is that --bool and --int would be possible in the
same command and there would be no way to output an error, but I guess
that's not a big problem.

>> +static const char *get_color_name, *get_colorbool_name;
>> +static int end_null;
>> +
>> +static struct option builtin_config_options[] = {
>> +     OPT_GROUP("Config file location"),
>> +     OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
>> +     OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
>> +     OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),
>
> Why CAPS?

I looked at some other code, like builtin-commit.c and that's what is
used there.

>> +     OPT_GROUP("Action"),
>> +     OPT_BOOLEAN(0, "get", &do_get, "get value: name [value-regex]"),
>> +     OPT_BOOLEAN(0, "get-all", &do_get_all, "get all values: key [value-regex]"),
>> +     OPT_BOOLEAN(0, "get-regexp", &do_get_regexp, "get values for regexp: name-regex [value-regex]"),
>> +     OPT_BOOLEAN(0, "replace-all", &do_replace_all, "replace all options: name [value [value_regex]"),
>
> all matching variables?

Ok.

>> +     OPT_BOOLEAN(0, "add", &do_add, "adds a new option: name value"),
>
> new variable?

Ok.

>> +     OPT_BOOLEAN(0, "unset", &do_unset, "removes an option: name [value-regex]"),
>
> Please don't introduce a new noun "option" that has never been used to
> mean a "configuration variable" in git documentation.  It unnecessarily
> confuses everybody.

Ok.

And true, "config" files don't only contain options.

>> +     OPT_BOOLEAN(0, "unset-all", &do_unset_all, "removes all matches: name [value-regex]"),
>> +     OPT_BOOLEAN(0, "rename-section", &do_rename_section, "rename section: old-name new-name"),
>> +     OPT_BOOLEAN(0, "remove-section", &do_remove_section, "remove a section: name"),
>> +     OPT_BOOLEAN('l', "list", &do_list, "list all"),
>> +     OPT_STRING(0, "get-color", &get_color_name, "name", "find the color configured: [default]"),
>
> get-color is used to get the defined color for a given slot.  Please do not
> rename it to "name" (see the original).

The documentation says "Find the color configured for `name`" so the
first argument would be "name", I'm just storing that argument.

Perhaps the documentation needs to be improved?

>> +     OPT_STRING(0, "get-colorbool", &get_colorbool_name, "name", "find the color setting: [stdout-is-tty]"),
>
> get-colorbool is used to get the boolean setting for a given configuration
> variable.  Please do not rename it to "name" (see the original).

Same as get-color, right?

>> +     OPT_BOOLEAN('e', "edit", &do_edit, "opens an editor"),
>> +     OPT_GROUP("Type"),
>> +     OPT_BOOLEAN(0, "bool", &type_bool, "value is \"true\" or \"false\""),
>> +     OPT_BOOLEAN(0, "int", &type_int, "value is decimal number"),
>> +     OPT_BOOLEAN(0, "bool-or-int", &type_bool_or_int, NULL),
>> +     OPT_GROUP("Other"),
>> +     OPT_BOOLEAN('z', "null", &end_null, "end values with null character"),
>
> The name of the character is NUL (with a single el).  I'd prefer this to
> say either "use machine readable output format", or "terminate values with NUL byte".

I'd prefer "terminate values with NUL byte".

>> +     OPT_END(),
>> +};
>> +
>>  static int show_all_config(const char *key_, const char *value_, void *cb)
>>  {
>>       if (value_)
>> @@ -177,12 +216,11 @@ static char *normalize_value(const char *key, const char *value)
>>  }
>>
>>  static int get_color_found;
>> -static const char *get_color_slot;
>> +static const char *get_color_name;
>
> Why?

Because the documentation says the argument is a 'name'.

>> @@ -289,151 +258,180 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>> ...
>> +     {
>> +             int action_sum;
>> +             action_sum = do_unset + do_unset_all + do_get + do_get_all + \
>> +                          do_get_regexp + do_add + do_list + do_edit + \
>> +                          do_rename_section + do_remove_section + do_replace_all;
>> +             if (action_sum > 1)
>> +                     die ("Can't execute two actions at the same time.");
>
> Hmph.  I wonder if use of OPT_BIT() and HAS_MULTI_BITS() make this simpler.

Yeap, definitely, thanks for the suggestion.

Again, it would have been nice to see any example of this.

>> +     else if (do_add) {
>> +             if (argc > 2)
>> +                     die("Too many arguments.");
>> +             if (argc != 2)
>> +                     die("Need name value.");
>> +             value = normalize_value(argv[0], argv[1]);
>> +             return git_config_set_multivar(argv[0], value, "^$", 0);
>
> This part did not lose argc error checking, but...
>
>> +     }
>> +     else if (do_replace_all) {
>> +             value = normalize_value(argv[0], argv[1]);
>> +             return git_config_set_multivar(argv[0], value, (argc == 3 ? argv[2] : NULL), 1);
>
> You do not check argc here (nor in many "else if" below) to make sure you
> have sufficient number of arguments.  "git config --unset" is now allowed
> to segfault, and "git config --unset a b c d e f" can silently ignore
> excess arguments for example?

Yes the arguments check need to be revised.

My hope was somebody would review this and suggest a clever and
generic way of doing this. Perhaps a util function check_min_args, or
maybe something in parseopt that receives the number of args?

Also, since I sent the patch I've learned that if argc is 2, then
argv[2] will be NULL, so the argc == 3 check is redundant.

>> +     }
>> +     else if (do_get)
>> +             return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
>> +     else if (do_get_all) {
>> +             do_all = 1;
>> +             return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
>> +     }
>> +     else if (do_get_regexp) {
>> +             show_keys = 1;
>> +             use_key_regexp = 1;
>> +             do_all = 1;
>> +             return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
>> +     }
>> +     else if (do_unset) {
>> +             if (argc == 2)
>> +                     return git_config_set_multivar(argv[0], NULL, argv[1], 0);
>> +             else
>> +                     return git_config_set(argv[0], NULL);
>> +     }
>> ... similar error-ridden parts omitted ...
>
>> +     else if (get_color_name) {
>> +             const char *def_color = NULL;
>> +
>> +             switch (argc) {
>> +             case 2:
>> +                     def_color = argv[1];
>> +                     /* fallthru */
>> +             case 1:
>> +                     get_color_name = argv[0];
>>                       break;
>> +             default:
>> +                     die("Too many arguments.");
>> +             }
>> +
>> +             get_color_found = 0;
>> +             parsed_color[0] = '\0';
>> +             git_config(git_get_color_config, NULL);
>> +
>> +             if (!get_color_found && def_color)
>> +                     color_parse(def_color, "command line", parsed_color);
>> +
>> +             fputs(parsed_color, stdout);
>
> This is actively worse than the original that uses a separate helper
> function in readability.

The original separate helper functions where helping parse the args.
Since that's not happening any more I saw no reason to pass the argc
and argv variables, so I thought maybe these options should not be
treated any differently than other options.

Anyway, I can create the helper functions again, and maybe have some
function parameters instead of passing argc and argv

>>       }
>> +     else if (get_colorbool_name) {
>> +             if (argc == 1)
>> +                     stdout_is_tty = git_config_bool("command line", argv[0]);
>> +             else if (argc == 0)
>> +                     stdout_is_tty = isatty(1);
>> +             else
>> +                     die("Too many options.");
>>
>> +             get_colorbool_found = -1;
>> +             get_diff_color_found = -1;
>> +             git_config(git_get_colorbool_config, NULL);
>> +
>> +             if (get_colorbool_found < 0) {
>> +                     if (!strcmp(get_colorbool_name, "color.diff"))
>> +                             get_colorbool_found = get_diff_color_found;
>> +                     if (get_colorbool_found < 0)
>> +                             get_colorbool_found = git_use_color_default;
>>               }
>> +
>> +             if (argc == 0) {
>> +                     return get_colorbool_found ? 0 : 1;
>>               } else {
>> +                     printf("%s\n", get_colorbool_found ? "true" : "false");
>> +                     return 0;
>>               }
>
> Likewise.
>
> Overall, with the same number of lines, we lost a lot of error checking in
> exchange for an ability to say "git config --remove-sec" instead of "git
> config --remove-section", and "git config --help" may give an easier to
> read message.
>
> Given that "git config" is primarily meant for script use, this particular
> round does not look like a good tradeoff to me.

That doesn't mean it shouldn't have a nice UI.

Also, I think the code would be easier to maintain with parseopt.

-- 
Felipe Contreras
