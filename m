From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Mon, 08 Aug 2005 13:47:09 -0700
Message-ID: <7vd5oo40mq.fsf@assigned-by-dhcp.cox.net>
References: <20050808.103304.55507512.davem@davemloft.net>
	<Pine.LNX.4.58.0508081131540.3258@g5.osdl.org>
	<20050808160846.GA7710@kroah.com>
	<20050808.123209.59463259.davem@davemloft.net>
	<20050808194249.GA6729@kroah.com>
	<Pine.LNX.4.58.0508081249110.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 22:47:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2EWi-00072W-BK
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 22:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVHHUrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 16:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVHHUrN
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 16:47:13 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20625 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932217AbVHHUrN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 16:47:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808204710.BXMX15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 16:47:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508081257190.3258@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 8 Aug 2005 12:57:44 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

>> It may not have the nicest error messages: if you try to revert a merge
>> (which won't have a diff), git-apply will say something like
>> 
>> 	fatal: No changes
>> 
>> which isn't exactly being helpful. And the revert message could be made 
>> more interesting (like putting the first line of the description of what 
>> we reverted into the message instead of just the revision number).

> Comments?
>
> 		Linus

I like the general idea, and if we had a commit pretty format
"oneline", then something like this would make it look nicer.

Totally untested.  I acquired your habit of coding in my e-mail
client ;-).

        #!/bin/sh
        . git-sh-setup-script || die "Not a git archive"

        rev=$(git-rev-parse --verify --revs-only "$@") &&
        commit=$(git-rev-parse --verify --revs-only "$commit^0") || exit
        if git-diff-tree -R -p $commit | git-apply --index &&
           msg=$(git-rev-list --pretty=oneline --max-count=1 $commit)
        then
                {
                        echo "Revert $msg"
                        echo
                        echo "This reverts $commit commit."
                        test "$rev" = "$commit" ||
                        echo "(original 'git revert' arguments: $@)"
                } | git commit
        else
                # Now why did it fail?
                parents=`git-cat-file commit "$commit" 2>/dev/null |
                        sed -ne '/^$/q;/^parent /p' |
                        wc -l`
                case $parents in
                0) die "Cannot revert the root commit nor non commit-ish" ;;
                1) die "The patch does not apply" ;;
                *) die "Cannot revert a merge commit" ;;
                esac
        fi
