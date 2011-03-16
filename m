From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] reflog: silence -O3 -Wuninitialized warning
Date: Tue, 15 Mar 2011 22:22:57 -0700
Message-ID: <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
References: <20110316024959.GA24932@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 06:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzjCW-00077K-FS
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 06:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab1CPFXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 01:23:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab1CPFXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 01:23:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A6352269;
	Wed, 16 Mar 2011 01:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g3ltZMImoxGuBMlaD8hsGA97Mr4=; b=UYH5rl
	iR0+qOa/9gbZUg/c8c+qCebErqlT2k3GCGuJ0b0LblX3nADXGQSuixMRXZI8c/YG
	DLSHv63Ah5083uzlzifvzkePJBg6kyG0Y/qQ7/t1Q26JZTr5ZMl+/csqj0D70h0i
	DG5Cpskrl20y2FjB7HJEFSgMHJvRvqxaLj5to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mNen+MTVaEnxpY3bZFnXMuIK80DuJb/r
	mqjfORyoQqv4V+VP8kgN4ygUAZZCDdrASImaNqXTEv2RuejVkw1lN5t1A/e2lYP9
	2W6tv/8HBPt+7jHj4B+o7zf2QF5mnbpBWDJRUgOoF6Z1+PI3XKb5/BYZKeDv5LyG
	aaP7yS/tZZQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 67F8A2268;
	Wed, 16 Mar 2011 01:24:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 163BF2265; Wed, 16 Mar 2011
 01:24:31 -0400 (EDT)
In-Reply-To: <20110316024959.GA24932@elie> (Jonathan Nieder's message of
 "Tue, 15 Mar 2011 21:49:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AED7CA54-4F8D-11E0-95F4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169104>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Date: Fri, 04 Mar 2011 00:54:53 -0600
>
> Starting with gcc 4.5 (r147852, Pretty-ipa merge: Inliner heruistics
> reorg, 2009-05-25), gcc -O3 -Wall warns when building
> reflog_expire_config:
>
>     warning: 'expire' may be used uninitialized in this function [-Wuninitialized]
>
> The cause: starting with that version, gcc realizes it can inline the
> call to parse_expire_cfg_value.  In the error case, 'expire' is not
> initialized and the function returns early, but gcc does not have
> enough information to figure out that this is an error return.
> ...
> Anyway, maybe this can provide some amusement.

It actually provides only puzzlement.  That is obviously a buggy compiler
whose warning cannot be trusted.

I am not suggesting to work this around on the caller side, but I wonder
what effect the usual workaround to tell the compiler that we know it
doesn't understand the validity of this variable by saying:

	unsigned long expire = expire;

have on this?

We obviously do not want to work the compiler bug around in the callee
side by assigning to the variable when we didn't parse anything, but the
change to inline config_error_nonbool() to force this particular version
of the compiler to see the callchain through is _too_ subtle for my taste.
The call-chain horizon the next version of the compiler may stop looking
may be different, potentially shifting the compiler bug around.

I see two solutions (1) do not use -Wunitialized if the compiler is known
to be broken, or (2) initialize the variable to 0 (not the fake "x = x")
on the caller side at the place of the definition (yes, we would waste one
real assignment) if we really need to work this around, or (3) take this
patch.

We could obviously do (2) or (3), but the thing is, I don't think we can
have much confidence on -Wuninitialized warnings from this compiler once
we go down that route.  Is it _guaranteed_ that the compiler bug _always_
err on the false-positive side?

IOW, I'd very much prefer (1) for this particular case and if somebody
really cares (2).

Well, it indeed turned out to be amusing, at least for some definition of
the word ;-). I was starting to feel somewhat depressed watching news
programs from Japan on ustream.
