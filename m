From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Buggy handling of non-canonical ref names
Date: Wed, 24 Aug 2011 15:27:58 -0700
Message-ID: <7vaaayo369.fsf@alter.siamese.dyndns.org>
References: <4E551D70.9080509@alum.mit.edu>
 <7vaaayps9z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 25 00:28:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwLvd-0006RH-MY
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 00:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab1HXW2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 18:28:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab1HXW2C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 18:28:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B1C54B4;
	Wed, 24 Aug 2011 18:28:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HAOzn7KyufRwZtg+HUNLq477rMg=; b=fEyLCS
	MRbTofQS5ZKPNDOGP3oGBbFdMRAMq0NRmRVxFmiwMSaKlcR7XOaMHhmADwoxH9Qn
	ZwTuaFr6PaHECLpLIjWUfK4Q2cvDIBspS7H2bmteQfrl0w+gYDDD9+5c80NZpnFv
	k7bM5MP3vXY6fzo+Se2/fO+jWxzS4oVkuyfN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KboMUJAB04PsNIW0REwH3A/T4s2LrQcC
	/yA/vXMcf39aZuBlruGs5yB9CHMyUHdjqp10i9jCUOlChO+K/FzswEtms+9P1st9
	D9JMG6ppr8PmXwCgZc6lJ/ZZBo2H8QxhuX+b/4QHYyyMQIejIWhszZHSxxBhg/pD
	TfX9r/FvLFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 207CA54B3;
	Wed, 24 Aug 2011 18:28:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78B9F54B2; Wed, 24 Aug 2011
 18:28:00 -0400 (EDT)
In-Reply-To: <7vaaayps9z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 24 Aug 2011 11:40:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 531B522A-CEA0-11E0-B0A9-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180047>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> What is the policy about reference names and their canonicalization?
>
> The overall policy has been that we care about well-formed input, and
> everything else is "undefined", even though as you found out some of them
> try to work sensibly.
>
>>     $ git check-ref-format /foo/bar ; echo $?
>>     0
>>
>>     $ git check-ref-format --print /foo/bar
>>     /foo/bar
>
> I think these are bogus. Patches welcome.

I actually think the former is correct and the latter should strip the
leading slash. Essentially what "check-ref-format" (and the underlying
check_ref_format() function) validates is if the given user string can be
used under $GIT_DIR/refs/ to name a ref, and $GIT_DIR/refs//foo/bar is
(because we "tolerate duplicated slashes" cf. comment in the function) the
same as $GIT_DIR/refs/foo/bar and is allowed.

I do not know what the original motivation behind --print was, but it
seems to want to show it canonicalized, so it should strip the leading
slash as well.

I think what is missing is a unified way to canonicalize the refnames
(which led to the inconsistencies you observed), and I strongly suspect
that check_ref_format() should learn to return the canonicalized format
(if asked by the caller) and the caller should use the canonicalized
version after feeding end-user input to it.

Then the plumbing "check-ref-format --print" can use it just like any
other caller that should be (or already are) using check_ref_format()
to validate the end-user input.

Yes, such a change will update the overall policy I stated earlier and
narrow the scope of "undefined" down a bit, by uniformly codifying that
leading and duplicate slashes are removed to be nice to the user.
