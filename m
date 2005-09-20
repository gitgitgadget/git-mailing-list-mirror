From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make time-based commit filtering work with topological ordering
Date: Tue, 20 Sep 2005 15:50:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509201543140.2553@g5.osdl.org>
References: <Pine.LNX.4.58.0509201358200.2553@g5.osdl.org>
 <7vpsr31ii7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 00:50:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHqwT-0006LM-0r
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 00:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVITWuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 18:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVITWuW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 18:50:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21732 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750710AbVITWuV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 18:50:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8KMo9Bo019926
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 15:50:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8KMo3PM011173;
	Tue, 20 Sep 2005 15:50:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsr31ii7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9025>



On Tue, 20 Sep 2005, Junio C Hamano wrote:
>
> This seems to break t6001 merge-order with max-age test.

Yes. 

Merge-order with ages doesn't make sense. I'd seriously suggest removing
--merge-order entirely, but in the meantime I think you should remove 
anything that tests dates and merge-order.

Merge-order doesn't use the normal limit rules, but does its own home-brew
limiting.  It could do the date-limiting on its own, if it wanted to, but 
I doubt it would make sense.

Try the example I had without my patches:

        [torvalds@g5 git]$ git-rev-list $(git-rev-parse --since="8 days ago" HEAD) | wc
             80      80    3280
        [torvalds@g5 git]$ git-rev-list --topo-order $(git-rev-parse --since="8 days ago" HEAD) | wc
             10      10     410

and I bet the same thing was true for --merge-order. And that's just not 
_sensible_. It doesn't make sense that a time limiter would depend on the 
order, but the way it used to be done it always did so for very 
fundamental reasons.

So the old code was broken. Any test for it was broken too.

		Linus
