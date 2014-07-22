From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] "git clean" deletes excluded files in untracked directories
Date: Tue, 22 Jul 2014 15:53:59 -0700
Message-ID: <xmqqvbqpdmyg.fsf@gitster.dls.corp.google.com>
References: <20140702184429.GA32538@sigill.intra.peff.net>
	<20140702191114.GA3474@sigill.intra.peff.net>
	<xmqq8unlf4z4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 00:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9iws-0003Ok-2T
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 00:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933434AbaGVWyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 18:54:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52633 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932312AbaGVWyK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 18:54:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 157F22C15C;
	Tue, 22 Jul 2014 18:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fMJTiO/DflzMbq5LPO7XrQMjSlI=; b=JqK4Hl
	BN2BZLbaoO9QcEdpG/y0OZoFUTlCsU3zV5LST/Sat3cEBJPHg3JVoNhTP3ORcSk7
	gM0NA2hodoAD7Id1Hnn+oFb+YHL7izIubuN84MBuifffbkqH95h3QFiD2aczHSx6
	RCVEKezjL3NufLUcrRkFjoVc6MWfURtJK7Nro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1oq4c1TrnT6Ar3FatFeOT34oOve7G/V
	+YFZ93Gc+VNd4S/VDoTOMiXYIEc2INTY5Ih6Y/1VX6J02Bx+CE8Udux54i0Hpia5
	rjnE+l0ZtyUoiOSkDJJM+DsE/GCX6oTEDU18yAVuljWGRQu4EqyXBL8GeP/PBifr
	CpEKQvG9MpU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0ACBB2C15B;
	Tue, 22 Jul 2014 18:54:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A86512C14F;
	Tue, 22 Jul 2014 18:54:01 -0400 (EDT)
In-Reply-To: <xmqq8unlf4z4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Jul 2014 14:39:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 12BC021C-11F3-11E4-A41C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254048>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> If you have an untracked directory that contains excluded files, like
>> this:
>>
>>   mkdir foo
>>   echo content >foo/one
>>   echo content >foo/two
>>   echo "foo/one" >.gitignore
>>
>> then "git clean -d" will notice that "foo" is untracked and recursively
>> delete it and its contents, including the ignored "foo/one".
>
> Hmph, starting from an empty repository and doing the above four
> commands, and "git clean" without "-d" does not bother removing
> either foo/one or foo/two.  Is this correct?
>
> It gets worse.  Following the above four commands and then these two:
>
>     >foo/three
>     git add foo/two
>
> and "git clean" (with or without "-d") suddenly notices that
> "foo/three" is expendable, but not foo/one nor foo/two, which sounds
> about right.
>
> Honestly, as I do not use "git clean" myself, I do not know what the
> "right" behaviour is for that command.  Anything it does seems just
> arbitrary and wrong to me ;-)

Having said that...

Let's play my usual "I do not know what I am doing because I do not
use it myself, but instead of leaving the mess other people created
that may harm users, let's try to clean it up", and the first step
for that is to clarify what is wrong about it, and what, if
anything, could be a more sensible behaviour.

"git clean" with or without "-d" in my two-command added to your
four-command example notices .gitignore and foo/three are to be
cleaned, and further with "-x" makes foo/one eligible for
removal.  I think these are all sensible.

"git clean" without "-d" in your four-command example says
".gitignore is untracked and can be cleaned", but is "foo/two" that
is not tracked fundamentally different from ".gitignore"?

The only difference I can see is one is at the top-level while
the other is not.  What bad things could happen if we remove
"foo/two" with or without "-d", making "-d" a no-op?

I know "-d" talks about "untracked directory", but notice that with
your four-command example, there is no "git add"; there is no
difference between the top-level and "foo/" in tracked-ness, so it
is a meaningless distinction.  I could be pursuaded to buy a
proposal to make "-d" almost no-op except that a directory that
becomes empty after running "git clean [-x]" is rmdir(2)'ed and
without "-d" the empty directory is kept.

Would such a pair of changes bring some sanity to the command?

No matter what we do, I suspect that people expect various
combinations of options to "git clean" has some parallel to
"ls-files -o" with various combinations of options, to allow them to
list paths that will be cleaned with "ls-files", store them away,
and then run "clean", or something, so any "fix" would involve
updating "ls-files" in a way consistent with the updated behaviour
of "clean".
