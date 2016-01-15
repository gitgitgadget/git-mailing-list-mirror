From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 10/11] test-dump-untracked-cache: don't modify the untracked cache
Date: Fri, 15 Jan 2016 12:16:37 -0800
Message-ID: <xmqqa8o6ha3e.fsf@gitster.mtv.corp.google.com>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
	<1452841192-620-11-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:16:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKAnc-0005Ue-53
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbcAOUQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:16:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751777AbcAOUQj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:16:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5710939BEB;
	Fri, 15 Jan 2016 15:16:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=1+idnvVSqjLqa2u1jXIGN0dd+UY=; b=GmunLHmSGv3Yih9nTbDg
	KUfTX7IGWxLQiwgf9ZJE6R5LGfH7WTYzPauWSsl05CJ+zN/sCv/sXvL0L5YCWATx
	cg8GVO3ck5f68MVvo2LC8AJYkj2eCGjhdNN+8myz5V5m0SECA9ysyZLbOh/Tg3uq
	7jqAshtBuGcBRF7voN4C0sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mxiBMNlq6sGcj6vqfTcee/hrWmC/5GbFtEfhBfKmnxota0
	Mb4ve2WUh2aLCuzvUq19df4ONRQCf3VlkIDWgNClZMNe9C8a+B/CE+16dw6/h9ZL
	jdPDHebz4+k0UYFA6KOoFh5dGUJ0jL3II0hoTDYAXdYydJLlVnsGs3fwebW8E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F21339BE9;
	Fri, 15 Jan 2016 15:16:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C21E139BE8;
	Fri, 15 Jan 2016 15:16:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E24682CE-BBC4-11E5-A97E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284207>

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/cache.h b/cache.h
> index 59a15fd..89c7e10 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1605,6 +1605,8 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
>  extern int git_config_get_pathname(const char *key, const char **dest);
>  extern int git_config_get_untracked_cache(void);
>  
> +extern int ignore_untracked_cache_config;
> +

I know you said this is a hack to support the test, but I really do
not like to have a test-only global variable exposed to everybody
like this, as I do not think "ignore_untracked_cache_config" should
be necessary outside the context of testing [*1*].

If the config cache layer that is used by the implementation of
git_config_get_untracked_cache() had a way to be told to pretend
that the value of a particular configuration variable is a given
value, then we could do

	git_config_pretend_value("core.untrackedcache", "keep");

at the beginning of the test program without harming anybody else.

The above is just me "thinking aloud", without assessing if the
damage to the entire codebase with that approach to extend the
config layer would be larger than the damabe by this patch, and it
is certainly not a suggestion to redo this patch along that line.
But I am saying it aloud because it may turn out to be a good
direction to go in the larger picture once this series is done--it
may be a solution that is applicable to a class of similar problems
in a more general way.

Inside the scope of this series, can we at least add a comment next
to this variable telling everybody to never use it in normal
programs, or something?

Thanks.


[Footnote]

*1* Otherwise, we have a larger problem; it would mean that "we
trust the configuration variable better than the fact that the user
said the feature must (or must not) be used with this index file" is
flawed, which would contradict with the whole premise of this
series.


> diff --git a/config.c b/config.c
> index 647a15e..a4f70f7 100644
> --- a/config.c
> +++ b/config.c
> @@ -1599,6 +1599,9 @@ int git_config_get_untracked_cache(void)
>  	int val = -1;
>  	const char *v;
>  
> +	if (ignore_untracked_cache_config)
> +		return -1;
> +
>  	if (!git_config_get_maybe_bool("core.untrackedcache", &val))
>  		return val;
>  
> diff --git a/environment.c b/environment.c
> index 1cc4aab..74294ee 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -87,6 +87,12 @@ int auto_comment_line_char;
>  /* Parallel index stat data preload? */
>  int core_preload_index = 1;
>  
> +/*
> + * This is to ensure that the untracked cache is not modified, for
> + * example in test programs like test-dump-untracked-cache.
> + */
> +int ignore_untracked_cache_config;
> +
>  /* This is set by setup_git_dir_gently() and/or git_default_config() */
>  char *git_work_tree_cfg;
>  static char *work_tree;
> diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
> index 25d855d..8d1293c 100644
> --- a/test-dump-untracked-cache.c
> +++ b/test-dump-untracked-cache.c
> @@ -44,6 +44,8 @@ int main(int ac, char **av)
>  {
>  	struct untracked_cache *uc;
>  	struct strbuf base = STRBUF_INIT;
> +
> +	ignore_untracked_cache_config = 1;
>  	setup_git_directory();
>  	if (read_cache() < 0)
>  		die("unable to read index file");
