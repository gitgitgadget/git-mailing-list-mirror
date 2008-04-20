X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 15:29:02 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com> <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org> <20080420215700.GA18626@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 20 Apr 2008 22:30:10 +0000 (UTC)
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
In-Reply-To: <20080420215700.GA18626@bit.office.eurotux.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1Jni3Q-0004dJ-MB for gcvg-git-2@gmane.org; Mon, 21 Apr 2008
 00:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752912AbYDTW3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008
 18:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYDTW3k
 (ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:29:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40553 "EHLO
 smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752742AbYDTW3j (ORCPT <rfc822;git@vger.kernel.org>); Sun, 20 Apr
 2008 18:29:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
 [140.211.169.55]) by smtp1.linux-foundation.org
 (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3KMT3GL031297
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Sun, 20
 Apr 2008 15:29:05 -0700
Received: from localhost (localhost [127.0.0.1]) by
 imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with
 ESMTP id m3KMT25B017609; Sun, 20 Apr 2008 15:29:03 -0700
Sender: git-owner@vger.kernel.org



On Sun, 20 Apr 2008, Luciano Rocha wrote:
> 
> Well, it can be improved. The memcpy can be avoided by using the stored
> data directly, and a _or_die can be added for the common case.

Agreed. I think a big part of the overhead is also the allocation cost, 
and that can probably be obliterated (or at least minimized) by using a 
special and much faster allocator (see "alloc.c") since none of the 
allocations will ever be free'd.

The one thing I liked about your patch was that I think we could be better 
off with wrapping "lstat()" for other reasons - the same way we wrap 
read/write calls in our own "write_in_full()" simplified library 
functions. I hate tracing them, for example, and a wrapper around lstat() 
would have helped my efforts to avoid some of the unnecessary ones.

So I do think your stat cache could be improved, but for the reasons I 
outlined I would much prefer to make it unimportant instead.

I do agree that actually actively removing stat calls requires a lot more 
subtle interactions. We almost always *have* the stat information in the 
index, but the problem with "git status ." is that we re-read the index so 
many times (and then have to re-validate the stat info).

