From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] credential: let empty credential specs reset helper list
Date: Fri, 26 Feb 2016 15:26:06 -0800
Message-ID: <xmqqy4a7hx4h.fsf@gitster.mtv.corp.google.com>
References: <20160226105135.GA30215@sigill.intra.peff.net>
	<xmqqa8mnl71v.fsf@gitster.mtv.corp.google.com>
	<xmqqk2lrjmff.fsf@gitster.mtv.corp.google.com>
	<20160226223719.GA2429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Guilherme <guibufolo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 00:26:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZRm2-0004b4-JG
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933420AbcBZX0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:26:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755128AbcBZX0J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:26:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0403047388;
	Fri, 26 Feb 2016 18:26:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=43DmDwg8GW7FukFQ1GWsWJSLZvg=; b=niNLdo
	SKQ5MZQ20QSBwM6joOcFi6NzNV63ndni6LOndcIJUo0xL6f6RQLc+UWSSv6q3teW
	zOA8u4UoTLHoPawe1r1wUAEuV93vC/3XMCxEJVuuGne1xyME3STGck4JTm+ayMSY
	pbUhIjxJfW0DMD/1aOmfCO+ChP1Vxx+6D4MYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WmYc5I2fFS1dNdOfF+7nJWH+upwLQ49J
	pSKB3NbUpgEVeU/wdDc5tI48A46/eC0pow3Ji020IlwqUjMJcwUgrQf1EY7XzQqE
	01tUV3l29uIONDilp8hKmAbPHxEDZJgDXUiebaQsTCqcLMwJ7izRF99oN3Qzvb4k
	fxpasPuGU1A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EED1C47387;
	Fri, 26 Feb 2016 18:26:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 646B647386;
	Fri, 26 Feb 2016 18:26:07 -0500 (EST)
In-Reply-To: <20160226223719.GA2429@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 26 Feb 2016 17:37:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FD78180-DCE0-11E5-A8F3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287634>

Jeff King <peff@peff.net> writes:

> I think there is another reason, which is that the interface we expose
> to config callbacks (and via "config --get-all") is to sequentially pass
> in all values. How does that interact with this "reset"? For example,
> what is the output of:
>
>   git config foo.bar one
>   git -c '!foo.bar' config --get-all foo.bar

The callback API needs to be extended to include this "reset" bit,
not just "var" and "value", obviously.  And then of course the users
of the API need to be updated to act on that "reset" thing.

That is what I meant by "multi-value things need custom code".  The
single-valued ones can do "last one wins", and "reset" can be turned
into "the initial state" assignment for the variable; multi-value
cumulative ones already have custom code to accumulate things into
list, and they need to learn to empty the list upon seeing the
"reset" bit.

But that is not as fundamental as "new syntax breaks old clients".
If we want our new code to do useful things, obviously we would need
to work on making it do so ;-)

> I think you could get away without changing the users of the multi-value
> variables, using the "negative" approach I mentioned above. Basically:
> ...
> But like I said, that does feel somewhat half-implemented to me, since
> it treats the command-line specially.

I agree with you that that is a kludge and not the right way
forward.
