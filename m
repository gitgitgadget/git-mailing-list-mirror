From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] inline constant return from error() function
Date: Tue, 06 May 2014 15:29:37 -0700
Message-ID: <xmqqppjqczhq.fsf@gitster.dls.corp.google.com>
References: <20140505212938.GA16715@sigill.intra.peff.net>
	<20140506151441.GA25768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 00:29:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whnrv-0002fO-8C
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 00:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbaEFW3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 18:29:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62901 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbaEFW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 18:29:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B34E1151AD;
	Tue,  6 May 2014 18:29:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qK+zAOxQZd1QHyX5kwqMh7iQgxM=; b=mRgl8S
	04JZWeV1qz9WK7mKq2ZuFEmMRPqw8Weh8wwCC+L1toSUPZQcTUFRZkOa04nJ1U5c
	PbmnXYtTnpvPXXag+SdwzVt5DLNgC3XJOoNmz05DWQ6JB9J2FHENN3dh1mNcuMx+
	cXcggYTaJ1HOYa1ZdW7BASVnUHGn2koudQtLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bfv3MkC8FF7GcpKbAIykPD8MwZRQUcmU
	LXuLbhfI2mZh1Pz1+tTY4SbAttq/VcQylXGbRFB9BOnLicgO1PKVNsMxnid1kfn3
	PTmJmzlGSVa3osF52WLJDfhqmAi+GOIa3NViefEt8J+P9KaTRWXf0oxCHi5K8I62
	V70hEdl5ONM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA1F8151AC;
	Tue,  6 May 2014 18:29:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69F4C151AB;
	Tue,  6 May 2014 18:29:39 -0400 (EDT)
In-Reply-To: <20140506151441.GA25768@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 6 May 2014 11:14:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E95AC8D4-D56D-11E3-BF09-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248261>

Jeff King <peff@peff.net> writes:

> Commit e208f9c introduced a macro to turn error() calls
> into:
>
>   (error(), -1)
>
> to make the constant return value more visible to the
> calling code (and thus let the compiler make better
> decisions about the code).
>
> This works well for code like:
>
>   return error(...);
>
> but the "-1" is superfluous in code that just calls error()
> without caring about the return value. In older versions of
> gcc, that was fine, but gcc 4.9 complains with -Wunused-value.
>
> We can work around this by encapsulating the constant return
> value in a static inline function, as gcc specifically
> avoids complaining about unused function returns unless the
> function has been specifically marked with the
> warn_unused_result attribute.

That's kind of W*A*T magic, and I generally try to avoid magic, as
long as it solves your "can we make both -O2 with new compilers and
-O3 happy?" I wouldn't complain ;-)

> We also use the same trick for config_error_nonbool and
> opterror, which learned the same error technique in a469a10.
>
> Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On Mon, May 05, 2014 at 05:29:38PM -0400, Jeff King wrote:
>
>> I cannot think of any other way to make the compiler aware of the
>> constant value, but perhaps somebody else is more clever than I am.
>
> This came to me in a dream, and seems to work.



>
>  cache.h           | 2 +-
>  git-compat-util.h | 6 +++++-
>  parse-options.h   | 2 +-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 107ac61..e2f12b0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1272,7 +1272,7 @@ extern int git_env_bool(const char *, int);
>  extern int git_config_system(void);
>  extern int config_error_nonbool(const char *);
>  #if defined(__GNUC__) && ! defined(__clang__)
> -#define config_error_nonbool(s) (config_error_nonbool(s), -1)
> +#define config_error_nonbool(s) (config_error_nonbool(s), const_error())
>  #endif
>  extern const char *get_log_output_encoding(void);
>  extern const char *get_commit_output_encoding(void);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f6d3a46..b4c437e 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -331,7 +331,11 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
>   * using the function as usual.
>   */
>  #if defined(__GNUC__) && ! defined(__clang__)
> -#define error(...) (error(__VA_ARGS__), -1)
> +static inline int const_error(void)
> +{
> +	return -1;
> +}
> +#define error(...) (error(__VA_ARGS__), const_error())
>  #endif
>  
>  extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
> diff --git a/parse-options.h b/parse-options.h
> index 3189676..2f9be96 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -177,7 +177,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
>  extern int optbug(const struct option *opt, const char *reason);
>  extern int opterror(const struct option *opt, const char *reason, int flags);
>  #if defined(__GNUC__) && ! defined(__clang__)
> -#define opterror(o,r,f) (opterror((o),(r),(f)), -1)
> +#define opterror(o,r,f) (opterror((o),(r),(f)), const_error())
>  #endif
>  
>  /*----- incremental advanced APIs -----*/
