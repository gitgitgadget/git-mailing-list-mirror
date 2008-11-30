From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Sun, 30 Nov 2008 16:26:19 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>  <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>  <20081128192033.GF23984@spearce.org> 
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>  <alpine.LNX.1.00.0811281938250.19665@iabervon.org>  <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com> <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 22:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6tpZ-0008Iu-Le
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 22:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbYK3V0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 16:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbYK3V0V
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 16:26:21 -0500
Received: from iabervon.org ([66.92.72.58]:40553 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbYK3V0V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 16:26:21 -0500
Received: (qmail 7556 invoked by uid 1000); 30 Nov 2008 21:26:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Nov 2008 21:26:19 -0000
In-Reply-To: <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101985>

On Sun, 30 Nov 2008, Nguyen Thai Ngoc Duy wrote:

> On 11/29/08, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > On 11/29/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >  >  If there's any need for this to be distinguished from "assume unchanged",
> >  >  I think it should be used with, not instead of, the CE_VALID bit; and it
> >  >  could probably use some bit in the stat info section, since we don't need
> >  >  stat info if we know by assumption that the entry is valid.
> >
> >
> > Interesting. I'll think more about this.
> >
> 
> As I said, CE_VALID implies all files are present.

My first question is whether this actually should be true. Going back to 
the message for 5f73076c1a9b4b8dc94f77eac98eb558d25e33c0, it sounds like 
the CE_VALID code is designed to be safe and sort of correct even if the 
files are not actually unchanged; I don't think it would be out-of-spec 
for CE_VALID to (1) always produce output as if the working tree contained 
what the index contains, while (2) refusing to make any changes to working 
tree files that do not actually match the index. As it is now, (2) is 
explicitly true, but (1) is left vague-- commands may fail entirely or 
produce different output if CE_VALID is set in the index for a file that 
has changes in the working tree, but not in any particular way.

Now, it might be necessary for CE_NO_CHECKOUT to differ from CE_VALID in 
some ways in (2): if a file is CE_NO_CHECKOUT and absent, code which would 
modify it could probably just report sucess, while CE_VALID on a file 
with changes should probably report failure. On the other hand, that could 
just as easily be at the porcelain layer, with the porcelain instructing 
the plumbing to change the index without changing the working tree for 
those files outside the sparse checkout, and the plumbing would report 
errors if the porcelain did not do this.

> I could make CE_NO_CHECKOUT to be used with CE_VALID, but I would need 
> to check all CE_VALID code path to make sure the behaviour remains if
> CE_NO_CHECKOUT is absent. It's just more intrusive.

I would expect all code that has a CE_VALID path to do something actually 
wrong if it took the non-CE_VALID code path on CE_NO_CHECKOUT and there 
was no CE_NO_CHECKOUT code path. So I'd expect that your patch is 
insufficient to the extent that CE_NO_CHECKOUT doesn't imply CE_VALID 
(since there is very little in the way of CE_NO_CHECKOUT-specific 
handling in your patch).

The only case I can think of where NO_CHECKOUT is more like !VALID than 
VALID is with respect to whether we can report the content in the index by 
looking in the filesystem instead of in the database; I don't think this 
is an intentional optimization anywhere, and I think it would be a likely 
source of bugs if it were (e.g., it would have to know about files which 
are up-to-date with respect to stat info, but which have been "smudged" on 
disk and therefore don't match byte-for-byte with the database). Actually, 
it might be most accurate to treat --no-checkout as being CE_VALID with a 
smudge filter of "rm". If the combination of CE_VALID and on-disk 
conversion works (which is likely to be the common pattern for Windows 
users, who need autocrlf and have a slow lstat(), and is therefore 
maintained), surely this combination would work for CE_NO_CHECKOUT.

> I have nothing against storing CE_NO_CHECKOUT in stat info except that
> it seems inappropriate/hidden place to do. ce_flags is more obvious
> choice. I haven't looked closely to stat info code in read-cache.c
> though.

It should be pretty clean to check CE_VALID when reading an entry from 
disk and remap bits from it to additional flags in memory. I wouldn't 
suggest overlaying them in memory, but there's also no shortage of space 
for flags in memory.

	-Daniel
*This .sig left intentionally blank*
