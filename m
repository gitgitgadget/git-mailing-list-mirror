From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 17:34:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512121720150.15597@g5.osdl.org>
References: <1134404990.5928.4.camel@localhost.localdomain>
 <7vmzj6i206.fsf@assigned-by-dhcp.cox.net> <7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
 <7vek4igevq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512121529200.15597@g5.osdl.org>
 <7vlkypdcsb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 02:36:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elz48-0003SJ-Uk
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVLMBeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVLMBeu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:34:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751010AbVLMBet (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 20:34:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBD1YVDZ013590
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Dec 2005 17:34:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBD1YTe6028727;
	Mon, 12 Dec 2005 17:34:29 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkypdcsb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13558>



On Mon, 12 Dec 2005, Junio C Hamano wrote:
> 
> I'll revert the changes anyway, but not because I necessarily
> agree with you two.  I am not 100% confident that the core of
> the diff_delta code would work fine with empty input (it seems
> to from my limited test), and I do not want to break things
> unnecessarily at this point.

Well, I checked the pack-objects.c side, and your patch to diff_delta() 
should not hurt at least there. We already check the size and would have 
broken out long before if either side was zero-sized.

But that's kind of part of the point - any user of diff_delta() is likely 
to have checked the size anyway for other reasons. There's just very 
seldom any valid reason to generate a delta against an empty file, there's 
no interesting information that diff_delta() can really give us.

Basically, the binary diffs that diff-delta returns are interesting for 
just two things:

 - efficient packing, in the pack-objects.c style.

   As mentioned, pack-objects.c needs to check the size heuristics before 
   doing diff_delta() _anyway_, for performance reasons as well as simply 
   because the secondary use of diff_delta() is to estimate how big the 
   delta is, and it's always pointless to generate a delta that is 
   guaranteed to be bigger than the file (which is always the case with 
   either side being an empty file - the size difference will inevitably 
   be bigger than the size of the resulting file).

 - difference size estimation (ie for rename/copy detection)

   This boils down to the same case as the secondary use of pack-objects, 
   ie delta size estimation. Again, if either side is empty, we _know_ 
   that the delta generation is pointless, because the delta is always 
   going to be bigger than the end result, and thus it can't be sensible 
   for rename/copy detection.

So in one sense I actually agree with your patch: it makes the deltifier 
code more generic and actually simplifies the diff_delta() code a bit by 
avoiding one special case, and in that sense it's a good change.

So the reason I disagree with it is that doing the delta is always going 
to be unnecessary work. And regardless of how we're ever going to use the 
delta, we _know_ that it's unnecessary work.

So I think your diffcore-break.c patch is much more appropriate: it also 
fixes the bug, but it fixes it by virtue of realizing that the delta 
cannot matter and thus should never even be computed.

Now, your diff_setup() change may actually be worth it because of the 
simplification, but on the other hand, you can also consider the NULL 
return as being nice because it's effectively a way of saying "the delta 
is meaningless, why did you even ask me?"

			Linus
