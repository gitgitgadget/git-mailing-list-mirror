From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] Documentation: rework SHA1 description in git push
Date: Thu, 30 Oct 2008 22:36:11 -0700
Message-ID: <7v1vxxba2c.fsf@gitster.siamese.dyndns.org>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-4-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Fri Oct 31 06:38:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvmi1-0003eS-Bx
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 06:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbYJaFgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 01:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbYJaFgj
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 01:36:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbYJaFgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 01:36:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA3B576EC3;
	Fri, 31 Oct 2008 01:36:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8D5F176EC0; Fri, 31 Oct 2008 01:36:18 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3B22592-A70D-11DD-8BE2-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99553>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> Get rid of a double pair of parentheses. The arbitrary SHA1 is a
> special case, so it can be postponed a bit.

Hmmm...

Strictly speaking, arbitrary SHA-1 is the general case, and branch name is
a special case of it, but in practice, branch name is the most frequently
used form, and that is why it has the short-hand convention that allows it
to to be pushed to the same name.  I agree with the outcome of this patch
(except for one point I'll mention shortly) because I think it is a good
idea to talk about most frequently used form first, not because "branch"
is the general case.  IOW, the proposed commit log message is wrong.

> Also mention HEAD, which is possibly the most useful SHA1 in this
> situation.

HEAD is indeed useful, but it falls into the special case of "branch
name", not "arbitrary SHA-1 expression".  This distinction is important
because you can push "HEAD" without colon and it will act as if you said
master:master (or whatever branch you are currently on).  This is already
described in the existing doc:

    The local ref that matches <src> is used
    to fast forward the remote ref that matches <dst> (or, if no <dst> was
    specified, the same ref that <src> referred to locally).

but I agree that it is unnecessarily hard to understand, because the
document tries to describe the general case first and then relies on the
user to understand that "ref <src> referred to locally" means "branch
name".  We should make this part more explicit.

With that in mind, I have two paragraphs to replace the parts your patch
touches as a counterproposal.

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 02c7dae..fb9fb97 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -38,9 +38,7 @@ OPTIONS
>  	by the source ref, followed by a colon `:`, followed by
>  	the destination ref.
>  +
> -The <src> side represents the source branch (or arbitrary
> -"SHA1 expression", such as `master~4` (four parents before the
> -tip of `master` branch); see linkgit:git-rev-parse[1]) that you
> +The <src> side represents the source branch that you
>  want to push.  The <dst> side represents the destination location.

The <src> is often the name of the branch you would want to push, but it
can be any arbitrary "SHA-1 expression", such as `master~4` (four parents
before the tip of `master` branch -- see linkgit:git-rev-parse[1]), or
`HEAD` (the tip of the current branch).  The <dst> tells which ref on the
remote side is updated with this push.

The object referenced by <src> is used to fast forward the ref <dst> on
the remote side.  You can omit <dst> to update the same ref on the remote
side as <src> (<src> is often the name of a branch you push, and often you
push to the same branch on the remote side; `git push HEAD` is a handy way
to push only the current branch to the remote side under the same name).
If the optional leading plus `{plus}` is used, the remote ref is updated
even if it does not result in a fast forward update.

> @@ -193,6 +195,10 @@ git push origin master::
>  	with it.  If `master` did not exist remotely, it would be
>  	created.
>  
> +git push origin HEAD:master::
> +	Push the current head to the remote ref matching `master` in
> +	the `origin` repository.
> +

Additional example is good, but you would want to tell readers that this
would be useful when your current branch is _not_ 'master'.
