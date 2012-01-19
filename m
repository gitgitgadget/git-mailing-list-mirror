From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Making pathspec limited log play nicer with --first-parent
Date: Thu, 19 Jan 2012 12:43:10 -0800
Message-ID: <7vwr8niftt.fsf@alter.siamese.dyndns.org>
References: <7v1uqvjwga.fsf@alter.siamese.dyndns.org>
 <CA+55aFxucaeX7it_Kj7WV3ZbwCukN+wvbuxqJzh3V5Rxz4ib1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 21:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnypK-00036o-Bj
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 21:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968Ab2ASUnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 15:43:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932778Ab2ASUnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 15:43:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42C205179;
	Thu, 19 Jan 2012 15:43:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oA2X6PuKgj/CIs9cI3FSDQg90zA=; b=JuZ0ZD
	nN18k+PkyWGjkhSRAiy/HE22zaHmanf+kvHpduC2dBOnKC8O/WO+XRVpsTcPAIeP
	uVf3HG5R/oDwObBSNMEN3u4JqRLjGi9Lf247mV3+/X29HePPKL2IuhCUxIYpCZze
	V2JLV1XCeQScm/vZYtPpPCRdNqhrQLH2lRSb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FyQjZrucP0AySzPCMglkrxePjmVLbmh4
	hfyWbhxAWtu0dHtb9pVcl75fZu0GDIUNiEsUvMV1Xhls9tkScy4WMzYVO5KiM5oI
	QrTU6NLjRNOcid4Nfc+XyF2LUH6rMQMU4N+11tdXZnTKiEgAHkeP3ZvPYRlGrH5h
	c5TSFf0JtqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AD0F5178;
	Thu, 19 Jan 2012 15:43:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B64555175; Thu, 19 Jan 2012
 15:43:11 -0500 (EST)
In-Reply-To: <CA+55aFxucaeX7it_Kj7WV3ZbwCukN+wvbuxqJzh3V5Rxz4ib1g@mail.gmail.com> (Linus
 Torvalds's message of "Thu, 19 Jan 2012 12:15:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33D491E4-42DE-11E1-95A9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188834>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jan 19, 2012 at 11:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Comments?
>
> Looks conceptually right, but I do have to admit to hating that new variable.
>
> I don't see a better way to do it, though. Sure, you could do it with just
>
>    if (revs->first_parent_only && pp != &commit->parents)
>              break;
>
> and avoid the new variable that way, but that replaces the annoying
> variable with a pretty subtle thing.
>
> Or we could re-write that while() loop and move the 'parent' variable
> into it. Like the appended untested thing.
>
> But maybe your patch is better, and my dislike for that parent counter
> is just irrational.

I didn't like that parent counter that _only_ increments when we are
running under first-parent-only mode at the conceptual level. At the
implementation level, of course it is the right thing to do because
outside first-parent-only mode nobody cares about the parent counter,
so it is a valid but subtle optimization.

But I personally find your loop

	do {
        	...
	} while (!revs->first_parent_only);

is even more disgusting. It is misleading to have something that is not
supposed to change inside the loop as the terminating condition as if we
are saying "loop until somebody flips that bit" which is clearly not the
case.

So obviously I am saying that I do not think either patch is pretty
without offering a better alternative implementation, which is my usual
badness. As this is not an ultra urgent fix, I'll wait and see if somebody
else comes up with a more readable version.

Thanks for eyeballing the logic side of it, anyway. That was what I was
worried about the change the most.
