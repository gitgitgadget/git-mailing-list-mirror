From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 01:56:39 -0400
Message-ID: <E1IhIwR-0006be-Ki@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org>
	<1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710150039120.25221@racer.site>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: ae@op5.se, raa.lkml@gmail.com, git@vger.kernel.org, make-w32@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 07:57:58 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhIwf-000481-1T
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 07:56:53 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhIwY-0007sy-EN
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 01:56:46 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhIwU-0007sj-B5
	for make-w32@gnu.org; Mon, 15 Oct 2007 01:56:42 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhIwS-0007sX-Sl
	for make-w32@gnu.org; Mon, 15 Oct 2007 01:56:41 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhIwS-0007sU-PD
	for make-w32@gnu.org; Mon, 15 Oct 2007 01:56:40 -0400
Received: from fencepost.gnu.org ([140.186.70.10])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <eliz@gnu.org>) id 1IhIwS-0000px-Dc
	for make-w32@gnu.org; Mon, 15 Oct 2007 01:56:40 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhIwR-0006be-Ki; Mon, 15 Oct 2007 01:56:39 -0400
In-reply-to: <Pine.LNX.4.64.0710150039120.25221@racer.site> (message from
	Johannes Schindelin on Mon, 15 Oct 2007 00:45:47 +0100 (BST))
X-detected-kernel: by monty-python.gnu.org: Linux 2.6, seldom 2.4 (older, 4)
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60947>

> Date: Mon, 15 Oct 2007 00:45:47 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: Alex Riesen <raa.lkml@gmail.com>, ae@op5.se, tsuna@lrde.epita.fr, 
>     git@vger.kernel.org, make-w32@gnu.org
> 
> The problem is not so much opening, but determining if an existing file 
> and a file in the index have the same name.
> 
> For example, "README" in the index, but "readme" in the working directory, 
> will be handled as "deleted/untracked" by the current machinery.  IOW git 
> will not know that what it gets from readdir() as "readme" really is the 
> same file as "README" in the index.

That's because you think file names are simple strings and can be
compared by simple string comparison.  This naìve view is not true
even on POSIX systems: "foo/bar" and "/a/b/foo/bar" can be the same
file, as well as "/a/b/c/d" and "/x/y/z", given the right symlinks.
But for some reason that eludes me, people who are accustomed to POSIX
stop right there and in effect say "file names are strings, if we only
make them absolute and resolve links".  Instead, recognize that file
names are not strings (although they inherit some of the strings'
traits), and think in terms of "file-name comparison" abstraction;
then everything will fall in place just fine.

> > > - no acceptable level of performance in filesystem and VFS (readdir,
> > >   stat, open and read/write are annoyingly slow)
> > 
> > With what libraries?  Native `stat' and `readdir' are quite fast. 
> > Perhaps you mean the ported glibc (libgw32c), where `readdir' is indeed 
> > painfully slow, but then you don't need to use it.
> 
> No, native.

Can you show a test case where this penalty is clearly visible?  I'm
curious to see the numbers.  TIA
