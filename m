From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Mon, 3 Jul 2006 10:05:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607030957420.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060701232958.GC2513@lsrfire.ath.cx> <7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 19:06:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxRsE-0003Cz-NO
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 19:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWGCRGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 13:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWGCRGK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 13:06:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751168AbWGCRGJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 13:06:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k63H5xnW015687
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 10:06:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k63H5sFT025484;
	Mon, 3 Jul 2006 10:05:57 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23190>



On Mon, 3 Jul 2006, Johannes Schindelin wrote:
> 
> On Mon, 3 Jul 2006, Junio C Hamano wrote:
> 
> > Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> > 
> > > Don't care if objects have been parsed or not and don't stop when we
> > > reach a commit that is already clean -- its parents could be dirty.
> > 
> > There is something quite wrong with this patch.
> 
> I always had the feeling that it was wrong to traverse not-yet-parsed 
> parents: How could a revision walk possibly come to a certain commit 
> without at least one continuous history of now-parsed objects?

No, that's not the problem.

The problem is that if we unconditionally traverse parents - whether 
parsed or not - any merge will basically result in a 2* expansion of the 
working set: we'll traverse all children twice (whether they meet again or 
not).

So the cost of doign unconditional traversals of parents basically 
approaches 2^n, where 'n' is the number of merges.

Now, the fact that we only traverse parents without adding new ones (and 
the decision on whether it is parsed or not is irrelevant - the only 
relevant part being that we don't parse any _new_ ones) means that each 
commit itself is very cheap to traverse, but O(2^n) ends up meaning that 
even a small constant will eventually be pretty big.

The proper fix is _not_ to add the "object->parsed" check (which is silly, 
wrong, and doesn't fix anything at all), but to add a check for whether 
the object has been seen or not.

In the case of clearing flags, you have two choices:

 - _set_ a new flag ("already cleared"). This would work - once - but is 
   obviously pretty bad.

   This is what we do in all the other cases. We usually call the flag 
   SEEN or similar.

 - depend on the flags being "dense", and saying that we depend on the 
   fact that in order for any of the flags to have been set in the first 
   place, at least _one_ of them needs to be set in the path leading up to 
   that commit.

Now, for the specific case of get_merge_bases(), the flags _are_ dense. 
Individual flags may not be (eg the "UNINTERESTING" flag, whatever it's 
called, will not be dense), but the question of "is _any_ of the flags we 
care about set" _will_ be dense.

As such, adding a

	/* Have we already cleared this? */
	if (!(mask & object->flags))
		return;
	object->flags &= ~mask;

to the traversal function will fix the O(m+2^n) behaviour, and turn the 
traversal into O(m+n) (where "n" is the number of merges, and "m" is the 
total number of commits).

		Linus
