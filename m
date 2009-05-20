From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 10:59:31 -0700
Message-ID: <7vab57zmd8.fsf@alter.siamese.dyndns.org>
References: <4A136C40.6020808@workspacewhiz.com>
	<alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	<20090520032139.GB10212@coredump.intra.peff.net>
	<alpine.LFD.2.00.0905192328310.3906@xanadu.home>
	<025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
	<alpine.LFD.2.00.0905200853010.3906@xanadu.home>
	<20090520141709.GO30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Wincent Colaiuta <win@wincent.com>,
	Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 20 19:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6q4q-00033e-CZ
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 19:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbZETR7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 13:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbZETR7b
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 13:59:31 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34672 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbZETR7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 13:59:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090520175931.MMEK17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 May 2009 13:59:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ttzY1b0054aMwMQ04tzYCn; Wed, 20 May 2009 13:59:32 -0400
X-Authority-Analysis: v=1.0 c=1 a=oAYF_C9AAAAA:8 a=CjNCB-vqXkWgjbxkGs0A:9
 a=GwwwYVjTzBrH3EELYrOUlfEBqlMA:4 a=R0wQ3QzoQ0IA:10
X-CM-Score: 0.00
In-Reply-To: <20090520141709.GO30527@spearce.org> (Shawn O. Pearce's message of "Wed\, 20 May 2009 07\:17\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119623>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> You did say "uncommitted entry causes reflog append", so in Peff's
> original example of "git add a; vi a; git add a", we should be
> creating a reflog entry for that first added state, which is clearly
> not a disagreement.
>
> FWIW, I think this is a great idea, but lack the time to code it
> myself, otherwise I probably would start hacking on it right now.

The devil's in the details.  There are at least four things you would need
to design before start hacking.

 (0) Do you want this to apply only to Porcelains, or do you want to use
     this for plumbing operations as well?

 (1) When would you "auto" write-tree?  When you do "git add" or anything
     that adds new contents to the index?  Or immediately before you do
     something destructive like "git reset"?  Or perhaps both?

 (2) Enumerate the operations that falls into the category you decided in
     the above question.  For example, "git apply --index" and "git apply
     --cached" would fall into the same category as "git add".  If you
     cover plumbing, you would also need to cover "git update-index".

 (3) What should happen when you cannot write the index out as a tree?  I
     think it is easier to make mistakes during a conflicted merge
     resolution than during a straight linear development of your own, and
     one of the cases that would benefit most would be that you have
     resolved a path to your satisfaction but then later you screw up
     while resolving some other paths, losing an earlier resolution.
