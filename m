From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Wed, 5 Dec 2007 22:09:12 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>  <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Miller <davem@davemloft.net>, ismail@pardus.org.tr, gcc@gcc.gnu.org,         git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: gcc-return-142725-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 07:09:56 2007
Return-path: <gcc-return-142725-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J09vl-00033v-Gu
	for gcc@gmane.org; Thu, 06 Dec 2007 07:09:54 +0100
Received: (qmail 8826 invoked by alias); 6 Dec 2007 06:09:34 -0000
Received: (qmail 8815 invoked by uid 22791); 6 Dec 2007 06:09:33 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 06:09:22 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB669E24025853 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Wed, 5 Dec 2007 22:09:15 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB669CAw011937; 	Wed, 5 Dec 2007 22:09:12 -0800
In-Reply-To: <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67249>



On Thu, 6 Dec 2007, Daniel Berlin wrote:
> 
> Actually, it turns out that git-gc --aggressive does this dumb thing
> to pack files sometimes regardless of whether you converted from an
> SVN repo or not.

Absolutely. git --aggressive is mostly dumb. It's really only useful for 
the case of "I know I have a *really* bad pack, and I want to throw away 
all the bad packing decisions I have done".

To explain this, it's worth explaining (you are probably aware of it, but 
let me go through the basics anyway) how git delta-chains work, and how 
they are so different from most other systems.

In other SCM's, a delta-chain is generally fixed. It might be "forwards" 
or "backwards", and it might evolve a bit as you work with the repository, 
but generally it's a chain of changes to a single file represented as some 
kind of single SCM entity. In CVS, it's obviously the *,v file, and a lot 
of other systems do rather similar things.

Git also does delta-chains, but it does them a lot more "loosely". There 
is no fixed entity. Delta's are generated against any random other version 
that git deems to be a good delta candidate (with various fairly 
successful heursitics), and there are absolutely no hard grouping rules.

This is generally a very good thing. It's good for various conceptual 
reasons (ie git internally never really even needs to care about the whole 
revision chain - it doesn't really think in terms of deltas at all), but 
it's also great because getting rid of the inflexible delta rules means 
that git doesn't have any problems at all with merging two files together, 
for example - there simply are no arbitrary *,v "revision files" that have 
some hidden meaning.

It also means that the choice of deltas is a much more open-ended 
question. If you limit the delta chain to just one file, you really don't 
have a lot of choices on what to do about deltas, but in git, it really 
can be a totally different issue.

And this is where the really badly named "--aggressive" comes in. While 
git generally tries to re-use delta information (because it's a good idea, 
and it doesn't waste CPU time re-finding all the good deltas we found 
earlier), sometimes you want to say "let's start all over, with a blank 
slate, and ignore all the previous delta information, and try to generate 
a new set of deltas".

So "--aggressive" is not really about being aggressive, but about wasting 
CPU time re-doing a decision we already did earlier!

*Sometimes* that is a good thing. Some import tools in particular could 
generate really horribly bad deltas. Anything that uses "git fast-import", 
for example, likely doesn't have much of a great delta layout, so it might 
be worth saying "I want to start from a clean slate".

But almost always, in other cases, it's actually a really bad thing to do. 
It's going to waste CPU time, and especially if you had actually done a 
good job at deltaing earlier, the end result isn't going to re-use all 
those *good* deltas you already found, so you'll actually end up with a 
much worse end result too!

I'll send a patch to Junio to just remove the "git gc --aggressive" 
documentation. It can be useful, but it generally is useful only when you 
really understand at a very deep level what it's doing, and that 
documentation doesn't help you do that.

Generally, doing incremental "git gc" is the right approach, and better 
than doing "git gc --aggressive". It's going to re-use old deltas, and 
when those old deltas can't be found (the reason for doing incremental GC 
in the first place!) it's going to create new ones.

On the other hand, it's definitely true that an "initial import of a long 
and involved history" is a point where it can be worth spending a lot of 
time finding the *really*good* deltas. Then, every user ever after (as 
long as they don't use "git gc --aggressive" to undo it!) will get the 
advantage of that one-time event. So especially for big projects with a 
long history, it's probably worth doing some extra work, telling the delta 
finding code to go wild.

So the equivalent of "git gc --aggressive" - but done *properly* - is to 
do (overnight) something like

	git repack -a -d --depth=250 --window=250

where that depth thing is just about how deep the delta chains can be 
(make them longer for old history - it's worth the space overhead), and 
the window thing is about how big an object window we want each delta 
candidate to scan.

And here, you might well want to add the "-f" flag (which is the "drop all 
old deltas", since you now are actually trying to make sure that this one 
actually finds good candidates.

And then it's going to take forever and a day (ie a "do it overnight" 
thing). But the end result is that everybody downstream from that 
repository will get much better packs, without having to spend any effort 
on it themselves.

			Linus
