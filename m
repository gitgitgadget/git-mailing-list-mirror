From: Jon Loeliger <jdl@freescale.com>
Subject: Checking git-cherry-pick Use Case
Date: Wed, 11 Jan 2006 10:46:07 -0600
Message-ID: <1136997967.29751.198.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 11 17:46:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewj6z-0006JU-OH
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 17:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWAKQqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 11:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWAKQqL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 11:46:11 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:39819 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751670AbWAKQqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 11:46:10 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k0BGvqdE004201
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 09:57:52 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k0BGs8xt002377
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 10:54:08 -0600 (CST)
To: Git List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14488>

Guys,

Could you sanity check me on two issues with
my "work flow" here, please?  Maybe I could do
something better/easier?

I have a repo with a bunch of commits coming from
several different places (me, co-worker, remote repo, etc).
I'm applying co-worker's patches into "cow" branch.
I'm applying my changes directly to "jdl" branch"
I'm pulling in "origin" crude.

Ultimately, I want to do development against the "sum total
set of all known patches supplied by anyone".  Oh yeah.
So I make a "dev" branch that has "cow" + "jdl" + "origin".

However, at the end of the development day, I want to send
just _my_ patches upstream.  Thus, I need to have my changes
sitting around neatly on the "jdl" branch.

I don't want to develop in the "jdl" branch, as it doesn't
have everything needed to test stuff properly (missing "cow"
code, eg.).  So I actually edit and commit in the "dev"
branch where everything is unioned.

To isolate just my changes out of the "dev" branch into 
the "jdl" branch, I cherry pick them like this:

    $ git checkout dev
    $     <do edit-compile-test cycle until all is well>
    $ git commit -m "Stuff jdl made up and committed"

Now, things look, in part, like this:

        ! [dev] Stuff jdl made up and committed
         * [jdl] Early stuff jdl made up
          ! [origin] Original stuff
        ---
        +   [dev] Stuff jdl made up and committed
        +   [dev^] Merge branch 'jdl'
        ++  [jdl] Early stuff jdl made up
        +++ [origin] Original stuff

Then I pull that last "dev" commit over to "jdl":

    $ git checkout jdl
    $ git cherry-pick -r dev

Now it looks like this:

        ! [dev] Stuff jdl made up and committed
         * [jdl] Early stuff jdl made up
          ! [origin] Original stuff
        ---
         +  [jdl] Stuff jdl made up and committed
        +   [dev] Stuff jdl made up and committed
        +   [dev^] Merge branch 'jdl'
        ++  [jdl^] Early stuff jdl made up
        +++ [origin] Original stuff

My first question is that I expected to see 
something more like this (hand edited):

	! [dev] Stuff jdl made up and committed
         * [jdl] Early stuff jdl made up
          ! [origin] Original stuff
        ---
        ++  [dev] Stuff jdl made up and committed
        +   [dev^] Merge branch 'jdl'
        ++  [jdl^] Early stuff jdl made up
        +++ [origin] Original stuff

That is, the _same_ commit is now in both the "dev"
and "jdl" branches, so why does it have two lines here?

And finally, the "general" question:  Is this a sane
work-flow used by anyone else?  Or is there a different
perhaps even better way to do what I described above?

Thanks,
jdl
