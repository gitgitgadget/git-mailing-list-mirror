From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 09:10:48 -0700
Message-ID: <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 15 18:11:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhkzT-0003Bu-C1
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 18:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab1GOQLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 12:11:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41409 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753039Ab1GOQLk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 12:11:40 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FGBAVF000771
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 09:11:11 -0700
Received: by wwe5 with SMTP id 5so1441775wwe.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 09:11:08 -0700 (PDT)
Received: by 10.216.81.5 with SMTP id l5mr681563wee.102.1310746268143; Fri, 15
 Jul 2011 09:11:08 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 09:10:48 -0700 (PDT)
In-Reply-To: <20110715074656.GA31301@sigill.intra.peff.net>
X-Spam-Status: No, hits=-102.889 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177201>

On Fri, Jul 15, 2011 at 12:46 AM, Jeff King <peff@peff.net> wrote:
>
> So you don't see a difference between storing the information directly
> in the commit object, where it affects the sha1 of the commit, and
> calculating and storing it somewhere else?

Sure, I see the difference. And I think it's uglier to have two
different places for required information.

>  That is what seems ungit to
> me. You aren't adding new information to the DAG (note I said "DAG" and
> not commit) that is not already there, but you are changing the ids of
> commits in the DAG.

Umm. It's redundant, but so what? We have tons of redundant
information in there already. Those commits are very explicitly using
a 40-byte ASCII representation of the 20-byte SHA1 names. The very
original deeper object structure is also redundant: we repeat the
object size in the object itself, even though it's part of the
implicit object format itself.

We also very purposefully repeat the type of the object there, even
though the type is basically always redundant (in fact, the core git
functions require you to give the type of the object as part of the
lookup, and will error out if the SHA1 points to the wrong type). That
was one of my original design decisions, exactly because I wanted the
redundancy for verification.

Redundancy isn't a problem. It's a source of sanity checking.

I'm not seeing why you are harping on it.

I think it's much worse to have the same information in two different
places where it can cause inconsistencies that are hard to see and may
not be repeatable. If git ever finds the wrong merge base (because,
say, the generation numbers are wrong), I want it to be a *repeatable*
thing. I want to be able to repeat on the git mailing list "hey, guys,
look at what happens when I try to merge commits ABC and XYZ". If you
go "yeah, it works for me", then that is bad.

What I tried very hard to do in the git data structures is to make
them (a) immutable (so the DAG could never have two-way links, for
example) and (b) "simple".

Right now, we do *have* a "generation number". It's just that it's
very easy to corrupt even by mistake. It's called "committer date". We
could improve on it.

> Are packfiles unclean, or a random hack? How about pack indices?

No. Neither of them are unclean or random. The original git design was
very much about thinking of the object space as a "filesystem". Now,
the original object layout actually used the native OS filesystem, and
I naively thought that would be ok. Using  aspecialized filesystem
instead doesn't really change anything. It's not fundamentally
different from the difference between running git on ext3 or btrfs or
nfs or whatever. In fact, I think we've had more filesystem-related
bugs wrt NFS than we've had with pack-files.

The pack indices are actually kind of ugly - and I would have
preferred having them in the same file instead of having the worry of
consistency across two different files. They *are* the kind of thing
that could cause local inconsistency, but they are fairly simple, and
they have some serious protection in them (ie they aren't just SHA1'd
in themselves, they contain a SHA1 of the pack-file they index in them
to make sure that any inconsistency is findable). Again, that's
"redundancy". But I consider the packfile/index to be just a
filesystem. It really fundamentally *is* that.

Partly for that reason, I do think that if the generation count was
embedded in the pack-file, that would not be an "ugly" decision. The
pack-files have definitely become "core git data structures", and are
more than just a local filesystem representation of the objects:
they're obviously also the data transport method, even if the rules
there are slightly different (no index, thank god, and incomplete
"thin" packs).

That said, I don't think a generation count necessarily "fits" in the
pack-file. They are designed to be incremental, so it's not very
natural there. But I do think it would be conceptually prettier to
have the "depth of commit" be part of the "filesystem" data than to
have it as a separate ad-hoc cache.

> Those things rely on the idea that the git DAG is a data model that we
> present to the user, but that we're allowed to do things behind the
> scenes to make things faster.

.. and that is relevant to this discussion exactly *how*?

It's not. It's totally irrelevant. I certainly would never walk away
from the DAG model. It's a fundamental git decision, and it's the
correct one.

But it all boils down to one simple issue: we should have added
generation counts back in 2005. It's likely the *one* data format
decision that I regret. Using commit dates was wrong. Everybody knew
it was wrong, but we ended up going with it just to keep the format
constant.

If I had realized how small the patch was to add generation counters,
and that it wouldn't have broken backwards compatibility (ie fsck
doesn't start complaining). I would have done it originally, instead
of all the crazy hacks we did for commit date verification.

And that is what this discussion fundamentally boils down to for me.

If we should have fixed it in the original specification, we damn well
should fix it today. It's been "ignorable" because it's just not been
important enough. But if git now adds a fundamental cache for them,
then that information is clearly no longer "not important enough".

                               Linus
