From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch not removing commits when it should in 2.7.0
Date: Tue, 19 Jan 2016 13:46:35 -0800
Message-ID: <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
	<xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
	<xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
	<20160119213705.GA28656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:46:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLe6t-0007jc-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 22:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933071AbcASVqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 16:46:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933011AbcASVqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 16:46:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0DAE83D28C;
	Tue, 19 Jan 2016 16:46:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HDGgZ02KIxzE+oNj5p2InXnkpCM=; b=ilnHNP
	/OaQsFXTUgOcmk5c92ZF6bJJ4o1uUMVe1jvAeGu7aROKeLxlAR+ake9OgPcKObMH
	/QnJvgAUmgMh4bygGAsh260AZhLXHHQ0lw6aG0GEI6JbGF66ZknKb2VifQLmpaDw
	gnBNEtMvsW8yuzBCZHdeFS7D81e442GupL+H8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IdEQGdKpkOjbitACmInqmpT9wUhNwXED
	rLsNONh5wde0IFoBiLwtN5FU5QlVDYTt5PgKx6UhKSPjEs62/LadtRx0xX7iMuup
	hzBQGyUV6WtWlEjmCZcdCcdWlAk8fn3VMoymVDX5Sq/yH0OGp3QHBRy9eXgmzRJu
	+tYndbKSfTk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04E9C3D28B;
	Tue, 19 Jan 2016 16:46:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7290A3D28A;
	Tue, 19 Jan 2016 16:46:36 -0500 (EST)
In-Reply-To: <20160119213705.GA28656@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Jan 2016 16:37:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D242282-BEF6-11E5-B9F9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284383>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 19, 2016 at 01:35:25PM -0800, Junio C Hamano wrote:
>
>> In other words, would the fix be a one-liner like this?
>> [...]
>> -		tree="$commit^{tree}"
>> +		tree=$(git rev-parse "$commit^{tree}")
>
> Yes, I was just writing up the commit message for it. :-/
>
> It _is_ slower, though, because it introduces an extra rev-parse. When
> we could in fact be getting rid of one. Give me a moment to complete a
> few timing tests and post the results.

Good point.

We should do that rev-parse in the helper function.  That rev-parse
is there only because the skip-empty code wants to know the exact
object name when comparing.  There is no reason for this code to do
it for the helper--the helper, if (and only if) it is called, can
do the rev-parse itself, and we can still omit the overhead when
we are not skipping empty ones.
