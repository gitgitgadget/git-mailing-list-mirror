From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 18:58:19 -0800
Message-ID: <7v64bw3ewk.fsf@assigned-by-dhcp.cox.net>
References: <junkio@cox.net>
	<200612271206.kBRC6ke2004207@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 03:58:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzlTT-00012G-Mg
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 03:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWL1C6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 21:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWL1C6V
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 21:58:21 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62602 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964893AbWL1C6U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 21:58:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228025820.XNIA18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 21:58:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 42yZ1W00Q1kojtg0000000; Wed, 27 Dec 2006 21:58:33 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200612271206.kBRC6ke2004207@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Wed, 27 Dec 2006 09:06:46 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35515>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> This is still rough, but I think we have a pretty good idea what
>> will and what won't be in v1.5.0 by now, and end-of-year is a
>> good slow time to summarize what we have done.
>
> Could somebody please summarize how to "upgrade" a repository to the new
> layout?  This has got my head spinning... and I'm /not/ cloning the
> various repos I've got here just to take advantage of the changes.

The old layout was to map remote branch $B to local tracking
branch .git/refs/heads/$B, unless $B == 'master' in which case
it was mapped to .git/refs/heads/origin (and I think we
discarded 'origin' at remote).

Each remote branch $B is tracked with .git/refs/remote/origin/$B
in the new layout.

And you will get something like this in your .git/config:

    [remote "origin"]
            url = git://git.kernel.org/pub/scm/.../torvalds/linux-2.6.git/
            fetch = refs/heads/*:refs/remotes/origin/*
    [branch "master"]
            remote = origin
            merge = refs/heads/master

The first section defines what the token 'origin' means when you
say "git pull origin" or "git fetch origin".  remote.origin.url
defines the URL to fetch/pull from, and remote.origin.fetch
supplies the refspecs you omitted from the command line (fetch
everything from refs/heads/ hierarchy of remote and store them
in my refs/remotes/origin/ hierarchy).

The second section defines what happens when you say "git pull"
or "git fetch" while on your "master" branch.  It tells that you
meant to say "git pull origin" or "git fetch origin" when you
omitted the URL argument from the command line.  And because you
are also omitting the refspecs, remote.origin.fetch kicks in and
slurps all the branches from the remote side and stores them in
your refs/remotes/origin/ hierarchy.  When the command was "git
pull", it also says the merge that follows the fetch is to merge
the 'master' branch at the remote side (which happens to be
copied to your remotes/origin/master only because you have
remote.origin.fetch) into your current branch (which is
"master", because this section is about what happens while you
are on your "master" branch).

So for an existing repository that does not use the separate
remotes layout, you can easily convert that by hand if you
wanted to by:

 - Move tracking branches from refs/heads/* to
   refs/remotes/origin/*,

 - create the config section like the above in .git/config, and

 - remove .git/remotes/origin when you are done.
