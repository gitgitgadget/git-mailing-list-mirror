From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for
 .gitattributes
Date: Wed, 10 Oct 2012 20:15:38 -0700
Message-ID: <7v8vbdaecl.fsf@alter.siamese.dyndns.org>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-3-git-send-email-pclouds@gmail.com>
 <50758477.3030304@viscovery.net>
 <CACsJy8CoedQBm4xyfhZX1mNTXpLMHxugygZUqOoZS8V5WVztGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 05:15:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM9Fe-0003jX-9f
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 05:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277Ab2JKDPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 23:15:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40605 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757260Ab2JKDPl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 23:15:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97E638D9D;
	Wed, 10 Oct 2012 23:15:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ubd0geWsDeg08tJCmsNhV4KnXJA=; b=q/100A
	Lu5hta0j2ckk1UcRYpkDn2R2sne5J2fB/9k/7kX22lletsDvmDPWG1q7W/v88E1W
	2PsX9Bvjn2keK06Fac6Tnqhpqck1I0vTvzjGyw73xYfVlVi6wFJ59tqc36nG96Zz
	215RIy8zvgqlAgBgGrjWOclXqovCQHwMnbWqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r5mLNlmwDxHwCXYE47Tv6IuDd5o7axFB
	OUDggFG/YfHDUzoeMZmxe4zFRIE/aGO0eAmn665yBPTwFD2Ozsm5cT/ULeSZwfCi
	DldTRGbelru1THGJR8uWnpvO0FZOjOi0iJ8rd+bRA1Cp2oqYltpBGCXi6sNuxOL4
	FbHAm+ByF8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 843C78D9C;
	Wed, 10 Oct 2012 23:15:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D29FD8D9B; Wed, 10 Oct 2012
 23:15:39 -0400 (EDT)
In-Reply-To: <CACsJy8CoedQBm4xyfhZX1mNTXpLMHxugygZUqOoZS8V5WVztGg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 11 Oct 2012 08:49:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF116704-1351-11E2-9C28-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207458>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Oct 10, 2012 at 9:21 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> +     git commit -m new &&
>>> +     echo "Binary file HEAD:t matches" >expect &&
>>> +     git grep text HEAD -- t >actual &&
>>> +     test_cmp expect actual &&
>>> +     git reset HEAD^
>>> +'
>>
>> And in yet another test, should
>>
>>         git grep text HEAD:t
>>
>> /not/ respect the binary attribute?
>
> Gray area. Is it ok to do that without documenting it (i.e. common
> sense)? I have something in mind that could do that, but it also makes
> "git grep text HEAD^{tree}" not respect attributes.

Personally, I do not think HEAD:t is worth worrying about.

We could use the get_sha1_with_context() to get "t" out of "HEAD:t",
and we could even enhance get_sha1_with_context() to also preserve
the value of what came before the colon, but that would mean that
these three

    git grep text HEAD:t/t0200
    git grep text $(git rev-parse HEAD:t/t0200)
    git grep text $(git rev-parse HEAD:t):t0200

would behave differently; only the first one has any chance of
applying the correct set of ".gitattributes".  All of them would be
able to use the ".gitattributes" file contained in the tree object
that corresponds to t/t0200 (if we updated attr.c to read from tree
objects, that is), but the latter two would skip ".gitattributes"
files from the top-level and "t" directories, still using the final
fallback definition from $GIT_DIR/info/attributes file.

If we have to draw a line somewhere, the saner place to draw it is
to stop at

    git grep text HEAD -- t/t0200
