X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 7 Dec 2006 11:05:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
References: <45708A56.3040508@drzeus.cx> <Pine.LNX.4.64.0612011639240.3695@woody.osdl.org>
 <457151A0.8090203@drzeus.cx> <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
 <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org>
 <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>
 <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>
 <45785697.1060001@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 19:08:14 +0000 (UTC)
Cc: Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45785697.1060001@zytor.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33604>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsObD-00031x-KC for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163199AbWLGTH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163209AbWLGTH7
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:07:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57138 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1163199AbWLGTH6
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 14:07:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB7J60ID010398
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 7
 Dec 2006 11:06:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB7J5xKT021872; Thu, 7 Dec
 2006 11:05:59 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org



On Thu, 7 Dec 2006, H. Peter Anvin wrote:
> 
> That all being said, the lack of intrinsic caching in gitweb continues to be a
> major problem for us.  Under high load, it makes all the problems worse.

I really don't see what gitweb could do that would be somehow better than 
apache doing the caching in front of it.. Is there some apache reason why 
that isn't sufficient (ie limitations on its cache size or timeouts?)

Maybe the cacheability hints from gitweb could be tweaked (a lot of it 
should be "infinitely cacheable", but the stuff that depends on refs and 
thus can change, could be set to some fixed host-wide value - preferably 
some that depends on how old the ref is).

Having gitweb be potentially up to an hour out of date is better than 
causing mirroring problems due to excessive load.

For example, if the git "refs/heads/" (or tags) directory hasn't changed 
in the last two months, we should probably set any ref-relative gitweb 
pages to have a caching timeout of a day or two. In contrast, if it's 
changed in the last hour, maybe we should only cache it for five minutes.

Jakub: any way to make gitweb set the "expires" fields _much_ more 
aggressively. I think we should at least have the ability to set a basic 
rules like

 - a _minimum_ of five minutes regardless of anything else

   We might even tweak this based on loadaverage, and it might be 
   worthwhile to add a randomization, to make sure that you don't get into 
   situations where everything webpage needs to be recalculated at once.

 - if refs/ directories are old, raise the minimum by the age of the refs

   If it's more than an hour old, raise it to ten minutes. If it's more 
   than a day, raise it to an hour. If it's more than a month old, raise 
   it to a day. And if it's more than half a year, it's some historical 
   archive like linux-history, and should probably default to a week or 
   more.

 - infinite for stuff that isn't ref-related.

Hmm?

