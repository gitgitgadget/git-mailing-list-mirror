From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Wed, 08 Feb 2006 17:35:49 -0800
Message-ID: <7v3bitl3ey.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602081643570.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 02:36:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F70iw-0001n9-Bg
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 02:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422763AbWBIBfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 20:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWBIBfw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 20:35:52 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52197 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1422763AbWBIBfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 20:35:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209013447.VACQ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 20:34:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602081643570.2458@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 8 Feb 2006 17:05:14 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15781>

Linus Torvalds <torvalds@osdl.org> writes:

> In particular, I think the real culprit is the plain "git diff" with no 
> arguments at all. Right now it ends up showing just a piece of the 
> picture, and the piece it shows is incomplete enough to be irritating.

Not necessarily.  Your "during the merge" example is a good one,
and "so far it looks good and I do not want to see these diffs
while modifying things further -- update-index it!" workflow
benefits immensely from it.

> Right now a plain "git diff" only shows the differences in the current 
> tree against the index. I think that was just the wrong choice. I think 
> almost everybody would actually prefer the default to be to show the 
> difference against HEAD.

I somehow suspect this is welding training wheels to your
bicycle.

> Teaching "git status" to take a "-p" flag (for "patch" - or -v for 
> "verbose") might actually be a good thing. Then, instead of "git diff", 
> you'd use "git status -p" and it would show you what the differences are 
> in the index, and what they are in the tree, so you'd _really_ know what 
> "git commit" in all its glory would do.

I think this may not be a bad idea.

What we could do is this:

	$ git status -v [--only | --include] [paths...]

When -v is given, it takes the same parameter as "git commit",
and changes its output format from the usual N x "# useful info lines"
to something like:

	---
        diff ...
        --- a/path
        +++ b/path
        @@ -N,M +L,K @@

that shows the commit preview.  At the same time we change "git
commit" commit log message reader to stop reading the input at
the first '---' line, just like we do for e-mailed patches.

Then:

 - If you want a commit preview _before_ initiating a commit,
   you can say:

	$ git status -v [whatever you planned to give git commit]

 - If you want a commit preview _while_ writing the commit log, you can
   say:

	$ git commit -v [whatever your parameters are]

   which internally would pass the -v and "$@" to git status
   that seeds the log message


 - If you want a commit preview after you made a commit, it is
   too late ;-).
