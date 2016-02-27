From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] environment.c: introduce SETUP_GIT_ENV helper macro
Date: Sat, 27 Feb 2016 09:51:51 -0800
Message-ID: <xmqqpovighxk.fsf@gitster.mtv.corp.google.com>
References: <1456593215-16302-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:51:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZj26-0001kD-TS
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbcB0Rvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 12:51:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756553AbcB0Rvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 12:51:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49B3F45CDA;
	Sat, 27 Feb 2016 12:51:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5At7FS/Agu7Bdi3q4+BI9cNYrJ8=; b=bYeEBf
	C4LbYlH0Sq+JSFmqmmyH0kAzgo4HGg1zjGFE8G8SFQwPo1PPYatsFmutKnUDLga7
	Wv+9jh7+PaLxbq2dBMhtrc0htV9DtMAGAUoVZk7cC2VP/3oJC7HkC6cn+syfGfXU
	f+4kyBQcjFF5W5W1A+Ym7XLFbXvhAN+FtfYzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AG5Z2hV8xdlONRw3H7KS3YgRa0aR/a1Q
	LPBq6XyLGC//sZell0q/I/N7ZRxZM4gFyAJcy3B5u1WuQnirioWvXxnhzWxwlhuY
	cq2IqqqGJWBR9z5v3gsFwMCBKOA/O2ljaUky6Thh1xxcxG3JYAZlKeSwrYK5jv9F
	QW5nyDAKsW8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4148F45CD9;
	Sat, 27 Feb 2016 12:51:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AC74245CD7;
	Sat, 27 Feb 2016 12:51:52 -0500 (EST)
In-Reply-To: <1456593215-16302-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Sat, 27 Feb 2016 23:13:35 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C8ACD07A-DD7A-11E5-89CF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287713>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> The environment.c contans a couple of functions which are
> consist from the following pattern:
>
>         if (!env)
>                 setup_git_env();
>         return env;
>
> Let's move this to the SETUP_GIT_ENV helper macro to prevent
> code duplication in these functions.

Please don't.  A macro that hides "return" makes things harder to
follow, not easier.

>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  environment.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 6dec9d0..04cb6cd 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -126,6 +126,11 @@ const char * const local_repo_env[] = {
>  	NULL
>  };
>  
> +#define SETUP_GIT_ENV(env)              \
> +	if (!env)                       \
> +		setup_git_env();        \
> +	return env;
> +
>  static char *expand_namespace(const char *raw_namespace)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> @@ -199,9 +204,7 @@ int is_bare_repository(void)
>  
>  const char *get_git_dir(void)
>  {
> -	if (!git_dir)
> -		setup_git_env();
> -	return git_dir;
> +	SETUP_GIT_ENV(git_dir);
>  }
>  
>  const char *get_git_common_dir(void)
> @@ -211,9 +214,7 @@ const char *get_git_common_dir(void)
>  
>  const char *get_git_namespace(void)
>  {
> -	if (!namespace)
> -		setup_git_env();
> -	return namespace;
> +	SETUP_GIT_ENV(namespace);
>  }
>  
>  const char *strip_namespace(const char *namespaced_ref)
> @@ -251,9 +252,7 @@ const char *get_git_work_tree(void)
>  
>  char *get_object_directory(void)
>  {
> -	if (!git_object_dir)
> -		setup_git_env();
> -	return git_object_dir;
> +	SETUP_GIT_ENV(git_object_dir);
>  }
>  
>  int odb_mkstemp(char *template, size_t limit, const char *pattern)
> @@ -295,16 +294,12 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
>  
>  char *get_index_file(void)
>  {
> -	if (!git_index_file)
> -		setup_git_env();
> -	return git_index_file;
> +	SETUP_GIT_ENV(git_index_file);
>  }
>  
>  char *get_graft_file(void)
>  {
> -	if (!git_graft_file)
> -		setup_git_env();
> -	return git_graft_file;
> +	SETUP_GIT_ENV(git_graft_file);
>  }
>  
>  int set_git_dir(const char *path)
