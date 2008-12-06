From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Sat, 6 Dec 2008 13:39:18 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>  <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>  <20081128192033.GF23984@spearce.org> 
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>  <alpine.LNX.1.00.0811281938250.19665@iabervon.org>  <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>  <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>  <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 19:40:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9253-0006jg-2e
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 19:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbYLFSjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 13:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYLFSjV
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 13:39:21 -0500
Received: from iabervon.org ([66.92.72.58]:44197 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbYLFSjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 13:39:20 -0500
Received: (qmail 21800 invoked by uid 1000); 6 Dec 2008 18:39:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Dec 2008 18:39:18 -0000
In-Reply-To: <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102467>

On Sun, 7 Dec 2008, Nguyen Thai Ngoc Duy wrote:

> On 12/1/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Sun, 30 Nov 2008, Nguyen Thai Ngoc Duy wrote:
> >
> >  > On 11/29/08, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> >  > > On 11/29/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >  > >  >  If there's any need for this to be distinguished from "assume unchanged",
> >  > >  >  I think it should be used with, not instead of, the CE_VALID bit; and it
> >  > >  >  could probably use some bit in the stat info section, since we don't need
> >  > >  >  stat info if we know by assumption that the entry is valid.
> >  > >
> >  > >
> >  > > Interesting. I'll think more about this.
> >  > >
> >  >
> >  > As I said, CE_VALID implies all files are present.
> >
> >
> > My first question is whether this actually should be true. Going back to
> >  the message for 5f73076c1a9b4b8dc94f77eac98eb558d25e33c0, it sounds like
> >  the CE_VALID code is designed to be safe and sort of correct even if the
> >  files are not actually unchanged; I don't think it would be out-of-spec
> >  for CE_VALID to (1) always produce output as if the working tree contained
> >  what the index contains, while (2) refusing to make any changes to working
> >  tree files that do not actually match the index. As it is now, (2) is
> >  explicitly true, but (1) is left vague-- commands may fail entirely or
> >  produce different output if CE_VALID is set in the index for a file that
> >  has changes in the working tree, but not in any particular way.
> 
> (1) is not always true. For example diff machinary may examine
> worktree files regardless CE_VALID, which is updated for
> CE_NO_CHECKOUT in d9f8fca (Prevent diff machinery from examining
> worktree outside sparse checkout)

I know (1) is not always true in the current implementation. What I'm 
getting at is to ask (a) whether our documented behavior ever violates (1) 
and (b) whether enforcing (1) would be an improvement.

I suspect that enforcing (1) would be less surprising to users in the 
situation where the assumption is false that worktree files match the 
index when CE_VALID is set. As it is, the diff machinery does surprising 
things in this situation, and I think we just say "Nasal Monkey Territory" 
(that is, we tell the user, "if you don't want git to do surprising 
things, don't get into this situation"). If that is the case, we should be 
fine changing it to match your CE_NO_CHECKOUT behavior, and it wouldn't be 
worse for CE_VALID and might be better.

> >  Now, it might be necessary for CE_NO_CHECKOUT to differ from CE_VALID in
> >  some ways in (2): if a file is CE_NO_CHECKOUT and absent, code which would
> >  modify it could probably just report sucess, while CE_VALID on a file
> >  with changes should probably report failure. On the other hand, that could
> >  just as easily be at the porcelain layer, with the porcelain instructing
> >  the plumbing to change the index without changing the working tree for
> >  those files outside the sparse checkout, and the plumbing would report
> >  errors if the porcelain did not do this.
> 
> That's right. Much of work in the last half of the series is on
> porcelain layer. "git grep" fix is the only porcelain that gets fixed
> in this series.

I haven't gotten to reading the last half yet, so I'll avoid taking a 
specific position on how it should work, and just make unsupported 
suggestions.

> >  > I could make CE_NO_CHECKOUT to be used with CE_VALID, but I would need
> >  > to check all CE_VALID code path to make sure the behaviour remains if
> >  > CE_NO_CHECKOUT is absent. It's just more intrusive.
> >
> >
> > I would expect all code that has a CE_VALID path to do something actually
> >  wrong if it took the non-CE_VALID code path on CE_NO_CHECKOUT and there
> >  was no CE_NO_CHECKOUT code path. So I'd expect that your patch is
> >  insufficient to the extent that CE_NO_CHECKOUT doesn't imply CE_VALID
> >  (since there is very little in the way of CE_NO_CHECKOUT-specific
> >  handling in your patch).
> 
> I read the code again. CE_NO_CHECKOUT should follow CE_VALID code path
> (which was extended to CE_VALID_MASK to have both flags). That means
> CE_NO_CHECKOUT is treated as same as CE_VALID. The only difference
> here is CE_VALID is set/unset by "git update-index --really-refresh"
> and core.ingorestat while CE_NO_CHECKOUT has its own way to set/unset.

I think, then, that it would be cleaner to have CE_VALID instead of 
CE_VALID_MASK, and have the things that care test CE_NO_CHECKOUT or 
!CE_NO_CHECKOUT. This wouldn't be all that different, except that it would 
mean that distinguishing them appears as a special case, which in turn 
makes it easier to question whether they should differ.

> There is not much work for CE_NO_CHECKOUT on plumbling level except
> some fixes. The last half of the series, for porcelain level, you will
> see more.

For the porcelain level, do we need the difference to be in the index? If 
the porcelain knows the sparse checkout area and can instruct the plumbing 
appropriately, the information shouldn't need to be stored in the index 
unless it's ever important to remember whether an entry is CE_VALID due to 
having been outside the checkout when the index was written, even though 
the checkout area now includes it. I don't have a good intuition as to 
what ought to happen if the user manually changes what's specified for 
checkout without actually updating the index and working tree.

> >  The only case I can think of where NO_CHECKOUT is more like !VALID than
> >  VALID is with respect to whether we can report the content in the index by
> >  looking in the filesystem instead of in the database; I don't think this
> >  is an intentional optimization anywhere, and I think it would be a likely
> >  source of bugs if it were (e.g., it would have to know about files which
> >  are up-to-date with respect to stat info, but which have been "smudged" on
> >  disk and therefore don't match byte-for-byte with the database).
> 
> There is worktree file reuse in diff code somewhere IIRC. Yes, this
> should be checked.
> 
> >  Actually,
> >  it might be most accurate to treat --no-checkout as being CE_VALID with a
> >  smudge filter of "rm". If the combination of CE_VALID and on-disk
> >  conversion works (which is likely to be the common pattern for Windows
> >  users, who need autocrlf and have a slow lstat(), and is therefore
> >  maintained), surely this combination would work for CE_NO_CHECKOUT.
> 
> Very interesting.
> 
> >  > I have nothing against storing CE_NO_CHECKOUT in stat info except that
> >  > it seems inappropriate/hidden place to do. ce_flags is more obvious
> >  > choice. I haven't looked closely to stat info code in read-cache.c
> >  > though.
> >
> >
> > It should be pretty clean to check CE_VALID when reading an entry from
> >  disk and remap bits from it to additional flags in memory. I wouldn't
> >  suggest overlaying them in memory, but there's also no shortage of space
> >  for flags in memory.
> 
> I see. Still I prefer the current approach, less headache to decide
> what bit to take from stat info ;-)

True. But it would be even easier if it didn't have to be marked in the 
index at all.

	-Daniel
*This .sig left intentionally blank*
