X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Moving a directory into another fails
Date: Mon, 4 Dec 2006 12:51:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612041246150.3476@woody.osdl.org>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
 <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
 <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
 <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 20:51:28 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33245>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKmW-0003Rk-9x for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967147AbWLDUvR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967151AbWLDUvR
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:51:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45658 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S967147AbWLDUvQ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 15:51:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB4Kp9ID009980
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 4
 Dec 2006 12:51:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB4Kp8D2003044; Mon, 4 Dec
 2006 12:51:09 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Mon, 4 Dec 2006, Linus Torvalds wrote:
> 
> If a filesystem cannot represent that name AS THAT BYTE SEQUENCE then the 
> filesystem is broken. No ifs, buts, maybes about it. I'm sorry, but that's 
> how it is.

Btw, what this means in practice is that when git creates a file with a 
certain sequence of bytes, then 
 (a) readdir had better return _that_ sequence of bytes, or git will see 
     it as somethign else.
 (b) opening it with that same sequence of bytes had better work.

This does not mean that a filesystem may not internally use some other 
encoding. It just means that if the filesystem - when converting back and 
forth between the internal encoding and the one it shows to user space - 
had better convert back to the exact same thing.

Also, note that for most projects, even a broken filesystem doesn't 
actually matter - it's enough that the filesystem gets the conversions 
right for the particular set of names in a particular project. So any 
project that just has 7-bit filenames will obviously never even see any 
issues at all, even if the filesystem it runs on then does something 
strange with 8-bit filenames.

This is one reason why UNIX's "everything is a stream of bytes" is so 
important, and whyprograms should generally work with byte streams, not 
"wide strings" or similar. It's the only way that you can reliably work 
across different locales. Use wide strings and locale-specific stuff 
_only_ for actually showing users something on the tty, for example.

