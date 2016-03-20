From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add the tag.gpgsign option to sign all created tags
Date: Sun, 20 Mar 2016 00:29:12 -0400
Message-ID: <20160320042912.GD18312@sigill.intra.peff.net>
References: <20160319182310.GA23124@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 05:29:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahUzX-0005qV-5L
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 05:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbcCTE3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 00:29:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:34744 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750963AbcCTE3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 00:29:15 -0400
Received: (qmail 17934 invoked by uid 102); 20 Mar 2016 04:29:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 00:29:15 -0400
Received: (qmail 24324 invoked by uid 107); 20 Mar 2016 04:29:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 00:29:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2016 00:29:12 -0400
Content-Disposition: inline
In-Reply-To: <20160319182310.GA23124@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289332>

On Sat, Mar 19, 2016 at 07:23:10PM +0100, Laurent Arnoud wrote:

> The tag.gpgsign config option allows to sign all
> commits automatically.

We have commit.gpgsign, so this makes some sense. Would you want to sign
_all_ tags created with "git tag", including lightweight tags, or only
those that would already create a tag object (i.e., annotated tags)?

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 1705c94..53cad28 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -29,6 +29,7 @@ static const char * const git_tag_usage[] = {
>  };
>  
>  static unsigned int colopts;
> +static const char *sign_tag;
>  
>  static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
>  {
> @@ -166,6 +167,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
>  	status = git_gpg_config(var, value, cb);
>  	if (status)
>  		return status;
> +	if (!strcmp(var, "tag.gpgsign")) {
> +		sign_tag = git_config_bool(var, value) ? "" : NULL;
> +		return 0;
> +	}

Why is "sign_tag" a pointer, and not simply an "int"?

If it is just representing the config, should it perhaps be given a more
specific name, like "sign_tag_config"?

> @@ -381,14 +387,21 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
>  
> +	if (argc == 0 && !cmdmode)
> +		cmdmode = 'l';
> +
> +	/* Remove config option when calling command other than create tag */
> +	if (cmdmode != 0 && sign_tag)
> +		sign_tag = NULL;
> +

Perhaps rather than rearranging the setup of cmdmode in this function,
you can just use have a conditional that makes explicit when this config
option kicks in, like:

  if (!cmdmode && sign_tag_config)
	opt.sign = 1;

That seems easier to follow to me (and then we don't have to check
sign_tag_config later; it acts as if the user gave "-s"). Although...

>  	if (keyid) {
>  		opt.sign = 1;
>  		set_signing_key(keyid);
>  	}
> -	if (opt.sign)
> +	if (opt.sign || sign_tag) {
> +		opt.sign = 1;
>  		annotate = 1;
> -	if (argc == 0 && !cmdmode)
> -		cmdmode = 'l';
> +	}
>  
>  	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
>  		usage_with_options(git_tag_usage, options);

How do I disable tag.gpgsign if I want an unsigned tag? I should be able
to do:

  git config tag.gpgsign true
  git tag --no-sign foo

but I don't think that works with your patch. You'd need to tweak the
handling of opt.sign to be able to tell the difference between
"--no-sign was given" and "there was no signing-related option given",
and only kick in the config in the latter case.

-Peff
