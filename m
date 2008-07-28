From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Mon, 28 Jul 2008 19:24:06 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807281919400.8986@racer>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann> <alpine.DEB.1.00.0807281605330.8986@racer>
 <alpine.DEB.1.00.0807281610270.8986@racer>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1955511276-1217269448=:8986"
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNXPF-0008Vt-Bo
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 20:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758554AbYG1SYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758420AbYG1SYL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 14:24:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:41504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757898AbYG1SYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 14:24:09 -0400
Received: (qmail invoked by alias); 28 Jul 2008 18:24:07 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp047) with SMTP; 28 Jul 2008 20:24:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195xXsekr55/bYrZyPwYFqZD4QJP8Ur5lHLs7TESs
	pPmgxWUCweezeB
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807281610270.8986@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90482>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1955511276-1217269448=:8986
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Jul 2008, Johannes Schindelin wrote:

> On Mon, 28 Jul 2008, Johannes Schindelin wrote:
> 
> > On Mon, 28 Jul 2008, SZEDER Gábor wrote:
> > 
> > > there is a race somewhere in these 'git-mv: Keep moved index entries 
> > > inact' changes.
> > > 
> > > The test cases 'git mv should overwrite symlink to a file' or 'git 
> > > mv should overwrite file with a symlink' fail occasionaly.  It's 
> > > quite non-deterministic:  I have run t7001-mv.sh in a loop (see 
> > > below) and one or the other usually fails around 50 runs (but 
> > > sometimes only after 150).  Adding some tracing echos to the tests 
> > > shows that both tests fail when running 'git diff-files' at the end.
> > 
> > To make it more convenient to test: with this patch it fails all the 
> > time:
> 
> Ooops.  Seems like I changed the test 23 to fail, instead of test 24.  
> However, I think it is the same bug: the index is newer by one second, 
> so it seems that the patch for builtin-mv.c did not really keep the data 
> "intact".
> 
> Note that a test case should use test-chmtime to force this scenario, 
> not sleep a second.
> 
> Unfortunately, I already spent my Git time budget for today, so the ball 
> is out of my half for now.

Hah!  I had a few minutes, and this is my analysis:

Just try to "mv" a file, and look at the _ctime_ before and after.  Yes, 
that is right, at least on my system (ext3) it _changes_.

So the test 23 and 24 in t7001-mv.sh are totally bogus.  They purport to 
test that git-mv retains the whole meta-information in the cache and 
therefore the index does not need to be updated.

However, it _does_ need to be updated, exactly because ctime changed.

Only that the test failed to test what it tried to test, instead 
succeeding erroneously, just because the index was racy most of the time 
and got silently updated.

So, this is the analysis.  The fixes will have to be done by somebody 
else, because /me goes running now.

(Possible fixes I envisage: update ctime via stat() after rename(), or 
just give up and scrap the whole "leave cache_entry inact" thing.)

Ciao,
Dscho

--8323329-1955511276-1217269448=:8986--
