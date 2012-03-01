From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3]http: authenticate on NTLM proxies and others
 suppported by CuRL
Date: Thu, 01 Mar 2012 11:07:19 -0800
Message-ID: <7v399snnrs.fsf@alter.siamese.dyndns.org>
References: <4F4FBDBA.8040609@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:07:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3BLe-0007Np-GY
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 20:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776Ab2CATHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 14:07:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164Ab2CATHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 14:07:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 346746A96;
	Thu,  1 Mar 2012 14:07:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HnH4AsBKtg8C4YVQRojBWXv2Nj4=; b=DY176A
	AhOM1p3qK83imUib9ZktqCtQpVLjFI+dSNerQ1TQ5LT5K7c/MuYvuui/oNds2QG4
	AcvOr+qY4+0Lk3lgd6lo0XaCpbaskmNpEb37X2kUV5ujtK5w4hL3NWqu+7TA/jSo
	njMgxhtS/zkg5dL6NtcnjIC8/jYRFdi7LpIb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qrnRm6qo+oDujEBkZAy0HJKz0/WNcvDP
	4q+wOSd+FXUifS22bQm0vIhIOFo3KHZqzR7J1DRmkoyMGkmhPyJE+dHqXpn8eEkf
	5Woullgw0wDlIqTZW8q1A6Q1Fo8oGW38or+1py+GZCx5vKTROf+y217/wW5ceOMi
	zsvp1VLKwmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C4FE6A95;
	Thu,  1 Mar 2012 14:07:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 868166A90; Thu,  1 Mar 2012
 14:07:20 -0500 (EST)
In-Reply-To: <4F4FBDBA.8040609@seap.minhap.es> (Nelson Benitez Leon's message
 of "Thu, 01 Mar 2012 19:19:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C53382E4-63D1-11E1-9093-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191958>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

Thanks; doesn't a missing space before http: above look ugly to you, by
the way?

> CURLAUTH_ANY option automatically chooses the best auth method from
> among those the server supports, that means curl will ask the proxy and
> use the appropiate, and it will only do that if you are using a proxy
> (i.e. you've set CURLOPT_PROXY or you have http_proxy env var), also
> curl will not try to authenticate if you've not provided username or
> password in the proxy string, as told here[1]..

The above may justify why you used CURLAUTH_ANY as opposed to
CURLAUTH_BASIC or other types, but without any description of the problem
you are trying to solve before that paragraph, it does not justify why you
are adding a code to use CURLOPT_PROXYAUTH in the first place.

This is my *guess* of the problem you are trying to solve.

	When the proxy server specified by the http.proxy configuration or
	the http_proxy environment variable requires authentication, git
	failed to connect to the proxy, because we did not configure the
	cURL handle with CURLOPT_PROXYAUTH.

It may or may not match the reality, but either case, the explanation
should have something like that at the beginning of the log.

Instead of "as told here[1]..", I would have preferred for _you_ to say "I
ran with this patch against a proxy that requires authentication and
another that does not, and made sure that there was no prompt or any extra
network traffic when no username or password is in in the proxy URL to
trigger the authentication", or something like that.  The item you refer
to with your "as told here[1].." only has this to say on this issue:

   I don't think PROXYAUTH=HTTP_ANY must be conditional.  curl parses the
   proxy string, and if there's no user/pass, I'm quite sure it will ignore
   PROXYAUTH anyway.

which is *not* convincing enough to be worth even referring to.  It is
just expressing one person's educated guess.

> so, setting CURLOPT_PROXYAUTH = CURLAUTH_ANY will not affect the speed of
> normal curl use, only if 1) you are using a proxy and 2) your proxy requires
> authentication, only then curl will just make two or three roundtrips to find out
> the auth methods the proxy is using, that is a tiny cost compared to having the
> user find out the proxy auth type and set manually a specific config option to
> enable that type.
>
> So as CURLAUTH_ANY provide us out-of-the-box proxy support without affecting speed,
> we don't want it activated manually from a config option, instead we added it
> automatically when a proxy is being used.

I think you are discussing the latency (not the speed) here.  Also the
first few sentences are very hard to parse.  Perhaps you meant to say
something like this?

        When a proxy is in use, and you tell git that the proxy requires
	authentication by having username in the http.proxy configuration,
	an extra request needs to be made to the proxy to find out what
	authentication method it supports, as this patch uses CURLAUTH_ANY
	to let the library pick the most secure method supported by the
	proxy server.

        The extra round-trip adds extra latency, but relieves the user
	from the burden to configure a specific authentication method.  If
	it becomes problem, a later patch could add a configuration option
	to specify what method to use, but let's start simple for the time
	being.
