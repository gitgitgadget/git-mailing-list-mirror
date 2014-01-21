From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 21 Jan 2014 11:28:20 -0800
Message-ID: <xmqqsishuobv.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
	<xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
	<xmqqiotiwfdk.fsf@gitster.dls.corp.google.com>
	<xmqq61piw4yf.fsf@gitster.dls.corp.google.com>
	<20140121061307.GE5878@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 21 20:28:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5gzw-0008Lg-RS
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 20:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbaAUT23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 14:28:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbaAUT22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 14:28:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A5F8648B0;
	Tue, 21 Jan 2014 14:28:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=01Xx4XeAbV6jXHGnCqdGLAIvTjM=; b=YZ3faT
	Ergx1/DiZRs0C18a7/ksc1OwGmlQGdj3LoN88KJhanmPlOU7618pQaT8mz1QNN5V
	S23/O2uRaRFjMhoilRQnGjtZfg+/LcCzFWnMXxfbcwNyakWgu6uEOTo1el18ITX8
	IIY2tWo1x+z0NTOxD3BhZyVFJvTB0hA9bszSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tac/06NUY0TukRZQEUiynAtRq/AA33rl
	p3C+XQe7ccHhDnjLlXtpNPSopN+TRVbTPjnrDNRmt4dKAjcgpq8HTL4EETDPYHMe
	aDBAWzjhcc6DNeQt/k346Q+171IMB5j3jKpLLvfvSDEwLzSt2YVT+9zRgUo+dkKI
	UM7AjFYDuxM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88481648AF;
	Tue, 21 Jan 2014 14:28:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C378E648AD;
	Tue, 21 Jan 2014 14:28:23 -0500 (EST)
In-Reply-To: <20140121061307.GE5878@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 21 Jan 2014 01:13:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31994542-82D2-11E3-BEE9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240765>

Jeff King <peff@peff.net> writes:

> Perhaps instead of just dumping it into a macro, we could actually parse
> it at compile time into C code, and store the result as a header file.
> Then that header file becomes the proper dependency, and this run-time
> error:
>
>> +	while (*pager_env) {
>> +		struct strbuf buf = STRBUF_INIT;
>> +		const char *cp = strchrnul(pager_env, '=');
>> +
>> +		if (!*cp)
>> +			die("malformed build-time PAGER_ENV");
>
> would become a compile-time error. We could do the same for the shell
> code, too.
>
> I'm thinking something like:

Heh, great minds think alike.  I did start writing a toy-patch with
a new file called "pager-env.h", before discarding it and sending a
simpler alternative which you are responding to.

I do not mind the approach at all; the primary reason I stopped
doing that was because the amount of code to get quotes right turned
out to be sufficiently big to obscure the real point of the "how
about doing it this way" illustration patch.

> diff --git a/Makefile b/Makefile
> index b4af1e2..3a8d15e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2182,6 +2182,16 @@ GIT-LDFLAGS: FORCE
>  		echo "$$FLAGS" >GIT-LDFLAGS; \
>              fi
>  
> +GIT-PAGER-ENV:
> +	@PAGER_ENV='$(PAGER_ENV)'; \
> +	if test x"$$PAGER_ENV" != x"`cat GIT-PAGER-ENV 2>/dev/null`"; then \
> +		echo "$$PAGER_ENV" >GIT-PAGER-ENV; \
> +	fi
> +
> +pager-env.h: GIT-PAGER-ENV mkcarray
> +	$(SHELL_PATH) mkcarray pager_env <$< >$@+
> +	mv $@+ $@
> +
>  # We need to apply sq twice, once to protect from the shell
>  # that runs GIT-BUILD-OPTIONS, and then again to protect it
>  # and the first level quoting from the shell that runs "echo".
> diff --git a/mkcarray b/mkcarray
> index e69de29..5962440 100644
> --- a/mkcarray
> +++ b/mkcarray
> @@ -0,0 +1,21 @@
> +name=$1; shift
> +guard=$(echo "$name" | tr a-z A-Z)
> +
> +cat <<-EOF
> +#ifndef ${guard}_H
> +#define ${guard}_H
> +
> +static const char *${name} = {
> +EOF
> +
> +for i in $(cat); do
> +	# XXX c-quote the values?
> +	printf '\t"%s",\n' "$i"
> +done
> +
> +cat <<EOF
> +	NULL
> +};
> +
> +#endif /* ${guard}_H */
> +EOF
