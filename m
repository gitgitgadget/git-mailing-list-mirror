From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up
 git-cherry
Date: Mon, 2 Jun 2008 16:52:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806021639150.13507@racer.site.net>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>  <alpine.DEB.1.00.0806020649110.13507@racer.site.net> <7f9d599f0806020750g78e6816dl884d36bb903c707b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:54:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3CMs-0000iQ-FO
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbYFBPxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYFBPxs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:53:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:45025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752483AbYFBPxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:53:47 -0400
Received: (qmail invoked by alias); 02 Jun 2008 15:53:45 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 02 Jun 2008 17:53:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WkvIRvGdWvoD1eAmVqpoIfwSwlwO+f60/l+qh4k
	pG/hzBTeF7LLCV
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7f9d599f0806020750g78e6816dl884d36bb903c707b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83537>

Hi,

On Mon, 2 Jun 2008, Geoffrey Irving wrote:

> On Sun, Jun 1, 2008 at 11:13 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sun, 1 Jun 2008, Geoffrey Irving wrote:
> >
> >> See commit d56dbe8cb56ce9b4697d1f1c2425e2e133a932a5 for the original 
> >> code.
> >
> > This is not in any official git.git repository.  And my branches are 
> > prone to be rebased.  So this is not a good reference.  The mailing 
> > list, however, would be one.
>
> That was added only because I knew it wouldn't be the final patch, and 
> that it'd be useful to you.

Ah, then you might want to say "[PATCH/RFC]" in the subject.  I thought 
you meant this for inclusion.

> >> diff --git a/Makefile b/Makefile
> >> index cce5a6e..3a5396d 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -435,6 +435,7 @@ LIB_OBJS += pager.o
> >>  LIB_OBJS += parse-options.o
> >>  LIB_OBJS += patch-delta.o
> >>  LIB_OBJS += patch-ids.o
> >> +LIB_OBJS += patch-id-cache.o
> >
> > If all you do is a hashmap from SHA-1 to SHA-1, then I think
> > "patch-id-cache" is a misnomer for that file and structure.
> >
> > Let's not repeat the same naming mistakes as we have for path_list and
> > decoration.
> 
> Is persistent_sha1_map a good name?

I'd prefer cached_sha1_map, but I do not really care.

> >> +void write_patch_id_cache()
> >> +{
> >> +     if (!cache || cache->count == written_count)
> >> +             return;
> >
> > Does that mean that the patch_id_cache is not updated when the number 
> > of commits stays the same after committing, branch -d and gc?
> 
> The patch_id_cache is only updated when it changes.  Since entries are 
> immutable and are never deleted, all changes increase the count.

Right, I only realized that with my previous post to this thread.  
However, in that case I would prefer a flag "int dirty:1" to the cache 
structure, which is set whenever it needs writing.  Certainly not a global 
variable (which the cache already is).
 
> >> +     hashcpy(entry.commit_sha1, commit_sha1);
> >> +     hashcpy(entry.patch_id_sha1, patch_id_sha1);
> >
> > It would be more elegant to copy the SHA-1s _after_ finding where to 
> > write them.
> 
> Alas, that would break the elegance of my loop, since the loop swaps in 
> new entries to keep the table sorted.  I can remove the sorting if you 
> want: I only left it in there to be more similar to your code.

I think that my code tried to do too much here; it was before I benched 
hashmap vs binary-search.

So I think that can just go and simplify the elegance of the loop even 
more ;-)

> > Declar... ah, well, suffice to say that you should read the 
> > CodingGuidelines, and try to fix up all the offending sites in your 
> > code.
> 
> I'd be happy to do that, but I don't see mention of either C++
> comments or declarations after statements in the CodingGuidelines.

>From the Coding Guidelines:

	As for more concrete guidelines, just imitate the existing code
	(this is a good guideline, no matter which project you are
	contributing to).

> 
> >> +             if (!cmp) {
> >> +                     if (hashcmp(entry.patch_id_sha1, cache->entries[i].patch_id_sha1))
> >> +                             die("found mismatched entry in patch-id-cache");
> >
> > I wonder if that potentially expensive operation should not rather be 
> > wrapped in an assert() call (since I recently learnt that Git's source 
> > code has more than one instance of assert()).
> 
> A 20 byte comparison doesn't seem potentially expensive to me.

It's all a question of repetition, isn't it?

In any case, I am not a fan of wasting cycles unnecessarily.  The check 
would indicate a programming error, not a user error, and should therefore 
punish the programmer, not the user.

> >>  static uint32_t take2(const unsigned char *id)
> >> @@ -136,6 +150,8 @@ int free_patch_ids(struct patch_ids *ids)
> >>               next = patches->next;
> >>               free(patches);
> >>       }
> >> +
> >> +     write_patch_id_cache();
> >>       return 0;
> >
> > That's cute.
> 
> Thanks (assuming cute means good).

Yes, it does!

> I'll wait to actually make any of these changes until you and Jeff 
> decide whether I should stick to hashes or use binary search.  It seems 
> sad not to use hashes for a map when we get the best hash keys in the 
> world for free, so I'd prefer not switching.

Me, too.

BTW I think that you did some awesome work here, and I am glad that you 
could use my code as starting point.

Thanks,
Dscho
