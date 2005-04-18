From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] "checkout-cache -m" writes unmerged contents for each
 stage.
Date: Sun, 17 Apr 2005 20:05:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171957210.7211@ppc970.osdl.org>
References: <7v1x99vwdg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504171833450.7211@ppc970.osdl.org> <7vk6n0vnbq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:59:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNMU8-00042Z-MR
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVDRDDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 23:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVDRDDe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 23:03:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:32232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbVDRDDa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 23:03:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3I33Js4010394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 20:03:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3I33IPB021539;
	Sun, 17 Apr 2005 20:03:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6n0vnbq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Junio C Hamano wrote:
> 
> LT> What do you think? I can whip up a "merge-cache" program like that in five 
> LT> minutes, and it _seems_ like the right interface..
> 
> Yes.  I think that is the right thing to do.  In fact the idea
> is quite similar to what I've been working on, which is a
> rewrite of that perl thing to use "read-tree -m O A B".

I pushed the thing out. It was indeed pretty trivial.

Just as an example, on your merge-test, I can then do

	merge-cache echo -a

and the output is

	 .merge_file_Raanu4 .merge_file_q7ZoLY AA
	 .merge_file_zMXLAW .merge_file_SOugrU AN
	.merge_file_tWf5zS   DD
	.merge_file_YmGzgR   DM
	.merge_file_N1M8oO   DN
	.merge_file_eAC5WL .merge_file_ROg7mM  MD
	.merge_file_G1AWSM .merge_file_LMCruN .merge_file_ucVx7N MM
	  .merge_file_3YxD2O NA
	.merge_file_2SJa6P .merge_file_3V5g6Q  ND
	.merge_file_SIo4nQ   S/DD
	.merge_file_dO8AOP   S/DM
	.merge_file_wOO6iP   S/DN
	.merge_file_RrgnYR .merge_file_KQxqHU  S/MD
	.merge_file_F0sQRX .merge_file_E4DC00 .merge_file_HQkyn2 S/MM
	.merge_file_od0mf4 .merge_file_Xvv035  S/ND
	.merge_file_oEtq17 .merge_file_TwkT5c .merge_file_aqx58h Trivial

(Note that the spaces signify an empty argument in those places, since the
file in question didn't always exist). It executed the "echo" thing 16 
times (once for each object that your script-from-hell had caused a clash 
with).

In all cases you have $1 being "original", $2 being "branch 1", $3 being
"branch 2", and $4 being "name in cache".

ALERT ALERT ALERT! The git "merge object order" is different from the 
"merge" program merge object order. In the above ordering, the original is 
first. But the argument order to the 3-way merge program "merge" is to 
have the original in the middle. Don't ask me why.

Anyway, another example:

	torvalds@ppc970:~/merge-test> merge-cache cat MM
	This is MM from the original tree.			# original
	This is modified MM in the branch A.			# merge1
	This is modified MM in the branch B.			# merge2
	This is modified MM in the branch B.			# current contents

or 

	torvalds@ppc970:~/merge-test> merge-cache cat AA MM
	cat: : No such file or directory
	This is added AA in the branch A.
	This is added AA in the branch B.
	This is added AA in the branch B.
	fatal: merge program failed

where the latter example shows how "merge-cache" will stop trying to merge 
once anything has returned an error (ie "cat" returned an error for the AA 
file, because it didn't exist in the original, and thus "merge-cache" 
didn't even try to merge the MM thing).

		Linus
