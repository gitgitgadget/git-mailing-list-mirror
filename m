From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repack command on larger pack file
Date: Tue, 27 Oct 2015 23:23:24 -0700
Message-ID: <xmqqlhanmrz7.fsf@gitster.mtv.corp.google.com>
References: <loom.20151026T065553-934@post.gmane.org>
	<xmqq611ujfn0.fsf@gitster.mtv.corp.google.com>
	<xmqqziz6hzom.fsf@gitster.mtv.corp.google.com>
	<loom.20151027T025257-333@post.gmane.org>
	<20151027234406.GB4172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sivakumar Selvam <gerritcode@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 07:23:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrK8y-0007rw-If
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 07:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbbJ1GX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 02:23:28 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751290AbbJ1GX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 02:23:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CE9D1A3F8;
	Wed, 28 Oct 2015 02:23:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xb8PkmIBJ/vI6Nihm63uybIQYbE=; b=fg5/LC
	qnco3vQw8yYAZfKfp2DqobKzSKw+OSDebE9xhlVNn15qYAGwo1kEwvxQdApLou9r
	SJQIattN7WzdAzUZw0sx4MP08D7MgbyEo9Q82af0fjszhr+E8pBefeVSWCj7ucW7
	PXOJ0ECvd8Y561QPLnymddrmA6VUWbdn/DVow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IMwi6rav58JGRxWmHfxA+xCKdzvC31P8
	JZlg5oNKZvo7i/7pDWo7SkQByUo6zcwxnX7gksfgZoVZRb7kft5b0i3EcSxC/A2n
	kSJaP2iWSo78gCQzyYfU+0bWLmsmA+/kN90TMj5iU8uaOh0/SOCgcvKCsOZzlA4V
	YbsfCJOclkw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44E821A3F7;
	Wed, 28 Oct 2015 02:23:26 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C3CDE1A3F6;
	Wed, 28 Oct 2015 02:23:25 -0400 (EDT)
In-Reply-To: <20151027234406.GB4172@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 27 Oct 2015 19:44:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6571C860-7D3C-11E5-84D6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280353>

Jeff King <peff@peff.net> writes:

> Git tries to take some shortcuts when repacking: if two objects are in
> the same pack but not deltas, it will not consider making deltas out of
> them. The logic is we would already have tried that while making the
> original pack. But of course when you are doing weird things with the
> packing parameters, that is not always a good assumption.

Yup, that is http://thread.gmane.org/gmane.comp.version-control.git/16223/focus=16267

> [1] This is all theory, and I don't know how well git actually finds
>     such deltas, but it is probably better to have a dense tree of
>     deltas rather than long chains.  If you have a chain of N objects
>     and would to add object N+1 to it, you are probably not much worse
>     off to base it on object N-1, creating a "fork" at N.

Yes, your guess is perfectly correct here, and indeed we did an
extensive work along that line in 2006/2007.  For an example, see
http://thread.gmane.org/gmane.comp.version-control.git/51949/focus=52003

The histogram "verify-pack -v" produces was in fact done primarily
in order to make it easy to check the distribution of delta depth.

Thanks.
