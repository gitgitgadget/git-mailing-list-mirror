From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] check-ignore.c, dir.c: fix segfault with '.'
 argument from repo root
Date: Tue, 19 Feb 2013 18:47:23 -0800
Message-ID: <7vtxp73dms.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <1361301696-11307-1-git-send-email-git@adamspiers.org>
 <7vzjz03wid.fsf@alter.siamese.dyndns.org>
 <7vfw0s3qsq.fsf@alter.siamese.dyndns.org>
 <20130220015723.GB7860@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 03:47:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ziu-000256-0t
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 03:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935471Ab3BTCrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 21:47:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934711Ab3BTCra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 21:47:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDAAFAC2E;
	Tue, 19 Feb 2013 21:47:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L57qRM7j/0l9hdTBXqouIGmaG4A=; b=fZ8chd
	Tq9dEDaxqwscuoiYvWhHmpMfQAvHzXOXOrd4SSE6thzyCPgBRJDtNCsf6qd1bAN0
	QZ+hDAU8aHW6W5hbFv7dBQ93nTHEMDGGf+EJpFSeRK8UqozGvC6zzwIjM1CvhEX4
	HSvCRHgKRvebKvuk5CImGxceipyZTTpmwFoUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dOuXmnbQUNNQvN+DXcoCdzULJV3U3VgP
	UamBjAnsidBYHjwyNbuQXL46b1DqjjPc5KKvXp8ISQmFeiLoqyZ/a30G/UfO2ZuS
	XbIXLcdbvzC3j/zPwvwuglMs0vZnByt7sUPA5/Ddmb8SKam4D+WKe9AqL2O5pPOd
	f2kGggF609k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1C95AC2D;
	Tue, 19 Feb 2013 21:47:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFA11AC26; Tue, 19 Feb 2013
 21:47:25 -0500 (EST)
In-Reply-To: <20130220015723.GB7860@pacific.linksys.moosehall> (Adam Spiers's
 message of "Wed, 20 Feb 2013 01:57:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC8F32B4-7B07-11E2-A791-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216674>

Adam Spiers <git@adamspiers.org> writes:

>> Remove a sweep-the-issue-under-the-rug conditional in check-ignore
>> that avoided to pass an empty string to the callchain while at it.
>> It is a valid question to ask for check-ignore if the top-level is
>> set to be ignored by default, even though the answer is most likely
>> no, if only because there is currently no way to specify such an
>
> Hmm, I see very little difference between the use of "most likely" and
> the use of the words "much" and "typically" which you previously
> considered "a sure sign that the design of the fix is iffy".

Your patch were "The reason why feeding empty string upsets
hash_name() were not investigated; by punting the '.' as input, and
ignoring the possibility that such a question might make sense, I
can work around the segfault. I do not even question if hash_name()
that misbehaves on an empty string is a bug. Just make sure we do
not tickle the function with a problematic input".

The patch you are responding to declares that hash_name() should
work sensibly on an empty string, and that is the _only_ necessary
change for the fix.  We could keep "&& path[0]", but even without
it, by fixing the hash_name(), we will no longer segfault.

My "most likely" is about "the special case '&& path[0]' produces
correct result, and it is likely to stay so in the near future until
we update .gitignore format to allow users to say 'ignore the top by
default', which is not likely to happen soon".  It is not about the
nature of the fix at all.

Still do not see the difference?

The removal of the "&& path[0]" is about allowing such a question
whose likeliness may be remote.  In the current .gitignore format,
you may not be able to say "ignore the whole thing by default", so
in that sense, the answer to the question this part of the code is
asking when given "." may always be "no".  Keeping the "&& path[0]"
will optimize for that case.

And "unusual thing to ask" below is to judge if answering such a
question is worth optimizing for (the verdict is "no, it is not a
common thing to do").

>> entry in the .gitignore file. But it is an unusual thing to ask and
>> it is not worth optimizing for it by special casing at the top level
>> of the call chain.
>
> Although I agree with your proposed patch's sentiment of avoiding
> sweeping this corner case under the rug, 'check-ignore .' still
> wouldn't match anything if for example './' was a supported mechanism
> for ignoring the top level.

It indicates that there may be more bugs (that may not result in
segv) somewhere in check-ignore codepath, if (1)

	echo ./ >.gitignore
        
were to say "ignore everything in the tree by default.", and (2) the
real ignore check does work that way, but (3)

	git check-ignore .

says "we do not ignore that one".  Such a bug may come from some
code that is not prepared to see an empty pathname that refers to
the top-level in the codepath, which was why I originally asked 

    Does the callchain that goes down to this function have other places
    that assume they will never see an empty string, like this function
    does, which I _think_ is the real issue?

in one of the previous messages.

But is 

	echo ./ >.gitignore

a way to say "ignore everything in the tree by default" in the first
place?  I think historically that has never been the case, I recall
that the list had discussions on that topic in the past (it may be
before you appeared here), and I do not recall we reached a concensus
that we should make it mean that nor applied a patch to do so.
