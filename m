From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/4 v8] config: read (but not write) from $XDG_CONFIG_HOME/git/config file
Date: Thu, 12 Jul 2012 09:55:22 +0200
Message-ID: <877gu9wh05.fsf@thomas.inf.ethz.ch>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
	<1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
	<1340355806-6894-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>,
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	<Valentin.Duperray@ensimag.imag.fr>,
	<Franck.Jonas@ensimag.imag.fr>, <Lucien.Kong@ensimag.imag.fr>,
	<Thomas.Nguy@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 12 09:55:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpEFH-0005Za-RB
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 09:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049Ab2GLHz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 03:55:26 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:47143 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147Ab2GLHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 03:55:25 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 12 Jul
 2012 09:55:22 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.208.48) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 12 Jul
 2012 09:55:23 +0200
In-Reply-To: <1340355806-6894-2-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Fri, 22 Jun 2012 11:03:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.208.48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201350>

Hi all,

This patch causes valgrind warnings in t1300.81 (get --path copes with
unset $HOME) about passing NULL to access():

==25286== Syscall param access(pathname) points to unaddressable byte(s)
==25286==    at 0x56E2227: access (in /lib64/libc-2.14.1.so)
==25286==    by 0x48CA42: git_config_early (config.c:948)
==25286==    by 0x4F0C20: check_repository_format_gently (setup.c:369)
==25286==    by 0x4F1A52: setup_git_directory_gently_1 (setup.c:531)
==25286==    by 0x4F24ED: setup_git_directory_gently (setup.c:725)
==25286==    by 0x405D8C: run_builtin (git.c:287)
==25286==    by 0x40548E: main (git.c:467)
==25286==  Address 0x0 is not stack'd, malloc'd or (recently) free'd

AFAICT it is this bit of code:

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +void home_config_paths(char **global, char **xdg, char *file)
> +{
> +	char *xdg_home = getenv("XDG_CONFIG_HOME");
> +	char *home = getenv("HOME");
> +	char *to_free = NULL;
> +
> +	if (!home) {
> +		if (global)
> +			*global = NULL;
[...]
>  int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  {
>  	int ret = 0, found = 0;
> -	const char *home = NULL;
> +	char *xdg_config = NULL;
> +	char *user_config = NULL;
> +
> +	home_config_paths(&user_config, &xdg_config, "config");
>  
>  	if (git_config_system() && !access(git_etc_gitconfig(), R_OK)) {
>  		ret += git_config_from_file(fn, git_etc_gitconfig(),
> @@ -937,14 +940,14 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  		found += 1;
>  	}
>  
> -	home = getenv("HOME");
> -	if (home) {
> -		char buf[PATH_MAX];
> -		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
> -		if (!access(user_config, R_OK)) {
> -			ret += git_config_from_file(fn, user_config, data);
> -			found += 1;
> -		}
> +	if (!access(xdg_config, R_OK)) {
> +		ret += git_config_from_file(fn, xdg_config, data);
> +		found += 1;
> +	}
> +
> +	if (!access(user_config, R_OK)) {
> +		ret += git_config_from_file(fn, user_config, data);
> +		found += 1;
>  	}

That is, while the old code was careful about home==NULL, the new code
checks this only in home_config_paths(); after that, it does no further
NULL check.

There's a similar instance in your changes to cmd_config(), found by
running 'unset HOME; valgrind git config --global --get foo.bar':

==27841== Syscall param access(pathname) points to unaddressable byte(s)
==27841==    at 0x56E2227: access (in /lib64/libc-2.14.1.so)
==27841==    by 0x425280: cmd_config (config.c:390)
==27841==    by 0x405C34: run_builtin (git.c:306)
==27841==    by 0x40548E: main (git.c:467)
==27841==  Address 0x0 is not stack'd, malloc'd or (recently) free'd

around here:

> @@ -379,13 +382,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
[...]
> +		char *user_config = NULL;
> +		char *xdg_config = NULL;
> +
> +		home_config_paths(&user_config, &xdg_config, "config");
> +
> +		if (access(user_config, R_OK) && !access(xdg_config, R_OK) &&

Can you fix this?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
