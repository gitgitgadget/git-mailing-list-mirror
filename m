X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: --objects list inconsistency
Date: Tue, 14 Nov 2006 10:26:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611141020480.3327@woody.osdl.org>
References: <4559E6A9.9A30A236@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 14 Nov 2006 18:27:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4559E6A9.9A30A236@eudaptics.com>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31359>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk2zw-0008RD-6Y for gcvg-git@gmane.org; Tue, 14 Nov
 2006 19:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966252AbWKNS1A (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 13:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966259AbWKNS1A
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 13:27:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39097 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S966252AbWKNS07 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 13:26:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAEIQooZ011913
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 14
 Nov 2006 10:26:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAEIQleI010755; Tue, 14 Nov
 2006 10:26:49 -0800
To: Johannes Sixt <J.Sixt@eudaptics.com>
Sender: git-owner@vger.kernel.org



On Tue, 14 Nov 2006, Johannes Sixt wrote:
> 
> As you can see, without --objects, master^^..master and --max-count=2
> list the same two commits.

"--max-count=X" and "master^^..master" are two TOTALLY different things.

The fact that they happened to give the same results without "--objects" 
is a random thing, and not at all guaranteed. For example, if "master" (or 
its parent) had been a merge, it probably wouldn't have given the same 
result even _without_ "--objects".

> But with --objects I get different object lists. I don't even know which
> one is the one to expect, but I certainly would not have expected the
> lists to be different. What's wrong here?

Nothing is wrong. You're asking for two totally different things.

With "--max-count=2", you're saying "I want the first two commits", and 
then the "--objects" part extends that to all the other object types too.

So you get two commits _and_ every single object reachable from those two 
commits.

In contrast, with "master^^..master", you're saying "I want everything 
that is reachable from "master", but _not_ reachable from it's 
grand-parent. And the "--objects" flag extends that to all the other 
object types too.

So you get (in this case) two commits _and_ all the objects that are 
reachable from those two commits but that are _not_ reachable from the 
grandparent.

That's a totally different thing, obviously. There's likely to be a lot of 
objects in common between "master" and its grandparent, and you literally 
asked to not be shown those objects. In the first case, you didn't ask for 
the exclusion of the grandparent.

So you should expect a big difference in almost all cases. In one case, 
you ask for an exclusion, in the other case, you just say "just the first 
two commits, please". Not at all equivalent.

