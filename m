X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Moving a directory into another fails
Date: Mon, 4 Dec 2006 12:26:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
 <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
 <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
 <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 20:26:59 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33241>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKOq-0007YD-Ir for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937373AbWLDU0t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937376AbWLDU0t
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:26:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41251 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937373AbWLDU0s
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 15:26:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB4KQhID007458
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 4
 Dec 2006 12:26:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB4KQgjO002186; Mon, 4 Dec
 2006 12:26:42 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Mon, 4 Dec 2006, Johannes Schindelin wrote:
> 
> On Mon, 4 Dec 2006, Jakub Narebski wrote:
> 
> > Johannes Schindelin wrote:
> > 
> > > On Mon, 4 Dec 2006, Jakub Narebski wrote:
> > > 
> > >> [...] git should acquire core.filesystemEncoding configuration variable 
> > >> which would encode from filesystem encoding used in working directory 
> > >> and perhaps index to UTF-8 encoding used in repository (in tree objects) 
> > >> and perhaps index.
> > > 
> > > So, you want to pull in all thinkable encodings? Of course, you could rely 
> > > on libiconv, adding yet another dependency to git. (Yes, I know, mailinfo 
> > > uses it already. But I never use mailinfo, so I do not need libiconv.)
> > 
> > A conditional dependency. If you don't have libiconv, this feature wouldn't
> > be available.
> 
> You are speaking as somebody compiling git from source. We are a minority.

You guys are ignoring the _real_ problem. 

It has nothing at all to do with dependencies on external packages. The 
REAL problem is that if you do locale-dependent trees and other git 
objects, git will STOP WORKING.

A filename in a tree object _has_ to be see as a pure 8-bit character 
stream. They _have_ to be compared with "memcmp()", and they have to sort 
the same way and mean EXACTLY the same thing for everybody.

If a filesystem cannot represent that name AS THAT BYTE SEQUENCE then the 
filesystem is broken. No ifs, buts, maybes about it. I'm sorry, but that's 
how it is.

This is _exactly_ the same issue as case independence. Git does not ignore 
case, and it really CANNOT ignore case. Ignoring case would cause horrible 
and deep problems, and it has nothing to do with dependencies on libraries 
(although it _would_ get much much worse from locale settings, and again 
having different locales compare the same name differently because case 
rules are different).

So it really boils down to one one: git saves a byte stream. Not text. 

This is true for all levels of the git archive. It's true for blob 
content, it's true for filenames in trees, and it is true for commits. The 
commit message is actually somewhat easier (because we have nothing to 
"compare" it to afterwards in the checked-out tree), so the commit message 
is the _one_ thing we can kind of play games with, but even there, once 
it's done, it's done, and it's just a stream of bytes.

