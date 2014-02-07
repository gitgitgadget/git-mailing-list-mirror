From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 12/14] trailer: set author and committer env variables
Date: Thu, 06 Feb 2014 16:20:52 -0800
Message-ID: <xmqqzjm3vkm3.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Fri Feb 07 01:21:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBZBk-0000U9-V0
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbaBGAU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 19:20:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbaBGAU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 19:20:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A507C6A555;
	Thu,  6 Feb 2014 19:20:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CL1kVhvLcmuHOvv9J+oe5T3ZrgA=; b=GjzqQB
	gOFKvN3Y05BWlXyosufK54d29YPxuyvDan/u6Hzr4uz92jRGdL38fzyClQurdCqD
	yUVWP6A2HuCbFpRHuaZRicXXSX9T7o1SCE+QKnacRU/7lncYbj4PLGew4r/HmYo0
	S32hqceeVVqcwXZOy9kkrqDG+/6VUqAqbs97U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PX2RxkRREHXuwsWA91lT877F/AZ2C9/m
	S3nlCSQ2Izdg/48d+sIzgR2LoaMiUICeN3MOIDx+ZDZdAZgzdGkSaxYtxDhi+R8q
	adrM9xZnd+XveU248rrIpnkmxAwUrJQ+3VYGA32Q7s0GKJK6fdscvvLN+PtZocSA
	7LqjmDqmkkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91D816A554;
	Thu,  6 Feb 2014 19:20:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C02166A553;
	Thu,  6 Feb 2014 19:20:54 -0500 (EST)
In-Reply-To: <20140206202004.325.20148.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:20:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B574ED40-8F8D-11E3-B411-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241756>

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
> +		struct ident_split ident;
> +		const char *namebuf, *mailbuf;
> +		int namelen, maillen;
> +		const char *ac_info = read(IDENT_NO_DATE);

This is far too confusing.  Name it read_fn() or something.

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
