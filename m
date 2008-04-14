From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 08:23:28 +0100
Message-ID: <20080414072328.GW9785@ZenIV.linux.org.uk>
References: <47FEADCB.7070104@rtr.ca> <20080413121831.d89dd424.akpm@linux-foundation.org> <20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl> <20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net> <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu> <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 09:25:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJ3d-0005pG-Dg
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758508AbYDNHYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 03:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758193AbYDNHYG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:24:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38712 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757485AbYDNHYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 03:24:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.63 #1 (Red Hat Linux))
	id 1JlJ2G-0005Ub-5O; Mon, 14 Apr 2008 08:23:28 +0100
Content-Disposition: inline
In-Reply-To: <20080413232441.e216a02c.akpm@linux-foundation.org>
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79478>

On Sun, Apr 13, 2008 at 11:24:41PM -0700, Andrew Morton wrote:

> No.  The problem we're discussing here is the apparently-large number of
> bugs which are in the kernel, the apparently-large number of new bugs which
> we're adding to the kernel, and our apparent tardiness in addressing them.
> 
> Do you agree with these impressions, or not?
> 
> If you do agree, what would you propose we do about it?

In addition to obvious "we need testing and something better than bugzilla
to keep track of bugs"?  Real review of code in tree and patches getting into
the tree.

And the latter part _must_ be done on each entry point.  Any git tree
that acts as injection point really needs a working mechanism of some
sort that would do that; afterwards it's too late, since review of
the stuff getting into mainline on a massive merge is sadly impractical.

I don't know any formal mechanism that could take care of that; no more
than making sure that no backdoors are injected into the tree.  It really
has to be a matter of trust for tree maintainers and community around
the subsystem.

Git is damn good at killing the merge bottleneck.  Too good, since it
hides the review bottleneck.  And we get equivalents of self-selected
communities that had been problem for "here's our CVS, here's monthly
dump from it, apply" kind of setups.  It _is_ better, since one can
get to commit history (modulo interesting issues with merge nodes and
conflict resolution).  But in practice it's not good enough - the patches
going in during a merge (especially for a tree that collects from
secondaries) are not visible enough.  And it's too late at that point,
since one has to do something monumentally ugly to get Linus revert
a large merge.  On the scale of Great IDE Mess in 2.5...

linux-next might help with the last part, but I don't think it really
deals with the first one.  It certainly helps to some extent, but...

We need higher S/N on l-k.  We need people looking into the subsystem
trees as those grow and causing a stench when bad things are found,
with design issues getting brought to l-k if nothing else helps.  We
need tree maintainers understanding that review, including out-of-community
one, is needed (the need of testing is generally better understood - I
_hope_).

We need more people reading the fscking source.  Subsystem by subsystem.
Without assumption that code is not broken.  With mechanism collating
the questions asked and answers given.  Ideally we need growing documentation
of core subsystems and data structures, with explicit goal of helping
reviewers new to an area to find their way around it.  And yes, I'm
guilty of procrastinating on that - several half-finished pieces on
VFS-related stuff are sitting locally ;-/

We need gregkh to get real and stop assuming that two Signed-off-by are
equivalent to "reviewed at least twice", while we are at it ;-)

We need people to realize that warnings are useful as triage tools -
not as "Ug see warning.  Warning bad.  Ug fix that line.  Warning go away.
Ug changeset count grow.  Ug happy.", but as machine-assisted part of
finding confused areas of code.  With human combining signals from
different warnings to get statistically useful triage strategies (note
that aforementioned making gcc/sparse/whatnot to STFU by local change
has a lovely potential of distorting those signals and actually _hiding_
crap code).

Maybe we need a list a-la linux-arch for tree maintainers to coordinate
stuff - obviously open not only for those.

We really need to get around to doing triage of remaining stuff in -mm,
BTW - again, guilty for not getting through such on VFS-related stuff
in there.  Hopefully linux-next trees will eventually vacuum most of the
pile in...

As for the bug that got this thread started...  I'd say that asking to
bisect was reasonable in this particular case.  The following DSW mixed
into the thread very soon went the way of all DSW (OK, it hadn't godwinated
yet, at least in the parts I've seen, so there's still way to go, but...)
