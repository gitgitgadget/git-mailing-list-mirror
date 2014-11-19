From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 13:18:56 -0800
Message-ID: <xmqqsiherirj.fsf@gitster.dls.corp.google.com>
References: <6997784.RuzRO1AFsK@al> <20141119190800.GB9908@peff.net>
	<xmqq1toysyak.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Peter Wu <peter@lekensteyn.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 22:19:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCec-0000Nq-Uo
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933567AbaKSVTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:19:02 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933046AbaKSVS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:18:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E9331E712;
	Wed, 19 Nov 2014 16:18:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RXJdHaVEQpc3cvZi/zT1raEeTqM=; b=MZtDXk
	Uq8b83n7AQ86JTVXUBSqAHwaoenOXRXX3K0pVt8op1Wvda4TNFpzQ1y+6be9D6sB
	rbIq8pajLBo6ZqzTHvbuS/X2BX83EDHZC1egNZmLdM8lp2vPm3wvJhjwsDqP1yII
	/VrUZF6QgUjb7rOy+v4Vb89Pr7hN7gQ55Q81Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HeDwWLmf0unVcGEQtGYzSNoFD5IbwsVL
	PlOpGRthwKdSsHQANfwweqNxUZd1YS8yHDLVo9TgbdpPPUXje0UIG4bwqy9jN3mV
	ZfKRwAS2I4QdAclW+xmMn8cKcCw9w0J8Nz0+OHkc3d3slEs4bpREnDEpyKiOh3jx
	MPMtA8p2544=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95C641E710;
	Wed, 19 Nov 2014 16:18:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B7641E70F;
	Wed, 19 Nov 2014 16:18:58 -0500 (EST)
In-Reply-To: <xmqq1toysyak.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Nov 2014 12:58:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACB5A336-7031-11E4-8326-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But here you do not have a pushurl defined in the first place. So I
>> guess this is really just a shortcut for swapping the two, like:
>>
>>   git remote set-url --push gh $(git config remote.gh.url)
>>   git remote set-url gh new-fetch-url
>
> It seems that this swapping is only necessary because the repository
> is set up in this way:
>
>     $ browser github.com
>     ... fork upstream to your own publishing repository ...
>     $ git clone <your publish repo>
>     ... oops, I am set up to fetch from myself ...
>     $ git remote set-url --push mine <url for your publish repo>
>     $ git remote set-url <url for your upstream repo>
>
> If you are fetching from somebody else and then pushing into your
> own publishing repository (i.e. fork of that upstream), why isn't
> the sequence of event like this, instead?
>
>     $ git clone $upstream
>     $ browser github.com
>     ... fork upstream to your own publishing repository ...
>     $ git remote set-url --push mine <url for your publish repo>
>
> Isn't this one of those bad workflows encouraged by GitHub, for
> which you guys have to be punished ;-)?

I re-read the original and Peter is really accessing the same
repository, only over different transports.  Cloning via ssh:// but
later deciding to push via ssh:// but to fetch via https:// (or vice
versa; the important point is that clone was done over a transport
that is "wrong" for future fetching).

Of course, if you cloned via a wrong transport that is not suitable
for whatever reason for later fetching, you would need to have a way
to "swap", so the observation I made in the message I am following
up on does not apply to this thread at all.  Please scratch all of
the above.

Coming back to the topic, how common would this "oops, I cloned via
a wrong transport" be?  I am not opposed to giving a recovery method
for gotcha that does not happen very often, but if such an addition
adds undue confusion factor for people who use "set-url" for more
common cases, that would be a bad trade-off.
