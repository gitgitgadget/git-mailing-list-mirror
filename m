From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Question] Fetching a new branch from remote
Date: Thu, 01 Dec 2005 12:09:01 -0800
Message-ID: <7vk6eoinqa.fsf@assigned-by-dhcp.cox.net>
References: <20051128163356.GA8300@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 21:12:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehujs-000258-WA
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 21:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbVLAUJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 15:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVLAUJF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 15:09:05 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:55187 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751715AbVLAUJE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 15:09:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201200816.XKLB20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 15:08:16 -0500
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051128163356.GA8300@hpsvcnb.fc.hp.com> (Carl Baldwin's message
	of "Mon, 28 Nov 2005 09:33:56 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13068>

Carl Baldwin <cnb@fc.hp.com> writes:

> I would expect this to do it:
>
> % git fetch -f <url> new-branch
>
> But, it doesn't.
>
> Actually, I just noticed that this accomplishes the desired result...
>
> % git fetch <url> new-branch:new-branch

First, '-f' means "allow overriding the fast-forward check when
updating an existing branch".  This can be done per refspec by
saying "+rbranch:lbranch" but if you are fetching more than one
remote branches at once (especially through "remotes" shorthand)
the option can be used to allow override of all of them.

A single token <refspec> defaults to "<refspec>:" (meaning,
"fetch but do not muck with our branches") is deliberate.  When
I get a pull request "please pull from git://u/r/l/ send2junio branch",
I do not "git pull git://u/r/l/ send2junio" right away, but do
"git fetch git://u/r/l/ send2junio" and inspect FETCH_HEAD with
various combinations of "git diff master..FETCH_HEAD" and
friends.  I do _not_ want it to create send2junio branch in my
repository with that.  Also "git pull git://u/r/l/ send2junio"
would internally run "git fetch git://u/r/l/ send2junio" and
then runs merge, and I do not want that to create send2junio
branch in my repository either.  The latter could be prevented by
adding an extra flag to git-fetch to tell it not to default
a single token <refspec> to "<refspec>:<refspec>" and pass that
flag from git-pull, though.

I just found out that the documentation for '-f' flag is simply
missing.  I'd propose to add the following.  Thanks for noticing.

-- >8 --
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index a25d04a..200c9b2 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -4,6 +4,11 @@
 	option old data in `.git/FETCH_HEAD` will be overwritten.
 
 -f, \--force::
+	When `git-fetch` is used with `<rbranch>:<lbranch>`
+	refspec, it refuses to update the local branch
+	`<lbranch>` unless the remote branch `<rbranch>` it
+	fetches is a descendant of `<lbranch>`.  This option
+	overrides that check.
 
 -t, \--tags::
 	By default, the git core utilities will not fetch and store
