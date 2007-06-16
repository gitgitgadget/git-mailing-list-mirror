From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-send-pack SIGSEGV..
Date: Sat, 16 Jun 2007 00:57:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706152342490.4740@iabervon.org>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
 <7vvedp935y.fsf@assigned-by-dhcp.pobox.com> <7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
 <Pine.LNX.4.64.0706150949300.5848@iabervon.org> <7v7iq47j5z.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 06:57:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzQME-0002pn-0q
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 06:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXFPE5s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 00:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbXFPE5s
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 00:57:48 -0400
Received: from iabervon.org ([66.92.72.58]:2331 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbXFPE5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 00:57:47 -0400
Received: (qmail 18180 invoked by uid 1000); 16 Jun 2007 04:57:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jun 2007 04:57:46 -0000
In-Reply-To: <7v7iq47j5z.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50285>

On Fri, 15 Jun 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> I suspect this has an side effect of allowing
> >> 
> >> 	fetch = refs/heads/*
> >> 
> >> to mean the same thing as
> >> 
> >> 	fetch = refs/heads/*:refs/heads/*
> >> 
> >> which is suitable for a bare mirroring repository, but I do not
> >> think of any downside, so it might be Ok.
> >> 
> >> But that is something from a person who was under anesthesia a
> >> few hours ago, so you should take it with a big grain of salt ;-)
> >
> > Yeah, that's not right; "push = refs/heads/*" works like that, but 
> > "fetch = refs/heads/*" puts them in MERGE_HEAD without storing them 
> > anywhere, unlike "fetch = refs/heads/*:refs/heads/*".
> 
> While I appreciate the proper fix, I have to say "Wait a minute".
> 
> First of all, do you really mean MERGE_HEAD in the above? 

Sorry, FETCH_HEAD. MERGE_HEAD would be seriously wrong. I was trying to 
say that it didn't store them in any tracking location, and messed up the 
irrelevant bit of was it does do with them.

> I did not even realize that "push/fetch = $prefix/*" was
> allowed.  IIRC, it has always been "$prefix1/*:$prefix2/*" form,
> and "$prefix/*" was illegal. 

I thought when I was first writing the remotes.{c,h} code, I found that at 
least "push = foo/*" was supported already, due to nothing actually 
excluding it, and the code for copying the lhs to a blank rhs was being 
applied to patterns just like non-patterns.

That is, since "push = refs/heads/master" was already the same as "push = 
refs/heads/master:refs/heads/master", the pattern fell into that code. I 
was at least confidant enough of this to translate --tags into 
"refs/tags/*" instead of "refs/tags/*:refs/tags/*" when I got to that 
point.

I'm not sure if "fetch = foo/*" was permitted (or is, since fetch is still 
using other parsing in general), but, whatever it does, if it's allowed, 
it should certainly match "fetch = refs/head/master", which is pretty well 
agreed on at this point.

> Somehow a change in sematics sneaked in without me knowing that makes it 
> legal, and the updated semantics is that for push "$prefix/*" is the 
> same as listing every ref under the prefix (without any colon, so it
> pushes to the same name), and for fetch "$prefix/*" is the same
> as $prefix/$x: (i.e. with colon and empty RHS) for all refs
> under $prefix.
> 
> Now, I am not opposed to _having_ enhanced semantics.  Earlier,
> "$prefix/*" was illegal, so it is not like you have introduced
> any incompatibility.  On the push side, I do not think of any
> sane interpretation for it other than treating it exactly as
> "$prefix/*:$prefix/*".  On the fetch side, however, I am not
> sure not to use any tracking _and_ grabbing everything is a sane
> semantics.  You fetch everything under $prefix/ and list them in
> FETCH_HEAD --- now what?  On the other handl, treating it as if
> the user wrote "$prefix/*:$prefix/*" makes some sense.  It is a
> natural operation to keep a bare mirroring repository up to
> date.

I think it could make sense to prepare an octopus merge of a bunch of 
heads in a subdirectory. And it should either be prohibited or match the 
behavior of a non-pattern, or it would be really confusing.

> But I am somewhat upset about us having the enhanced semantics
> without me knowing.  I see two possible reasons for it: (1) I
> was not being extra careful when I accepted your patches, and
> (2) the change in the semantics were not documented, either in
> the log nor Documentation/.

Actually, I thought I was just overlooking the part of the documentation 
that explained patterns for push, but it isn't actually there. 
builtin-push.c put a lot of effort into supporting them when I got to it, 
but none of the documentation even suggests that you can put wildcards in 
two-sided refspecs for push, let alone one (and the code I was looking at 
was yours, added without documentation but with a hefty commit message in 
d46ae3f0). Based on the meaning of wildcards in push refspecs, however, 
the documentation for one-sided refspecs in git-push:

 A parameter <ref> without a colon pushes the <ref> from the source 
 repository to the destination repository under the same name.

clearly implies that anything that, whatever refs/heads/* matches, it 
pushes to the destination under the same name.

On the fetch side, the code isn't using my parser yet, anyway. But my 
parser should be able to distinguish the one-sided refspec case, so that 
the fetch logic can do whatever is determined to be right with the 
combination of features.

> I think "fetch = refs/heads/*" syntax, if it just fetches
> without storing, does not make much sense.  In a separate-remote
> repository, "[remote "foo"] fetch = refs/heads/*" would probably
> be useful if we treated it as "refs/heads/*:refs/remotes/foo/*".
> In a bare repository used for mirrors, it would be useful if it
> stood for "refs/heads/*:refs/heads/*".

I'm kind of uncomfortable with this level of complexity for a fully 
specified lhs pattern. Maybe "fetch = refs/heads/*" should be prohibited, 
while something DWIM-y like "fetch = heads/*" or even "fetch = head *" 
could come up with clever and useful patterns. In any case, the parser 
should report "refs/heads/*" as pattern,refs/heads/,NULL and let the fetch 
code decide what to do with it, rather than having the special case in the 
parser.

	-Daniel
*This .sig left intentionally blank*
