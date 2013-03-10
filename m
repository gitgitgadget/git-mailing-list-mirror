From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH/RFC] Make help behaviour more consistent
Date: Sun, 10 Mar 2013 23:56:47 +0000
Message-ID: <513D1DBF.4050208@iee.org>
References: <1362937729-9050-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:57:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEq7Z-0005V8-NT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab3CJX5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:57:15 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:36365 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753249Ab3CJX5O (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Mar 2013 19:57:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAIUdPVFZ8rke/2dsb2JhbAANNsRFgWKDGgEBAQECAThAAQULCxgJFg8JAwIBAgFFBg0BBQIBAYgJEqkZkk6OWzMHg0ADl3OSYQ
X-IronPort-AV: E=Sophos;i="4.84,819,1355097600"; 
   d="scan'208";a="568392136"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 10 Mar 2013 23:56:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <1362937729-9050-1-git-send-email-kevin@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217844>

On 10/03/13 17:48, Kevin Bracey wrote:
> Previously, the command "help" and the option "-h" behaved differently
> depending on whether a command was specified or not. Old user interface:
>
> Commands with no defaults show usage: "git"           "git CMD"
> To specifically request usage:        "git help"      "git CMD -h"
> To get a manual page:                 "git help git"  "git help CMD"
>

I agree they were inconsistent, but the change should also consider how 
the help for 'git help' should be provided as well.

I have some patches in preparation for also listing the commonly used 
guides, which can also be accessed by the existing `git help <guide>` 
e.g. 'tutorial' (but not user-manual or everday git unfortunately).

http://permalink.gmane.org/gmane.comp.version-control.git/217354

I have a new version in prep but my ubuntu m/c is out of action.

> Two significant usability flaws here:
>   - If using man, "man git" to side-step "git help" is obvious. But if
>     trying to use help.format=web, how to get the root html page? My
>     technique was "git help XXX" and click the "git(1) suite" link at the
>     bottom. "git help git" is non-obvious and apparently undocumented
>     (it's not mentioned by "git", "git help", or "git help help"...).
>
>   - Because git itself didn't support -h (and thus actually printed less
>     if you specified it), the general availability of -h for commands was
>     non-obvious. I didn't know about it until I started this patch.
>
> Tidy this up, so that help and -h do not change behaviour depending on
> whether a command is specified or not. New, consistent user interface:
>
> Commands with no defaults show usage: "git"           "git CMD"
> To specifically request usage:        "git -h"        "git CMD -h"
> To get a manual page:                 "git help"      "git help CMD".
>
> "git help git" is still accepted. The legacy "--help" option behaves as
> before, which means "git --help" on its own is now a synonym for "git
> -h", not "git help", and it remains consistent with GNU Coding
> Guidelines.
>
> So the only change to existing command behaviour is that "git help" or
> "git help -w" now opens the git manual page, rather than showing common
> commands.
>
> "git -h cmd" is also accepted as a synonym for "git cmd -h", as per
> Linus's rationale for treating "git cmd --help" as a synonym for "git
> --help cmd".
>
> Option list shown in command-line usage re-ordered to match the manual
> page, and git and git-help manual pages edited to reflect the new help
> behaviour.
>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---
>   Documentation/git-help.txt | 22 +++++++++-------------
>   Documentation/git.txt      | 17 ++++++++---------
>   builtin/help.c             |  9 +--------
>   git.c                      | 40 +++++++++++++++++++++++-----------------
>   4 files changed, 41 insertions(+), 47 deletions(-)
>
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index e07b6dc..25def9f 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -13,19 +13,16 @@ SYNOPSIS
>   DESCRIPTION
>   -----------
>
> -With no options and no COMMAND given, the synopsis of the 'git'
> -command and a list of the most commonly used Git commands are printed
> -on the standard output.
> -
>   If the option '--all' or '-a' is given, then all available commands are
>   printed on the standard output.
>
> -If a Git subcommand is named, a manual page for that subcommand is brought
> +Otherwise, a manual page for Git or the specified Git command is brought
>   up. The 'man' program is used by default for this purpose, but this
>   can be overridden by other options or configuration variables.
>
>   Note that `git --help ...` is identical to `git help ...` because the
> -former is internally converted into the latter.
> +former is internally converted into the latter.  Also, to supplement
> +`git help`, most Git commands offer the option '-h' to print usage.
>
>   OPTIONS
>   -------
> @@ -36,14 +33,13 @@ OPTIONS
>
>   -i::
>   --info::
> -	Display manual page for the command in the 'info' format. The
> -	'info' program will be used for that purpose.
> +	Display manual page in the 'info' format. The 'info' program will
> +	be used for that purpose.
>
>   -m::
>   --man::
> -	Display manual page for the command in the 'man' format. This
> -	option may be used to override a value set in the
> -	'help.format' configuration variable.
> +	Display manual page in the 'man' format. This option may be used to
> +	override a value set in the 'help.format' configuration variable.
>   +
>   By default the 'man' program will be used to display the manual page,
>   but the 'man.viewer' configuration variable may be used to choose
> @@ -51,8 +47,8 @@ other display programs (see below).
>
>   -w::
>   --web::
> -	Display manual page for the command in the 'web' (HTML)
> -	format. A web browser will be used for that purpose.
> +	Display manual page in the 'web' (HTML)	format. A web browser will
> +	be used for that purpose.
>   +
>   The web browser can be specified using the configuration variable
>   'help.browser', or 'web.browser' if the former is not set. If none of
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 9d29ed5..51cdca2 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -9,7 +9,7 @@ git - the stupid content tracker
>   SYNOPSIS
>   --------
>   [verse]
> -'git' [--version] [--help] [-c <name>=<value>]
> +'git' [--version] [--help] [-h] [-c <name>=<value>]
>       [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
>       [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
>       [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
> @@ -361,16 +361,15 @@ OPTIONS
>   --version::
>   	Prints the Git suite version that the 'git' program came from.
>
> ---help::
> +-h::
>   	Prints the synopsis and a list of the most commonly used
> -	commands. If the option '--all' or '-a' is given then all
> -	available commands are printed. If a Git command is named this
> -	option will bring up the manual page for that command.
> +	commands. Most Git commands also provide a '-h'	option to
> +	show their own synopsis.
>   +
> -Other options are available to control how the manual page is
> -displayed. See linkgit:git-help[1] for more information,
> -because `git --help ...` is converted internally into `git
> -help ...`.
> +For compatibility, `git --help` is also implemented. With no
> +following options, it is equivalent to `git -h`. Otherwise it is
> +converted internally into `git help ...`, which will open a manual
> +page. See linkgit:git-help[1] for more information.
>
>   -c <name>=<value>::
>   	Pass a configuration parameter to the command. The value
> diff --git a/builtin/help.c b/builtin/help.c
> index d1d7181..ef4706a 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -432,13 +432,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>   		return 0;
>   	}
>
> -	if (!argv[0]) {
> -		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
> -		list_common_cmds_help();
> -		printf("\n%s\n", _(git_more_info_string));
> -		return 0;
> -	}
> -
>   	setup_git_directory_gently(&nongit);
>   	git_config(git_help_config, NULL);
>
> @@ -447,7 +440,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>   	if (help_format == HELP_FORMAT_NONE)
>   		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
>
> -	alias = alias_lookup(argv[0]);
> +	alias = argv[0] ? alias_lookup(argv[0]) : NULL;
>   	if (alias && !is_git_command(argv[0])) {
>   		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
>   		return 0;
> diff --git a/git.c b/git.c
> index b10c18b..82a74c5 100644
> --- a/git.c
> +++ b/git.c
> @@ -6,10 +6,10 @@
>   #include "run-command.h"
>
>   const char git_usage_string[] =
> -	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
> +	"git [--version] [--help] [-h] [-c name=value]\n"
> +	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
>   	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
>   	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
> -	"           [-c name=value] [--help]\n"
>   	"           <command> [<args>]";
>
>   const char git_more_info_string[] =
> @@ -17,6 +17,7 @@ const char git_more_info_string[] =
>
>   static struct startup_info git_startup_info;
>   static int use_pager = -1;
> +static int show_usage;
>
>   static void commit_pager_choice(void) {
>   	switch (use_pager) {
> @@ -40,17 +41,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>   		if (cmd[0] != '-')
>   			break;
>
> -		/*
> -		 * For legacy reasons, the "version" and "help"
> -		 * commands can be written with "--" prepended
> -		 * to make them look like flags.
> -		 */
> -		if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
> -			break;
> -
> -		/*
> -		 * Check remaining flags.
> -		 */
>   		if (!prefixcmp(cmd, "--exec-path")) {
>   			cmd += 11;
>   			if (*cmd == '=')
> @@ -143,6 +133,25 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>   			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "0", 1);
>   			if (envchanged)
>   				*envchanged = 1;
> +		} else if (!strcmp(cmd, "--version")) {
> +			/* Alternative spelling for "git version" */
> +			(*argv)[0] += 2;
> +			break;
> +		} else if (!strcmp(cmd, "--help")) {
> +			if (*argc > 1) {
> +				/* Alternative spelling for "git help XXX" */
> +				(*argv)[0] += 2;
> +				break;
> +			} else
> +				show_usage = 1;
> +		} else if (!strcmp(cmd, "-h")) {
> +			if (*argc > 1 && (*argv)[1][0] != '-') {
> +				/* Turn "git -h cmd" into "git cmd -h" */
> +				(*argv)[0] = (*argv)[1];
> +				(*argv)[1] = "-h";
> +				break;
> +			} else
> +				show_usage = 1;
>   		} else {
>   			fprintf(stderr, "Unknown option: %s\n", cmd);
>   			usage(git_usage_string);
> @@ -537,10 +546,7 @@ int main(int argc, const char **argv)
>   	argv++;
>   	argc--;
>   	handle_options(&argv, &argc, NULL);
> -	if (argc > 0) {
> -		if (!prefixcmp(argv[0], "--"))
> -			argv[0] += 2;
> -	} else {
> +	if (argc <= 0 || show_usage) {
>   		/* The user didn't specify a command; give them help */
>   		commit_pager_choice();
>   		printf("usage: %s\n\n", git_usage_string);
>
