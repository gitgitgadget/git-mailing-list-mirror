From: Junio C Hamano <gitster@pobox.com>
Subject: Re: request for documentation about branch surgery
Date: Mon, 06 Jul 2009 19:50:06 -0700
Message-ID: <7vab3hb40x.fsf@alter.siamese.dyndns.org>
References: <200907070105.12821.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 04:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO0lV-0002fz-M4
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 04:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbZGGCuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 22:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbZGGCuJ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 22:50:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbZGGCuI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 22:50:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 51BFD2533C;
	Mon,  6 Jul 2009 22:50:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 74B812533A; Mon, 
 6 Jul 2009 22:50:08 -0400 (EDT)
In-Reply-To: <200907070105.12821.bruno@clisp.org> (Bruno Haible's message of
 "Tue\, 7 Jul 2009 01\:05\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E39472A2-6AA0-11DE-A3E1-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122819>

Bruno Haible <bruno@clisp.org> writes:

> 1) After the section "Rewriting a single commit", it may be useful to
> have a section "Inserting one or more new commits". This is something that
> cannot be done with the "detached head" technique.

You learn new things every day, and today is such a day ;-)

>   If you want to add a commit in the middle of a branch:
>
>             A---C---...---Z    master
>
>   =>
>
>             A---B---C---...---Z    master
>
>   it is achieved by

        $ git checkout master~25 ;# detach HEAD at A
        $ edit edit edit
        $ git commit ;# creates B

which makes

               B              HEAD (detached)
              /
             A---C---...---Z    master

and then

        $ git rebase HEAD master

which reshapes the history into


               B---C'--...---Z' master
              /
             A---C---...---Z    master@{1}

and you are done.

> 3) When do I need "git merge", and when do I need "git rebase", in the
>    context of branch surgery?
>
>    The simple answer, that I would find worth mentioning, is:
>      - "git merge" copies commits from one branch to another.
>      - "git rebase" only moves commits around to make history more linear.

If you think "git merge" _copies_, you will never understand what "merge"
does.

If you have master and origin branch, merging them together

                X---Y---Z  origin
               /
              /
             O----A----B master

        $ git checkout master
        $ git merge origin

will give you this:


                X---Y---Z  origin
               /         \
              /           \
             O----A----B---M master
                       ^
                       master@{1}

There is no copying involved anywhere .  It only creates a new commit, M,
and that commit allows 'master' (that used to point at B) to reach both
the history leading to B and the history leading to Z.

On the other hand, rebase _copies_.  It _does_ make new commits A' and B',
whose _effect_ to the tree mimics those of A and B.

        $ git rebase origin master


                X---Y---Z---A'---B' master
               /        ^origin
              /
             O----A----B master@{1}

> 4) It would be good to have a section "Cutting branches"
>
>    How do I remove the N most recent commits from a branch?
>
>                D---E---F---G---H---.........---Y---Z master
>
>   =>
>                D---E master

And it is not even cutting.  It merely makes this:

                      F---G---H---.........---Y---Z master@{1}
                     /
                D---E
                    ^master

so that a new history can grow at E that is parallel to the
history that leads to Z.

I think your confusion is primarily coming from not understanding what a
branch in git is.  A branch in git does not have its own identity per-se,
and a commit does _not_ belong to a branch, in the sense that a commit
object does not record anywhere on which branch it was created on.  A
branch is just a pointer into a dag and the pointer can be moved.
