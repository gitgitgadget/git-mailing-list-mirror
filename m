From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git: expand user path in --git-dir
Date: Mon, 24 Sep 2012 10:30:37 -0700
Message-ID: <7vvcf3z5tu.fsf@alter.siamese.dyndns.org>
References: <5060588D.3080202@drmicha.warpmail.net>
 <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 19:30:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGCUc-00074b-9U
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 19:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300Ab2IXRal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 13:30:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757288Ab2IXRak (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 13:30:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B61848700;
	Mon, 24 Sep 2012 13:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BfoAl8Djdb5Wv1GTTVG47q7/vaw=; b=m+UprJ
	fQAFIvzPcyQtPwsN3IXnKjzNPtUCZlaH7Lkp2CLCMJSGAMTQCKjlpHVQoYDNb2kG
	6AbPZzwEc2XVq+24mY9Uhd/lVf1OFcANH14CfGg0dAtbZczk2ekp9UMT5f/96Rru
	q1zD3W46+VSHRkrDQsMGAkE2F55KN/TEb08kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Un2JEwQDGyl9lyCSHq1OVkQacj3auWyL
	IDKLL3cpljK2fWcWUb3wPMAu/iIhTZtVKL3BvAxUSzzIZoX4CoywzZt/odGHj6Vh
	JlrEZh7imMDpUXpki3s2AoLqTmBmw9L5v6OVtkXn/H8bg76Rut5dRMANnKHJdpJc
	cP0nsUry4YM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2D5586FF;
	Mon, 24 Sep 2012 13:30:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC38786FE; Mon, 24 Sep 2012
 13:30:38 -0400 (EDT)
In-Reply-To: <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon, 24 Sep 2012 14:57:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E9DE596-066D-11E2-8994-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206298>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, all paths in the config file are subject to tilde expansion
> for user paths while the argument to --git-dir is not expanded, and
> neither are paths in the environment such as GIT_DIR. From the user
> perspective, though, the two commands
>
> GIT_DIR=~user/foo git command
> git --git-dir=~user/foo command
>
> currently behave differently because in the first case the shell would
> perform tilde expansion, but not in the second. Also, one may argue that
> specifying '--git-dir=' is like specifying a config variable (which
> cannot exist for this purpose).
>
> Thus, make arguments to '--git-dir' undergo tilde expansion.
> ---
> So, here's a simple patch implementing tilde expansion for --git-dir. It passes
> all tests. It's done doing the expansion on the setting side.

This looks sensible, as long as there is no potential caller within
this file that wants user-path expansion and that does _not_ want to
export the result to an environment.

The helper will be usable as-is for --work-dir, which does want to
export the result to an environment.  We would want --exec-path=
handle its parameter the same way, but that one has its own setenv()
elsewhere, so "expand-path-setenv()" helper would not help it very
much.  The caller of git_set_argv_exec_path() needs to do the
expanding (and freeing after it makes the call) itself.

> Alternatively, one might do it on the getting side, i.e. when reading GIT_DIR,
> so that paths passed directly through the environment undergo tilde expansion
> as well. We don't do this for any environment variable yet, so I didn't go
> that far.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  git.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index 8788b32..35e8011 100644
> --- a/git.c
> +++ b/git.c
> @@ -64,6 +64,22 @@ static void commit_pager_choice(void) {
>  	}
>  }
>  
> +static int expand_path_setenv(const char *name, const char *value, int overwrite)
> +{
> +	int ret;
> +	const char *expanded;
> +
> +	if (!value)
> +		return setenv(name, value, overwrite);
> +
> +	expanded = expand_user_path(value);
> +	if (!expanded)
> +		die("Failed to expand user dir in: '%s'", value);

This should say where the 'value' came from (e.g. "--git-dir=" on
the command line).

> +	ret = setenv(name, expanded, overwrite);
> +	free((void *)expanded);
> +	return ret;
> +}
> +
>  static int handle_options(const char ***argv, int *argc, int *envchanged)
>  {
>  	const char **orig_argv = *argv;
> @@ -117,13 +133,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				fprintf(stderr, "No directory given for --git-dir.\n" );
>  				usage(git_usage_string);
>  			}
> -			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
> +			expand_path_setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
>  			if (envchanged)
>  				*envchanged = 1;
>  			(*argv)++;
>  			(*argc)--;
>  		} else if (!prefixcmp(cmd, "--git-dir=")) {
> -			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
> +			expand_path_setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
>  			if (envchanged)
>  				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--namespace")) {
