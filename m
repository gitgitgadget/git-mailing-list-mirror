From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Tue, 8 Nov 2005 15:05:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 00:08:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZcY3-0001WG-M9
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 00:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVKHXGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 18:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbVKHXGN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 18:06:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030398AbVKHXGK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 18:06:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA8N60nO030982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 8 Nov 2005 15:06:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA8N5hXj025628;
	Tue, 8 Nov 2005 15:05:51 -0800
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051108223609.GA4805@c165.ib.student.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11366>



On Tue, 8 Nov 2005, Fredrik Kuivinen wrote:
> 
> The problem is in the multiple-common-ancestors case. If we have three
> common ancestors, A, B and C, we will start with merging A with B. The
> result is a new 'virtual' commit object (not stored in the object
> database), lets call it V. We are then going to merge V with C. To do
> that we need to get the common ancestor(s) of V and C, and as V
> doesn't exist in the database we can't use git-merge-base.

Hmm. That's really the same as the merge-base of "C _and_ (A _or_ B)", 
isn't it?

So we should be able to do that even without ever seeing the virtual 
merge. In fact, it really is pretty trivial from a technical standpoint: 
the "A _or_ B" part is really just inserting both A and B with the same 
"flags" value (see the "merge_base()" function in merge-base.c).

So in general, "merge-base" could trivially be extended to have any number 
of "OR commits" on either side, as long as there is just one "and".

It could also be extended to have multiple "and" cases, but that has 
actually already been done by "git-show-branch", I think. It's all the 
same logic, except it uses more than just two bits.

So _technically_ it should be easy to do, it would just need some sane 
command line syntax to specify the grouping.

> I haven't given it a lot of thought though, it might be possible to
> use git-merge-base in some way and get the same results as we get now.
> 
> It would certainly be possible to use git-merge-base in the first
> iteration and use the python code only when we actually have any
> 'virtual' commit objects.

Just handling the first case specially would be sufficient for 99% of all 
uses.  And if the multi-parent cases are slightly slower, I don't think 
anybody cares.

In fact, we _always_ do the first git-merge-base in git-merge.sh anyway 
(actually, not git-merge-base, but "git-show-branch --merge-base"). So 
that's really done already for the "test if it's trivial" case..

Junio, that points out that "git-merge-base" is another program that could 
just be removed, since it's really supreceded by git-show-branch. Or did I 
miss something?


			Linus
