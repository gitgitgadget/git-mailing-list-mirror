From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.5.0.rc1.gb60d: fetch in another branch works strangely
Date: Sat, 13 Jan 2007 13:46:15 -0800
Message-ID: <7vr6tyk3bs.fsf@assigned-by-dhcp.cox.net>
References: <200701132106.l0DL6BPH008314@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 22:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5qhh-0001S6-1c
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 22:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXAMVqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 16:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbXAMVqS
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 16:46:18 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39619 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbXAMVqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 16:46:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113214616.FHEV18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 16:46:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id AlmY1W00c1kojtg0000000; Sat, 13 Jan 2007 16:46:33 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701132106.l0DL6BPH008314@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Sat, 13 Jan 2007 18:06:11 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36774>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> I created a new branch in the kernel to carry a not yet official patch, to
> keep this up to date I do:
>
>    $ git fetch git://git2.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

If you use longhand without colon-refspec (src:dst), then the fetch
result will be in temporary ref, FETCH_HEAD.  (google, or gmane
search for a message on "temporary ref" and "FETCH_HEAD" by
Linus for gory details).  So next fetch will keep re-fetching
the same thing (this has been how "fetch" was designed to work
from day one and there is nothing new).

>    $ git pull . origin

You do not have origin tracking branch (well, you do -have- one,
but by doing the longhand without colon-refspec, you choose not
to keep it up-to-date), so that would try to merge an ancient
copy you obtained probably when you cloned to create the
repository.

You either can do:

 (1) Ad-hoc promiscuous pull without using tracking branch

     $ git pull git://git.kernel.org/...../linux-2.6.git

     This is good for one-shot pulling from random place when
     you notice somebody you usually do not interact with has
     something interesting.  I do not think you would want to do
     that with Linus.

 (2) Use remote shorthand, define and maintain tracking branch(es).

     In the traditional configuration,
     you would have .git/remotes/origin that says something
     like:

	URL: git://git.kernel.org/...../torvalds/linux-2.6.git
	Pull: refs/heads/master:refs/heads/origin

     With the newer configuration, the moral equivalent is found
     in your .git/config file and would look like something like
     this:

	[remote "origin"]
        	url = git://git.kernel.org/...../linux-2.6.git/
		fetch = +refs/heads/*:refs/remotes/origin/*
	[branch "master"]
        	merge = refs/heads/master

     In either way, you can update the tracking branch with:

     $ git fetch origin ;# or just "git fetch"

     With this, since you -do- have and -maintain- the tracking
     branch, you can do after this "git fetch":

     $ git merge origin

     to merge in what you have fetched.
