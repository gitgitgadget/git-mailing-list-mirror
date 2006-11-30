X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 13:03:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301253380.3513@woody.osdl.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 21:04:25 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Theodore Tso <tytso@mit.edu>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32798>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpt4k-0002me-1F for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936451AbWK3VEG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 16:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936450AbWK3VEG
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:04:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52702 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S936447AbWK3VED (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:04:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUL3KjQ010757
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 13:03:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUL3JCN019276; Thu, 30 Nov
 2006 13:03:19 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Nicolas Pitre wrote:
> 
> Would it make sense for "git add" to do the same as "git update-index" 
> on already tracked files?  Given the explanation above this would make 
> 100% sense to me.

Yeah, I think it would probably make sense. I also think it would make 
sense to rename "update-index" entirely, or at least offer other names for 
it (ie the "git resolved" suggestion).

In short - I agree that it's all just facets of the same thing: telling 
git that some part of the working tree is now in a state ready to be 
committed. Whether it's because we want to "add" content, or just mark it 
as no longer having conflicts, or any other reason.

> But right now, doing "git add" on an already tracked file simply does 
> nothing.  This is even worse than erroring out.

Yeah, that's arguably a stupid thing to do ("you already added it, what do 
you want me to do?") but the choice we use is probably the worst of the 
three straightforward possibilities (ignore, update or error).

The _original_ "git add" was literally just this one-liner:

	#!/bin/sh
	git-update-index --add -- "$@"

which actually was better in this respect (it updated the content), but 
that didn't do sub-directories, so this is arguable a bug introduced by 
commit 37539fbd: 

    [PATCH] Improved "git add"

    This fixes everybodys favourite complaint about "git add", namely that it
    doesn't take directories.

which started using 

	git-ls-files --others -z -- "$@"

together with the exclude files to generate the list of files to add. At 
that point, we lost files that already existed (since "--others" specifies 
just files we don't know about).

