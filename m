From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Thu, 28 Dec 2006 03:04:10 -0800
Message-ID: <7vtzzguvrp.fsf@assigned-by-dhcp.cox.net>
References: <20061228073441.GB17304@spearce.org>
	<7vmz58whnx.fsf@assigned-by-dhcp.cox.net>
	<20061228084245.GA18150@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 12:04:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzt3a-0006FH-E8
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 12:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbWL1LEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 06:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbWL1LEN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 06:04:13 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48808 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbWL1LEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 06:04:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228110411.IADV29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 06:04:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4B4Q1W00n1kojtg0000000; Thu, 28 Dec 2006 06:04:25 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061228084245.GA18150@spearce.org> (Shawn Pearce's message of
	"Thu, 28 Dec 2006 03:42:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35553>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
> ...
>> I am very tempted to have sliding window mmap() if it helps
>> people on cygwin, for example.
>
> Especially now that NO_MMAP is the default on that platform.
> At this point it may be ready to graduate to next to try and get a
> wider audience.  Since fixing that segfault in pack-objects I can't
> break it.  Of course I couldn't break it before you found that error,
> so take my words with a grain of salt... ;-)

Well, I have a bad news for you.

"ng refs/heads/master n/a (unpacker error)" is back.  I cannot
push things out.

But a bad news is that the problem does not decompose so easily;
git-push has too many players involved.  I _think_ I have the
list of positive and negative objects fed to rev-list --objects
--thin --stdin, whose output is in turn fed to pack-objects, but
manually running these steps in isolation seems to produce an Ok
result that index-pack --stdin --fix-thin accepts happily.

While I was looking at the problem, I noticed something a bit
easier to reproduce and should be lot easier to diagnose.  At
http://userweb.kernel.org/~junio/broken.tar, I have a tarball of
git.git repository.

When you extract it, you will have a directory "broken/" with a
single directory ".git/" in it.  The repository passes
"fsck-objects --full" from master just fine.

However, if you try to "git repack -a -d" it using "next" plus
"sp/mmap" with your latest fix ("pu" also has it), you will see:

        Generating pack...
        Done counting 32054 objects.
        fatal: internal error: pack revindex corrupt

In that sample repository, I have pack.window, and
repack.deltabaseoffset.  These settings do not seem to affect
the breakage.
