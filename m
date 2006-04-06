From: Christopher Faylor <me@cgf.cx>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Wed, 5 Apr 2006 20:34:50 -0400
Message-ID: <20060406003449.GA7174@trixie.casa.cgf.cx>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com> <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org> <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org> <fa0b6e200604050624h13ebd8deg241ae98cef1f5a74@mail.gmail.com> <Pine.LNX.4.63.0604051612200.25304@wbgn013.biozentrum.uni-wuerzburg.de> <20060405210844.GN26780@trixie.casa.cgf.cx> <20060405232739.GA18121@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 06 02:35:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRISy-0007yi-PG
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 02:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWDFAfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 20:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWDFAfF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 20:35:05 -0400
Received: from pool-71-248-179-247.bstnma.fios.verizon.net ([71.248.179.247]:43931
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S932128AbWDFAfE
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 20:35:04 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 071E613C08F; Wed,  5 Apr 2006 20:34:50 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060405232739.GA18121@nospam.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18462>

On Thu, Apr 06, 2006 at 01:27:39AM +0200, Rutger Nijlunsing wrote:
>On Wed, Apr 05, 2006 at 05:08:44PM -0400, Christopher Faylor wrote:
>> On Wed, Apr 05, 2006 at 04:14:20PM +0200, Johannes Schindelin wrote:
>> >> Inspired by a patch of Alex Riesen (thanks, Alex), I tried to use the
>> >> regular mmap for mapping pack files, only to discover that I compile
>> >> without defining "NO_MMAP", so I've been using the stock mmap all
>> >> along. So now I'm thinking that the cygwin mmap also does a
>> >> malloc-and-read, just like git does with NO_MMAP. So I'll continue to
>> >> investigate in that direction.
>> >
>> >I think cygwin's mmap() is based on the Win32 API equivalent, which could 
>> >mean that it *is* memory mapped, but in a special area (which is smaller 
>> >than 1.5 gigabyte). In this case, it would make sense to limit the pack 
>> >size, thereby having several packs, and mmap() them as they are needed.
>> 
>> Yes, cygwin's mmap uses CreateFileMapping and MapViewOfFile.  IIRC,
>> Windows might have a 2G limitation lurking under the hood somewhere but
>> I think that might be tweakable with some registry setting.
>
>Windows places its DLLs criss-cross through the memory space because
>every DLL on the system has its own preferred place to be loaded (the
>base address). This severely limits the amount of largest contiguous
>memory block available, which is needed for one mmap() I think.
>
>Several solutions exist:
>  - enlarge the address space with the /3GB boot flag in boot.ini

Thanks.  The 3GB boot flag is what I was trying to remember.

>  - rebase all DLLs with REBASE.EXE (part of platform sdk) .
>    Just make them the same and fix them to a low address.
>    Problem is rebasing system dlls since those are locked by the system.

Cygwin has its own version of rebase and a method for rebasing all of the
dlls in the distribution.  Using that may help squeeze out a little bit
of memory.

>  - at start of program before other DLLs are loaded,
>    reserve an as large part of the memory as possible with
>    VirtualAlloc()

Cygwin actually uses this trick to try to push DLLs into their right
locations after a fork.  It sort of works but sometimes, in a child
proccess, Windows puts "stuff" in locations previously occupied by a
DLL.  I could swear that it does that just to be annoying...

There is a chicken/egg problem here in that Cygwin uses Doug Lea's malloc
and that version of malloc will use mmap when sbrk() fails -- as it is
apt to do when allocating gigabytes of memory.  So, using malloc is
not a way to avoid mmap.

cgf
