From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v5] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Sat, 11 Jul 2009 12:58:24 +0200
Message-ID: <200907111258.25118.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907100152.30683.johan@herland.net>
 <7vy6qvn1ya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 12:59:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPaId-0005n9-0L
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 12:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbZGKK6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 06:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbZGKK6a
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 06:58:30 -0400
Received: from mx.getmail.no ([84.208.15.66]:60983 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751152AbZGKK63 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2009 06:58:29 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMM00IT16HEJG40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 11 Jul 2009 12:58:26 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMM001PQ6HD4CA0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 11 Jul 2009 12:58:26 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.11.104609
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <7vy6qvn1ya.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123109>

On Saturday 11 July 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > quickfetch() calls rev-list to check whether the objects we are about
> > to fetch are already present in the repo (if so, we can skip the object
> > fetch). However, when there are many (~1000) refs to be fetched, the
> > rev-list command line grows larger than the maximum command line size
> > on some systems (32K in Windows). This causes rev-list to fail, making
> > quickfetch() return non-zero, which unnecessarily triggers the
> > transport machinery. This somehow causes fetch to fail with an exit
> > code.
> >
> > By using the --stdin option to rev-list (and feeding the object list to
> > its standard input), we prevent the overflow of the rev-list command
> > line, which causes quickfetch(), and subsequently the overall fetch, to
> > succeed.
>
> I feel uneasy with that "somehow" at the end of the first paragraph, but
> nevertheless this is the right thing to do.

Yes, it feels wrong that transport_fetch_refs() returns error when there are 
no objects to be fetched. After all, the quickfetch() routine is only meant 
to be an optimization (to skip the object fetching when not needed). Only if 
quickfetch() returned a false positive (indicating that all objects are 
present when they're really not) would I expect it to have adverse effects 
on the result of the fetch. But even then, as you indicate, fixing 
quickfetch() itself is the right thing to do, and looking into 
transport_fetch_refs() is a separate issue.

> Since it is a very isolated
> change, I'd queue this directly on 'master' and see if anybody notices a
> breakage, as it would be relatively pain-free to revert if it turns out
> to be necessary.

Thanks.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
