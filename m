From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Sun, 09 Jun 2013 15:51:11 -0700
Message-ID: <7vip1moq3k.fsf@alter.siamese.dyndns.org>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
	<1370798000-2358-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 00:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UloSL-00068p-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab3FIWvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 18:51:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938Ab3FIWvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 18:51:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9296326061;
	Sun,  9 Jun 2013 22:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Bce2gt4ZQ1IeawPz/LF138JyjI=; b=a7QNYM
	DtL00MTqhjHqYMlGLwkjsglbrhYc+PtkcLvIOEDyaCMN5Ir9rwNW2ogqjsw01pGr
	nIGZRDwOWdoN3boWYd1pEZ5PMVbQpn3CX8BFA4UIwFe8oV2dblBfHfEmgPbs+uRZ
	KL+PkP3ttFH4SCo+WsR1/86x8ww9+Y5MMyZVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BAzFtlZ+O735QBq4vA6ASTaUp3HjoVSp
	rGuc3i9+ghJtUCek6BaT9R9QpMy6zZDZoAU1oVPlOpFhMERR4f9PPiceB6rVZvVF
	SnWOEfZK4D5AyDMOlnfgjqCBKQ+6zvLYcRMqskL96C45GcZGu4eiCbXJYeBHTW7v
	nOSEibxSNXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 868EA26060;
	Sun,  9 Jun 2013 22:51:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D36DC2605F;
	Sun,  9 Jun 2013 22:51:12 +0000 (UTC)
In-Reply-To: <1370798000-2358-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 9 Jun 2013 22:43:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1591755E-D157-11E2-98F2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227204>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> rr/triangle (4d35924, 2013-04-07) introduced support for triangular
> workflows, but did not think through the effect of the new configuration
> variables in the upstream and simple modes.  When remote.pushdefault or
> branch.<name>.pushremote is set, and push.default is set to upstream or
> simple, this happens (master@{u} != origin):
>
>   $ git push
>   fatal: You are pushing to remote 'origin', which is not the upstream of
>   your current branch 'master', without telling me what to push
>   to update which remote branch.
>
> The configuration variables work as expected with push.default = current
> and matching, which makes the above unexpected and counter-intuitive.
> It happens because upstream and simple were designed with central
> workflows in mind.  Even when these configuration variables are not set,
>
>   $ git push origin
>   fatal: You are pushing to remote 'origin', which is not the upstream of
>   your current branch 'master', without telling me what to push
>   to update which remote branch.

I am not sure what you mean by artificial.

If you have push.default set upstream or simple, then a push run
while on the branch 'foo' will figure out what happens when you do a
fetch by looking at 'branch.foo.merge' to find the branch we are set
to integrate from 'branch.foo.remote' remote.  The simple further
says that branch name must be the same as 'foo'.

And that is what setup_push_UPSTREAM() is designed to do.  Rejecting
a call that breaks the precondition is perfectly the right thing to
do: if you set to push to "upstream" and if you are trying to push
to a different remote, for example.

The triangle topic changed the precondition without updating the
logic to check it, which was the bug, not the original check.

Also, it is still unclear to me why push.default = upstream in a
triangular setting should compute that the current branch 'foo' is
set to integrate with 'master' from the remote 'origin' and assume
that updating branch 'master' in a different repository, which may
or may not have anything to do with 'master' at 'origin', is a sane
thing to do.

We do not have the branch.$name.push yet and if we did, that would
be the value to be used.  So I agree that we need to default to
something, but I do not think this patch has justified that updating
'master' (i.e. branch.foo.merge) in a repository that is totally
unrelated to the branch branch.foo.merge's name was taken from is a
better default than updating 'foo' itself.  Both look like a random
choice at least to me.

I actually am OK with 'upstream' that rejects triangular, while
making 'simple' do something different [*1*].

"push.default = upstream" is to "push back to where I fetch and
integrate with", which by definition makes no sense in triangular
workflow.  But 'simple' will be the new default and it does not say
anything about "what I fetch and integrate with" at all, so we can
choose a sensible default when branch.$name.push does not say what
to update.


[Footnote]

*1* I offhand do not know what that "something else" is, but it
would probably be closer to 'current'.  In an extreme case, consider
that there may no branch.$name.remote or branch.$name.merge at all
(the user is the top-level integrator).

Removing the "remote name must match when using 'upstream'" check in
the setup_push_upstream() is not sufficient if we want to allow the
remote.pushdefault for such a user with push.default = simple mode,
because presense of branch.$name.remote and branch.$name.merge is
checked very early in the function, and lack of them will error out.
