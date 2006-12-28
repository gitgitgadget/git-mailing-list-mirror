From: Junio C Hamano <junkio@cox.net>
Subject: Re: branch.pu.forcefetch
Date: Thu, 28 Dec 2006 14:44:54 -0800
Message-ID: <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net>
References: <1167251519.2247.10.camel@dv>
	<7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
	<1167341346.12660.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 28 23:45:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H03zh-00022p-UM
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 23:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWL1Wo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 17:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWL1Wo4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 17:44:56 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:59245 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965027AbWL1Wo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 17:44:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228224455.KQEO20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 17:44:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4Nl81W00S1kojtg0000000; Thu, 28 Dec 2006 17:45:09 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1167341346.12660.17.camel@dv> (Pavel Roskin's message of "Thu,
	28 Dec 2006 16:29:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35564>

[jc: some people CC'ed because I'll talk about logallrefupdates
 at the end]

Pavel Roskin <proski@gnu.org> writes:

> Actually, it's strange that I don't actually have refs/heads/pu
> under .git, and it doesn't get created even if I run "git-pull" or
> "git-pull origin pu".

"git-pull" without argument (and "git-pull origin") are affected
by the config (and .git/remotes/origin), so we will look at your
config later.

With "git-pull origin pu", you are saying "use URL for origin
but this time I am not interested in the set of branches to
fetch by default specified in my config".  And single token "pu"
means you do not want to store the fetch result in any tracking
branch (otherwise you would explicitly say "pu:refs/heads/pu" or
"pu:/refs/remotes/origin/pu").

> We have a line that says: "pull from pu branch of origin and merge it
> into local pu branch even if fast-forward is impossible".

Are you talking about "remote.origin.fetch = +pu:refs/heads/pu"?

If so, the line does _not_ say that.  It does not talk about
pulling nor merging.  What it says is "My refs/heads/pu is used
as a tracking branch for keeping track of the progress of his
'pu'; because I know he rewinds and rebases, please override the
fast-forward check when you store the updated value of his 'pu'
to my 'refs/heads/pu'".

> However,
> there it no local pu branch.  Yet not having this line blocks updating
> of master branch.

Now that is worrisome.  "git pull"  and "git pull origin" (but
not "git pull pu" for the reason I mentioned earlier) should
create your "pu" branch if you have the configuration.

Let me understand the situation.  Your config file is:

> My .git/config file is:
>
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         logallrefupdates = true
> [remote "origin"]
>         url = git://www.kernel.org/pub/scm/git/git.git
>         fetch = refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master

So you may not have refs/heads/pu (iow, you do not build on top
of my 'pu'), but the config says refs/remotes/origin/ is used to
track all my branches.  Do you have refs/remotes/origin/pu?

If so, then "git fetch" would error out exactly because 'pu'
would not fast forward and the config says it does not allow
non-fast-forward fetch.

It might make sense to make the default configuration git
clone creates to say

        [remote "origin"]
                url = git://www.kernel.org/pub/scm/git/git.git
                fetch = +refs/heads/*:refs/remotes/origin/*

instead.

I think I suggested this once but vaguely recall some people
objected, for the reason that an unusual situation such as
non-fast-forward should always error out for safety and should
require an explicit override by the user.

But come to think of it, I think failing to update the remote
tracking branch for non-fast-forward does not buy us very much.
Letting the user to be aware of the situation has value, but at
that point, I do not think there is much else the user can do.
The purpose of the tracking branches is to track what happens on
the remote side, and the user is in no position to override what
has already happend on the remote side (otherwise it stops being
"tracking branches").  If reflogs are enabled on remote tracking
braches, you can always get back the older state if you wanted
to.

That makes me notice another thing.  We do not seem to create
reflog for remotes/ hierarchy even when logallrefupdates is set
to true.  Would people object if we did this?

diff --git a/refs.c b/refs.c
index 8b2a3c1..e88ed8b 100644
--- a/refs.c
+++ b/refs.c
@@ -925,7 +925,8 @@ static int log_ref_write(struct ref_lock *lock,
 	const char *committer;
 
 	if (log_all_ref_updates &&
-	    !strncmp(lock->ref_name, "refs/heads/", 11)) {
+	    (!strncmp(lock->ref_name, "refs/heads/", 11) ||
+	     !strncmp(lock->ref_name, "refs/remotes/", 13))) {
 		if (safe_create_leading_directories(lock->log_file) < 0)
 			return error("unable to create directory for %s",
 				lock->log_file);
