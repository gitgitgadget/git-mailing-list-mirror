From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to rebase backwards
Date: Mon, 02 Nov 2009 23:43:07 -0800
Message-ID: <7vocnkt5o4.fsf@alter.siamese.dyndns.org>
References: <20091103054510.GB7117@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5E31-0002sL-Lb
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbZKCHnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 02:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755644AbZKCHnL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:43:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbZKCHnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 02:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2998A715B8;
	Tue,  3 Nov 2009 02:43:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tu2thE5AC0fQJnFC7sNIPrO1H0A=; b=vWuyQ9
	N6C8+mR/Z3xCRFce3usMobiOZqcmfIQK2hApj9YV1yFU+pXtZfu3D9yPnWT0Y0Lf
	M8JhP4fg7nZTOT/WhliptqVnYvsVj6FmgPsS7Y/0BlnqUbR7Pm7CkqFRoqXPOju7
	dmhi9a9cyuadRyWZfjJ6FLsOjDY0zit7nJk7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o36LOE1+Nfvj6WeCgLR7Vmbihxss2aWf
	s6gM5WcVov5pU6gp1M3kOotnRIIWzBcip+EPVrsJ8umnsjNBaKsm2RInujAcSafZ
	QpofYUa2aw3iu86KoV2BylSHj0aXpJu4jD8GOyxAA2agBkENCaMuIoJh+8FmfkV7
	b/uxaf51uf4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07368715B7;
	Tue,  3 Nov 2009 02:43:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F624715B6; Tue,  3 Nov
 2009 02:43:09 -0500 (EST)
In-Reply-To: <20091103054510.GB7117@debian.b2j> (bill lam's message of "Tue\,
 3 Nov 2009 13\:45\:10 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89A4712A-C84C-11DE-A0DA-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131952>

bill lam <cbill.lam@gmail.com> writes:

> I want to rebase a new branch onto an earlier commit 
>
> original:  
> E is a newly created branch from D and not yet modified
>
>                     E
>                    /
> -- A -- B -- C -- D

I sense a grave misconception here.  If you have "not yet modified"
anything at all since D, then E does *not* even exist.

Remember, a branch is just a pointer pointing at a commit.  You can have
more than one such pointers pointing at the same commit.  So, if you have
been working on 'master' branch, building up to D, your history would look
like this:

    ---A---B---C---D
                   ^ master

And you would "create a branch", say "hack", like this:

    $ git checkout -b hack

What happens to your history when you do so is this:

                   v hack
    ---A---B---C---D
                   ^ master

The same commit "D", pointed by two branches, 'master' and 'hack'.

If you start editing files at this point, before making a commit, nothing
in the history changes.  But once you make a commit E while on branch
'hack' (since you ran "git checkout -b hack" above), the history changes
into this:

                     E
                    /^ hack
    ---A---B---C---D
                   ^ master

> new: what I wanted
>
>      B'-- C' -- E     for deployment
>     /          
> -- A -- B -- C -- D    trunk
>
> so that I can continue to change all commits from B to C without
> affecting E
>
> I try (not sure if correct) doing it by
>   git rebase --onto A B E

This asks to replay C, D and E in this order on top of A, to create

      C'--D'--E'
     /
 -- A

which is different from what you described earlier.

Assuming that you did actually commit to create E, after branching 'hack'
off of 'master', i.e. your history looks like this:

                     E
                    /^ hack
    ---A---B---C---D
                   ^ master

the way to create what you want would actually be

    $ git checkout -b deploy master^ ;# branch deploy at "C"
    $ git cherry-pick hack           ;# replay E on top of it

which would make a history of this shape.

                 v deploy
                 E'  E
                /   /^ hack
    ---A---B---C---D
                   ^ master

If you need to later tweak B and C (only) for deployment branch, you could
further rewrite B and/or C with

    $ git rebase -i A

to rewrite everything since A leading to the tip of your current branch
(i.e. E'), to result in

                   v deploy
           B'--C'--E"
          /
         /       E'  E
        /       /   /^ hack
    ---A---B---C---D
                   ^ master

Now, you may not want to keep both 'hack' and 'deploy'.  Perhaps you
forked 'deploy' and modified for E but it was done on top of D that you
did not want to include in 'deploy' by mistake.  IOW, you might have done
this:

                     E
                    /^ deploy
    ---A---B---C---D
                   ^ master

Another way to make 'deploy' point at the result of replaying E on top of
C when your history looks like this is (assuming you are on 'deploy'):

    $ git reset --hard HEAD^^ ;# reset to "C"
    $ git cherry-pick @{1}    ;# cherry-pick "E"

That would give you a history of this shape:

                 v deploy
                 E'  E
                /   /
    ---A---B---C---D
                   ^ master

Note that the original commit "E" becomes dangling and it will eventually
be garbage-collected.
