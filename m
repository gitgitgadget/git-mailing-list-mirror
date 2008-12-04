From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pre-rebase safety hook
Date: Thu, 04 Dec 2008 14:29:52 -0800
Message-ID: <7vd4g7d15r.fsf@gitster.siamese.dyndns.org>
References: <e1a5e9a00812040958u3af4c69ofba66567baacb79c@mail.gmail.com>
 <7vbpvrens3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Tim Harper" <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 23:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8MjA-0000vz-Cy
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 23:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbYLDWaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 17:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756307AbYLDWaA
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 17:30:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102AbYLDWaA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 17:30:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 75F5E181E3;
	Thu,  4 Dec 2008 17:29:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 10D91181E2; Thu, 
 4 Dec 2008 17:29:54 -0500 (EST)
In-Reply-To: <7vbpvrens3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Dec 2008 11:35:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1532D19C-C253-11DD-B4BF-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102372>

Junio C Hamano <gitster@pobox.com> writes:

> If you want to prevent a branch whose tip commit is on more than one
> branches from being rebased, I think something like this would suffice.
>
>     #!/bin/sh
>     LF='
>     '
>     in_branches=$(git branch -a --with "${2-HEAD}")
>     case "$in_branches" in
>     *"$LF"*)
> 	: this commit is on more than two branches
>         exit 1
>         ;;
>     esac
>     exit 0
>
> But I didn't test it.

Actually, the above cannot possibly be right.  To decide whether to allow
rebasing of a branch or not, you need to also give it from which commit
the rebase will rewrite.

For example, suppose you have a branch "topic", that was forked from
"master" and built two commits, then another branch "side" was forked from
that, and you have three more commits on "topic" since then:

               o "side"
              /  
         A---B---C---D---E "topic"
        /
    ---o---o---o---o "master"

Now, can I allow you to rebase "topic"?  It depends.  These should be
allowed:

	git rebase B "topic"
	git rebase C "topic"
	git rebase D "topic"

but rebasing "topic" on top of "master", or anything that changes the fact
that "topic" contains commits A and B, should be prohibited, because it
will interfere with "side".  For example,

	git rebase A "topic"

would make this history:

           B---o "side"
          /
         A---B'--C'--D'--E' "topic"
        /
    ---o---o---o---o "master"

where B' and B are different commits.

So you need to check all the commits that will be affected by the rebase
to see if any of them is on a branch other than the one that is being
rebased.  The set of commits that needs to be checked are:

        git rev-list "$1..${2-HEAD}"

so a naive implementation that is based on brnach --with would probably
look like:

	#!/bin/sh

	: allow rebasing a detached HEAD
	git symbolic-ref -q HEAD || exit 0

        LF='
        '
        git rev-list "$1..${2-HEAD}" |
        while read commit
        do
        	case "$(git branch -a --with $commit)" in
                *"$LF"*)
                	: this is on two or more branches
                        exit 1
                        ;;
		esac
	done
