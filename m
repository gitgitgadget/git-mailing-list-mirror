From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [RFH] rebase -i optimization
Date: Fri, 27 Feb 2009 01:10:10 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngqefbi.g56.sitaramc@sitaramc.homelinux.net>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 02:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcrGa-0007Mg-9n
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 02:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbZB0BKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 20:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbZB0BKW
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 20:10:22 -0500
Received: from main.gmane.org ([80.91.229.2]:35486 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754526AbZB0BKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 20:10:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LcrF5-0005ta-LX
	for git@vger.kernel.org; Fri, 27 Feb 2009 01:10:19 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 01:10:19 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 01:10:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111624>

On 2009-02-26, Sverre Rabbelier <srabbelier@gmail.com> wrote:

> I am currently working on a large set of patches for Melange, and as
> such I'm using rebase -i a lot to polish things a bit. I do this
> mainly by 'git rebase -i master' from my topic branch, then change on
> of the 'pick' lines into an 'edit', and then fix up the commit and
> 'git rebase --continue'. Now I notice I'm waiting a lot for 'rebase
> -i' to finish picking the first bunch of commits that I didn't change.
> Now obviously I couldof done 'git rebase -i <foo>', but then I have
> first figure out what the last commit I want to change is.

you could, in theory, do it with a custom "EDITOR" variable
that actually points to a script you write.  This script
will invoke the normal editor just as now, but if it finds
that the resulting file has pick line(s) before the first
edit line, it aborts the rebase by sending back an empty
file, and print out a suitable rebase command that you just
click-and-paste :-)

Any other combination it just sends through as normal (like
if the first non-pick line was a 'squash', for instance).

Yes this is a kludge but it gets your job done with a
minimum of fuss asap.

Regards,

Sitaram

PS: Even more fun...

I tested a script that looks like this:

    #!/bin/bash

    vim "$@"
    # -- parse $1 (which will be # .git/rebase-merge/rebase-todo
    # really) to pick the correct SHA you need --
    unset EDITOR
    git rebase --abort
    git rebase -i the-SHA-you-picked

When it finishes the inner rebase it does protest mildly
(something about grep not finding that same file), a remnant
of the outer rebase... but it seems to work fine.

This removes even the extra step of having the outer rebase
print something that you have to then copy/paste :-)
