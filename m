X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fetching from a big repository is slow
Date: Fri, 15 Dec 2006 00:26:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612150015330.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612141340.43925.andyparkins@gmail.com>
 <200612141518.05770.andyparkins@gmail.com> <458171B7.1020702@xs4all.nl>
 <200612141620.17782.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612141732410.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xha2osd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 23:26:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xha2osd.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34436>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzyB-0001AQ-SL for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751826AbWLNX02 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWLNX02
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:26:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:58071 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751826AbWLNX01
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 18:26:27 -0500
Received: (qmail invoked by alias); 14 Dec 2006 23:26:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp027) with SMTP; 15 Dec 2006 00:26:26 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > git-show-ref traverses every single _local_ tag when called. This is to 
> > overcome the problem that tags can be packed now, so a simple file 
> > existence check is not sufficient.
> 
> Is "traverses every single _local_ tag" a fact?  It might go
> through every single _local_ (possibly stale) packed tag in
> memory but it should not traverse $GIT_DIR/refs/tags.
> 
> If I recall correctly, show-ref (1) first checks the filesystem
> "$GIT_DIR/$named_ref" and says Ok if found and valid; otherwise
> (2) checks packed refs (reads $GIT_DIR/packed-refs if not
> already).

If I read builtin-show-ref.c correctly, it _always_ calls 
for_each_ref(show_ref, NULL);

The only reason that the loop in for_each_ref can stop early is if 
show_ref returns something different than 0. But it does not! Every single 
return in show_ref() returns 0. It does not matter, though (see below).

> So that would be at most one open (which may fail in (1)) and one 
> open+read (in (2)).  Unless we are talking about fork+exec overhead, 
> that "traverse" should be reasonably fast.
> 
> Where is the bottleneck?

The problem is that so many stat()s _do_ take time. Again, if I read the 
code correctly, it not only stat()s every loose ref, but also resolves the 
refs in get_ref_dir(), which is called from get_loose_refs(), which is 
unconditionally called in for_each_ref().

Even if the refs are packed, it takes quite _long_ (I confirmed this). And 
it is not at all necessary! Instead of a O(n^2) we can easily reduce this 
to O(n*log(n)), and we can reduce the n fork()&exec()s of git-show-ref by 
a single one.

Ciao,
Dscho
