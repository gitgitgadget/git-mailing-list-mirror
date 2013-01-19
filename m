From: "=?iso-8859-1?q?Jean-No=EBl?= AVILA" <avila.jn@gmail.com>
Subject: Re: [PATCH 2/2] help --standard: list standard commands
Date: Sat, 19 Jan 2013 11:32:51 +0100
Message-ID: <201301191132.51808.avila.jn@gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <7vpq11ob4w.fsf_-_@alter.siamese.dyndns.org> <7vk3r9ob22.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 11:33:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwVjq-0007KT-9L
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 11:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab3ASKdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 05:33:04 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:47499 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723Ab3ASKdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 05:33:02 -0500
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 2B9354B015A;
	Sat, 19 Jan 2013 11:32:53 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc4jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vk3r9ob22.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213969>

Le samedi 19 janvier 2013 09:02:13, Junio C Hamano a =E9crit :
> If you run "make" on a branch that adds "git check-ignore", checkout
> an older branch that did not know about the command without "make cle=
an",
> and the run t9902 test, the completion script fails to exclude the
> "check-ignore" command from candidates to complete "check".
>=20
> This is because the completion script asks "git help -a" to show
> every executable that begins with "git-" in the GIT_EXEC_PATH, and
> because we run tests with GIT_EXEC_PATH set to the top of the
> working tree, that has the executable we just built, in order to
> test these before installing.  Leftover "git check-ignore" that we
> did not build for the current version gets in the way.
>=20
> One way to solve this is to restrict the completion to only the
> commands we know about.
>=20
> Note that this will make the completion useless in real life for
> some people, as they do want to get their custom commands on their
> $PATH to be included in the completion.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
>  * This is not a real patch, for the reasons stated.
>=20
>  builtin/help.c                         | 17 ++++++++++++++---
>  command-list.txt                       |  4 ++--
>  contrib/completion/git-completion.bash | 14 +-------------
>  generate-cmdlist.sh                    | 13 ++++++++++++-
>  help.c                                 | 30 ++++++++++++++++++++++++=
++++--
>  help.h                                 |  1 +
>  6 files changed, 58 insertions(+), 21 deletions(-)
>=20
> diff --git a/builtin/help.c b/builtin/help.c
> index 6067a61..32e7d64 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -35,11 +35,16 @@ enum help_format {
>=20
>  static const char *html_path;
>=20
> -static int show_all =3D 0;
> +#define HELP_SHOW_ALL 1
> +#define HELP_SHOW_STANDARD 2
> +static int show_what;
>  static unsigned int colopts;
>  static enum help_format help_format =3D HELP_FORMAT_NONE;
>  static struct option builtin_help_options[] =3D {
> -	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands=
")),
> +	OPT_SET_INT('a', "all", &show_what, N_("print all available command=
s"),
> +		HELP_SHOW_ALL),
> +	OPT_SET_INT(0, "standard", &show_what, N_("print all available
> commands"), +		HELP_SHOW_STANDARD),
>  	OPT_SET_INT('m', "man", &help_format, N_("show man page"),
> HELP_FORMAT_MAN), OPT_SET_INT('w', "web", &help_format, N_("show manu=
al in
> web browser"), HELP_FORMAT_WEB),
> @@ -424,12 +429,18 @@ int cmd_help(int argc, const char **argv, const=
 char
> *prefix) builtin_help_usage, 0);
>  	parsed_help_format =3D help_format;
>=20
> -	if (show_all) {
> +	if (show_what =3D=3D HELP_SHOW_ALL) {
>  		git_config(git_help_config, NULL);
>  		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>  		list_commands(colopts, &main_cmds, &other_cmds);
>  		printf("%s\n", _(git_more_info_string));
>  		return 0;
> +	} else if (show_what =3D=3D HELP_SHOW_STANDARD) {
> +		int i;
> +		limit_to_standard(&main_cmds);
> +		for (i =3D 0; i < main_cmds.cnt; i++)
> +			printf("%s\n", main_cmds.names[i]->name);
> +		return 0;
>  	}
>=20
>  	if (!argv[0]) {
> diff --git a/command-list.txt b/command-list.txt
> index 7e8cfec..94ce8ec 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -116,8 +116,8 @@ git-show                                mainporce=
lain
> common git-show-branch                         ancillaryinterrogators
>  git-show-index                          plumbinginterrogators
>  git-show-ref                            plumbinginterrogators
> -git-sh-i18n                             purehelpers
> -git-sh-setup                            purehelpers
> +git-sh-i18n                             purehelpers nocomplete
> +git-sh-setup                            purehelpers nocomplete
>  git-stash                               mainporcelain
>  git-status                              mainporcelain common
>  git-stripspace                          purehelpers
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash index a4c48e1..46f22af 10064=
4
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -531,23 +531,11 @@ __git_complete_strategy ()
>  	return 1
>  }
>=20
> -__git_list_all_commands ()
> -{
> -	local i IFS=3D" "$'\n'
> -	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
> -	do
> -		case $i in
> -		*--*)             : helper pattern;;
> -		*) echo $i;;
> -		esac
> -	done
> -}
> -
>  __git_all_commands=3D
>  __git_compute_all_commands ()
>  {
>  	test -n "$__git_all_commands" ||
> -	__git_all_commands=3D$(__git_list_all_commands)
> +	__git_all_commands=3D$(git help --standard)
>  }
>=20
>  __git_list_porcelain_commands ()
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 9a4c9b9..7800af3 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -9,7 +9,7 @@ struct cmdname_help {
>  static struct cmdname_help common_cmds[] =3D {"
>=20
>  sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
> -sort |
> +LC_ALL=3DC LANG=3DC sort |
>  while read cmd
>  do
>       sed -n '
> @@ -20,4 +20,15 @@ do
>  	    p
>       }' "Documentation/git-$cmd.txt"
>  done
> +echo "};
> +
> +static const char *standard_cmd[] =3D {"
> +
> +LC_ALL=3DC LANG=3DC sort command-list.txt |
> +sed -n -e '
> +	/^git-[^ 	]*[ 	].* deprecated.*/d
> +	/^git-[^ 	]*[ 	].* nocomplete.*/d
> +	s/^git-\([^ 	]*\)[ 	].*/  "\1",/p
> +'
> +
>  echo "};"
> diff --git a/help.c b/help.c
> index 1dfa0b0..2ad10db 100644
> --- a/help.c
> +++ b/help.c
> @@ -182,7 +182,7 @@ void load_command_list(const char *prefix,
>  		uniq(main_cmds);
>  	}
>=20
> -	if (env_path) {
> +	if (env_path && other_cmds) {
>  		char *paths, *path, *colon;
>  		path =3D paths =3D xstrdup(env_path);
>  		while (1) {
> @@ -201,7 +201,33 @@ void load_command_list(const char *prefix,
>  		      sizeof(*other_cmds->names), cmdname_compare);
>  		uniq(other_cmds);
>  	}
> -	exclude_cmds(other_cmds, main_cmds);
> +
> +	if (other_cmds)
> +		exclude_cmds(other_cmds, main_cmds);
> +}
> +
> +void limit_to_standard(struct cmdnames *cmds)
> +{
> +	int src =3D 0, dst =3D 0, ref =3D 0;
> +
> +	while (src < cmds->cnt && ref < ARRAY_SIZE(standard_cmd)) {
> +		int cmp =3D strcmp(cmds->names[src]->name, standard_cmd[ref]);
> +		if (cmp < 0) {
> +			src++; /* not a standard command */
> +		} else if (!cmp) {
> +			if (dst !=3D src) {
> +				free(cmds->names[dst]);
> +				cmds->names[dst] =3D cmds->names[src];
> +			}
> +			ref++;
> +			dst++;
> +		} else {
> +			ref++; /* uninstalled standard command */
> +		}
> +	}
> +	for (src =3D dst; src < cmds->cnt; src++)
> +		free(cmds->names[src]);
> +	cmds->cnt =3D dst;
>  }
>=20
>  void list_commands(unsigned int colopts,
> diff --git a/help.h b/help.h
> index 0ae5a12..ce0d2a5 100644
> --- a/help.h
> +++ b/help.h
> @@ -21,6 +21,7 @@ extern const char *help_unknown_cmd(const char *cmd=
);
>  extern void load_command_list(const char *prefix,
>  			      struct cmdnames *main_cmds,
>  			      struct cmdnames *other_cmds);
> +extern void limit_to_standard(struct cmdnames *);
>  extern void add_cmdname(struct cmdnames *cmds, const char *name, int=
 len);
>  /* Here we require that excludes is a sorted list. */
>  extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames
> *excludes);

With these two patches, the test passes.
