From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Fri, 12 Apr 2013 15:28:30 -0700
Message-ID: <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 00:28:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQmSY-00068r-5S
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 00:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab3DLW2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 18:28:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab3DLW2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 18:28:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B301716709;
	Fri, 12 Apr 2013 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kNUvfbIsoDx+9m+XOTXZ2NKcDmo=; b=JoTL3h
	THBZ33hu/mtONSc/+XSD0xSG41nw4cjK6QjmxhFFm+klsHSRkeQE8yYMPHqjzVF9
	0tT1+f2SvIAtBxrwWaQINv3TSI6TVwAUrH57GtePpWnmDMGOgCstxY/bIxtvbZVx
	nteCPk38VmzI4qwS/9IGq2GKYuK8Gdb7cFTQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0JqB+Fvlq2+y8aQ16OhNPTOkwYCMVgO
	GPbciBs9s2ktUYAJhcHgSpwZ+GJWR621gEskl57HKXXiM8wz83+X+R1sas7OvVyj
	YWTpYuSDaxgpJREc3hqrMPthbM7aJg5dN7nwyPROVR4/ntsbbUX/1pyNR7GqGUhn
	sviJJjC2htE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8A6316708;
	Fri, 12 Apr 2013 22:28:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1325A16705; Fri, 12 Apr
 2013 22:28:31 +0000 (UTC)
In-Reply-To: <1365780835-2853-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 12 Apr 2013 21:03:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E84E338-A3C0-11E2-9A1D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221033>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, there is no way to invoke 'git push' without explicitly
> specifying the destination to push to as the first argument.  When
> pushing several branches, this information is often available in
> branch.<name>.pushremote, falling back to branch.<name>.remote.  So,
> we can use this information to create a more pleasant push experience.
> You can now do:
>
>     $ git push master next pu
>
> If the branches master, next, and pu have different remotes, do_push()
> will be executed three times on the three different remotes.

I am lukewarm on this one, slightly more close to negative than
positive, for a couple of reasons.

The primary reason is the confusion factor Jeff mentioned in the
thread that inspired this patch.  People would realize it is very
natural to decide where to push to based on what branch is being
pushed, but only after they think it long and hard enough [*1*].  I
suspect that it is an equally natural expectation for casual users
that the destination is chosen based on the current branch, if only
because that is what they are used to seeing when they say "git
push" without any argument.

Even though I personally am in favor of this "destination is tied to
what is pushed out", not "destination is chosen based on the current
branch", I can understand why some people would prefer the latter,
and why they find it simpler and easier to explain.

The second reason is purely on the differences between what the
above clean-nice explanation says and what the patch actually does.

I think "is-possible-refspec" and "pushremote-get-for-refspec" are
both way over-engineered, even for people who agree with me and the
above introduction for this change to favor "destination depends on
what branch is pushed out".  If is-possible-refspec is replaced with
a much simpler to understand logic, "Is this a local branch name?",
possibly combined with "There is no such path on the filesystem" and
"It's not a defined remote" (iow, reject "git push master:next" and
anything more complex) [*2*], I suspect it would be a bit more
sellable.


[Footnote]

*1* I've explained in a separate message why basing the destination
on what is being pushed is logical and internally consistent.

*2* This is in the same spirit (not implementation or design) as
revname vs pathspec disambiguation.
