From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Allowing push --dry-run through fetch url
Date: Fri, 06 Nov 2009 01:44:54 -0800
Message-ID: <7vfx8s0yy1.fsf@alter.siamese.dyndns.org>
References: <20091106073707.GA14881@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6LNg-0004Ya-BL
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 10:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447AbZKFJo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 04:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755354AbZKFJo6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 04:44:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZKFJo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 04:44:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9943694A51;
	Fri,  6 Nov 2009 04:45:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1qjWVYg0PqYd9SmSS+O7Ub3Sc+A=; b=WEeg/K
	tWoguksUIb1/JUZfcp0VzP2+Sc1OiurXANwD6pc6dEvft5VxugHggjdvnnQusyDT
	J2bb/Kz97muo5mS9KFYLfHfepywORHtWZhtQkspv7MsOHOH+JTDjbRF0CEXlC7S4
	juUrTXRaA0QYtZbRRbfApAO9OJ25fEddDZP0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OIvzjzzdSybJJAHvHOYlJ/D1ztX9ai4D
	Z4JS5j4hTTOYXq9yvz3iIs/LjPYUNaNgDQT0dra2V6lftDGfyLoNSGU/jbvH1XYk
	A58UldZayN9QYBpRK+E1Zgr/lDncQwEa8Fmj83WjY3yU6YuBGkJ1vI9Y6jRwskMr
	zJmuGHRyRKI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A59A94A50;
	Fri,  6 Nov 2009 04:44:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3A90194A4F; Fri,  6 Nov 2009
 04:44:55 -0500 (EST)
In-Reply-To: <20091106073707.GA14881@glandium.org> (Mike Hommey's message of
 "Fri\, 6 Nov 2009 08\:37\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C772D4A-CAB9-11DE-A58B-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132291>

Mike Hommey <mh@glandium.org> writes:

> The typical use of both at the same time is to put an authenticated
> value for pushurl (ssh://, for example) and an anonymous one (git://,
> for example) for url.
>
> What has been annoying me lately is that git push --dry-run asks me
> for the ssh key or password. I know I could be using an ssh-agent, but
> that's not the point.

I actually sense a possible XY problem here.

What are you trying to achieve with "git push --dry-run", especially when
you would instead be doing an equivalent of "git fetch" (or "ls-remote")
but not storing what you learned from that session with a change like what
you are imagining?

The answer to the above question is the real reason "X".

It could be that what you are interested in is if you are ahead of the
other side.  In other words, you would want to know if some branches
result in non-fast-forward error, causing you to re-fetch and re-merge (or
rebase).

And "push --dry-run" that fails would give you that information, if it
worked for you without authenticating.  And that could be your "Y".

But doesn't "branch -v" give the necessary information for that purpose
and even a bit more?  Couldn't "git fetch && git branch -v" be a better
solution for your real problem "X"?

It is a better solution _if_ the real problem you are trying to solve is
what I suspected above because:

 (1) If you will end up fetching to make you ahead of them again, doing
     "push --dry-run" to learn fast-forwardness first would still require
     you to fetch from there anyway.  With "git fetch && git branch -v",
     you have already fetched when you learned that you are not ahead;

 (2) When you learn from "git fetch && git branch -v" that you were indeed
     ahead, you can push.  In such a case, because you were ahead, the
     fetch wouldn't have slurped a lot of data from the other end anyway,
     so there is no real overhead for doing so.

 (3) In either case, "branch -v" output would give you not just "is it
     fast-forward?" but also "if not, by how much they have diverged" (in
     addition to the commit message for the tip).

But this may not be an XY problem.  I am just curious.
