From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 16:57:44 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707231638020.3607@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
 <20070719105105.GA4929@moonlight.home> <86zm1sbpeh.fsf@lola.quinscape.zz>
 <20070719123214.GB4929@moonlight.home> <863azka7d4.fsf@lola.quinscape.zz>
 <87ps2inab5.fsf@hades.wkstn.nix> <85y7h6dewp.fsf@lola.goethe.zz>
 <87lkd6n62i.fsf@hades.wkstn.nix> <85k5sqdavo.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707231527050.3607@woody.linux-foundation.org>
 <873azen1c7.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID7n7-00012v-I4
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 01:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbXGWX6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 19:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbXGWX6O
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 19:58:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39658 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750704AbXGWX6N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 19:58:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NNvowh030122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 16:57:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NNvi64018651;
	Mon, 23 Jul 2007 16:57:44 -0700
In-Reply-To: <873azen1c7.fsf@hades.wkstn.nix>
X-Spam-Status: No, hits=-3.224 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53509>



On Tue, 24 Jul 2007, Nix wrote:
>
> On 23 Jul 2007, Linus Torvalds spake thusly:
> > So practically speaking, you want to track the *minimal* possible state, 
> > not the maximal one. 
> 
> I think it depends on your use case. For source code and indeed anything
> with heavy merges, this is true

Yes, very obviously. Git is targeted towards source code and working in a 
distributed manner across a very wide variety of users and setups, while 
something that would be more targeted towards a special scenario and much 
stricter usage would find that the "minimum" set is much bigger, and might 
well include ACL's and usr information.

> but I'm increasingly using git as a sort of `merged historical tar' to 
> store images of entire random filesystem trees across time, and gaining 
> the benefit of the packer's lovely space-efficiency as well (doing this 
> with svn would be a lost cause, twice the space usage before you even 
> think about the repository). And in that case, preserving everything you 
> can makes sense.

On the other hand, almost all the space-efficiency comes from things that 
delta well, and change quickly. That includes the file data itself (and 
very much the tree contents), but it doesn't necessarily include things 
like permissions and user information - mainly because that doesn't 
actually delta at all (not because it can't, but because it hardly ever 
changes, and when it does change, it often changes all over the map).

To make an example of your "tar" situation: if you want to be space- 
efficient in a tar-like setting, you should *not* make user information be 
something that is per-file at all! Why? Because in 99% of all tar-files, 
there is a single user name.

So even your usage *may* actually be much better off using git as a "data 
backend", and using something totally different for "user/group" 
information. Yes, you'd have to make a "shim layer" on top of git to hide 
the fact that the user information is handled separately, but that 
shouldn't be that hard per se.

> (Perhaps what I should be doing is tarring the directory tree up and
> storing the *tarball* in git. I'll try that and see what it does to pack
> sizes. These are version-controlled backups of my mother's magnum opus
> in progress so you can understand that I don't want to destroy them
> accidentally: I'd never hear the end of it! ;) )

You don't want to do this. 

There's a few reasons, but the two big ones are:

 - the git delta logic is strictly a "single delta base" thing.

   Yes, git would be able to find the delta's between two tar-files (as 
   long as you don't compress them), and express one tar-file in terms of 
   the other, and it would probably save a fair amount of disk.

   But it would not be able to do _nearly_ as well as it can if you store 
   individual files, and let git just find the best delta per-file (and 
   not just "one delta base for the whole tar-ball")

 - git is very much optimized for "many small files". Yes, you can check 
   in large files, and it works fine, but quite frankly, all the design 
   and heavy optimizations have been about having trees with tens of 
   thousands of files, but the files individually reasonably small.

   A lot of the speed advantages of git come from efficiently pruning away 
   whole sub-directory structures, for example, and not even touching the 
   data at all!

   So if you track just one file that changes in every version, all the 
   things that make git fly are basically disabled, and you won't take 
   full advantage of what git does.

> Yes indeed: that's why I proposed doing this using a couple of new hooks
> driving entirely optional permissions-preservation stuff. Most use cases
> really won't want to track this, so this sort of stuff shouldn't impose
> upon the git core or upon anyone who doesn't want it. (However, the
> ability to have alternative file merging strategies *may* be useful
> elsewhere, perhaps.)

The ".gitattributes" file really could be used for some of that. Using it 
to track ownership and full permissions would not be impossible, and it 
could have interesting semantics (especially as .gitattibutes is path 
pattern based - so you could literally do a "user" attribute, and say that 
everything in a particular subdirectory is owned by a particular user).

That wouldn't be UNIX-like semantics, of course, but it can be very useful 
for certain things. 

Taking an example of something totally independent of git, look at how 
"udev" handles permissions, for example. In situations like that, static 
user information is useless, and it actually ends up setting up modes and 
ownership based on name-based patterns rather than having each file have a 
permission/user (because individual files appear and disappear, the 
name-based patterns are the things that matter).

So if you *just* want to track a regular filesystem layout, that's not the 
right thing, but "udev" does show an example of a totally different way of 
describing ownership and permissions, and one which wouldn't actually be 
at all foreign to git.

		Linus
