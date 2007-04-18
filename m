From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 11:45:56 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
References: <11768880622402-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0704181247410.12094@racer.site> <20070418153445.GC12888@admingilde.org>
 <alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
 <7vslaxhamd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:46:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeFAc-0004ZC-1q
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993005AbXDRSqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993018AbXDRSqT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:46:19 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41965 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993005AbXDRSqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 14:46:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IIjxYC024167
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 11:45:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IIjuaj032514;
	Wed, 18 Apr 2007 11:45:57 -0700
In-Reply-To: <7vslaxhamd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.966 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44929>



On Wed, 18 Apr 2007, Junio C Hamano wrote:
> 
> While I agree with all of the above, I am currently fighting
> with a back-to-drawing-board design problem.
> 
> The series made the low-level 3-way merge machinery
> customizable, which is a progress, but I think merge-recursive
> needs a hook to affect middle-level merge decision, similar to
> what git-merge-one-file does.

Hmm. I think that it's not so much a "hook", as a "recursive merge is a 
separate merge policy altogether, that just *defaults* to the same final 
merge policy".

For example, for a three-way merge, it makes sense to do the three-way 
merge for the "internal" merge too. But it might be that that isn't true 
for all strategies. For a "blend" merge, blending at the middle level 
might be the wrong thing to do because it might duplicate the messages, 
for example.

So maybe the rule could be:

 - for a file with merge strategy "xyzzy", a recursive merge will first 
   look up the merge machinery for "xyzzy-recursive" and if no such merge 
   strategy exists, it will look up merge machinery for "xyzzy".
 - the final merge will always use merge strategy "xyzzy".

So then, assuming I'm right that the "blend" strategy needs soemthing else 
in the middle (and I'm not sure I'm right at all, this is purely 
hypothetical ;), you could have something like

	# a recursive merge will always just pick the ORIGINAL
	# version of a file when blending - the blending will
	# be done only on the final merge
	[merge "blend-recursive"]
		name = recursive blend strategy
		driver = cp %O %A

	[merge "blend"]
		name = blend (changelog) strategy
		driver = blend %A %O %B

or something like that?

I _suspect_ that most merge strategies want to use the same strategy for 
the recursive merge as for the final one, but I haven't really thought it 
through.

		Linus
