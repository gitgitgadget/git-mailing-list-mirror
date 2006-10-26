X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: (unknown)
Date: Thu, 26 Oct 2006 08:35:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610260825040.3962@g5.osdl.org>
References: <E1Gck2K-0003H4-00@dvr.360vision.com> <7v1wowm46j.fsf@assigned-by-dhcp.cox.net>
 <7vwt6okpgr.fsf@assigned-by-dhcp.cox.net> <200610261522.44433.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 15:36:56 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610261522.44433.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30228>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd7HD-00082w-1q for gcvg-git@gmane.org; Thu, 26 Oct
 2006 17:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423563AbWJZPgL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 11:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423575AbWJZPgL
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 11:36:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18821 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1423563AbWJZPgJ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 11:36:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9QFZbPo025966
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 26
 Oct 2006 08:35:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9QFZZJW018570; Thu, 26 Oct
 2006 08:35:36 -0700
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Thu, 26 Oct 2006, Josef Weidendorfer wrote:

> On Thursday 26 October 2006 00:20, Junio C Hamano wrote:
> > Heh, I spoke too fast.
> > 
> > 	"git log origin..master"
> > 
> > If you do not have none of .git/origin
> 
> Really? I thought refs are always looked up in ".git/refs" only?

Yes and no.

The "iterate over all refs" code only ever looks in the "refs" 
subdirectory, so when you _list_ refs, they won't ever be shown unless 
they are there. That affects a lot of programs (like "git ls-remote").

Also, a symlink-ref has to point into "refs/" or it is considered invalid.

But, there are two extra rules:

 - ".git/HEAD" is obviously special, and will show up separately even for 
   things like "git ls-remote", so even processes that _list_ things will 
   show it.

 - when you do a named lookup, stuff directly in ".git" will take 
   precedence over EVERYTHING, even if it is never listed. So for example, 
   if you have a branch named HEAD in .git/refs/heads/HEAD, it doesn't 
   matter. Your ".git/HEAD" will still be looked up first.

   Similarly, other "special heads", like ORIG_HEAD or MERGE_HEAD will be 
   looked up in .git, even though they will never be listed by anything.

So the "refs/" requirement is a real requirement for a "true ref", but it 
is still overruled by the rule that we have special refs in $GIT_DIR that 
always take precedence.

This also means, for example, that you can always give the "full" refname 
for lookup, ie

	git-rev-parse refs/heads/master

works, because that's the "full path" from the ".git" subdirectory. If we 
only ever looked things up inside "refs", you'd have to use 
"heads/master".

