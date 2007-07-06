From: David Kastrup <dak@gnu.org>
Subject: git-diff memory/speed/disk impacts (was: being nice to patch(1))
Date: Fri, 06 Jul 2007 17:22:06 +0200
Message-ID: <864pkha76p.fsf_-_@lola.quinscape.zz>
References: <20070702125450.28228edd.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org> <20070702142557.eba61ccd.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org> <20070702145601.a0dcef0f.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org> <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org> <Pine.LNX.4.64.0707031303130.4071@racer.site> <86644xd7wr.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 17:22:54 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pe1-0004p9-Bx
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760454AbXGFPWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760269AbXGFPWY
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:22:24 -0400
Received: from main.gmane.org ([80.91.229.2]:34368 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759970AbXGFPWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:22:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I6pdR-0004Dz-23
	for git@vger.kernel.org; Fri, 06 Jul 2007 17:22:17 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 17:22:17 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 17:22:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:WOMGZRdWi4zhXUv1timBIOk63Oo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51764>


Some more experiments:

David Kastrup <dak@gnu.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> > >
>>> > > I guess the second choice generally isn't an option, but dammit, 
>>> > > "git-apply" really is the better program here.
>>> > 
>>> > Why not?  git-apply works outside of a git repo ;-)
>>> 
>>> I was more thinking that people are not necessarily willing to install git 
>>> just to get the "git-apply" program..
>>
>> But maybe they would be willing to install git to get that wonderful
>> git-apply program, and that wonderful rename-and-mode-aware
>> git-diff, and the git-merge-file program, all of which can operate
>> outside of a git repository. (Take that, hg!)
>
> Well, hmph!  I just rewrote my git-diff-using script to not check
> stuff into a throw-away git repository, and guess what: with real-life
> use cases (diffing trees of about 500MB size), git-diff runs out of
> memory (the machine probably has something like 1.5GB of virtual memory
> size) when operating outside of a git repository.
>
> So the usefulness still seems limited, even now that the output format
> of --name-status has been fixed.
>
> Any idea whether this is a bug, sloppy programming, or an inherent
> restriction/necessity?
>
> Also an idea which of the following scenarios would be best for
> catching all of moves/renames/deletes/adds?  Note: any repository is
> strictly throw-away.
>
> Experiments are somewhat time-consuming, so every hunch helps.
>
> a) diff directories outside of git (works, but fatal memory footprint
>                                     for large cases)
> b) diff index against work directory
fatal memory footprint
> c) diff revision against work directory
fatal memory footprint
> d) diff revision against index
does not detect copies/renames
> e) diff revision against revision (works, but high disk footprint and
>                                    likely slower than alternatives)

So it seems like option e) is the only feasible option.  In the total
numbers, git-add is by far the slowest operation, followed by
git-commit.  git-diff on revisions is quite fast and with moderate
memory footprint.

Committing itself does not seem to add much disk space: adding into
the index seems to be the main disk space allocation.

So while the behavior of d) appears puzzling, doing another commit
before the diff is cheap, so the motivation for asking people to find
out the problems with d) is low for me.

Somewhat dissatisfactory that rewriting my script for using the
repository-less variant of git-diff fails for seriously large use
cases due to out-of-memory conditions.

I suppose that's life.

-- 
David Kastrup
