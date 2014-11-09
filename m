From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Sun, 09 Nov 2014 10:37:29 -0800
Message-ID: <xmqqh9y8b4pi.fsf@gitster.dls.corp.google.com>
References: <20141107081324.GA19845@peff.net>
	<xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
	<20141107191745.GB5695@peff.net>
	<CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
	<CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
	<CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
	<20141108083040.GA15833@peff.net> <20141108084526.GA18912@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 19:37:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnXN5-0003dK-25
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 19:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbaKIShd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 13:37:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751347AbaKIShc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 13:37:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B6A5197A4;
	Sun,  9 Nov 2014 13:37:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SQHLAL4njurL5ChgfDgJXb/5HVs=; b=nfJxb8
	BuBfPzO8SfJW7hfv0pJKWQ849zLEa4gn+jU1ReZKhLqzKPF3R1G3cJiZGgcAj7Te
	+NlA3XkH3dJNmbTsXqggsVdM5xs8BRWEabYV/OLaMW7WimEGDCBFrqUYSOAVa3s8
	ni+2mRafpzzKmc+AT7xuowyCaJph3LKRHIDGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E6jbnFooJnHsG6uUT5u6f+T1xM5YW+aS
	lUy1afS9XtXQaYaJx3NZUIf5u+WteB7PV/c+7KIFzm728OpXg+cqGdlkYF/xRkjJ
	P3bhkPypqyrKE81Q23qIu8jfgWjULUb1P5ArXAOsSgwuyHrfQNH7HKFljFJi+CZ9
	cyYMis6Ghck=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 41CB5197A3;
	Sun,  9 Nov 2014 13:37:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4368197A2;
	Sun,  9 Nov 2014 13:37:30 -0500 (EST)
In-Reply-To: <20141108084526.GA18912@peff.net> (Jeff King's message of "Sat, 8
	Nov 2014 03:45:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7673FE5C-683F-11E4-91A4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Nov 08, 2014 at 03:30:40AM -0500, Jeff King wrote:
>
>> So just to be clear, the behavior we want is that:
>> 
>>   echo foo >some-new-path
>>   git add some-new-path
>>   git checkout HEAD -- .
>> 
>> will delete some-new-path (whereas the current code turns it into an
>> untracked file). What should:
>> 
>>   git checkout HEAD -- some-new-path
>> 
>> do in that case? With the current code, it actually barfs, complaining
>> that nothing matched some-new-path (because it is not part of HEAD, and
>> therefore we don't consider it at all), and aborts the whole operation.
>> I think we would want to delete some-new-path in that case, too.
>
> Also, t2022.3 has me very confused.
>
> It is explicitly checking that if we have "subdir/foo" unmerged in the
> index, and we "git checkout $tree -- subdir", and $tree does not mention
> "foo", that we _leave_ foo in place.

The definition of how "checkout $tree -- $pathspec" should behave
logically leads to that, I think.  Grabbing everything that matches
the "subdir" pathspec from $tree, adding them to the index and
checking them out will not touch subdir/foo that does not appear in
that $tree.

With the proposed updated semantics, it would behave differently, so
it is natural that we have tests that protect the traditional
definition of how it should behave and we will have to visit them
and update their expectation if we decide that the proposed updated
semantics is what we want.

> That seems very counter-intuitive to me. If you asked to make "subdir"
> look like $tree, then we should clobber it.

Yes.  But the existing expectation is different ;-)

If the $tree has 'subdir/foo', we would want "checkout $tree --
subdir/foo" to keep working as a way for the user to declare the
resolution of the ongoing merge.  With the proposed change in
sematics, "git checkout $tree -- subdir" will become a way to say
"Everything inside subdir/ I'd resolve to the state recorded in
$tree" during such a conflicted merge, and it will lose paths not in
the $tree.

Which may be a good thing, but existing users who are used to the
traditional behaviour will find it confusing and even risky (i.e. "I
am checking OUT; never expected it to lose any path").  A counter
argument that I find sensible, of course, is "You told us to check
out subdir/, and the state recorded for subdir/ in $tree does not
have 'foo' in it.  That is the state you asked us to check out".

The argument for "checkout $tree -- subdir/foo" is essentially the
same.  The state recorded in $tree for subdir/foo is non-existence,
and that is checked out with the proposed new semantics.
