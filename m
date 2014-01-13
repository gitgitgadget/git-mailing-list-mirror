From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] blame: new option --prefer-first to better handle merged cherry-picks
Date: Mon, 13 Jan 2014 15:01:41 -0800
Message-ID: <xmqqbnzf5vvu.fsf@gitster.dls.corp.google.com>
References: <20140113063008.GA3072@client.brlink.eu>
	<xmqqfvor5xil.fsf@gitster.dls.corp.google.com>
	<20140113225229.GA3418@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Tue Jan 14 00:01:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2qVz-0007KD-C0
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 00:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbaAMXBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 18:01:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbaAMXBq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 18:01:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42EBC6379A;
	Mon, 13 Jan 2014 18:01:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SEpgZdxE1Fwf7O1yBc4exzcBh0c=; b=Q+6SBV
	UDnD3+UMWF/QcPMtmTlY/SnnuO89NPJ9bj9B31yqyqq5pniLuD0aC80zT6VVL5bx
	NVPljdKBvTbQ6Zcnc4HlMLxAfyMmXL+TuySGmSvEfKJGaBuCghVqyQ2cBiFrqdzK
	Jl8QBQgbtvwdSbsLrlIcvfX7e82L8RNXpnXLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i9u2FfEW2P0c0wJqHLzB2QlxDh+FqoWz
	r+N5Iv4aYaNXk0ylgzT/fzPmj2Rkcpen/4jsMKYj5pydurHkNCqrSP5GOZpF2p/U
	CYAtJ/lshZojrKDnz0/2meYhNnjGt18RQ0JtEWg8ThFJ9vTFU5qS3axMhfEpcMwo
	bwCah/6iYjQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2296C63799;
	Mon, 13 Jan 2014 18:01:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CEA763794;
	Mon, 13 Jan 2014 18:01:44 -0500 (EST)
In-Reply-To: <20140113225229.GA3418@client.brlink.eu> (Bernhard R. Link's
	message of "Mon, 13 Jan 2014 23:52:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC127532-7CA6-11E3-9AEC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240378>

"Bernhard R. Link" <brl+git@mail.brlink.eu> writes:

> * Junio C Hamano <gitster@pobox.com> [140113 23:31]:
>> I read the updated documentation three times but it still does not
>> answer any of my questions I had in $gmane/239888, the most
>> important part of which was:
>>
>>     Yeah, the cherry-picked one will introduce the same change as
>>     the one that was cherry-picked, so if you look at the end result
>>     and ask "where did _this_ line come from?", there are two
>>     equally plausible candidates, as "blame" output can give only
>>     one answer to each line.  I still do not see why the one that is
>>     picked with the new option is better.
>
> Because:
>   - it will blame the modifications of merged cherry-picked commit
>     to only one commit. Without the option parts of the modification
>     will be reported as coming from the one, parts will be reported
>     to be from the other. With the option only one of those two commits
>     is reported as the origin at the same time and not both.
>   - it is more predictable which commit is blamed, so if one is
>     interested in where some commit was introduced first into a
>     "mainline", one gets this information, and not somtimes a different
>     one due to unrelated reasons.
>
>> To put it another way, why/when would an end user choose to use this
>> option?  If the result of using this option is always better than
>> without, why/when would an end user choose not to use this option?
>
> While the result is more consistent and more predictable in the case
> of merged cherry picks, it is also slower in every case.

Consistent and predictable, perhaps, but I am not sure "exact" would
be a good word.

Wouldn't the result depend on which way the cherry pick went, and
then the later merge went?  In the particular topology you depicted
in the log message, the end result may happen to point at the same
commit for these two paths, but I am not sure how the change
guarantees that "we always point at the same original commit not the
cherry-picked one", which was implied by the log message, if your
cherry-pick and merge went in different direction in similar
topologies.

And that is why I said:

    At best, it looks to me that it is saying "running with this
    option may (or may not) give a different answer, so run the
    command with and without it and see which one you like"

With the stress on "different" answer; it the change were "with the
option the result is always better, albeit you will have to wait
longer", I would not have this much trouble accepting the change,
though.
