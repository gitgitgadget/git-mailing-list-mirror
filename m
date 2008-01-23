From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 08:16:33 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Kevin Ballard <kevin@sb.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHiIG-00072h-Nc
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 17:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYAWQRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 11:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbYAWQRE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 11:17:04 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44929 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752695AbYAWQRB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 11:17:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NGGY4E019680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 08:16:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NGGXov015456;
	Wed, 23 Jan 2008 08:16:34 -0800
In-Reply-To: <20080123133802.GC7415@mit.edu>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71550>



On Wed, 23 Jan 2008, Theodore Tso wrote:
> 
> So this demonstrates that on my MacOS 10.4.11 system, on NFS, MacOS is
> doing no normalization, as it is creating two files.  On HFS+, MacOS
> is mapping both filenames to the same decomposed name.

Well, it demonstrates that (a) the OS and (b) _perl_ don't mangle 
filenames on non-HFS+ filesystems.

The problem is that since most native applications *expect* that name 
mangling, they'll probably do name mangling of their own (internally) just 
to compare the names!

So I would not be surprised if the globbing libraries, for example, will 
do NFD-mangling in order to glob "correctly", so even programs ported from 
real Unix might end up getting pathnames subtly changed into NFD as part 
of some hot library-on-library action with UTF hackery inside.

Things like the finder etc, which must be very aware of the fact that 
filenames get corrupted, would presumably internally always convert 
everything they get into NFD in order to compare names from different 
sources. And as part of that, programs may well corrupt the name before 
they then use it to create a pathname.

The fact that your perl program works under NFS, but creates NFD on a VFAT 
volume, does imply that they probably used at least some of the same 
routines they use in HFS+ for VFAT. Not entirely surprising: doing case 
insensitive stuff with Unicode is nasty code, so why not share it (even if 
it's then incorrect for FAT)..

Piece of crap it is, though. Apple has painted themselves into a nasty 
corner there.

			Linus
