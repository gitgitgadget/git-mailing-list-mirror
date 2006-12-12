X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 11:48:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612121144220.3535@woody.osdl.org>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
 <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121352520.18171@xanadu.home>
 <Pine.LNX.4.63.0612121956470.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121420580.18171@xanadu.home>
 <Pine.LNX.4.63.0612122031450.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 19:48:28 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612122031450.2807@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34138>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuDc0-0005Am-Js for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932413AbWLLTsW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWLLTsW
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:48:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34788 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932350AbWLLTsV
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 14:48:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBCJmBID014583
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 12
 Dec 2006 11:48:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBCJm9bO013672; Tue, 12 Dec
 2006 11:48:10 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Tue, 12 Dec 2006, Johannes Schindelin wrote:
> On Tue, 12 Dec 2006, Nicolas Pitre wrote:
> 
> > On Tue, 12 Dec 2006, Johannes Schindelin wrote:
> > 
> > > But it would become a non-problem when the HTTP transport would learn 
> > > to read and interpret the .idx files, basically constructing thin 
> > > packs from parts of the .pack files ("Content-Range:" comes to 
> > > mind)...
> > 
> > Woooh.
> 
> Does that mean "Yes, I'll do it"? ;-)

Umm. I hope it means "Woooh, that's crazy talk".

You do realize that then you need to teach the http-walker about walking 
the delta chain all the way up? For big pulls, you're going to be a lot 
_slower_ than just downloading the whole dang thing, because the delta 
objects are often just ~40 bytes, and you've now added a ping-pong latency 
for each such small transfer.

You don't need to download many such small ranges, and suddenly the few 
hundred ping-pongs that got you a few tens of kB of data took longer than 
just downloading a big stream efficiently that got you everything.

One big reason the native git protocol is efficient is that it's largely a 
streaming protocol (apart from the early ref-walking, but even that tries 
to stream as much as possible, rather than having a back-and-forth latency 
for each query)

