From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] am: suppress error output from a conditional
Date: Sat, 11 May 2013 20:09:48 -0700
Message-ID: <7vwqr4vqpv.fsf@alter.siamese.dyndns.org>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
	<1368196005-5354-2-git-send-email-artagnon@gmail.com>
	<7vhaia51vh.fsf@alter.siamese.dyndns.org>
	<CALkWK0mtJU_fWK7A2BXN3f5VRT4Qh69PE0nfQaTJ6GU1Z5=wig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 05:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbMfc-0006Hx-5e
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 05:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab3ELDJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 23:09:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab3ELDJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 23:09:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61C2F12D7A;
	Sun, 12 May 2013 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MgLSTNof2X7ykDXFGjxALU3/mUw=; b=k8/rue
	rY3gr/gApkzwZ+gQPGX3xRLFeAzTH8c++dWKjzf0ZK4EdKiQ/1dUb4CuVtzJspk/
	tHZCe5AJHRDy3CDMlUjrcsT1GHTmS2cJpPh+17rAKqErHGYRkNB8VKJyS91/aCCH
	tKhimi2vXfMf8rm+lfn5ru9QHhHvYBmXhVfXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bOxXdo8fmj5dW8D6nRPt688Vvvm5gogp
	8aik84q6Q7wBungLyu/4DkyfQncGOZf++w/n9Iwg5uneyB8LSjyM8NUEhi2FPeLN
	aA4ufUYs6ecsrj1ywwsLWBtgGLcAealJp1baVahy7FMiVcrfIouolZmMp76jocg9
	VeQdczKgm6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55D8D12D79;
	Sun, 12 May 2013 03:09:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABCC012D78;
	Sun, 12 May 2013 03:09:49 +0000 (UTC)
In-Reply-To: <CALkWK0mtJU_fWK7A2BXN3f5VRT4Qh69PE0nfQaTJ6GU1Z5=wig@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 12 May 2013 05:08:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6858768C-BAB1-11E2-81AD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224024>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> If you are introducing "dotest exists but next/last may not be
>> present" as a valid new state, it probably should check the presence
>> and/or absence of them explicitly,
>
> Um, a test -f preceding the cat?  Why, when cat implicitly checks
> existence anyway?

With that logic, 'test -d "$dotest"' on the first line would also be
redundant, as we read from "$dotest/last" and that will catch an
error.

It is more about what is conceptually right.  You need to think what
the condition _means_.

We protect the "remove $dotest directory" with the precondition you
are changing, but what is that precondition really trying to say?
If $dotest does not exist, obviously we do not need to remove it,
but what is the essence of that sereis of tests?

It is what the comment says:

    "We have finished applying all the patches in them"

Earlier, presense of $dotest _must_ have meant that last and next
should exist (otherwise you have a corrupt state and we did want to
see error messages), and the check original did was perfectly fine.

Now, a mere presense of $dotest does _not_ mean "we have finished
applying all the patches", because sometimes you create it without
having anything to put in last or next yet.  That is why it starts
to make sense to do

        if test -d "$dotest" &&
           test -f "$dotest/last" &&
           test -f "$dotest/next" &&
           last=$(cat "$dotest/last") &&
           ...
