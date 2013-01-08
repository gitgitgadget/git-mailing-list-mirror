From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: make default of "cleanup" option configurable
Date: Tue, 08 Jan 2013 13:18:19 -0800
Message-ID: <7vlic3cr1g.fsf@alter.siamese.dyndns.org>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 22:18:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsgZL-0001U4-44
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 22:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab3AHVS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 16:18:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab3AHVSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 16:18:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5641B029;
	Tue,  8 Jan 2013 16:18:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NNgxgECFKM9M8IjZv/oM3ugMnVk=; b=MIMcr1
	0SuELsxVIzBOwlRglka0eOB/k/8mTuQgcdgeimiAV6zHpZ8Ztn2FTb8wPnDJunMo
	YOh9QJKKek3t9U343u3+blNLllqHSloFez6gWtDzxdoHg+uxC/70zmeJHEQGEUCq
	ju85lP4p1wz8GhYloQ0wl/Tz6U9D5/5rZxOnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RuKwnDOe4GethcHbv0rv50XkX3DlYSCE
	7D+gyoRn/MkTApJDWuNXbDM87YSL0NV1OPXk0c/grbfkPEPV2c3yJoLeDnltSmuQ
	lnnBdmtLatbX3BppxXmFbuwEmeThes6E+6mOUaToCTpMjWHc9+yt/63ITbesZocs
	Tu/Zf/ACYyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9009B028;
	Tue,  8 Jan 2013 16:18:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D64BCB027; Tue,  8 Jan 2013
 16:18:21 -0500 (EST)
In-Reply-To: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Tue, 8 Jan 2013 21:16:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE35EF9E-59D8-11E2-BEC4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213006>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The default of the "cleanup" option in "git commit"
> is not configurable. Users who don't want to use the
> default have to pass this option on every commit since
> there's no way to configure it. This commit introduces
> a new config option "commit.cleanup" which can be used
> to change the default of the "cleanup" option in
> "git commit".
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

The idea makes sense, but I am not sure the implementation is
correct.  Does the code already know the final value of use_editor
at the point where it calls git_commit_config?  I think you do not
know at least until you call parse_and_validate_options().

Once you got the implementation right, we would want to make sure
that future changes will not break it by adding some tests that
verify:

 - Without configuration and without option, the command keeps the
   built-in default;

 - Without configuration but with option, the command uses the
   command line option (we may already have this test, I didn't
   check);

 - With configuration and without option, the command uses the
   configured default (what this patch adds); and

 - With configuration and with option, the command uses the command
   line option.

The latter two probably needs a few variants, one with --edit (with
EDITOR set to something like "true"), another with --no-edit, one
without --edit nor --no-edit but with -m "$msg" to implicitly turn
use_editor off, and one without --edit, --no-edit, nor -m but with
EDITOR set to a scriptlet that writes a message to the file to
implicitly turn use_editor on.

Also, the readers of the documentation for "commit --cleanup" will
wonder the same thing you wondered before you wrote this patch;
mentioning the configuration variable in its documentation will help
them.

Thanks.

>  Documentation/config.txt |  4 ++++
>  builtin/commit.c         | 29 ++++++++++++++++++-----------
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 53c4ca1..3f76cd1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -917,6 +917,10 @@ column.tag::
>  	Specify whether to output tag listing in `git tag` in columns.
>  	See `column.ui` for details.
>  
> +commit.cleanup::
> +	This setting overrides the default of the `--cleanup` option in
> +	`git commit`. See linkgit:git-commit[1] for details.
> +
>  commit.status::
>  	A boolean to enable/disable inclusion of status information in the
>  	commit message template when using an editor to prepare the commit
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d6dd3df..42acde7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -103,7 +103,7 @@ static enum {
>  	CLEANUP_NONE,
>  	CLEANUP_ALL
>  } cleanup_mode;
> -static char *cleanup_arg;
> +const static char *cleanup_arg;
>  
>  static enum commit_whence whence;
>  static int use_editor = 1, include_status = 1;
> @@ -966,6 +966,20 @@ static const char *read_commit_message(const char *name)
>  	return out;
>  }
>  
> +static void parse_cleanup_arg()
> +{
> +	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
> +		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
> +	else if (!strcmp(cleanup_arg, "verbatim"))
> +		cleanup_mode = CLEANUP_NONE;
> +	else if (!strcmp(cleanup_arg, "whitespace"))
> +		cleanup_mode = CLEANUP_SPACE;
> +	else if (!strcmp(cleanup_arg, "strip"))
> +		cleanup_mode = CLEANUP_ALL;
> +	else
> +		die(_("Invalid cleanup mode %s"), cleanup_arg);
> +}
> +
>  static int parse_and_validate_options(int argc, const char *argv[],
>  				      const struct option *options,
>  				      const char * const usage[],
> @@ -1044,18 +1058,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		only_include_assumed = _("Clever... amending the last one with dirty index.");
>  	if (argc > 0 && !also && !only)
>  		only_include_assumed = _("Explicit paths specified without -i nor -o; assuming --only paths...");
> -	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
> -		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
> -	else if (!strcmp(cleanup_arg, "verbatim"))
> -		cleanup_mode = CLEANUP_NONE;
> -	else if (!strcmp(cleanup_arg, "whitespace"))
> -		cleanup_mode = CLEANUP_SPACE;
> -	else if (!strcmp(cleanup_arg, "strip"))
> -		cleanup_mode = CLEANUP_ALL;
> -	else
> -		die(_("Invalid cleanup mode %s"), cleanup_arg);
>  
>  	handle_untracked_files_arg(s);
> +	parse_cleanup_arg();
>  
>  	if (all && argc > 0)
>  		die(_("Paths with -a does not make sense."));
> @@ -1320,6 +1325,8 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  		include_status = git_config_bool(k, v);
>  		return 0;
>  	}
> +	if (!strcmp(k, "commit.cleanup"))
> +		return git_config_string(&cleanup_arg, k, v);
>  
>  	status = git_gpg_config(k, v, NULL);
>  	if (status)
