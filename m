From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Sun, 17 Jul 2011 12:30:34 -0700
Message-ID: <CA+55aFwqFhzd_cmbFxkCyNXhF99igBqdr8p4J76hLz=m4=ZNWg@mail.gmail.com>
References: <20110717182743.14423.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 21:31:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiX3W-0003fD-00
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 21:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab1GQTbD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 15:31:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49557 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754797Ab1GQTbC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 15:31:02 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6HJUxgW003359
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Sun, 17 Jul 2011 12:31:00 -0700
Received: by wyg8 with SMTP id 8so1700857wyg.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 12:30:54 -0700 (PDT)
Received: by 10.216.38.76 with SMTP id z54mr5024972wea.102.1310931054924; Sun,
 17 Jul 2011 12:30:54 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Sun, 17 Jul 2011 12:30:34 -0700 (PDT)
In-Reply-To: <20110717182743.14423.qmail@science.horizon.com>
X-Spam-Status: No, hits=-102.886 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177315>

On Sun, Jul 17, 2011 at 11:27 AM, George Spelvin <linux@horizon.com> wr=
ote:
>
> There are a few design mistakes in git. =A0The way the object type
> and size are prefixed to the data for hasing purposes, which prevents
> aligned fetching from memory-mapped data in the hashing code, isn't t=
oo
> pretty either.

Why would you ever care? That makes no sense.

> But git has generally preferred to avoid storing information that can
> be recomputed. =A0File renames are the big example. =A0given this, wh=
y the
> heck store generation numbers?

Guys, please don't bring up file renames. I explained once already why
bringing up file renames just makes you look like a f^&% moron.

Let me explain one more time:

 - Storing file renames is STUPID. It's stupid for very fundamental
reasons that have absolutely *NOTHING* to do with "it can be computed
later".

It's fundamentally stupid because it will FOREVER SCREW UP YOUR DATA,
and because it will make merging an unmitigated disaster and make your
repository depend on how you *created* your data, rather than on what
the data is. It will totally break the situation of one person doing a
rename, while another person does something else to the metadata (eg a
create of the same filename).

Trying to track file identities will leave to very fundamentally
unsolvable issues like "which file identity do we choose when two
different files get the same name", or "which file identity will we
choose when one file splits in two".

Git doesn't track renames, because unlike pretty much every other SCM
out there, git really does have a good design, and because I damn well
understood the real problems.

So bringing it up as an example of "we don't store it because we can
compute it" is really totally idiotic. It's a sign of not
understanding the problems with renames. Stop doing it. That argument
is totally irrelevant. Really.

It's like saying "We shouldn't do generation numbers because fish
don't use bicycles". The only thing that kind of argument does is to
make me convinced that you don't understand the problem enough to be
worth even arguing with. It is not only a worthless argument, but it
makes your every other argument suspect.

Comprende? Stop it.

> They *can* be computed on demand, so arguably they *should*.

Umm, no.

That's actually a really bad argument.

There are valid things that we "should" do, but they have nothing to
do with "if something can be done, it should be done". That's just a
crazy argument.

A thing we really *should* do is perform well. And be really reliable.
And support a distributed workflow.

Those are real arguments that aren't about "just because it's there".

Now, some of those arguments can then be used to say "don't bother
storing redundant data". For example, redundant data takes disk space
and network bandwidth, and if something can be recomputed cheaply (ie
if it doesn't have a negative impact on performance), then redundant
data is just bad.

And what appears like a much better argument (right now) is that some
data isn't needed AT ALL, because you can make do with other data
entirely (ie dates).

But "just because we could recompute it" is a bad bad reason.

The thing is, the very basic design of git is all about *incomplete*
DAG traversal. The DAG traversal part is pretty obvious and simple,
but the *partial* thing really is very very important. We absolutely
need it for reasonable scalability. We've spent a *lot* of time in git
development on trying to perform really well by avoiding work. Not
just in revision traversal, but in many other areas too (like making
diff and merge much faster by being able to handle whole identical
recursive subdirectories by just checking the SHA1, for example).

That's a *really* fundamental design issue in git. Performance was
always a primary goal. And by primary, I really mean primary. As in
"more important than just about anything else".  There were other
primary goals, but really not very many.

And there really aren't very good ways to limit DAG traversal.
Generation numbers are one of the very few fundamental ones. We hacked
around it with dates, and it works pretty well in practice (well
enough that I'm certainly ok with the hack), but it's definitely one
of the areas where git simply does something "wrong". It's simply not
a entirely reliable algorithm, and that fact makes me a bit
uncomfortable with it.

(Now, in theory, a global *approximate* time is theoretically possible
in a distributed environment, and as such it's arguable that "global
time with a slop that is based on the speed of light and knowledge of
location" is at least theoretically sound. So the real problem with
commit dates is that people simply don't have good clocks. So it's a
practical problem rather than a theoretical one, and it's a practical
problem that doesn't really cause enough problems in practice to not
be workable. But I'm making excuses for it, and I _know_ I'm making
excuses for it, so I'm not really happy about it)

And it's just about the only area where I am aware of git doing
something "wrong". Which is why I would like to have had generation
numbers even though the dates do work.

Anyway, to get back to the actual issue of caching vs not caching: if
you think "we could compute it dynamically" means that we should, then
we damn well shouldn't cache it either - why cache it, when you could
just compute it. And if it's worth it to waste resources on the cache
in order to avoid performance issues, then it damn well would be ok to
waste (fewer) resources on just saving the generation number in the
object data base. And make that *fundamental* fix to a hack that git
has had since pretty much day one.

And btw, git didn't have the date-based hack originally, because I
didn't think it would be problematic enough. I thought that we could
do universally efficient partial DAG traversal - not having to go all
the way to the root -  based purely on the DAG. The code in
"everybody_uninteresting()" tries to be that "limit DAG traversal by
only looking at the DAG itself", and it works for many simple
situations. But it turns out that it does *not* work for many other
cases.

So the generation number really is very very fundamnetal. It's
absolutely not some "additional information that can be computed",
because the whole AND ONLY point of having the number is to not
compute it.

We are never interested in the generation number for its own sake. We
are only interested in it in order to avoid having to look at the rest
of the DAG.

So no, the number fundamentally isn't computable, because computing it
obviates the need for it.

                           Linus
