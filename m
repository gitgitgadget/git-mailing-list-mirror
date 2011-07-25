From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos containing
 damaged trees.
Date: Mon, 25 Jul 2011 20:48:36 +0200
Message-ID: <4E2DBA84.3090405@kdbg.org>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>	<7v1uxfwmq3.fsf@alter.siamese.dyndns.org> <CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 20:48:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlQCs-0000CB-9f
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 20:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab1GYSsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 14:48:41 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:51727 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751382Ab1GYSsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 14:48:40 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C71A0CDF83;
	Mon, 25 Jul 2011 20:48:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6673619F34E;
	Mon, 25 Jul 2011 20:48:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177806>

Am 25.07.2011 11:28, schrieb Jon Seymour:
> On Mon, Jul 25, 2011 at 4:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>>> ... In particular, it
>>> allows git bisect to be used to locate commits containing damaged trees.
>>
>> I am afraid it wouldn't allow it, and I am not going to take this series
>> that adds an option to bisect to ignore errors during checkout.
> 
> Understand that you don't wish to accept the series, but I do think
> you are mistaken about whether it will work.
> 
>>
>> Remember that bisection is to find a single event in the history whose
>> effect consistently persists in all the commits into the future from that
>> point.  For example, if you have this history:
>>
>>    ---A---B---C
>>
>> and there is a bitflip in a blob contained in the commit B's tree, you may
>> not be able to check it out. But that does _not_ mean you cannot check C
>> out due to a corrupt object in B. The change going from B to C may be to
>> remove that blob, for example. "A tree that refers to a corrupt object was
>> introduced by this commit" is not a single event whose effect cascades
>> through the history into the future [*1*].
> 
> I don't think you understood my intention. Suppose, I have
> 
> B4 - B5 - B6' - B7' - B8' - B9
> 
> such that B6 and B7 and B8 all contain a damaged tree, but B4, B5 and B9 don't
> since it contains a different tree, then:
> 
>         git bisect start B8' B4 --ignore-checkout-failure &&
> 	git bisect run eval "git status >/dev/null 2>&1 || false"
> 
> will stop with bisect/bad = B6'
> 
> This is exactly the result I wanted, and I discover B6' with a binary
> search, rather than a linear search.
> 
> (I could also discover B8' with a binary search by reversing the sense
> of the test).

The fundamental preconditions of bisection are: that there is a single
event in the sequence, and that the effects of the event propagate to
the end of the sequence.

Junio explainded, that the second precondition is violated. Therefore,
you cannot apply git-bisect to find brokenness in a repository *in general*.

Of course, there may be special cases where stronger assumptions are
justifiable, and your case may have been one of them.

-- Hannes
