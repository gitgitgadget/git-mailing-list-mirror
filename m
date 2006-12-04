X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Moving a directory into another fails
Date: Mon, 4 Dec 2006 13:23:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612041317480.3476@woody.osdl.org>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
 <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
 <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
 <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
 <Pine.LNX.4.63.0612042201420.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 21:23:37 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612042201420.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33254>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLHj-00008L-DD for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759496AbWLDVXc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758411AbWLDVXb
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:23:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51467 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753226AbWLDVXa
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 16:23:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB4LNQID013084
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 4
 Dec 2006 13:23:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB4LNPL9004130; Mon, 4 Dec
 2006 13:23:25 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Mon, 4 Dec 2006, Johannes Schindelin wrote:
> 
> The issue was _not_ locale-dependent trees, but file systems which 
> _change_ the encoding.

Correct. However, it doesn't really change the issue: some byte streams 
may simply not work in certain encodings.

You could, of course, basically do some kind of "escape high characters" 
on the filename if it has characters in it that you suspect might cause 
problems, but you'd better make 100% sure that it really is 100% 
reversible (and you need to do all the real operations on the _native_git_ 
version of the filename).

So we _could_ use a flag that says "escape all filenames", but it would 
not be a _locale_ setting, it would really be a per-repository setting, 
and it wouldn't be "iconv", it would be something similar to what we do 
for "git diff" when we escape filenames with strange characters in them.

We could do it by changing ever "open()/creat()" and "[l]stat()" on the 
working tree with somethign that first escapes the filename.

Then, people with broken filesystems could set

	[core]
		escapefilenames = true

and instead of seeing 8-bit filenames, they'd see filenames with 7 bits 
and escapes. They could work with such a repo, for sure. It would be ugly 
as hell, though.

