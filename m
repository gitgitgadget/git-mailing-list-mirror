From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 13:40:46 -0700
Message-ID: <7vr4oui4a9.fsf@alter.siamese.dyndns.org>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
 <7vd30fl736.fsf@alter.siamese.dyndns.org>
 <20121019103627.GA29366@sigill.intra.peff.net>
 <CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
 <20121019202723.GA24184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, szager@google.com,
	git@vger.kernel.org, sop@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:41:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPJNO-000838-6n
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 22:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225Ab2JSUkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 16:40:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755076Ab2JSUku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 16:40:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64DE78D1A;
	Fri, 19 Oct 2012 16:40:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WOed1xFsl2ty2aurYTUmmL2J3Sc=; b=sEqHNx
	3I6SrH4YuX9raiU4lEHZABxvnJyr78UjzE8hIHsUItTrBcSarxS8ZF7ryQtFdoZu
	QgaYRG+t9eCGuiuuyfiM9jEnOCpKcGuLj5GZcb1us0lz9F4jcXyHfffUE2rl21Sp
	Ero1idw7gQ7QhQeQJX+7Z5xrk7XDBdFBpgi7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JhfaPKymX5q/K8QbnZ4XOSVLFoBluYuR
	opwYAATL88uMty5VwdI/oxEugjKdwXe8vfFVGtW8ZI+fEvlRmdwz0L8nXMa4fZsa
	6Pu33WPjhS/IxG7SFrTzarFn3PoQKcX/gPJSHiYN04gAqb5+V8mezK/mZKXQTWml
	0Z0hav27eqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 517FA8D19;
	Fri, 19 Oct 2012 16:40:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AD0E8D18; Fri, 19 Oct 2012
 16:40:48 -0400 (EDT)
In-Reply-To: <20121019202723.GA24184@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 19 Oct 2012 16:27:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43B69806-1A2D-11E2-957F-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208062>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 19, 2012 at 07:10:46AM -0700, Shawn O. Pearce wrote:
>
>> > IOW, it seems like we are _already_ following the advice referenced in
>> > curl's manpage. Is there some case I am missing? Confused...
>> 
>> The issue with the current code is sometimes when libcurl is opening a
>> CONNECT style connection through an HTTP proxy it returns a crazy high
>> timeout (>240 seconds) and no fds. In this case Git waits forever.
>> Stefan observed that using a timeout of 50 ms in this situation to
>> poll libcurl is better, as it figures out a lot more quickly that it
>> is connected to the proxy and can issue the request.
>
> Ah. That sounds like a bug in curl to me. But either way, if we want to
> work around it, wouldn't the right thing be to override curl's timeout
> in that instance? Like:

Yeah, that sounds like a more targetted workaround (read: better).

>
> diff --git a/http.c b/http.c
> index df9bb71..cd07cdf 100644
> --- a/http.c
> +++ b/http.c
> @@ -631,6 +631,19 @@ void run_active_slot(struct active_request_slot *slot)
>  			FD_ZERO(&excfds);
>  			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
>  
> +			/*
> +			 * Sometimes curl will give a really long timeout for a
> +			 * CONNECT when there are no fds to read, but we can
> +			 * get better results by running curl_multi_perform
> +			 * more frequently.
> +			 */
> +			if (maxfd < 0 &&
> +			    (select_timeout.tv_sec > 0 ||
> +			     select_timeout.tv_usec > 50000)) {
> +				select_timeout.tv_sec = 0;
> +				select_timeout.tv_usec = 50000;
> +			}
> +
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
>
> -Peff
