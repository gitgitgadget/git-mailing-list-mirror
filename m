From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 11:57:20 -0800
Message-ID: <xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>
	<54E31405.5040502@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:57:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNoGt-0006KE-ND
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 20:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbbBQT5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 14:57:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752381AbbBQT5X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 14:57:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69FF737F06;
	Tue, 17 Feb 2015 14:57:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sVpp78ubB7JEk3Gn01nfoJvBlBA=; b=x/oFhZ
	SiXSFXARPTDnqBmS/tUFPpArm/we3Pyd6VmLnlX+ivxvQYDD0ntZAxMb2sxPVXy5
	Y0EUWBv+7Quk7bhKf1X0UGDDqYKf1LFuY+/77b3h8W8ce/NmEcRFom2+GpzoaAnz
	7yhZNzw4HsZfTtkXhhALmruCk74SwYUDO76tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d0giTO1fm4M7ZVJaAt2yWvrNX9Avd5mN
	5xu+1REk0e1i0/lyQsO0PZKIYrMlEqk+a/cq600O3Vh5DwGDzQPAha+Yjr4gM65m
	n3u5ze4CUs1wZhjKlY5dntPI3J08uosEd0GMSlZCwriJTTIQAV5OG/ga6/xxP+3k
	BFhJIiIjJoo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6164E37F05;
	Tue, 17 Feb 2015 14:57:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B480A37F04;
	Tue, 17 Feb 2015 14:57:21 -0500 (EST)
In-Reply-To: <54E31405.5040502@gnu.org> (Paolo Bonzini's message of "Tue, 17
	Feb 2015 11:12:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F6B9FB2-B6DF-11E4-BCF8-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263979>

Paolo Bonzini <bonzini@gnu.org> writes:

> On 16/02/2015 20:47, Junio C Hamano wrote:
>> Paolo Bonzini <bonzini@gnu.org> writes:
>> 
>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> After updating to git 2.3.0, "git request-pull" is stubbornly complaining
>>> that I lack a matching tag on the remote side unless I pass the third
>>> argument.  But I did prepare and push a signed tag.
>> 
>> A few questions.
>> 
>>  - what old version did you update from?  I think the "correct
>>    over-eager dwimming" change was from v2.0 days.
>
> I upgraded from 1.9.  My workflow is to make a signed tag, push it and
> do "git request-pull origin/master <url>".
>
> My branches have a different name locally vs. remotely (e.g.
> "kvm-master" and "kvm-next" locally vs. refs/heads/master and
> refs/heads/next remotely) exactly to avoid overeager matching in
> git-request-pull.  I only ever want to request pulls based on signed tags.

So I think you would want something like this:

    git tag -s for-linus kvm-next
    git push <url> kvm-next:next tags/for-linus
    git request-pull origin/master <url> for-linus

in the post 2.0 world with 024d34cb (request-pull: more strictly
match local/remote branches, 2014-01-22)?

>>  - what exactly do you mean by "stubbornly complain"?  I think we
>>    say something about HEAD not matching the HEAD over there, which
>>    I think is bogus (we should instead say things about the branch
>>    you are on and the branch over there with the same name) and is
>>    worth fixing.
>
> I tried both "git checkout kvm-next" and "git checkout tags/for-linus",
> and it still complains.

Sorry, I was asking what you mean by "complains" (i.e. the exact
error message).  I was and am guessing it is something like this: 

    warn: No match for commit 3188ab3... found at <url>
    warn: Are you sure you pushed 'HEAD' there?

Asking to pull 'HEAD' may be often a wrong thing to do, and I
wouldn't mind if this sequence:

	git checkout kvm-next
        git request-pull origin/master <url>

behaved the same way as

        git request-pull origin/master <url> kvm-next

But I do not know if the implicit HEAD should DWIM locally to this:

        git request-pull origin/master <url> for-linus

> ...  Based on your answer, it seems like you are focusing mostly
> on a branch-based workflow; ...

Not really.  I am focusing mostly on not breaking what 024d34cb0 and
dc2eacc58c fixed earlier.

> ... the two definitely have
> different requirements for DWIMming (since you cannot get a tag name via
> "git symbolic-ref" for example).  On the other hand most of the
> un-DWIMming changes were done by Linus who works a lot with (other
> people's) signed tags...
