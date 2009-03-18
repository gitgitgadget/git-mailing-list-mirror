From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MinGW: implement mmap
Date: Wed, 18 Mar 2009 12:18:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903181213050.10279@pacific.mpi-cbg.de>
References: <49C0A462.3060902@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Janos Laube <janos.dev@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 12:18:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljtmv-0005Vu-Qh
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 12:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbZCRLQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 07:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbZCRLQr
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 07:16:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:48484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752421AbZCRLQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 07:16:46 -0400
Received: (qmail invoked by alias); 18 Mar 2009 11:16:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 18 Mar 2009 12:16:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/KGQN9sY/cPmeVKhR5kNafEIe+85RtMQkICp/pK
	llvADagBuo552R
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49C0A462.3060902@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113610>

Hi,

On Wed, 18 Mar 2009, Johannes Sixt wrote:

> From: Janos Laube <janos.dev@gmail.com>
> Date: Fri, 13 Mar 2009 16:50:45 +0100
> 
> Add USE_WIN32_MMAP which triggers the use of windows' native
> file memory mapping functionality in git_mmap()/git_munmap() functions.
> 
> As git functions currently use mmap with MAP_PRIVATE set only, this
> implementation supports only that mode for now.
> 
> On Windows, offsets for memory mapped files need to match the allocation
> granularity. Take this into account when calculating the packed git-
> windowsize and file offsets. At the moment, the only function which makes
> use of offsets in conjunction with mmap is use_pack() in sha1-file.c.
> 
> Git fast-import's code path tries to map a portion of the temporary
> packfile that exceeds the current filesize, i.e. offset+length is
> greater than the filesize. The NO_MMAP code worked with that since pread()
> just reads the file content until EOF and returns gracefully, while
> MapViewOfFile() aborts the mapping and returns 'Access Denied'.
> Working around that by determining the filesize and adjusting the length
> parameter.
> 
> Signed-off-by: Janos Laube <janos.dev@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

In case anybody wonders why this is not integrated into mingw.[ch]: I 
asked for it, as it is Windows-specific and could benefit Cygwin (or MSVC, 
should someone attempt that), too.

And I think I missed this style in the patch:

> +void *git_mmap
> +(void *start, size_t length, int prot, int flags, int fd, off_t offset)
> +{

... which I would like to see fixed, of course... :-)

Unfortunately, there is also a long line, which is corrupted due to 
wrapping:

> +	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), 0,
> PAGE_WRITECOPY,
> +		0, 0, 0);

It is easily fixed by moving the PAGE_WRITECOPY to the next line.

These are only style issues, though.

The more important part is: how much does this buy us (or is it more 
expensive, as we saw one MacOSX at one stage).  Janos was nice enough to 
perform some benchmark tests, and saw a ~40% improvement on rev-list 
--objects --all on a sizeable project (GCC 'twas, IIRC).  Funnily, the 
numbers got better when reducing the window, up until 1MB, and they got 
worse when enlarging the window.

So I guess there will be a follow-up patch at some stage which changes the 
default pack window size on Windows to something smaller than 64MB.

Ciao,
Dscho
