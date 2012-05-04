From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] http: try http_proxy env var when http.proxy config
 option is not set
Date: Fri, 04 May 2012 08:36:13 -0700
Message-ID: <7v4nrwc61e.fsf@alter.siamese.dyndns.org>
References: <4FA2B4D3.90809@seap.minhap.es>
 <20120504070802.GA21895@sigill.intra.peff.net>
 <alpine.DEB.2.00.1205040921090.12158@tvnag.unkk.fr>
 <20120504073913.GA22388@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 04 17:36:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQKYP-0004yg-4U
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 17:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757042Ab2EDPgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 11:36:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2EDPgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 11:36:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62D30607A;
	Fri,  4 May 2012 11:36:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/2aL+eusf2pDjpaus1+FqelCO5A=; b=OncLks
	NDC5/Pl6dDivh6iixX4x0AE1h+pszL4NkFx2IJQBdObQubWgzThSyR9CUt7V/kN2
	PXw+KJP+Q464eal+n4LycHPq9seDPr39a/t8XiujFz0xoulyPoXtvyU6M7xVqid+
	wRQdWlZURptvnKjvHfH9yvK70yTkWCDimk9r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F+JIcsOLaWZlAowtw5acGIIUWpYVI3Zq
	QABCUb1kHfOtX/qTTmtMRjYiYe+HlWt/VydvnjSKmJL2/qEjgS1zL7KeFv/Pluvs
	+Xjf3dXLXVOTQqNxJgIfY4kAC6UIpoLpNKuAfBai4aNFwn8slO36VNhVU3Sd78oo
	YSVibmUZIoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B9E6079;
	Fri,  4 May 2012 11:36:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFC036077; Fri,  4 May 2012
 11:36:14 -0400 (EDT)
In-Reply-To: <20120504073913.GA22388@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 4 May 2012 03:39:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2371D6A-95FE-11E1-99E4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197029>

Jeff King <peff@peff.net> writes:

> On Fri, May 04, 2012 at 09:27:16AM +0200, Daniel Stenberg wrote:
>
>> On Fri, 4 May 2012, Jeff King wrote:
>> 
>> >I don't see any way around it besides implementing curl's full
>> >tokenizing and matching algorithm, which is about a page of code.
>> >I'd really prefer not to re-implement bits of curl (especially
>> >because they may change later), but AFAIK there is no way to ask
>> >curl "is there a proxy configured, and if so, what is it?".
>> 
>> Sorry for being thick, but I lost track on this thread. Why does it
>> need this info again?
>
> We need to know information about the proxy in order to look up the
> username and password in our credential database. Before the request is
> made in some cases, and in others, after we see a 407. If we fed the
> proxy to curl via CURLOPT_PROXY, it's easy. But if the proxy came from
> the environment, we have to replicate curl's lookup rules.
>
>> Or perhaps put another way: if there was an ideal way to get this
>> done or provide this to libcurl other than the current way, how would
>> you suggest it would be done from a git internal point of view?
>
> The absolute simplest way for us would be to stop using
> CURLOPT_PROXYUSERNAME/PASSWORD to set it ahead of time, and instead
> provide a callback that curl would call on a 407. That callback would
> just need the URL of the proxy, and would return the username/password
> (or even just set them on the curl object via
> CURLOPT_PROXYUSERNAME/PASSWORD).
>
> For that matter, it would simplify our code to do the same for regular
> http auth, too. And though we usually know our URL in that case, we
> might not if we got a 302 with FOLLOWLOCATION set.
>
> -Peff

Thanks for a nice summary, and I agree with your list of what we wish we
had from the cURL library.  With such a change, it becomes irrelevant how
the user fed cURL provisional (partial) authentication information, either
in http.proxy (which we turn into CURLOPT_PROXY), or from the environment
(without Git having to know anything about it), and a lot of complexity
that led to bugs in this series will become unnecessary.

I am tempted to suggest that the current series should be rerolled without
all the guessing and preauth tricks until such an update to the cURL
library materializes.
