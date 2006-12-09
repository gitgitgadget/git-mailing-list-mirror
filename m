X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 16:45:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612081640400.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
 <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org>
 <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>
 <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>
 <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
 <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>
 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
 <45798FE2.9040502@zytor.com> <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
 <457998C8.3050601@garzik.org> <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
 <4579FABC.5070509@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 9 Dec 2006 00:46:20 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4579FABC.5070509@garzik.org>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33779>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsqM6-000507-CA for gcvg-git@gmane.org; Sat, 09 Dec
 2006 01:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947608AbWLIAqL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 19:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947607AbWLIAqK
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 19:46:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58145 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947603AbWLIAqJ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 19:46:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB90jHID013872
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 8
 Dec 2006 16:45:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB90jGhQ011445; Fri, 8 Dec
 2006 16:45:16 -0800
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org



On Fri, 8 Dec 2006, Jeff Garzik wrote:
>
> This is a bit cheesy, and completely untested, but since mod_cache never
> worked for me either, I bet it works better ;-)

Ok, this doesn't do the locking either, so on cache misses or expiry, 
you're still going to be that thundering herd.

Also, if you want to be nice to clients, I'd seriously suggest that when 
you hit in the cache, but it's expired (or it's close to expired), you 
still serve the cached data back, but you set up a thread in the 
background (with some maximum number of active threads, of course!) that 
refreshes the cached entry and then you extend the expiration time so that 
you won't end up doing this "refresh" _again_.

It's kind of silly to have people wait for 20 seconds just because a cache 
expired five seconds ago. Much nicer to say "ok, we allow a certain 
grace-period during which we'll do the real lookup, but to make things 
_look_ really responsive, we still use the old cached value".

