X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 23:56:14 -0800
Message-ID: <457A6C1E.4080302@midwinter.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net> <45798FE2.9040502@zytor.com> <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org> <457998C8.3050601@garzik.org> <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 07:56:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33805>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsx4D-0007dN-1B for gcvg-git@gmane.org; Sat, 09 Dec
 2006 08:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761360AbWLIH4N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 02:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761362AbWLIH4N
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 02:56:13 -0500
Received: from tater.midwinter.com ([216.32.86.90]:42432 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1761360AbWLIH4N
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 02:56:13 -0500
Received: (qmail 5565 invoked from network); 9 Dec 2006 07:56:12 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 9 Dec 2006 07:56:12
 -0000
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> Looking at the memcached operations, they have the "read" op (aka "get"), 
> but they seem to have no "read-for-fill" op. So memcached fundamentally 
> doesn't fix this problem, at least without explicit serialization by the 
> client.
>   

Actually, memcached does support an operation that would work for this: 
the "add" request, which creates a new cache entry if and only if the 
key is not already in the cache. If the key is already present, the 
request fails. You can use that to implement a simple named mutex, and 
it supports a client-specified timeout. The one thing it doesn't support 
that you described is a notion of deleting a key when a particular 
client disconnects, but as you say, that should only happen in the case 
of buggy clients anyway.

Mind you, I'm not convinced memcached is necessarily the right answer 
for this problem, but it does provide a way to implement the required 
locking semantics.

BTW, I'm one of the main contributors to memcached, so if it does end up 
looking like a good choice except for some minor issue or another, I may 
be able to tweak it to cover whatever is missing. For example, the 
"delete a key on disconnect" thing would be fairly straightforward, if 
it's actually necessary in practice.

-Steve
