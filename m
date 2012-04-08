From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] credential: do not store credentials received from
 helpers
Date: Sat, 07 Apr 2012 22:05:00 -0700
Message-ID: <7vaa2myfsz.fsf@alter.siamese.dyndns.org>
References: <20120407033417.GA13914@sigill.intra.peff.net>
 <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
 <7v398gywb1.fsf@alter.siamese.dyndns.org>
 <20120407050913.GA4211@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 07:05:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGkJN-0007Fl-PM
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 07:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab2DHFFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 01:05:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab2DHFFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 01:05:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E8BA7A9B;
	Sun,  8 Apr 2012 01:05:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i9MmTzsxwXsve20H2cBKulVJCSE=; b=wHZHIo
	r/o3HRSLhYqHEU2NpEwNaqEJExYzsAxMVut0qu90TJO7gmLqxJpRJyO056czIMmX
	nAEekXIb+AXY3M4SUdSmNVpYFzJoj+5hNEsR6ddIH+BuN4lC8Fn3jKA3g7BHl5ou
	lss+ehynTHa4hlZOgeLJfOKS27Zu2GKhKnCkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdf28CfkjtAiMaDJSGcSo9H79cZELLqg
	Kl0u0l6A+X4zj7R5BqiODgAA96hwxsgjNNXcgoSqEiB1hVvtf6q/hhBsZtUz9MXi
	SAuE0OQ12WCRQYjCVlSKTET2w0VtdwPYsyl0GbfxNPX8Fz9DKbf+yrkPYOgZFUUV
	3/X+Fqx8AYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7678B7A9A;
	Sun,  8 Apr 2012 01:05:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDEDE7A98; Sun,  8 Apr 2012
 01:05:01 -0400 (EDT)
In-Reply-To: <20120407050913.GA4211@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 7 Apr 2012 01:09:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65711EA0-8138-11E1-86E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194978>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 06, 2012 at 09:56:18PM -0700, Junio C Hamano wrote:
>
>> I am afraid that "do not trigger the cache helper" might be throwing the
>> baby with bathwater to solve the real problem the patch tries to address,
>> which is:
>> 
>> Peff>   2. If you use a time-based storage helper like
>> Peff>      "git-credential-cache", every time you run a git
>> Peff>      command which uses the credential, it will also
>> Peff>      re-insert the credential after use, freshening the
>> Peff>      cache timestamp. So the cache will eventually expire N
>> Peff>      time units after the last _use_, not after the time the
>> Peff>      user actually typed the password. This is probably not
>
> Actually, that was not the real problem. The real problem I had was the
> leakage between helpers. I just noticed this one while thinking about
> it. So the very thing that is useful to Shawn is also potentially
> dangerous to people who are doing something less clever.
>
>> Shouldn't the memory cache based helper already have enough clue to tell
>> when a new entry is first inserted vs when the existing entry it supplied
>> came back from the network layer after use?  If there is not enough clue
>> with the current network-layer-to-helper protocol, then wouldn't it be a
>> better approach to add that, so that the memory cache helper can make more
>> intelligent management of its timer?
>
> You can approximate it. The daemon sees that somebody is inserting the
> same thing that it already there, and can guess that it probably came
> from the daemon in the first place. There are some corner cases with
> expiration boundaries (we get the credential, the daemon expires it,
> then the http request succeeds, and we tell the daemon "hey, store
> this").
>
>> Once that is fixed, I would imagine that you can tell your users to use 
>> two helpers (yours and generic caching one) and configure them so that (1)
>> the caching one is asked first and then fall back to ask yours, and (2)
>> the expiration time of the caching one is set close to $X.
>
> Yeah, in my other response to Shawn, I mentioned that we could add a
> flag to do the "leaking" behavior if that's what the user wants. But it
> would have the side effect of refreshing his timestamp on each use, so
> his $X would not expire (although that is also the case now, and he
> hasn't complained).
>
> So I actually do think he would be better to implement the caching
> inside his helper, even if it is by calling out to git-credential-cache.

While I'm for keeping the interface simple, at the same time, "I have this
credential obtained and it is valid for $X time duration" sounds like a
very common thing, and it is somewhat a shame for the API to force its
users (i.e. helpers) to reimplement the caching logic over and over.

The network layer (i.e. the one that gets the authentication material from
helpers and uses it to talk with a remote git service on the other end)
could be thought of as a proxy server that gets information from its true
source (i.e. helpers) and relays it to the browser (i.e. the remote git
service). In that context, it would be natural for the API to allow the
source of the truth (i.e. the helpers) to pass its information to the
proxy with validity duration, so that the proxy can handle the expiration
in a way hidden from the information sources and the browser.  That proxy
(i.e. the network layer) could use git-credential-cache as a non-volatile
memory but that will become an implementation detail hidden from both the
remote service and the helpers.

So,... I dunno.
