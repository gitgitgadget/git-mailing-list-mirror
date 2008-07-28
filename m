From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Tue, 29 Jul 2008 01:41:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807290137370.2725@eeepc-johanness>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann> <alpine.DEB.1.00.0807281605330.8986@racer>
 <7vwsj5rf48.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-1870608718-1217288462=:2725"
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcKk-0004bI-Ie
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYG1Xjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbYG1Xjy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:39:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:42429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752113AbYG1Xjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:39:53 -0400
Received: (qmail invoked by alias); 28 Jul 2008 23:39:51 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp045) with SMTP; 29 Jul 2008 01:39:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GUi5JkhAGVmK66AeE6pavSeNEL0On4IWGTrdkrN
	x4BWuAxu8sHj1k
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vwsj5rf48.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90524>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-1870608718-1217288462=:2725
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 28 Jul 2008, SZEDER Gábor wrote:
> >
> >> there is a race somewhere in these 'git-mv: Keep moved index entries
> >> inact' changes.
> >> 
> >> The test cases 'git mv should overwrite symlink to a file' or 'git mv
> >> should overwrite file with a symlink' fail occasionaly.  It's quite
> >> non-deterministic:  I have run t7001-mv.sh in a loop (see below) and
> >> one or the other usually fails around 50 runs (but sometimes only
> >> after 150).  Adding some tracing echos to the tests shows that both
> >> tests fail when running 'git diff-files' at the end.
> >
> > To make it more convenient to test: with this patch it fails all the time:
> 
> It's because we rename(2) but do not read back ctime, and reuse the cached
> data from the old path that was renamed.  After the failed test that moves
> a regular file "move" to "symlink":
> 
> $ stat symlink
>   File: `symlink'
>   Size: 2               Blocks: 8          IO Block: 4096   regular file
> Device: 30ah/778d       Inode: 18104337    Links: 1
> Access: (0664/-rw-rw-r--)  Uid: ( 1012/   junio)   Gid: (   40/     src)
> Access: 2008-07-28 11:49:55.000000000 -0700
> Modify: 2008-07-28 11:48:41.000000000 -0700
> Change: 2008-07-28 11:48:42.000000000 -0700
> 
> But the cached stat information looks like this:
> 
> $ ../../git-ls-files --stat
> ctime=1217270921, mtime=1217270921, ino=18104337, mode=100644, uid=1012, gid=40symlink
> 
> We need to refresh the entry to pick up potential ctime changes.

Yep.

Tested-by: me

BTW I have no idea how we could test for this, short of introducing the 
"sleep 1" I did earlier.  Maybe guard it with a TEST_EXPENSIVE_CTIME 
variable or something similar.  Dunno.

And my suggestion to use test-chmtime: please just forget about it, and 
just assume that I had some very good wiid(1) in my pipe(2).

Ciao,
Dscho
--658432-1870608718-1217288462=:2725--
