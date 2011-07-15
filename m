From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 18:19:30 -0700
Message-ID: <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 15 03:20:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhX4n-0005N3-2q
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 03:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671Ab1GOBTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 21:19:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57749 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932217Ab1GOBTy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 21:19:54 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6F1JphQ019007
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 18:19:52 -0700
Received: by wwe5 with SMTP id 5so845102wwe.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 18:19:51 -0700 (PDT)
Received: by 10.216.38.76 with SMTP id z54mr2640290wea.102.1310692791119; Thu,
 14 Jul 2011 18:19:51 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Thu, 14 Jul 2011 18:19:30 -0700 (PDT)
In-Reply-To: <20110714203141.GA28548@sigill.intra.peff.net>
X-Spam-Status: No, hits=-102.893 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177186>

On Thu, Jul 14, 2011 at 1:31 PM, Jeff King <peff@peff.net> wrote:
>
> However, I'm not 100% convinced leaving generation numbers out was a
> mistake. The git philosophy seems always to have been to keep the
> minimal required information in the DAG.

Yes.

And until I saw the patches trying to add generation numbers, I didn't
really try to push adding generation numbers to commits (although it
actually came up as early as July 2005, so the "let's use generation
numbers in commits" thing is *really* old).

In other words, I do agree that we should strive for minimal required
information.

But dammit, if you start using generation numbers, then they *are*
required information. The fact that you then hide them in some
unarchitected random file doesn't change anything! It just makes it
ugly and random, for chrissake!

I really don't understand your logic that says that the cache is
somehow cleaner. It's a random hack! It's saying "we don't have it in
the main data structure, so let's add it to some other one instead,
and now we have a consistency and cache generation problem instead".

Just look at the size of the patches in question. Your caching patches
are bigger and more complicated. Sure, part of it is that your series
adds the code to _use_ the generation number, but look purely at the
code to maintain them.

Why do you think the odd separate cache is somehow better than just
doing it right? Seriously? If we require the generation numbers, then
they have *become* that minimal information that we should save!

 And I think that has served us
> well, because we're not saddled with cruft that seemed like a good idea
> early on, but isn't.

Again - we discussed adding generation numbers about 6 years ago. We
clearly *should* have done it. Instead, we went with the hacky "let's
use commit time", that everybody really knew was technically wrong,
and was a hack, but avoided the need.

Now, six years later, you clearly are saying that we need the
generation numbers, but then you go off and try to say that they
should be in some secondary non-architected random collection of data
structures that isn't covered by the security and maintenance
guarantees that the core git objects are.

Dammit, one of the things that makes git special is that the data
structures are NOT random odd ad-hoc files. There is a design to them.

> Generation numbers are _completely_ redundant with the actual structure
> of history represented by the parent pointers.

Not true. That's only true if you add ".. if you parse the whole
history" to that statement.

And we've *never* parsed the whole history, because it's just too
expensive and doesn't scale. So right now we depend on commit dates
with a few hacks.

So no, generation numbers are not at all redundant. They are
fundamental. It's why we had this discussion six years ago.

> And so that seems a bit hack-ish to me.

Um? If you feel that way, then why the hell are you pushing your EVEN
MORE HACKISH CACHE PATCHES?

That's what this really boils down to. I think that if we have a value
that we need, then it should be recorded. In the data structures. Not
in some random other location that isn't part of the real git data
structures.

We don't do caches in git, because we don't NEED to. Sure, gitk has
it's hacky cache, but that's not core functionality.

I think it's a sign of good design that we can do a "find .git" and
explain every single file, and show that it's all core functionality
(again, with the exception of "gitk.cache", and I suspect that's
because gitk is a script, not because of any really fundamental data
issues), and explain it.

I think the *cache* is a hell of a lot more hacky than just doing it right.

> I liken it somewhat to the "don't store renames" debate.

That's total and utter bullshit.

Storing renames is *wrong*. I've explained a million times why it's
wrong. Doing it is a disaster. I know. I've used systems that did it.
It's crap. It's fundamentally information that is actively misleading
and WRONG. It's not even that you can do rename detection at run-time,
it's that you *HAVE* to do rename detection at run-time, because doing
it at commit time is simply utterly and fundamentally *wrong*.

Just look at "git blame -C" to remind yourself why rename information is wrong.

But even more importantly, look at git merges. Look at how git has
gotten merging right since pretty much day #1, and has absolutely no
issues with files that got generated two different ways. Look at every
SCM that tries to do rename detection, and look at how THEY CANNOT DO
MERGES RIGHT.

It's that simple. Rename detection is not about avoiding "redundant
data". It's about doing the right thing.

                          Linus
