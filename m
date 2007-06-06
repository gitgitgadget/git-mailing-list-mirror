From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Thu, 7 Jun 2007 00:48:41 +0200
Message-ID: <20070606224841.GA3969@steel.home>
References: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com> <81b0412b0706060852y4ab6b794m5fed0484c63159e4@mail.gmail.com> <7vfy543kzn.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw4JC-0001s1-B3
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935293AbXFFWsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763548AbXFFWsp
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:48:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:33274 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935293AbXFFWso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:48:44 -0400
Received: from tigra.home (Fa87f.f.strato-dslnet.de [195.4.168.127])
	by post.webmailer.de (mrclete mo34) (RZmta 7.2)
	with ESMTP id D052cdj56IfXpz ; Thu, 7 Jun 2007 00:48:42 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B90B8277BD;
	Thu,  7 Jun 2007 00:48:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4CA27BEA7; Thu,  7 Jun 2007 00:48:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfy543kzn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49330>

Junio C Hamano, Wed, Jun 06, 2007 22:07:24 +0200:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > Otherwise ".git" is removed from every remote path which has it,
> > including "/some/path/somename.git".
> 
> I was very tempted to apply this patch, but after re-reading it
> once more, I decided to drop it.
> 
> I do not mind keeping the extra .git/ suffix in the -v output in
> your example, as the message is just "verbose information":
> 
>   $ git fetch -v
>     * refs/heads/origin: same as branch 'master' of /home/user/linux
>       commit: 5ecd310
> 
> But the same output is used by log messages for the merge
> commits; indeed, the primary purpose of this output is to
> prepare messages for merge commits.

BTW, this is hard to believe. Were does git-merge call fetch--tool?
Nor have I found its use for logging purposes. Or, if you refer to the
logs a user can create by redirecting output of git fetch someplace,
than it is highly suspicious for tham to contain something short,
sweet and not existing.

> From the beginning we deliberately omitted .git suffix to keep the
> resulting log message short and sweet.  Keeping .git suffix goes
> against it.

But this is how the repo is actually named! If you want to keep the
_message_ short and sweet than cut the suffix in the message
generation code.

> A repository "git://$site/repo.git" can be accessed with
> "git://$site/repo".  Repository owners _can_ confuse their users
> by having both repo and repo.git, but I honestly do not see a
> reason to encourage that.

People will never know whether they are encouraged or discouraged.
They just wont notice it is _wrong_ until they copy-paste the path
from git-fetch output and do something nasty to it.

> Earlier you mentioned you know of a case where "$URL/repo.git"
> exists and "$URL/repo" does not, and the current clone fails to
> set up the target repository after cloning from "$URL/repo"
> correctly?  I admit I haven't reproduced nor debugged it, but if
> that is the case that needs to be fixed.

    mkdir a.git && cd a.git && git init && :>file && \
    git add . && git commit -m1 && mv .git/* . && rmdir .git && \
    cd .. && git clone -l -s a b && cd b && git fetch

The cloned repo "b" gets "a" verbatim, instead of something more
useful (like "../../a.git" or "/full/path/a.git". It is not even
"/full/path/a").

git clone works correctly (origin's url is an absolute path) if a.git
is given:

    mkdir a.git && cd a.git && git init && :>file && \
    git add . && git commit -m1 && mv .git/* . && rmdir .git && \
    cd .. && git clone -l -s a.git b && cd b && git fetch

Fix, needed because of all this "detachable suffix" confusion:

diff --git a/git-clone.sh b/git-clone.sh
index fdd354f..d45618d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -20,7 +20,7 @@ usage() {
 get_repo_base() {
 	(
 		cd "`/bin/pwd`" &&
-		cd "$1" &&
+		cd "$1" || cd "$1.git" &&
 		{
 			cd .git
 			pwd
