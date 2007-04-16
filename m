From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Mon, 16 Apr 2007 08:58:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704160814300.5473@woody.linux-foundation.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
 <200704152051.35639.andyparkins@gmail.com> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
 <200704161003.07679.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:58:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTb4-0004Mx-2A
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 17:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030788AbXDPP6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 11:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030792AbXDPP6Z
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 11:58:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:39505 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030788AbXDPP6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 11:58:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GFwIIs025632
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 08:58:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GFwHco006175;
	Mon, 16 Apr 2007 08:58:17 -0700
In-Reply-To: <200704161003.07679.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.451 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44654>



On Mon, 16 Apr 2007, Andy Parkins wrote:
> 
> It's not an accurate analogy at all.  Your conclusion is your supposition - 
> it's stupid because it's stupid.  I don't understand what the huge problems 
> are - all you've done is say again that it's a problem to have keyword 
> expansion.  Why?  What problem does it actually cause?

The easiest way to explain it is that keyword expansion is like crlf, just 
a million times worse (but if you were to do it in git, you'd literally 
do it in the same path that does crlf expansion).

Like crlf:
 - it requires you to be careful about binary vs non-binary, and corrupts 
   binary files subtly.
 - it never appears to be a problem as long as you stay inside the "same 
   system", because everybody just agrees.

But why did I actually implement auto-CRLF, if I'm so against it? Because 
keyword expansion has a lot of problems that CRLF does *not* have:

 - pretty much every single tool out there actually handles CRLF 
   automatically. When you send emails from a CRLF system to a non-CRLF 
   system, the CRLF will just be removed. Why? Because tools *outside* the 
   SCM already know about "text vs binary", and while you can certainly 
   screw it up (use a CRLF system to generate a kernel patch and send it 
   as a binary attachment, and it won't apply for me, for example), you 
   actually have to work at it a bit.

 - A transformation like LF<->CRLF is "stateless". Anybody can translate a 
   file between CRLF and LF without having to know anything at all, so 
   even *if* somebody sends me a patch with CRLF (and it actually happens: 
   the amount of whitespace damage that people can do with email is just 
   surprisingly high, and people occasionally use Windows machines to send 
   me kernel patches, probably because they send email from some other 
   machine than the one they did development on).

 - Related to the statelessness: CRLF is a "global" operation, and doesn't 
   depend on file history or placement. Keyword expansion explicitly does
   *not* work that way, since the whole *point* of keywords is to make it 
   depend on its place in history!

An example of real-world problems with that lack of statelessness of 
keywords is something as simple as "git rebase". Think about what it does: 
it moves a commit around in history. But then think about *how* it does 
that.

[ Ok, take a break here, and think about why "keyword expansion" might be 
  a problem for "git rebase" in a way that CRLF is not, before you read on ]

Hint: the reason statefulness is broken for things like "git rebase" is 
that the natural operation for something like that is to generate a patch, 
and carry it forward. Now, what is in the patch? Keywords. Will the patch 
apply to the target? Yes? No?

See? Keywords means that you suddenly have merge problems with something 
as simple as patches. Does this matter in CVS? Not often. CVS is so 
limited that you cannot much do those operations anyway, but if you've 
ever done a merge in CVS, keyword expansion tends to be one of the things 
that just make it more complicated. So now you have to remember flags like 
like "-kk" that disable keywords.

(Not a lot of people actually do merges in CVS - branches are hard to use 
to begin with, so the only people who do branches tend to be pretty 
hardcode CVS people, and once you've learnt enough to do a branch, keyword 
expansion is the least of your problems. But it's *one* reason - however 
small compared to the other reasons - that doing things like merging in 
CVS is just more painful than it should be)

Or what about generating a diff between two branches? Keywords are a total 
*nightmare*. Do you realize just how *fast* git is in diff generation. 
Have you ever done "cvs diff"? Have you ever *thought* about how git can 
be so fast? Hint: we don't even *look* at the contents for most files. But 
if the content is "generated" depending on history, you just screwed that 
up too.

Or what about something as seemingly unrelated as "git grep". You may not 
even *realize* how nasty a problem it is when you have two different 
representations of the same data: one that has keywords in it and is 
checked out, and one that does not. Which one should you choose? Which one 
is the right one? What about the git optimization of using the checked-out 
data because it doesn't need any unpacking?

Again, none of these things are problems with CRLF: CRLF is an issue that 
is pretty much *defined* to not matter for text-files. If you do a "grep", 
it doesn't matter if lines end in LF or CRLF. If you do a diff, line 
ending differences (a) shouldn't exist in the first place because they are 
stateless and (b) even if they were to exist, they shouldn't change the 
diff, because LF and CRLF are the same in text.

And the whole keyword issue gets *worse* when you move between 
repositories. If you stay "inside" the SCM, you can generally teach it to 
ignore them. For example, going back to the "git rebase" example (or the 
"git grep" one, for that matter), you can just define that it's done 
without keyword expansion.

But when you move the data between people? That's exactly where keyword 
expansion is enabled, and now you not only make things like "git diff" 
fundamentally broken and much much slower (in fact, it *cannot*work* in 
the git model, because we don't even *have* tree history, so you cannot 
add keywords to a tree!), you also guarantee that the end result is much 
less useful, because now when you send the patch to others, they'll have 
all the same issues that you had to work around locally.

I don't know if I can convince you, but take it from me, keyword expansion 
is fundamentally broken in the first place, but it's *more* so with git 
than with CVS, for example.

In CVS, the reason you can do keyword expansion in the first place is:

 - it's file-based to begin with. A file actually *has* history in CVS, in 
   a way it fundmanentally does *not* have in git. So when you generate a 
   diff on a file, the revision information is "just there". That's simply 
   not true in git. There *is* no per-file revision information. You 
   cannot know who touched the file last, for example, without starting 
   from a commit, and doing very expensive things.

 - it's slow to begin with. This is related to the above thing: exactly 
   because CVS is file-based and not content-based, when you do things 
   like "cvs diff" you will walk files individually anyway. People 
   *accept* (and I cannot imagine why) that an empty "cvs diff" on some 
   big project will take minutes. And the problems aren't even about 
   keyword expansion - keyword expansion is just a small detail.

 - it's centralized in more ways than one. You are simply not expected to 
   work by applying patches between two unrelated CVS trees. It's not 
   done. It cannot work. The closest you get is 
	(a) merging. Which is *hell*. Again, keyword expansion is just a
	    small detail in why it's hell, and people don't generally pick 
	    it up exactly because the merge problems are so much bigger.
	(b) applying patches from the outside from people who do *not* use 
	    CVS, and thus don't generally touch things around the 
	    keywords (but even here, you actually end up having problems
	    occasionally).

 - CVS really fundamentally has so many other problems that keyword
   expansion just isn't on peoples radar. Yeah, it can corrupt data, but 
   you're more likely to corrupt data with binary files other ways, so 
   it's just not an issue.

So basically, other (more fundamental) design mistakes in CVS make 
keywords seem like a better idea there, but all the keyword problems are 
just magnified ten-fold by the fact that git doesn't make those _other_ 
mistakes that CVS does.

And don't get me wrong: I think RCS was a great step forward, and CVS was 
too. A few decades ago. But in git, we sometimes have to teach people to 
*not* make the mistakes they did with CVS. Keyword expansion is a small 
detail, and happily few enough people used it in CVS that it's so far not 
been a huge problem to teach people not to do it.

We had to teach people that there's a difference between doing a local 
repository commit, and pushing that commit to a shared central point. 
That's a much more fundamental difference, and it's a lot harder to get 
your brain to accept that kind of change. In contrast, keywords look 
"trivial", but they really aren't. It's a fundamentally broken notion, 
even if it *sounds* like a small detail.

I'll finish off trying to explain the problem in fundamental git terms: 
say you have a repository with two branches, A and B, and different 
history  on a file "xyzzy" in those two branches, but because they both 
ended up applying the same patches, the actual file contents do end up 
being 100% identical. So they have the same SHA1.

What is

	git diff A..B -- xyzzy

supposed to print?

And *I* claim that if you don't get an immediate and empty diff, your 
system is TOTALLY BROKEN.

And now think about what keywords do. And realize that keywords are 
TOTALLY BROKEN!

			Linus
