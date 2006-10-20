From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [PATCH 2/2] Remove unused index tracking code.
Date: Thu, 19 Oct 2006 22:27:23 -0400
Message-ID: <20061020022723.GE7162@delft.aura.cs.cmu.edu>
References: <1168a0313ac1152d43731965fbbb6d4ccfd865a1.1161301889.git.jaharkes@cs.cmu.edu> <20061020002048.GC7162@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0610192058130.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 04:27:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gak6r-0005Ht-KT
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 04:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946834AbWJTC1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 22:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946836AbWJTC1b
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 22:27:31 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:10153 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1946834AbWJTC1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 22:27:30 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1Gak6V-0001l0-6V; Thu, 19 Oct 2006 22:27:23 -0400
To: Nicolas Pitre <nico@cam.org>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610192058130.1971@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29401>

On Thu, Oct 19, 2006 at 09:11:10PM -0400, Nicolas Pitre wrote:
> This patch impose an ordering on REF_DELTA objects that doesn't need to 
> exist.  Say for example that an OFS_DELTA depends on an object which is 
> a REF_DELTA object.  With this patch any pack with the base for that 
> REF_DELTA stored after the OFS_DELTA object will be broken.

I don't see where it imposes any ordering.

If we see a complete object it will remain complete. If we find a delta,
and we have the base in the current repository it will be expanded to a
complete object. When we get a delta that doesn't have a base in the
current repository it will remain unresolved and is written out as a
delta.

So the output pack will always contain fewer deltas as the input.

btw. I don't really know what OFS_DELTA and REF_DELTA objects are, I
grepped the source and found no references to either. I can only find
an OBJ_DELTA.

But if any of the deltas depend on an object that is not in the thin
pack, the base has to be available in the current repository and as such
it will be expanded to a full object, replacing the possibly external
delta reference with an internal base object. If the base is not found
in the current repository the base has to be another object in the
original thin pack so we can write out the delta as is.

There is no before or after decision here. We don't look back in the
thin pack, and we don't have to look forward either. So I don't
understand why your example would break or not depending on if the base
object happens to be before or after the OFS_DELTA.

> And to really do thin pack fixing properly we really want to just append 
> missing base objects at the end of the pack which falls in the broken 
> case above.

I guess I'll grep through the mailinglists to try to figure out what
these OFS and REF deltas are and why they behave so differently
depending on their order in the pack.

Jan
