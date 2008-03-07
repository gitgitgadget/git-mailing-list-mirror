From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Make unpack_trees() do separate source and destination
 indexes
Date: Fri, 7 Mar 2008 09:46:16 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803070932260.12253@woody.linux-foundation.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org> <7vwsof3x5n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 18:48:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXgfk-0004qT-UQ
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 18:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758042AbYCGRrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 12:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbYCGRrR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 12:47:17 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50522 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758014AbYCGRrQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 12:47:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m27HkhlE025188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Mar 2008 09:46:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m27HkGqV009347;
	Fri, 7 Mar 2008 09:46:17 -0800
In-Reply-To: <7vwsof3x5n.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.965 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76505>



On Thu, 6 Mar 2008, Junio C Hamano wrote:
> 
> What I have been wondering about this series was if we can re-enable
> cache-tree for more of the unpack_trees() users.
> 
> Currently, all unpack_trees() users, other than a single-tree read-tree,
> invalidates the whole cache-tree information, as Daniel's "pop one, decide
> what to put back, all in the original index" had too many manual index
> manipulations and sprinkling cache_tree_invalidate() call everywhere was
> too much cluttering of already hard-to-follow codepath.

It should work as-is, but not optimally.

The reason I say that is that the result-tree won't have any cache tree 
*at*all* with this series, which is a possible peformance poblem (but 
there are performance upsides to the series too, so I'm not sure it's all 
that noticeable). So the "source" index will keep its cache-tree 
unmodified, because it simply never got modified in the first place.

Of course, all _current_ users will have src_index == dst_index (except 
for the "diff_oneway" thing that doesn't have a destination at all, 
because it doesn't actually want any index manipulation), so for all 
current users this is all pure downside: we throw away the good cache_tree 
for the incoming index, and we aren't even able to use it for the result.

But because I envisioned that the people who really *care* will be the 
ones that want to have different incoming and outgoing indexes, I didn't 
actually worry about it. Ie all the "git status" and "git commit" stuff 
would presumably end up using different indexes, and then they can re-use 
the (unmodified) source, and that would generally be the one that they 
actually want.

But I dunno. Maybe we'd actually want to try to re-use the cache_tree from 
the source some way, if we normally actually want it in the destination.

So this series really isn't a final thing, but I do think that in the form 
I posted it, it's a step forward in (a) readability/maintainability and 
(b) flexibility. And I think all the really *core* stuff got converted, 
but now there's a lot of small details hanging around that just don't take 
advantage of the new capabilities.

I basically tried to keep things bug-for-bug compatible. I also didn't try 
to optimize some things that I know I'll want to eventually.

For example, since we now create a new "index_state" entirely, that means 
that we may need to re-hash the cache entries in the name hash, and that 
means that we now allocate a new one *and*copy*it* rather than just re-use 
cache entries directly.

So that's the reason for the new add_entry() function that actually 
allocates a new cache_entry. And it actually has room for various very 
obvious optimizations that I did *not* do:

 - if the cache_entry comes from a tree (common), just re-use it, since it 
   wasn't hashed in the first place
 - if "o->dst_index" is NULL, just don't do anything, because we'll not 
   use the result anyway.
 - if "o->dst_index == o->src_index" and the cache_entry doesn't have 
   CE_HASHED set, just re-use it directly.

adn things like that. So there were a lot of small micro-optimizations 
that I didn't do, because quite frankly, this conversion was really 
painful in the first place (the set of patches I sent out may have 
_looked_ fairly clean, but that's only because I didn't show you the pain 
it was to create them ;)

		Linus
