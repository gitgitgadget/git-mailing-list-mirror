From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 6 Sep 2009 13:42:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909061338350.8946@localhost.localdomain>
References: <4AA17874.7090905@debian.org> <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com> <7vab191dz1.fsf@alter.siamese.dyndns.org> <7vzl98vrmt.fsf@alter.siamese.dyndns.org> <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain> <7v3a6z3lsg.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain> <7vws4bzu7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 22:42:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkOZJ-0000of-Lb
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 22:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758694AbZIFUm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 16:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758692AbZIFUm0
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 16:42:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49295 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758691AbZIFUmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2009 16:42:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86KgOSQ016011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Sep 2009 13:42:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86KgOkP018658;
	Sun, 6 Sep 2009 13:42:24 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vws4bzu7w.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127868>



On Sun, 6 Sep 2009, Junio C Hamano wrote:
> 
> The reason I brought up adding the "candidate for the earliest name"
> interface to the function was to avoid a case where the index has
> 
>     blob "t"
>     blob "t-f"
> 
> and all the trees being merged have
> 
>     blob "t-f"
>     tree "t"
> 
> in which case the "Are we supposed to look at the index too?" logic in
> unpack_callback() may not catch the "t-f" entry from the index when the
> first callback from traverse_trees() feeds it "t-f".

I agree. It's why I initially wanted to do it _all_ in the 
unpack_callback() thing, but the more I tried, the more complex it got.

So now my plan is to do the conflict handling at a tree level in 
traverse_trees(), and get rid of the use of 'df_name_compare()' just there 
first. 

The index case is slightly easier, as we can go back-and-forth in the 
source index (we do try to avoid it right now, but that's a small 
optimization rather than anything fundamental), so the index we can 
traverse in a more flexible manner, and find the 't' conflict that way.

		Linus
