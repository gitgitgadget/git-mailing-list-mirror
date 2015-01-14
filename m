From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to prevent empty git commit --amend
Date: Wed, 14 Jan 2015 09:36:25 -0800
Message-ID: <xmqq387db6xy.fsf@gitster.dls.corp.google.com>
References: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
	<vpqzj9lfzqg.fsf@anie.imag.fr>
	<xmqqfvbdb7dc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Anjo <ivo.anjo@ist.utl.pt>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:36:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRrt-0007di-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbbANRg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:36:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751336AbbANRg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:36:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F46E2BA7E;
	Wed, 14 Jan 2015 12:36:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uCum24bskcwF24H/iyu+le5S2Js=; b=SgKbxP
	ZJ3qZtJVM56Xs4VJwoqhQP2y7MXzEeZFVxILvGjg0vO46FAbPT8yc9AieN4QHGMJ
	58pgPGWCdZDbT93uyedup+//YCtIueIPnpKmAuhtJtApxCOLxw6cXAoSvntWw1GQ
	B5Hll3TMR2Udv2Qizw7GjcnvaQ8AccJKMo5TY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VRXRahqJjwfYRqB+8KwwNX0F7Qm2C1ae
	hIzHGbWVzsQAdvSb4mVWkO5Fa9adO6Vs3M55C59ttXGnv3aulkY/pZNjynSXAPTH
	j4p174BoeAXOKm0S/X/jrOIsQOupL28crEfgdXNewls1LWVp1Oybp1fKObNno9VV
	7Yc4rJ22/PQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 353C82BA7D;
	Wed, 14 Jan 2015 12:36:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 516792BA7B;
	Wed, 14 Jan 2015 12:36:27 -0500 (EST)
In-Reply-To: <xmqqfvbdb7dc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 Jan 2015 09:27:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE282246-9C13-11E4-AF05-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262400>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Ivo Anjo <ivo.anjo@ist.utl.pt> writes:
>>
>>> Is there a way to prevent a *git commit --amend** with nothing to
>>> commit from working?
>>> If not, I would like to suggest that this feature would be very helpful :)
>>
>> I don't know any way to let Git do the check for you, but 
>>
>> git diff --staged --quiet || git commit --amend
>>
>> should do it. You can alias it like
>>
>> [alias]
>> 	amend = !git diff --staged --quiet || git commit --amend
>>
>> and then use "git amend".
>
> That would not let you say "git amend Makefile", no?
>
> 	!sh -c 'git diff --cached --quiet "$@" || git commit --amend "$@"' -
>
> or something, perhaps?

Heh, not that but something like that ;-).

 * If we have pathspec, we would want to see if the HEAD and the
   working tree differ at the given paths;

 * Otherwise we would want to see if the HEAD and the index differ.

So it would be more like this, I guess.

	case "$#" in
        0)	git diff --quiet --cached ;;
        *)	git diff --quiet HEAD -- "$@" ;;
	esac || git commit --amend ${1+--} "$@"
