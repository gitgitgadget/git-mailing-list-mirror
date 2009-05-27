From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 16:01:57 +0200
Message-ID: <C933C1BA-0170-4469-8099-2C0E95C61D24@dbservice.com>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 27 16:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9JiF-0007by-KQ
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 16:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761014AbZE0OC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 10:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbZE0OCZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 10:02:25 -0400
Received: from office.neopsis.com ([78.46.209.98]:41747 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099AbZE0OCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 10:02:25 -0400
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Wed, 27 May 2009 16:02:23 +0200
In-Reply-To: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120066>


On May 27, 2009, at 12:52 PM, Christopher Jefferson wrote:

> I recently came across a very annoying problem, characterised by the  
> following example:
>
> On a recent ubuntu install:
>
> dd if=/dev/zero of=file bs=1300k count=1k
> git commit file -m "Add huge file"
>
>
> The repository can be pulled and pushed successfully to other ubuntu  
> installs, but on Mac OS X, 10.5.7 machine with 4GB ram git pull  
> produces:
>
> remote: Counting objects: 6, done.
> remote: git(1533,0xb0081000) malloc: *** mmap(size=1363152896)  
> failed (error code=12)
> remote: *** error: can't allocate region
> remote: *** set a breakpoint in malloc_error_break to debug
> remote: git(1533,0xb0081000) malloc: *** mmap(size=1363152896)  
> failed (error code=12)
> remote: *** error: can't allocate region
> remote: *** set a breakpoint in malloc_error_break to debug
> remote: fatal: Out of memory, malloc failed
> error: git upload-pack: git-pack-objects died with error.
> fatal: git upload-pack: aborting due to possible repository  
> corruption on the remote side.
> remote: aborting due to possible repository corruption on the remote  
> side.
> fatal: protocol error: bad pack header
>
>
> The problem appears to be the different maximum mmap sizes available  
> on different OSes. Whic I don't really mind the maximum file size  
> restriction git imposes, this restriction varying from OS to OS is  
> very annoying, fixing this required rewriting history to remove the  
> commit, which caused problems as the commit had already been pulled,  
> and built on, by a number of developers.
>
> If the requirement that all files can be mmapped cannot be easily  
> removed, would be it perhaps be acceptable to impose a (soft?)  
> 1GB(ish) file size limit? I suggest 1GB as all the OSes I can get  
> hold of easily (freeBSD, windows, Mac OS X, linux) support a mmap of  
> size > 1GB.

I think this is a limitation of a 32bit build of git. I just tried  
with a 64bit build and it added the file just fine. The compiler on  
MacOSX (gcc) produces 32bit builds by default, even if the system  
supports 64bit executables. But gcc on 64bit Linux (at least the  
installations I have at home) produces a 64bit executables by default.  
Solaris/OpenSolaris behaves like MacOSX, no idea about *BSD or  
Windows. Maybe this is why git works on Linux but not MacOSX even on  
the same hardware.
Btw, I built git with: make install prefix=... CC="gcc -m64", no  
modifications needed (MacOSX 10.5.7).

tom
