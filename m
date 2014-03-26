From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/apply.c: use iswspace() to detect line-ending-like chars
Date: Wed, 26 Mar 2014 11:02:50 -0700
Message-ID: <xmqqzjkcj0s5.fsf@gitster.dls.corp.google.com>
References: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
	<532C1EFA.3000109@alum.mit.edu>
	<7vd2haq3n5.fsf@alter.siamese.dyndns.org>
	<CAByyCQBX+xfDdMwFOE2bZg8W2S0jwj2nLV36JwH1N3D4Fn2BUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: George Papanikolaou <g3orge.app@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:03:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSsAJ-0007Iv-NQ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbaCZSC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 14:02:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727AbaCZSC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 14:02:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04F7875603;
	Wed, 26 Mar 2014 14:02:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tK0wyZvRi++hfJ230sgCATpQhYs=; b=p0r0sM
	cl51314pcT4LYywwNngRCw3rceO0YP+f0YFvvmGdBjz1GaM5pJa6CC42yunG+toO
	I27+WLptCaJxZzwzoi6agyl1ECSZS64llO/jmIqv7ekXZYzd5od/VOGe9S9GOV2t
	SYSLT4li/0tNOmSrpPwwflmhVCEa3glfbrg1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SIgWQ4D28F0PyMGMsJP9eyjKt4V5QTZY
	PQfqSaTKuhdgwfd6XMlXCmlRevCseMT8zr/XcC8/RHMwKNyQ5PnSMjBxvrFKOvfs
	5eDbIIJtf2zePOtzmFDTPaz6sFuTDmYiJNKXMs4RMDvsCStYux+A7qh8Mte6LY0u
	PQQGHswJAT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E658075601;
	Wed, 26 Mar 2014 14:02:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1225975600;
	Wed, 26 Mar 2014 14:02:55 -0400 (EDT)
In-Reply-To: <CAByyCQBX+xfDdMwFOE2bZg8W2S0jwj2nLV36JwH1N3D4Fn2BUw@mail.gmail.com>
	(George Papanikolaou's message of "Wed, 26 Mar 2014 18:58:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB135FC0-B510-11E3-BEA4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245200>

George Papanikolaou <g3orge.app@gmail.com> writes:

> On Tue, Mar 25, 2014 at 6:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> As a tangent, I have a suspicion that the current implementation may
>> be wrong at the beginning of the string.  Wouldn't it match " abc"
>> and "abc", even though these two strings shouldn't match?
>
> Wouldn't that be accomplished by just removing the leading whitespace check?

Yes.  I was wondering *what* semantics we want in the first place;
how to implement what I suggested is so trivial that it goes without
saying for the intended audiences of that comment ;-).

> I'm somewhat confused about what the function should match. I haven't
> grasped it.

This function is used when attempting to resurrect a patch that is
whitespace-damaged.  The patch may want to change a line "a_bc" in
the original into something else [*1*], and we may not find "a_bc"
in the current source, but there may be "a__bc" (two spaces instead
of one the whitespace-damaged patch claims to expect).  By ignoring
the amount of whitespaces, it forces "git apply" to consider that
"a_bc" in the broken patch meant to refer to "a__bc" in reality.

I _think_ the original motivation of ignore_ws_change was to match
the "--ignore-space-change" option of "diff", i.e. "ignore changes
in the amount of white space".  I just checked the source
(xdiff/xutils.c) and made sure that "git diff" does not treat the
beginning of line any differently hence "_a_bc" and "a_bc" are not
considered a match under its --ignore-space-change option.

The current implementation of "apply --ignore-space-change" that
ignores leading whitespaces (not "ignore changes in the amount of
leading whitespaces") is likely to be a bug from this point of view.

But I wanted to hear opinions from other Git experts [*2*].  Hence
my "As a tangent, I have a suspicion".


[Footnote]

*1* This mode is not enabled by default.  I am not even sure if
    anybody sane would (or should) use this option.  Sure, the fuzzy
    match may be able to find the original line that the patch
    author may meant to patch even when it is whiltespace-damaged
    because it does not fully trust what the original lines exactly
    say (i.e. context lines prefixed by " " and old lines prefixed
    by "-").  What makes it sane for us to trust what the
    replacement lines (i.e. new lines prefixed by "+") in such a
    mangled patch says?

*2* For example, somebody may be able to point out that "this is
    meant to match the option of the same name 'diff' has", which is
    my assumption that leads to the above discussion, may not be
    true.
