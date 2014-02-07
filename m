From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 12/14] trailer: set author and committer env variables
Date: Thu, 06 Feb 2014 16:26:24 -0800
Message-ID: <xmqqvbwrvkcv.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.20148.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 01:26:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBZH5-0004tA-RN
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbaBGA02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 19:26:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbaBGA01 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 19:26:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C303B6A701;
	Thu,  6 Feb 2014 19:26:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ESTcuSQeY1/aPO80r1zc+H9YoyI=; b=E4UmzK
	6de7j3zpW0+O58F0jOfqVqJZQw5AV5dAPJn+l1Mv+3Xt4SLJ++Mkn7AxdkF1VDyU
	VabgsaApeI5Zq3eExHa/gN1ugnHIPjhXTsij83YI74yy0B7nR6bqUDwICt7tar/H
	3b4YQLiLx27+ioDUGz1J0PfjOgTN/L3wGlcT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jvXvidk2O1uSpSwSK7swaHG0vYS63mL2
	yalWQJ1ftXr4aky9iQFReHS8QlsHhq2Ma96TDC/tMQTuCzAfLEvGi63lPALVvaVr
	0RuXycHbx4Sjw4s60hmUYXBNFrlBlOpIQLcQ099snybI6/XEMmwYncV7PrEEGj3t
	N42/5u2OJgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAB636A700;
	Thu,  6 Feb 2014 19:26:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE90A6A6FD;
	Thu,  6 Feb 2014 19:26:25 -0500 (EST)
In-Reply-To: <20140206202004.325.20148.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:20:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7AD278DC-8F8E-11E3-B299-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241757>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  trailer.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/trailer.c b/trailer.c
> index 98187fc..b5de616 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "run-command.h"
> +#include "argv-array.h"
>  /*
>   * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
>   */
> @@ -433,14 +434,40 @@ static int read_from_command(struct child_process *cp, struct strbuf *buf)
>  	return 0;
>  }
>  
> +static void setup_ac_env(struct argv_array *env, const char *ac_name, const char *ac_mail, const char *(*read)(int))
> +{
> +	if (!getenv(ac_name) || !getenv(ac_mail)) {

Whoever is using this tool while replaying an existing commit likely
wants to export these two variables _into_ this command from the
outside, and this function will not interfere with it.

But for other uses, do we need to export these variables?  After
all, this matters _only_ when the command we spawn wants to know
the idents to be used, but they can ask git-var themselves to cover
both cases, whether the environment that called this tool already
had the ident environment variables or it didn't.

So I am not sure what value this step is adding to the series.

> +		struct ident_split ident;
> +		const char *namebuf, *mailbuf;
> +		int namelen, maillen;
> +		const char *ac_info = read(IDENT_NO_DATE);
> +
> +		if (split_ident_line(&ident, ac_info, strlen(ac_info)))
> +			return;
> +
> +		namelen = ident.name_end - ident.name_begin;
> +		namebuf = ident.name_begin;
> +
> +		maillen = ident.mail_end - ident.mail_begin;
> +		mailbuf = ident.mail_begin;
> +
> +		argv_array_pushf(env, "%s=%.*s", ac_name, namelen, namebuf);
> +		argv_array_pushf(env, "%s=%.*s", ac_mail, maillen, mailbuf);
> +	}
> +}
> +
>  static const char *apply_command(const char *command, const char *arg)
>  {
> +	struct argv_array env = ARGV_ARRAY_INIT;
>  	struct strbuf cmd = STRBUF_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct child_process cp;
>  	const char *argv[] = {NULL, NULL};
>  	const char *result = "";
>  
> +	setup_ac_env(&env, "GIT_AUTHOR_NAME", "GIT_AUTHOR_EMAIL", git_author_info);
> +	setup_ac_env(&env, "GIT_COMMITTER_NAME", "GIT_COMMITTER_EMAIL", git_committer_info);
> +



>  	strbuf_addstr(&cmd, command);
>  	if (arg)
>  		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> @@ -448,7 +475,7 @@ static const char *apply_command(const char *command, const char *arg)
>  	argv[0] = cmd.buf;
>  	memset(&cp, 0, sizeof(cp));
>  	cp.argv = argv;
> -	cp.env = local_repo_env;
> +	cp.env = env.argv;
>  	cp.no_stdin = 1;
>  	cp.out = -1;
>  	cp.use_shell = 1;
> @@ -459,6 +486,7 @@ static const char *apply_command(const char *command, const char *arg)
>  		result = strbuf_detach(&buf, NULL);
>  
>  	strbuf_release(&cmd);
> +	argv_array_clear(&env);
>  	return result;
>  }
