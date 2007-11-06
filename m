From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 08:36:45 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711060812170.15101@woody.linux-foundation.org>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> 
 <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>  <18223.46848.109961.552827@lisa.zopyra.com>
 <3abd05a90711052230y4d6151c6o3e7985a0c8e18161@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 17:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpRQu-0008Dm-Oo
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 17:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbXKFQh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 11:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbXKFQh3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 11:37:29 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57031 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752973AbXKFQh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 11:37:28 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA6Gakff025269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Nov 2007 08:36:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA6GajlL031592;
	Tue, 6 Nov 2007 08:36:45 -0800
In-Reply-To: <3abd05a90711052230y4d6151c6o3e7985a0c8e18161@mail.gmail.com>
X-Spam-Status: No, hits=-2.74 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63684>



On Tue, 6 Nov 2007, Aghiles wrote:
> 
> BitKeeper, for example, does a merge with a "dirty" directory.
> I am not saying that git should behave the same way but I think
> that this argument strengthens the point that it is not a
> "centralized repository" mindset.

Git does merge with a dirty directory too, but refuses to merge if it 
needs to *change* any individual dirty *files*.

And that actually comes from one of the great strengths of git: in git 
(unlike just about any other SCM out there) you can - and are indeed 
expected to - resolve merges sanely in the working tree using normal 
filesystem accesses (ie your basic normal editors and other tools).

That means that if there is a unresolved merge, you're actually expected 
to edit things in the same place where they are dirty. Which means that 
the merge logic doesn't want to mix up your dirty state and whatever 
merged state, because that is then not sanely resolvable.

Now, I do think that we could relax the rule so that "files that are 
modified must be clean in the working tree" could instead become "files 
that actually don't merge _trivially_ must be clean in the working tree". 
But basically, if it's not a trivial merge, then since it's done in the 
working tree, the working tree has to be clean (or the merge would 
overwrite it).

Doing a four-way merge is just going to confuse everybody.

So we *could* probably make unpack-trees.c: treeway_merge() allow this. 
It's not totally trivial, because it requires that the CE_UPDATE be 
replaced with something more ("CE_THREEWAY"): instead of just writing the 
new result, it should do another three-way merge.

So it's within the range of possible, but it's actually pretty subtle. The 
reason: we cannot (and *must*not*!) actually do the three-way merge early. 
We need to do the full tree merge in stage 1, and then only if all files 
are ok can we then check out the new tree. And we currently don't save the 
merge information at all.

So to do this, we'd need to:

 - remove the "verify_uptodate(old, o); invalidate_ce_path(old);" in 
   "merged_entry()", and actually *leave* the index with all three stages 
   intact, but set CE_UPDATE *and* return success.

 - make check_updates() do the three-way merge of "original index, working 
   tree, new merged state" instead of just doing a "unlink_entry() + 
   checkout_entry()".

It doesn't actually look *hard*, but it's definitely subtle enough that 
I'd be nervous about doing it. We're probably talking less than 50 lines 
of actual diffs (this whole code uses good data structures, and we can 
fairly easily represent the problem, and we already have the ability to do 
a three-way merge!), but we're talking some really quite core code and 
stuff that absolutely must not have any chance what-so-ever of ever 
breaking!

To recap:
 - it's probably a fairly simple change to just two well-defined places 
   (merge_entry() and check_updates())
 - but dang, those two places are critical and absolutely must not be 
   screwed up, and while both of those functions are pretty simple, this 
   is some seriously core functionality.

If somebody wants to do it, I'll happily look over the result and test it 
out, but it really needs to be really clean and obvious and rock solid. 
And in the absense of that, I'll take the current safe code that just 
says: don't confuse the merge and make it any more complex than it needs 
to be.

		Linus
