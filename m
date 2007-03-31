From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: SEGV in git-merge recursive:
Date: Fri, 30 Mar 2007 17:35:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
 <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
 <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 31 02:36:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXRZg-0008G0-KI
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 02:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933041AbXCaAgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 20:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933168AbXCaAgF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 20:36:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:57366 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933041AbXCaAgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 20:36:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2V0Zqod016139
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Mar 2007 17:35:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2V0Zpax011990;
	Fri, 30 Mar 2007 17:35:51 -0700
In-Reply-To: <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.462 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43515>



On Fri, 30 Mar 2007, Johannes Schindelin wrote:
> 
> IMHO, there is actually no way merge_trees() can fix the conflicts enough 
> to write a tree.
> 
> So, the only way I see to avoid that SEGV is to something like this:

I disagree.

It's much better to give a bad intermediate tree than to give up entirely.

If you give up entirely, the merge is basically impossible to complete.

If you give a bad intermediate, the merge will just have potentially 
more-than-necessary conflicts in the end.

> +			die ("cannot continue merging.");

This really isn't acceptable. We're not monotone or one of those projects 
that thinks that merging is hard. Merging is *easy*.

We're looking for a base version for a merge - think of a three-way merge 
on a file level. And the easiest base version is actually an empty base 
file (or, when it comes to a rename conflict, no base names at all).

Sure, that will make all changes conflict, but that's a *hell* of a lot 
better than giving up. It just means that now the user has to figure out 
what the end result should be - exactly the same way that if you have an 
empty file as a base version, a three-way merge will basically generate a 
conflict marker that looks like

	<<<<
	one version of the file
	====
	the other version of the file
	>>>>

Rule #1 when merging should *always* be: "never leave the user high and 
dry". You don't give up and say "I can't merge this". You say "I couldn't 
merge this, but here's the mess I left for you to show me how it's done!"

		Linus
