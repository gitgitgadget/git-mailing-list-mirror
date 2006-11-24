X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 03:24:20 -0800
Message-ID: <7vslg9axzv.fsf@assigned-by-dhcp.cox.net>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
	<20061123234203.GN7201@pasky.or.cz>
	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>
	<7vzmahe6qe.fsf@assigned-by-dhcp.cox.net>
	<7vpsbde4fy.fsf@assigned-by-dhcp.cox.net> <ek6glc$pn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 11:24:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ek6glc$pn$1@sea.gmane.org> (Salikh Zakirov's message of "Fri, 24
	Nov 2006 13:14:00 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32208>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnZAP-000710-M6 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 12:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757694AbWKXLYW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 06:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757695AbWKXLYW
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 06:24:22 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46061 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1757693AbWKXLYW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 06:24:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124112421.MZOM20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 06:24:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qbQV1V00B1kojtg0000000; Fri, 24 Nov 2006
 06:24:29 -0500
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Sender: git-owner@vger.kernel.org

Salikh Zakirov <Salikh.Zakirov@Intel.com> writes:

> git-push.1 has following description:
>
>     Some short-cut notations are also supported.
>
>               o   tag <tag> means the same as refs/tags/<tag>:refs/tags/<tag>.
>
>               o  A parameter <ref> without a colon is equivalent to
>                  <ref>:<ref>, hence updates <ref>  in
>                  the destination from <ref> in the source.
>
> Maybe this is only my reading of manual page, but I understood
> it like it does not leave the room for ambiguity, because it is using
> _the same_ refspec as the local one.

If you write

	git push $remote tag $string

it is handled exactly as if you wrote:

	git push $remote refs/tags/${string}:refs/tags/${string}

and if you write

	git push $remote master

it is handled exactly as if you wrote:

	git push $remote master:master

The manual correctly describes the above, but the issue the fix
addresses is about what happens to that 'master' string that
follows the colon, and the 'master' string becomes ambiguous if
the remote end uses separate-remote layout.

The way this command:

	git push $remote $src:$dst

is handled is:

 (0) send-pack gets ls-remote equivalent from the remote.  This
     tells us the set of refs the remote has and the value of
     each of them.

 (1) $src can be a ref that is resolved locally the usual way.
     You could have any valid SHA-1 expression (e.g. HEAD~6).

 (2) $dst is compared with the list of refs that the remote
     has, and unique match is found.  So if the set of refs the
     remote side has:

	refs/heads/origin
        refs/heads/master
        refs/tags/v1.0.0

     and if $dst is 'master', refs/heads/master is what will be
     updated.

 (3) Then send-pack generates and sends the necessary pack to
     update the remote side with objects needed for $src, using
     the knowledge of what the remote has.  Also, send-pack
     instructs the remote to update which ref with what value.
     Continuing with the example, it tells the remote to update
     its refs/heads/master with the value of our 'master'.

That *matching* in step (2) is what the fix is about.

The matching code of send-pack from the beginning has been the
unique tail-match.  When the other end had a branch 'bugfix' and
a tag 'bugfix', then both of them would match because both
refs/heads/bugfix and refs/tags/bugfix ends with 'bugfix'
('gfix' does not match 'refs/heads/bugfix' -- we are not that
stupid ;-).

So you had to disambiguate this case by saying heads/bugfix if
you want to push the branch.  That was fine between branches and
tags, since having a branch and a tag with the same name is
usually not done in order to keep user's sanity.

However, separate-remote layout poses a more serious problem,
because most of the time you would expect to see similar names
under refs/heads/ and refs/remotes/origin/ directories.  If we
kept the original ref matching code, a cloned remote would have
both refs/heads/master and refs/remotes/origin/master almost
always, so somebody who is pushing 'master' to such a remote
would have had to disambiguate it by saying:

	git push heads/master

which is (as described in the part of the manual you quoted) a
shorthand for

	git push heads/master:heads/master

'heads/master' before the colon is used to find out which commit
in your local repository we are pushing, and 'heads/master'
after the colon is used to match against the list of refs from
the remote (which contains both 'refs/heads/master' and
'refs/remotes/origin/master'), and only because the user said
'heads/master' (not just 'master') this avoids ambiguity.

Even under separate-remote layout, we would want to be able to
say:

	git push master

to mean we want to push to remote's heads/master when the remote
has remotes/{origin,blech}/master.

And that is what the fix is about.

