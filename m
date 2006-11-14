X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 14:13:44 -0800
Message-ID: <7vy7qdy8vb.fsf@assigned-by-dhcp.cox.net>
References: <20061114134958.5326.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 22:13:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31385>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk6XN-0003dK-Ne for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966413AbWKNWNr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966262AbWKNWNq
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:13:46 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24727 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S966413AbWKNWNp
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:13:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114221345.UHES18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 17:13:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mmDr1V00H1kojtg0000000; Tue, 14 Nov 2006
 17:13:51 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

> One thing I noticed is that with ref logs, you've just re-invented the
> CVS problem of associating history with a name.  If you want to rename
> a branch (say, from "mischacks" to something suitable for publication),
> do you rename the log or not?  It's a less virulent form, but it seems
> like the same disease.

I do not think we currently rename the log but it is probably a
bug.  Renaming tag should also be made easier.

> Another minor quibble: AFAICT, "git checkout -f -m" is meaningless (-f
> overrides -m), but doesn't complain.

It should be made to complain.

> An example of when you'd want to do this is performing a "git bisect"
> with a local "#define DEBUG 1" change.  Particularly if you
> hit a non-compiling version and need to back up.
> or the way git-bisect does it
>   
>         echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
>         git checkout new-bisect || exit
>         mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
>         GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD refs/heads/bisect

The name new-bisect is really temporary the code just shows it
punts on a situation it does not expect (it essentially expects
a clean tree and working with a local change is by accident) and
being ony half helpful to the user while recovering from that
unexpected situation.  In other words, that's a room for
improvement.  We should be rewrite the above with something like
what we have in the else clause in git-checkout around line 150.
It might make sense to make it a shell function and sharable
between checkout and bisect (perhaps there are other uses).
Then we do not need the temporary branch.

> Either way, it reserves a second branch name, and seems like a bit of
> a hack.

You are correct to call it a hack.  git-bisect started as a
technology demonstration of the underlying rev-list --bisect
feature.  The thing is that the technology was so nice and
useful that we started using it before cleaning up these
implementation details.  I think instead of documenting the duct
tape that holds git-bisect together ("rev-list --bisect" is
great, and what "git-bisect" does is basically great but with
minor glitches like you noticed and with hacky implementation
details; I am calling the latter "duct tape"), we should redo
the hackish part.

Enough with bisect.  And jumping the head while forward/back
porting the local change would also involve the same kind of
change, so "git reset --merge-local-change" might be a good
addition, but I am not sure about the details yet.
