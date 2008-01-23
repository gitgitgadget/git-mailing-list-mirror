From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 12:12:58 -0500
Message-ID: <20080123171258.GB32663@mit.edu>
References: <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Kevin Ballard <kevin@sb.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHjAx-0006kE-UD
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 18:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbYAWRNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 12:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYAWRN3
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 12:13:29 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:40832 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861AbYAWRN2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 12:13:28 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0NHD6VE025811;
	Wed, 23 Jan 2008 12:13:06 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0NHCxYS020220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Jan 2008 12:13:00 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JHj9m-0000Ye-TC; Wed, 23 Jan 2008 12:12:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71557>

On Wed, Jan 23, 2008 at 08:16:33AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 23 Jan 2008, Theodore Tso wrote:
> > 
> > So this demonstrates that on my MacOS 10.4.11 system, on NFS, MacOS is
> > doing no normalization, as it is creating two files.  On HFS+, MacOS
> > is mapping both filenames to the same decomposed name.
> 
> Well, it demonstrates that (a) the OS and (b) _perl_ don't mangle 
> filenames on non-HFS+ filesystems.

Well "touch" actually since that was what was actually creating the
files; I only used perl because it was easist way to gaurantee exactly
how the filenames would be generated.

> The problem is that since most native applications *expect* that name 
> mangling, they'll probably do name mangling of their own (internally) just 
> to compare the names!
> 
> So I would not be surprised if the globbing libraries, for example, will 
> do NFD-mangling in order to glob "correctly", so even programs ported from 
> real Unix might end up getting pathnames subtly changed into NFD as part 
> of some hot library-on-library action with UTF hackery inside.

It's worse than that.  You can specify at format time whether or not
HFS+ does case-sensitivity or not, and of course, there is UFS, which
I expect does no Unicode normalization at all, much like NFS.  I
suspect what you've pointed out is why certain MacOS programs break
horribly when run on non-HFS+ filesystems, though.  And if that is the
case, then those same programs might not be reliable if the user's
home directory is stored on NFS --- like they would be in an
enteprise/corproate environment, if Apple ever wants to have any hope
of penetrating that market.

Because of this, git code won't be able to just check for HFS+; it
will probably have to do a run-time test to see whether or not the
filesystem is doing case-folding or not, since that can be turned on
or off on a per-filesystem basis.  Also unknown, and which should be
tested, is whether turning off case-folding also turns off Unicode
normalization.  It may be that they did this so that HFS+ could be UFS
compatible, since Darwin *must* be built on a UFS filesystem,
reflecting its Mach/BSD heritage.  (I ran across this while doing my
web research; apparently HFS+ has been causing Apple headaches
internally.  Heh.  :-)

>Things like the finder etc, which must be very aware of the fact that
>filenames get corrupted, would presumably internally always convert
>everything they get into NFD in order to compare names from different
>sources. And as part of that, programs may well corrupt the name before
>they then use it to create a pathname.

Well, hopefully not everyone inside Apple's OS groups are total
morons, and actually use a utf8_str_equiv() routine instead of
strcmp() to do their Unicode comparisons.  But then again, maybe
not...

> The fact that your perl program works under NFS, but creates NFD on a VFAT 
> volume, does imply that they probably used at least some of the same 
> routines they use in HFS+ for VFAT. Not entirely surprising: doing case 
> insensitive stuff with Unicode is nasty code, so why not share it (even if 
> it's then incorrect for FAT)..
> 
> Piece of crap it is, though. Apple has painted themselves into a nasty 
> corner there.

No kidding!!

							- Ted
