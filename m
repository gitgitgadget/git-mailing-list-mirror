From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 17:44:25 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
 <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
 <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:45:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJIcz-0004RS-1J
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 02:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbXHJApR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 20:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbXHJApR
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 20:45:17 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53537 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752962AbXHJApO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 20:45:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7A0iVNZ002119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 17:44:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7A0iPBD027568;
	Thu, 9 Aug 2007 17:44:25 -0700
In-Reply-To: <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55492>



On Thu, 9 Aug 2007, Junio C Hamano wrote:
> 
> While I do not think the previous one was hacky at all, this one
> IS a hack, not meant for inclusion.


Ugh.

I had some time, so I tried to find out *why* that thing is so slow.

The fact is, "git read-tree -m HEAD" should be really really fast, because 
it should never actually insert multiple entries into the same index 
entry: it should just _replace_ the entry.

But why is it slow?

It doesn't actually replace the entry with "add_cache_entry()" at all. 
What it does is to *remove* the entry entirely at unpack-trees.c, line 
154, unpack_trees_rec(), which does a "remove_cache_entry_at(o->pos);".

That causes us to have to condense the index array, and is one big 
memcpy() for a large index.

It then ADDS THE NEW ENTRY BACK! Which causes *another* expensive index 
array memmove(), as it now needs to make room (at the same location that 
it just compacted).

Sadly, that removal is required for some of the other cases, so it's not 
like we can remove the remove. But we could *possibly* make things 
ridiculously much faster by making the remove a lazy thing, and if the 
next index operation just adds it back in, we wouldn't move things around.

A bit too subtle for my taste.

		Linus
