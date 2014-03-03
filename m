From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/25] path.c: make get_pathname() return strbuf instead of static buffer
Date: Mon, 03 Mar 2014 09:56:19 -0800
Message-ID: <xmqqob1nrwsc.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-2-git-send-email-pclouds@gmail.com>
	<xmqqk3cq7kgm.fsf@gitster.dls.corp.google.com>
	<CACsJy8AKu6UQURW-Zn=VE5WF3Yqfg329nsCoxiCt+nSJKfTW3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:56:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKX6K-00034n-9g
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 18:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbaCCR4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 12:56:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbaCCR4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 12:56:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E2947037D;
	Mon,  3 Mar 2014 12:56:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lQAi8xoMspSLd2alIqMhqRRJ75o=; b=Hy8C57
	YErtKE0frkeHiM+DdDa0Vps0NEsljH0EBvaZEPX8k9ga4m1XkUY4HUWIDaBtHXBr
	wWX9yUOX8WkgsY0Y+vC5dDOsaEJeuMb3/eiLlv5RwsWU6q3tq3ggyVINiSmToGL7
	blGeE+RuXy5fYSB0OjvUPisc/C9qmaOs/wYH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JfITOXGVa+SVmr0zZehvzcYi2wa3CcrC
	R0/DHLkW+CuaPDiZhbA+LjhLY7VQB2qoMRcGXGT+9ehM+ZZx4vC3+gxFnL6+Ya0g
	A4iEdmXzVJIwCoyo0VDQHHhWvTUc/2otpPEkuwVDjXAqTTaoPYI/yE2qk9qY+2QO
	P5fbmyxVci0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E4F77037C;
	Mon,  3 Mar 2014 12:56:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F18D7037B;
	Mon,  3 Mar 2014 12:56:21 -0500 (EST)
In-Reply-To: <CACsJy8AKu6UQURW-Zn=VE5WF3Yqfg329nsCoxiCt+nSJKfTW3g@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 1 Mar 2014 09:40:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2109740E-A2FD-11E3-90A2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243240>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 20, 2014 at 6:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Is there a reason not to do just an equivalent of
>>
>>     #define git_pathdup mkpathdup
>>
>> and be done with it?  Am I missing something?
>
> They have a subtle difference: mkpathdup() calls cleanup_path() while
> git_pathdup() does not. Without auditing all call sites, we can't be
> sure this difference is insignificant. So I keep both functions
> separate for now.

Thanks; that is a very good explanation why #define'ing two to be
the same would not be a workable solution to the ownership issue I
raised.

>  char *git_pathdup(const char *fmt, ...)
>  {
> -	char path[PATH_MAX], *ret;
> +	struct strbuf *path = get_pathname();
>  	va_list args;
>  	va_start(args, fmt);
> -	ret = vsnpath(path, sizeof(path), fmt, args);
> +	vsnpath(path, fmt, args);
>  	va_end(args);
> -	return xstrdup(ret);
> +	return strbuf_detach(path, NULL);
>  }

This feels somewhat wrong.

This function is for callers who are willing to take ownership of
the path buffer and promise to free the returned buffer when they
are done, because you are returning strbuf_detach()'ed piece of
memory, giving the ownership away.

The whole point of using get_pathname() is to allow callers not to
care about allocation issues on the paths they scribble on during
their short-and-simple codepaths that do not have too many uses of
similar temporary path buffers.  Why borrow from that round-robin
pool (which may now cause some codepaths to overflow the number of
such active temporary path buffers---have they been all audited)?
