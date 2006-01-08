From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 11:56:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601081141450.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
 <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 20:57:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvgfW-0002mg-Rp
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 20:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWAHT5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 14:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWAHT5a
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 14:57:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932754AbWAHT52 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 14:57:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k08JuNDZ026868
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Jan 2006 11:56:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k08JuM3K001401;
	Sun, 8 Jan 2006 11:56:22 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14330>



On Mon, 9 Jan 2006, Martin Langhoff wrote:
> 
> I think it does. All the tricky stuff that David and Junio have been
> discussing is actually done very transparently by
> 
>     git-rebase <upstream>

Yes, it's fairly easy to do. That said, I would actually discourage it. I 
haven't said anything to David, because he is obviously very comfy with 
the git usage, and it _does_ result in cleaner trees, so especially since 
the networking code ends up being the source of a lot of changes, the 
extra cleanup stage that David does might actually be worth it for that 
case.

But git is actually designed to have parallel development, and what David 
does is to basically artificially linearize it. We merge between us often 
enough that it doesn't really end up losing any historical information 
(since David can't linearize the stuff that we already merged), but in 
_theory_ what David does actually does remove the historical context.

So "git-rebase" is a tool that is designed to allow maintainers to (as the 
command says) rebase their own development and re-linearize it, so that 
they don't see the real history. It's basically the reverse of what Len is 
doing - Len mixes up his history with other peoples history in order to 
keep them in sync, while David bassically "re-does" his history to be on 
top of mine (to keep it _separate_).

The "git-rebase" means that David will always see the development he has 
done/merged as being "on top" of whatever my most recent tree is. It's 
actually a bit scary, because if something goes wrong when David re-bases 
things, he'll have to clean things up by hand, and git won't help him 
much, but hey, it works for him because (a) things seldom go wrong and (b) 
he appears so comfortable with the tool that he _can_ fix things up when 
they do go wrong.

And yes, git-rebase can be very convenient. It has some problems too 
(which is the other reason I don't try to convince other maintainers to 
use it): because it re-writes history, a change that _might_ have worked 
in its original place in history might no longer work after a rebase if it 
depended on something subtle that used to be true but no longer is in the 
new place that it has been rebased to.

Which just means that a commit that was tested and found to be working 
might suddenly not work any more, which can be very surprising ("But I 
didn't change anything!").

On the other hand, this is no different from doing a merge of two 
independent streams of development, and getting a new bug that didn't 
exist in either of the two, just because they changed the assumptions of 
each other (ie not a _mismerge_, but simply two developers changing 
something that the other depended on it, and the bug only appears when 
both the working trees are merged and the end result no longer works).

So my suggested git usage is to _not_ play games. Neither do too-frequent
merges _nor_ play games with git-rebase.

That said, git-rebase (and associated tools like "git-cherry-pick" etc) 
can be a very powerful tool, especially if you've screwed something up, 
and want to clean things up. Re-doing history because you realized that a 
you did something stupid that you don't want to admit to anybody else.

So trying out git-rebase and git-cherry-pick just in case you decide to 
want to use them might be worthwhile. Making it part of your daily routine 
like David has done? Somewhat questionable, but hey, it seems to be 
working for David, and it does make some things much easier, so..

			Linus
