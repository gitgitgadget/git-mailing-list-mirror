X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 21:26:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122121190.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
 <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121352520.18171@xanadu.home>
 <Pine.LNX.4.63.0612121956470.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121420580.18171@xanadu.home>
 <Pine.LNX.4.63.0612122031450.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121144220.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 20:26:46 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612121144220.3535@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34142>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuECt-0002Mn-FH for gcvg-git@gmane.org; Tue, 12 Dec
 2006 21:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932318AbWLLU02 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 15:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWLLU02
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 15:26:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:35228 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932318AbWLLU01
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 15:26:27 -0500
Received: (qmail invoked by alias); 12 Dec 2006 20:26:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 12 Dec 2006 21:26:25 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Linus Torvalds wrote:

> On Tue, 12 Dec 2006, Johannes Schindelin wrote:
> > On Tue, 12 Dec 2006, Nicolas Pitre wrote:
> > 
> > > On Tue, 12 Dec 2006, Johannes Schindelin wrote:
> > > 
> > > > But it would become a non-problem when the HTTP transport would learn 
> > > > to read and interpret the .idx files, basically constructing thin 
> > > > packs from parts of the .pack files ("Content-Range:" comes to 
> > > > mind)...
> > > 
> > > Woooh.
> > 
> > Does that mean "Yes, I'll do it"? ;-)
> 
> Umm. I hope it means "Woooh, that's crazy talk".
> 
> You do realize that then you need to teach the http-walker about walking 
> the delta chain all the way up? For big pulls, you're going to be a lot 
> _slower_ than just downloading the whole dang thing, because the delta 
> objects are often just ~40 bytes, and you've now added a ping-pong latency 
> for each such small transfer.

Two points:

- For loose objects, the HTTP walker does exactly that. This is the normal 
case for "just a few objects since the last fetch". It will _never_ be the 
case for the initial clone!

- Usually, the object fetching can be parallelized, because you want 
multiple objects which are in disjunct delta chains. And for these, you 
can say something like "Content-Range: 15-31,64-79,108-135" IIRC.

You could even fetch sensible chunks, i.e. cut only at multiples of 512 to 
make the transport more efficient, and only fetch the parts which are 
_still_ missing.

So, a crazy idea, yes. But a feasible one. Just not crazy enough to be 
tempting for me (I use the git protocol whenever possible, too).

Ciao,
