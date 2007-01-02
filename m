From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Tue, 02 Jan 2007 15:28:33 +0000
Message-ID: <459A7A21.4060901@shadowen.org>
References: <20061223073317.GA9837@spearce.org> <38b2ab8a0612240056k152344ael891e9b0b9f8cbc47@mail.gmail.com> <20061224090508.GF7443@spearce.org> <38b2ab8a0612240136r559376d4s14af3123f762a45d@mail.gmail.com> <20061224094959.GA7814@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Francis Moreau <francis.moro@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 16:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1lZF-0002oG-OT
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 16:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbXABP2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 10:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbXABP2m
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 10:28:42 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3558 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbXABP2l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 10:28:41 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H1lYD-0000Jl-ME; Tue, 02 Jan 2007 15:27:41 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061224094959.GA7814@spearce.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35791>

Shawn Pearce wrote:
> Francis Moreau <francis.moro@gmail.com> wrote:
>> On 12/24/06, Shawn Pearce <spearce@spearce.org> wrote:
>>> However with this series even a 32 bit OS which only permits
>>> processes to have at most 2 GiB of address space (2 GiB split
>>> between kernel space and userspace) can access packfiles up
>>> to 4 GiB in size.  That seems to be the split most OSes wind
>>> up using, if they didn't push it out to 3.2 GiB like Linux
>>> and Solaris have done.
>>>
>> Does it still needed for 64 bit OS ?
> 
> Not really.  Almost any reasonable 64 bit OS which is also running
> a Git compiled for 64 bit userspace would be able to mmap multiple
> 4 GiB packfiles without this series.
>  
>> if not, can the overhead (if there is a significant one) implied by
>> your rework be avoid for such cases ?
> 
> The overhead is rather low.  I did try hard to make it only a handful
> of machine instructions worth of additional work, and even then I
> tried to ammortize those over relatively large blocks of data to
> reduce the impact.  But yes, there is an overhead over the current
> shipping version of Git.
> 
> However at least some of the overhead can be avoided by setting
> core.packedGitWindowSize and core.packedGitLimit to higher values.
> This will allow the implementation to mmap() larger windows of the
> packfiles and retain a greater number of windows in memory at once.
> 
> If core.packedGitWindowSize is larger than your largest packfile
> then most of the code will just "shutoff" and won't get in the way.
> Its default is 32 MiB (see Documentation/config.txt).
> 
> I think the additional overhead added by this series is neglible
> and worth the more graceful degredation it allows when virtual
> address space becomes limited.

You now change the default size based on NO_MMAP, could you not just
bump the window size to 4GiB on 64 bit?

-apw
