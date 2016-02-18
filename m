From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] submodule: port init from shell to C
Date: Thu, 18 Feb 2016 12:46:37 -0800
Message-ID: <xmqqmvqxg30y.fsf@gitster.mtv.corp.google.com>
References: <1455320356-15778-1-git-send-email-sbeller@google.com>
	<1455320356-15778-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:46:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWVTI-000889-HO
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 21:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947698AbcBRUqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 15:46:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1947555AbcBRUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 15:46:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EAB0045AF6;
	Thu, 18 Feb 2016 15:46:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3oYF70CHaNlJXDPCg+Dz67YqO4s=; b=UecL8d
	XhaOz/QE6zcyi+SMp6RrLHob8Ukxosk8n5iFaBuH/B9vfOAuikK53lw7cKcscsOb
	Zcxe/CcQK9JLza/nfeHdmY1qAFsJ/ozDxDhXMpIfnI9HOhgbEtvuNQzgvuqZ9P6I
	7ApEDg3O14evEAbYzD2iFx93fkG/ysf8kAQ3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ckK63+GxGQ7Owsep+1xVZfI+ZtM6tfOB
	W77frHB9CxlHdL3opoYKsW0Lh7teQ0v3o+Yjw/K8LUUJ09VWNdDPgs3dc9RBw3lP
	XYSlgHHNESN5GpqkZGAagaQ2poE3afyYSNAV6r8v+EYzzAfIyz3/MCx7XBwSUboz
	ftWdQ2coiV0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1AD345AF5;
	Thu, 18 Feb 2016 15:46:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E7C345AF4;
	Thu, 18 Feb 2016 15:46:38 -0500 (EST)
In-Reply-To: <1455320356-15778-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 12 Feb 2016 15:39:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B4F317B6-D680-11E5-99F5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286619>

Stefan Beller <sbeller@google.com> writes:

> By having the `init` functionality in C, we can reference it easier
> from other parts in the code.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  39 +---------------
>  submodule.c                 |  21 +++++++++
>  submodule.h                 |   1 +
>  4 files changed, 130 insertions(+), 38 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d1e9118..30e623a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -214,6 +214,112 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>  	return 0;
>  }
>  
> +static void init_submodule(const char *path, const char *prefix, int quiet)
> +{
> +	const struct submodule *sub;
> +	struct strbuf sb = STRBUF_INIT;
> +	char *url = NULL;
> +	const char *upd = NULL;
> +	char *cwd = xgetcwd();
> +	const char *displaypath = relative_path(cwd, prefix, &sb);
> +
> +	/* Only loads from .gitmodules, no overlay with .git/config */
> +	gitmodules_config();

This feeds submodule_config() function with the contents of
".gitmodules".

> +	sub = submodule_from_path(null_sha1, path);
> +
> +	/*
> +	 * Copy url setting when it is not set yet.
> +	 * To look up the url in .git/config, we must not fall back to
> +	 * .gitmodules, so look it up directly.
> +	 */
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "submodule.%s.url", sub->name);
> +	if (git_config_get_string(sb.buf, &url)) {
> +		url = xstrdup(sub->url);
> +		if (!url)
> +			die(_("No url found for submodule path '%s' in .gitmodules"),
> +				displaypath);

I am assuming that this corresponds to these lines in the original
scripted version:

		url=$(git config -f .gitmodules submodule."$name".url)
		test -z "$url" &&
		die "$(eval_gettext "No url found for submodule path...

but what makes git_config_get_string() to read from ".gitmodules"
file?  Doesn't it read from $GIT_DIR/config & ~/.gitconfig instead?

> +		/* Possibly a url relative to parent */
> +		if (starts_with_dot_dot_slash(url) ||
> +		    starts_with_dot_slash(url)) {
> +			char *remoteurl;
> +			char *remote = get_default_remote();
> +			struct strbuf remotesb = STRBUF_INIT;
> +			strbuf_addf(&remotesb, "remote.%s.url", remote);
> +			free(remote);
> +
> +			if (git_config_get_string(remotesb.buf, &remoteurl))
> +				/*
> +				 * The repository is its own
> +				 * authoritative upstream
> +				 */
> +				remoteurl = xgetcwd();
> +			url = relative_url(remoteurl, url, NULL);
> +			strbuf_release(&remotesb);
> +			free(remoteurl);

Does the code inside this block correspond to this single line in
the original?

	url=$(git submodule--helper resolve-relative-url "$url") || exit

It seems to be doing quite a different thing, though.

> +		}
> +
> +		if (git_config_set(sb.buf, url))
> +			die(_("Failed to register url for submodule path '%s'"),
> +			    displaypath);
> +		if (!quiet)
> +			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
> +				sub->name, url, displaypath);
> +	}
> +
> +	/* Copy "update" setting when it is not set yet */
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "submodule.%s.update", sub->name);
> +	if (git_config_get_string_const(sb.buf, &upd) &&



This part of the code is supposed to read from in-tree ".gitmodules"
and copy to $GIT_DIR/config (i.e. git_config_set() below), but
again, I am not sure what makes this read from ".gitmodules".

Puzzled.

> +	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
> +		if (sub->update_strategy.type == SM_UPDATE_COMMAND) {
> +			fprintf(stderr, _("warning: command update mode suggested for submodule '%s'\n"),
> +				sub->name);
> +			upd = "none";
> +		} else
> +			upd = submodule_strategy_to_string(&sub->update_strategy);
> +
> +		if (git_config_set(sb.buf, upd))
> +			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
> +	}
> +	strbuf_release(&sb);
> +	free(cwd);
> +	free(url);
> +}
