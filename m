From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Rebase, please help
Date: Thu, 12 Apr 2007 14:22:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704121402530.4061@woody.linux-foundation.org>
References: <200704110852.00540.litvinov2004@gmail.com>
 <7v8xczqs1q.fsf@assigned-by-dhcp.cox.net> <200704111110.18461.andyparkins@gmail.com>
 <7v7ishjpm9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Alexander Litvinov <litvinov2004@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc6l9-0005I8-L5
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 23:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbXDLVXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 17:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbXDLVXJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 17:23:09 -0400
Received: from smtp.osdl.org ([65.172.181.24]:60720 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896AbXDLVXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 17:23:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3CLMxIs024683
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 14:22:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3CLMwiM017123;
	Thu, 12 Apr 2007 14:22:58 -0700
In-Reply-To: <7v7ishjpm9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.459 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44352>



On Thu, 12 Apr 2007, Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> >
> > When I was rebasing, some strange things happened (without any conflict 
> > warnings):
> 
> A patch that can ambiguously apply to multiple places is indeed
> a problem, and in such situations merge based rebase is probably
> safer as it can take advantage of the whole file as the context.

Indeed. It's one of the reasons I think the default "patch" behaviour of 
allowing some fuzz in the patch is totally broken, and why "git apply" 
defaults to a much stricter "no context differences allowed" behaviour.

That still doesn't entirely get *rid* of the problem, but it at least 
makes it slightly less common. You can still get a patch that applies 
cleanly if you have certain multi-line patterns that are very common, and 
that end up causing patch to find the wrong place to apply a patch, and 
still make it look right enough.

This is just one reason why patch-based systems are totally and utterly 
broken, and why I detested the original cogito patch-based merging.

The three-way merge behaviour ("git rebase --merge") is a lot safer, but 
it's obviously more expensive too.

Also, the reason a lot of people like patch-based setups is not only is it 
efficient, but it turns out too many people prefer "clean merges" even 
*despite* the dangers. See the recent patches that were floating around on 
"stgit" that actually make applying patches default to the same 
*broken*defaults* as standard "patch" does (see the emails with subject 
line

	"Pass -C1 to git-apply in StGIT ..."

for more on that).

So a lot of people prefer the less strict patch application rules, because 
*most* of the time it actually does the right thing. Never mind that it 
makes a fundamental problem with patches even worse.

Me, I'd prefer to have the patch fail early. But even failing early does 
not _guarantee_ that it applies in the right place. 

> But it brings up another interesting point.  The ambiguous patch
> is a problem even more so outside the context of rebasing, for
> another reason.  When rebasing, you are dealing with your own
> changes and you know what and how you want each of them to
> change the tree state, as opposed to applying somebody else's
> patch outside the context of rebasing.
> 
> When we only have the patch text (i.e. applymbox), there is no
> "merge to use the whole file as the context" fallback.  I wonder
> if this is a common enough problem that we would want to make it
> safer somehow...

We could make "git apply" also refuse to move more than a few lines by 
default (ie not only does the context have to be exact, it has to actually 
show up where the patch claims it should be!)

git-apply still allows arbitrary line offset differences (see 
"find_offset()").

> I can see two possible improvements.
> 
>  - On the diff generation side, we could notice that the hunk
>    we are going to output can be applied to more than one
>    location, and automatically widen the context for it.
> 
>    This is only a half-solution, as many patches do not even
>    come from git.

It's not even a solution _within_ git. Since a patch will always apply at 
the right place if no changes have been done (because we always start 
looking at the line number where the patch fragment _claims_ it should 
go), the problem only occurs when independent changes have been done to 
the target.

And those independent changes may obviously be the ones that *introduce* 
the new location that the patch can (incorrectly) apply to.

>  - Inside git-apply, apply_one_fragment(), ask find_offset() if
>    the hunk can match more than one location, and exit with an
>    error status (still writing out the patch results if it
>    otherwise applies cleanly) so that the user can manually
>    inspect and confirm.

Yes, that might be a good idea, but is going to be pretty expensive. 
"find_offset()" wasn't exactly written to be a model of efficiency. See 
the comment about me not being one of the "smart and beautiful" people.

So you'd want to have some smarter method of finding potential places to 
apply the fragment if you want to do those kinds of things. Like creating 
hashes of the line contents in order to not have to compare the whole 
fragment..

And EVEN THEN it wouldn't actually solve the problem. The most common case 
is simply:
 - somebody *already* fixed the same bug by a very similar patch (or an 
   identical one), and thus the patch obviously won't apply, since the 
   place it *should* apply to got changed.
 - so git-apply will look for another place to apply it, and it's quite 
   possible that there is just one such place - even though it's the exact 
   wrong place!

So it really does boil down to: patches will sometimes falsely apply at 
the wrong place. That's just in the fundamental nature of patches. The 
same way a three-way merge can sometimes generate total crap, even when it 
merged totally cleanly.

It's unusual enough that most of the time it doesn't happen (and I think 
it happens less with three-way merges than with patches), and hopefully 
most of the time the error will be obvious enough that it gets noticed 
quickly (ie the badly patched sources simply won't build any more!).

But there is no practical way to guarantee it cannot happen. The only way 
to guarantee that patches apply correctly is to make sure the source file 
matches *exactly*. But that kind of defeats the whole point of sending 
patches around in the first place.

			Linus
