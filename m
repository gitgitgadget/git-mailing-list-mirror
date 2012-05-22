From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 14/15] ident: trim whitespace from default name/email
Date: Tue, 22 May 2012 09:55:19 -0700
Message-ID: <7vipfo5f60.fsf@alter.siamese.dyndns.org>
References: <20120521230917.GA474@sigill.intra.peff.net>
 <20120521231029.GN10981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 18:55:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWsMy-00006q-8y
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 18:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614Ab2EVQz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 12:55:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715Ab2EVQzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 12:55:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD33812C;
	Tue, 22 May 2012 12:55:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=S4i6UhW0Zl7CCuorrGfsT5xNTYM=; b=JWb48ozt0Owa89aBLnJs
	8P0DCeo1z3jRcCvaVyE5Febm/LRg7wCZadKjThJ6eABwVp/S/izRbS+5vMXNecER
	2LgIwSgba4CQ8e+Zf/BCMAZjNG+ThQotxcPudMSsjZ8QXKc59Qs8RL4ykSWNQlmS
	L6fTik/pjC3R5ks5k81ygiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=j7YEroW4O9cgxfty+iYgdhUQBjHW2nfXPNouiFz1Aybs+D
	oSQgukNvupj+cIca8ATNuT6ny/7Ei2ND4qvLp2y1DSSRYw1e+Gc9XSCncOpDp9EO
	49aYRpS9KxNghdpWA76GVvy9s0iTq8pJWmWve+RBwa6bKatuxiqlR2gmApClE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12F96812B;
	Tue, 22 May 2012 12:55:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9967D8125; Tue, 22 May 2012
 12:55:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB07157E-A42E-11E1-AA1B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198205>

Jeff King <peff@peff.net> writes:

> ... Any other value
> comes from a config file, where we will have cleaned up
> accidental whitespace already.

Are you referring to the behaviour of the config parser that removes
leading and trailing whitespaces when reading an unquoted string value?

If the user really wanted to have trailing whitespaces by quoting, we
would let it pass, in other words; it probably is a reasonable behaviour.

The same can be said about the environment variable GIT_COMMITTER_NAME and
friends, but "accidental whitespaces are cleaned up already" does not
apply to them.

So, isn't the real rationale behind this choice to allow users who give
leading or trailing whitespaces in the configuration and environment
variables on purpose use whatever value they specified?

I agree with the placement of trimming in this patch, but I do not quite
get (I do not mean "I do not agree with") what the quoted sentence wanted
to say.

Other than that single small "hrm...", the entire series was a pleasant
read.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ident.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/ident.c b/ident.c
> index cefb829..e279039 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -95,8 +95,10 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
>  
>  const char *ident_default_name(void)
>  {
> -	if (!git_default_name.len)
> +	if (!git_default_name.len) {
>  		copy_gecos(xgetpwuid_self(), &git_default_name);
> +		strbuf_trim(&git_default_name);
> +	}
>  	return git_default_name.buf;
>  }
>  
> @@ -110,6 +112,7 @@ const char *ident_default_email(void)
>  			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>  		} else
>  			copy_email(xgetpwuid_self(), &git_default_email);
> +		strbuf_trim(&git_default_email);
>  	}
>  	return git_default_email.buf;
>  }
