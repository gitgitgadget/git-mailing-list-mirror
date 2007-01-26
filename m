From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Seriously broken "git pack-refs"
Date: Thu, 25 Jan 2007 22:24:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701252218540.25027@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701251636060.25027@woody.linux-foundation.org>
 <7v7iva4glo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701252202130.25027@woody.linux-foundation.org>
 <7vireu2uc6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 07:24:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAKVu-0008HJ-VW
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 07:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030788AbXAZGYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 01:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030789AbXAZGYk
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 01:24:40 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47970 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030788AbXAZGYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 01:24:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0Q6OagP024080
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 Jan 2007 22:24:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0Q6OZjx009315;
	Thu, 25 Jan 2007 22:24:35 -0800
In-Reply-To: <7vireu2uc6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.597 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37806>



On Thu, 25 Jan 2007, Junio C Hamano wrote:
> 
> On the other hand, I do not think it is worth unpacking non-tags
> that are packed when --all is not given, so...

Exactly. 

I'd much rather have

	git pack-refs --all --prune

just pack everything once and for all. Afterwards, if you do just

	git pack-refs

it will keep everything that was packed packed, and any loose refs (which 
might be loose because they are new, but perhaps because they simply got 
overridden by being changed) will not be added to the pack unless they are 
tags.

Which should be the semantics with my patch applied. 

The above actually makes tons of sense: operations like big imports (or 
clones) might want to start out with *everything* packed, but then as we 
update, commit and modify, what we actually want to do is to basically let 
the branches that are actively developed "become unpacked" as they are 
updated.

So the "repack refs that were already packed, or refs that are tags" is 
actually a very sane default. It's not just that we don't want to lose the 
refs entirely, it's also that what we actually want to do by default is to 
pack the stuff we have reason to believe won't be actively changing. 

Tags automatically fall under that heading (which is why it makes sense to 
pack them by default in the first place!) but so does any ref that was 
already packed, and hadn't become unpacked since the last repack. By 
definition, such a ref isn't "actively changing" even if it isn't a tag.

No?

		Linus
