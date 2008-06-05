From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] Move builtin-remote's skip_prefix() to
 git-compat-util.h
Date: Thu, 05 Jun 2008 15:38:23 -0700
Message-ID: <7vtzg7zew0.fsf@gitster.siamese.dyndns.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 00:39:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4O7B-0008F5-Fv
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 00:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbYFEWic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 18:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbYFEWic
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 18:38:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYFEWib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 18:38:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C4453E42;
	Thu,  5 Jun 2008 18:38:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EE4A83E41; Thu,  5 Jun 2008 18:38:25 -0400 (EDT)
In-Reply-To: <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Thu, 5 Jun 2008 22:44:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E56A5BA-3350-11DD-AFF2-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83988>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/builtin-remote.c b/builtin-remote.c
> index c49f00f..9c25018 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -29,12 +29,6 @@ static inline int postfixcmp(const char *string, const char *postfix)
>  	return strcmp(string + len1 - len2, postfix);
>  }
>  
> -static inline const char *skip_prefix(const char *name, const char *prefix)
> -{
> -	return !name ? "" :
> -		prefixcmp(name, prefix) ?  name : name + strlen(prefix);
> -}
> -
>  static int opt_parse_track(const struct option *opt, const char *arg, int not)
>  {
>  	struct path_list *list = opt->value;
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 01c4045..af515d4 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -127,6 +127,12 @@ extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
>  
>  extern int prefixcmp(const char *str, const char *prefix);
>  
> +static inline const char *skip_prefix(const char *name, const char *prefix)
> +{
> +	return !name ? "" :
> +		prefixcmp(name, prefix) ?  name : name + strlen(prefix);
> +}
> +

Somehow you seemed to have picked the one whose semantics is defined much
less clearly.  For one thing, it takes more effort (and unnatural way to
check) for the caller to detect the case where prefix did not match than
the one that returns NULL.  Worse, I think this one is less efficient,
doing strlen(prefix) twice.

> diff --git a/parse-options.c b/parse-options.c
> index acf3fe3..aa164d0 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -22,12 +22,6 @@ static inline const char *get_arg(struct optparse_t *p)
>  	return *++p->argv;
>  }
>  
> -static inline const char *skip_prefix(const char *str, const char *prefix)
> -{
> -	size_t len = strlen(prefix);
> -	return strncmp(str, prefix, len) ? NULL : str + len;
> -}
> -
>  static int opterror(const struct option *opt, const char *reason, int flags)
>  {
>  	if (flags & OPT_SHORT)
> @@ -161,7 +155,7 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
>  
>  		rest = skip_prefix(arg, options->long_name);
>  		if (options->type == OPTION_ARGUMENT) {
> -			if (!rest)
> +			if (!strcmp(rest, arg))

Ugh.

At least please have the courtesy of not making it more expensive than the
original unnecessarily.  Isn't (rest == arg) enough here?

Still, I think the one from builtin-remote.c you used is a much worse
implementation of the same thing between the two.  It was Ok while it was
a local scope hack only for builtin-remote.c's use, but a special calling
convention like "if name is NULL return empty string" should not be
promoted to public utility library status without defending why it is
always a good idea to do so.
