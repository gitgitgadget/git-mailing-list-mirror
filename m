From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6]
Date: Tue, 23 Jul 2013 11:26:38 -0700
Message-ID: <7v8v0x874x.fsf@alter.siamese.dyndns.org>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
	<loom.20130723T113216-324@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 20:26:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1hIL-0006SD-NE
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 20:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933692Ab3GWS0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 14:26:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933204Ab3GWS0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 14:26:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BCEF33BA9;
	Tue, 23 Jul 2013 18:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9FXKHEcUxiDnRmFxjvJ2Vhh0H3s=; b=ZApKdG
	JyscJgsPn+hi59FeuefCJoDAbO1RUC7Qwj0/7ir6sA+Tjj/GG8gtdOBnZGtQTtV6
	Q70SIKD7YTJcwhsEIbhflhbMqpoudbEfbNk3luC5/Q50uQIE9NqAwCQiRBVudiEy
	JExxEAz5P2Q7D1eALHgCuH7bRnw9iJUKj131k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=APvPdsVCRPeuI0WM7lx5nM9EJhJiB3Ij
	JDezep+3MfNy66Du00UZxPPcRUjAmHyL457BhxKYktM3zKCMXWH7k+JzwOgu7XGW
	ZlVF/OL7OXlVRDjG0+2TB0vLSjhtRHA7q0TA2c5mjMAq8Z7VR7SXXextquzxYr90
	BCgeOwI6XE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C8333BA8;
	Tue, 23 Jul 2013 18:26:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A494B33BA6;
	Tue, 23 Jul 2013 18:26:39 +0000 (UTC)
In-Reply-To: <loom.20130723T113216-324@post.gmane.org> (Jakub Narebski's
	message of "Tue, 23 Jul 2013 09:33:02 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A955F26-F3C5-11E2-8210-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231048>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>
>> 
>> This is mostly unchanged since the previous round, except that
>> 
>>  * The option is spelled "--force-with-lease=<ref>:<expect>".
>>    Nobody liked "cas" as it was too technical, many disliked
>>    "lockref" because "lock" sounded as if push by others were
>>    excluded by it while in fact this is to fail us.
>
> Perhaps "--force-gently" ? :-)

Hmph.  But we usually use "gently" to mean "do not give the end user
an error message--the caller handles the error itself".

While the option lets you break the usual "must fast-forward" rule,
it is more precise in that the remote ref must be pointing at not
just any ancestor of what you are pushing, but has to be at the
exact commit you specify.

E.g. if you have built one commit on top of the shared branch, and
try to push it with "push --cas=pu:HEAD^ HEAD:pu" (because you know
one commit before the tip is where you started from), your push will
be rejected if somebody else did an equivalent of "reset HEAD~3" on
the receiving end (perhaps because the top commits recorded some
material inappropriate for the project).  Your new commit is still a
decendant of that rewound tip, and usual "must fast-forward" rule
would accept the push, but with "push --cas=pu:HEAD^ HEAD:pu", you
will notice that somebody wanted to rewind the tip and pushing your
work that contains these dropped commit contradicts with that wish.

So I dunno.
