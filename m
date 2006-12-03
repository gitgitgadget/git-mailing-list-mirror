X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: jgit performance update
Date: Sun, 3 Dec 2006 09:45:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612030938140.3476@woody.osdl.org>
References: <20061203045953.GE26668@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 17:45:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061203045953.GE26668@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33118>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqvP3-0004Nv-VG for gcvg-git@gmane.org; Sun, 03 Dec
 2006 18:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758272AbWLCRpX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 12:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758275AbWLCRpW
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 12:45:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:27578 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758272AbWLCRpV (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 12:45:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB3HjGjQ023737
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 3
 Dec 2006 09:45:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB3HjF4v024496; Sun, 3 Dec
 2006 09:45:16 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Shawn Pearce wrote:
>
> With the help of Robin Rosenberg I've been able to make jgit's log
> operation run (on average) within a few milliseconds of core Git.

Very good. Are we any closer to actually having an eclipse plugin then?

Not that I've ever actually used eclipse, but maybe I should try it, just 
to see what those strange user-land people actually do. I'll be a 
veritable Jane Goodall..

> Walking the 50,000 most recent commits from the Mozilla trunk[1]:
> 
>   $ time git rev-list --max-count=50000 HEAD >/dev/null
> 
>   core Git:  1.882s (average)
>   jgit:      1.932s (average)
> 
>   (times are with hot cache and from repeated executions)

Now, the _interesting_ case in many ways is not "--max-count", but the 
revision limiter. It _should_ be equally fast, but if you've done 
something wrong, it won't be.

IOW, try to find a point far enough back in time to get about the same 
number of commits, and then do

	time git rev-list <thatpoint>..HEAD >/dev/null

because one of the things you want to handle is ranges, more so than 
simple counts. And that is not only the much more common case, it also 
triggers a few cases that you probably didn't trigger with the regular 
"list the first 50 thousand commits" case.

> One of the biggest annoyances has been the fact that although Java
> 1.4 offers a way to mmap a file into the process, the overhead to
> access that data seems to be far higher than just reading the file
> content into a very large byte array, especially if we are going
> to access that file content multiple times.

That must suck for big packed repositories. What JVM and other environment 
are you using?

Also, I have to say, one of the reasons I'm interested in your project is 
that I've never done any Java programming, because quite frankly, I've 
never had any reason what-so-ever to do so. But if there is some simple 
setup, and you have jgit exposed somewhere as a git archive, I'd love to 
take a look, if only to finally learn more about Java.

