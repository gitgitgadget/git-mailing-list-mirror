X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Stupid Git question
Date: Wed, 22 Nov 2006 14:43:05 -0800
Message-ID: <7vac2jp0g6.fsf@assigned-by-dhcp.cox.net>
References: <89b129c60611211331r3bb286b6re3c2c8f65ec3896f@mail.gmail.com>
	<89b129c60611211341j71079633g53b0ec1d2e3193a5@mail.gmail.com>
	<ejvs65$vo8$1@sea.gmane.org>
	<89b129c60611220628l59e305b8h4d2196f7cf6498d4@mail.gmail.com>
	<871wnvxwg4.wl%cworth@cworth.org>
	<89b129c60611221328l333d22c6o3668aef2706f92c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 22:43:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32108>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn0oB-0003tu-Pb for gcvg-git@gmane.org; Wed, 22 Nov
 2006 23:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757066AbWKVWnI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 17:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757087AbWKVWnI
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 17:43:08 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45014 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1757066AbWKVWnH
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 17:43:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122224306.FPYF20330.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 22
 Nov 2006 17:43:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id pyic1V00J1kojtg0000000; Wed, 22 Nov 2006
 17:42:36 -0500
To: "Sean Kelley" <sean.v.kelley@gmail.com>
Sender: git-owner@vger.kernel.org

"Sean Kelley" <sean.v.kelley@gmail.com> writes:

> One other question - how do you rename a branch on the remote
> repository once you have created it?

Right now, there is no way to remove a ref, so even "create new
and then remove" would not work.  You need a way to ssh-in to
the machine and run "branch -d" there.

You would need an access to run git tools on the remote site
for:

 - repository creation and deletion
 - ref deletion
 - fsck, pruning and repacking
 - adding entries to objects/info/alternates
 - managing hook scripts

with the current set of tools, which pretty much means an
account with a full shell access over SSH.

Earlier in another thread, Linus said that it is justifiable to
treat repository creation as a special event and outside of
git.  For one thing you need to have the account on the site and
arrange access permissions and authentication before you can
create a repository, so it is an understandable position to
take, and for people with full SSH access it is a minor nuisance
that they have to first go there to perform the above operations
instead of running "git-do-things-at-remote host:path" locally.

However, for sites that want to restrict the access via
git-shell, after a repository owner secured such an account and
access rights, not being able to allow the user to do some of
the above things himself is a burden on site administrators.
This _could_ be improved by allowing some common operations via
git-shell.

Even under git-shell, the process'es user and group
credentials are the primary means to control the access
rights.  So in that sense, letting the user to say things
like the following might make sense:

   $ REPO=repo.example.com:/pub/scm/git/project.git
   $ git remote-admin $REPO create-repository
   $ git remote-admin $REPO delete-repository
   $ git remote-admin $REPO repack
   $ git remote-admin $REPO fsck-objects
   $ git remote-admin $REPO count-objects

And for the sake of both simplicity (which would lead to
security) and to allow the site administrator to make policy
decision, I think we do not have to (and we shouldn't) make the
above commands to take any flags.  The command's availability
and what parameters to be passed to underlying commands such as
git-repack are determined by the site administrator.  For
example, an administrator may give a restricted account to a
user _and_ set up one repository for him but may not want to
give him rights to create another repository nor delete that
initial repository given to him, in which case create-repository
and delete-repository actions would be disabled.

I have a feeling that the users should not be given full control
over 'hook' scripts, but I am not sure.  A site administator
might want to forbid too expensive hooks from running, even the
process spawned by the user would work only in directories that
the user has access to.  If we give the users a full control,
then:

   $ git remote-admin $REPO get-hook $hookname >old-contents
   $ git remote-admin $REPO put-hook $hookname <new-contents
   $ git remote-admin $REPO remove-hook $hookname

would be the set of commands we could use (I am assuming
put-hook installs the hook in "enabled" state, and get-hook
would give a failure for nonexistent or disabled hooks).

The most straightforward extension of the above for ref deletion
is to say:

   $ git remote-admin $REPO delete-refs refs/heads/foo refs/tags/v1.0

and that would be the simplest way to implement it if we were to
go with "git remote-admin".  However, I think people would find
it more natural if manipulation of refs were part of "git push".

"git push $REPO $src:$dst" means "take what I have in $src in my
local repository, and update the $REPO's $dst ref with that".
So as a natural extension of that, we could make:

   $ git push $REPO '':$dst

to mean "store nothingness in $dst" and make that a way to
express the desire to remove $dst ref.

