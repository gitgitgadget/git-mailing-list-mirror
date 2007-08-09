From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 14:41:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Thu Aug 09 23:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJFmA-0006JK-Ar
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 23:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbXHIVmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 17:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbXHIVmb
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 17:42:31 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33856 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751470AbXHIVma (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 17:42:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79Lff2C027780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 14:41:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79LfYg0020979;
	Thu, 9 Aug 2007 14:41:34 -0700
In-Reply-To: <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55478>



On Thu, 9 Aug 2007, Sean wrote:
> 
> This makes things _much_ better, however the final commit in the 
> test script still shows a lot of user time:
> 
> ## time git commit -q -m 'buurrrrn' -a
> real    0m2.299s
> user    0m1.065s
> sys     0m1.317s
>
> ## time git commit -q -m 'hurry' 50/500
> real    0m16.944s
> user    0m15.466s
> sys     0m1.133s

In the case where we do a partial commit (never mind that it's all the 
changes: when you give a path limiter, it's "partial"), "git commit" one 
goes through another path, and triggers the same issue with

	git read-tree --index-output=tmp-index -i -m HEAD

which has the same O(n**2) issue (except it uses "unpack_trees()" rather 
than "read_tree()", so Junio's patch does nothing for it).

So "builtin-read-tree.c" (or rather unpack-trees.c) would need the same 
kind of logic.

		Linus
