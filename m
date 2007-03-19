From: Theodore Tso <tytso@mit.edu>
Subject: Re: Libification project (SoC)
Date: Sun, 18 Mar 2007 22:56:36 -0400
Message-ID: <20070319025636.GE11371@thunk.org>
References: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070319012111.GS18276@pasky.or.cz> <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:56:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT839-0007EP-Ns
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933763AbXCSC4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933776AbXCSC4m
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:56:42 -0400
Received: from THUNK.ORG ([69.25.196.29]:36527 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933763AbXCSC4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:56:41 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HT88t-0001UE-0c; Sun, 18 Mar 2007 23:02:39 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HT832-0002Ch-A6; Sun, 18 Mar 2007 22:56:36 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42567>

On Mon, Mar 19, 2007 at 02:43:54AM +0100, Johannes Schindelin wrote:
> >   I was talking about the API. The API has to be designed to be 
> > reentrant. And you get pretty much stuck with the API. And requiring 
> > reentrance isn't that far off once libgit is there, as I tried to point 
> > out; it's not really any obscure requirement.
> 
> - it is easy enough to extend the API later, _retaining_ the small and 
>   beautiful functions.

Um, look at what we had to do with gethostbyname() and
gethostbyname_r().  It wasn't possible to sweep through and fix all of
the programs that used gethostbyname(), despite the fact that if a
program called gethostbyname(), then called library function which
unknowingly to application, could possibly do a DNS or YP lookup (and
whose behavior could change depending on some config file like
/etc/nsswitch.conf), which would blow away the static information.  So
if the application tryied to use the information returned by _its_
call to gethostbyname after calling some other library function, it
could get some completely random hostname that wasn't what it
expected.

Yelch!  And so we have two API's that libc has to support,
gethostbyname(), and gethostbyname_r(), with the ugly _r() suffix, and
which in a sane world most programs should use since otherwise they
can be incredibly fragile unless the _first_ thing they do after
calling gethostbyname is to copy the information to someplace stable,
instead of relying on the static buffer to remain sane.  (And yet they
don't, which means bugs that only show up if optional YP or Hesiod
lookups are enabled, etc.)

Berkely got it horribly wrong when it tried to start with the "small
and beautiful" functions that were non-reentrant, and we've been
paying the price ever since.  Do we really want to support two
versions of the API forever?  Is it really that hard to support a
reentrant API from the beginning?  I'd submit the answer to these two
questions are no, and no, respectively.

						- Ted
