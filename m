From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Sun, 20 Mar 2016 15:25:04 -0700
Message-ID: <xmqqoaa8okhr.fsf@gitster.mtv.corp.google.com>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
	<20160319175705.GA6989@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Chirayu Desai <chirayudesai1@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 23:25:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahlmc-0004DJ-1d
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 23:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbcCTWZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 18:25:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751530AbcCTWZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 18:25:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F1C04D206;
	Sun, 20 Mar 2016 18:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iv5AZEsFBbelGaZk5/COu/2GJg8=; b=ocQlHq
	HzBGJSUnzdbP6jMCwOGIrbLcXHh7R1Crf9OundFJr3OZfGKr6INu3tSDfp+1Ynlb
	csmy1CCB6bqT+PC7Q/XuYZ3G5ci8GqOa0UhmW8D1QPMG0KmmJq8lLzsUCUtTldqN
	wS7CGTqR/U2+b+fhQTxIFJr2BcclIA0SJFp3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iB1j7F0VMDIruFiVdb60S3AiYcFqeoYI
	gBD/wTne9CZ91SQEg8PplD5N1rtrYxj8cBvwAxvZrGS8g+E88wAKLoTirDIqeHay
	CE0/ZQNfV3lw1ZW47H22zrxRjXRS4v5KviMaG/xkw24+jdHxq6pF7fWYtTvzhODl
	lDMrLdRNLyU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 275144D204;
	Sun, 20 Mar 2016 18:25:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 907B04D203;
	Sun, 20 Mar 2016 18:25:05 -0400 (EDT)
In-Reply-To: <20160319175705.GA6989@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 19 Mar 2016 13:57:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98AF2414-EEEA-11E5-8DAF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289387>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 19, 2016 at 10:19:02PM +0530, Chirayu Desai wrote:
>
>> > Yeah, I agree that showing the "-h" help is a bit much.
>> > This is a side effect of looking up in the commit in the parse-options
>> > callback. It has to signal an error to the option parser, and then the
>> > option parser always shows the help on an error.
>> > I think we'd need to do one of:
>> > 1. call die() in the option-parsing callback (this is probably a bad
>> > precedent, as the callbacks might be reused from a place that wants
>> > to behave differently)
>> I assume you mean parse-options-cb.c:parse_opt_commits() by the callback.
>> I see that it is currently used only by commands which have a "--with"
>> or "--contains" option,
>> and all of them behave the same way, printing the full usage, so a one
>> line change in that function would fix it for all of those.
>
> Yes, that is the right callback.
>
>> > 2. have the callback just store the argument string, and then resolve
>> > the commit later (and die or whatever if it doesn't exist). This
>> > pushes more work onto the caller, but in this case it's all done by
>> > the ref-filter code, so it could presumably happen during another
>> > part of the ref-filter setup.
>> I'm not quire sure how exactly to do that.
>
> You'd teach parse_opt_commits() to store the string _name_ of the
> argument (e.g., using a string_list rather than a commit_list), and then
> later resolve those names into commits.
>
>> > 3. teach parse-options to accept some specific non-zero return code
>> > that means "return an error, but don't show the usage"
>> This sounds good, but also the most intrusive of 3.
>
> Yeah. Reading the options again, I kind of like this one. The only trick
> is that you would need to make sure no other callbacks are returning the
> value you choose for the "don't show the usage" flag. That is probably
> not too bad, though. There aren't that many callbacks, and they are not
> likely to be using values besides "-1" and "0".

My knee-jerk preference among the three is 2., but I think I'll know
when I see a patch ;-)

Thanks for helping the candidates.
