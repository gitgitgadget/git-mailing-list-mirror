From: Anthony Van de Gejuchte <anthonyvdgent@gmail.com>
Subject: Re: Git commit generation numbers
Date: Mon, 18 Jul 2011 12:28:16 +0200
Message-ID: <A142F49B-FC91-410A-B3C8-15FC7E5C3C68@gmail.com>
References: <20110718051347.28952.qmail@science.horizon.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: torvalds@linux-foundation.org, git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 12:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qil3q-000809-Jq
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 12:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab1GRK2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 06:28:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52717 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab1GRK2U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 06:28:20 -0400
Received: by wyg8 with SMTP id 8so1968745wyg.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=XNN17UPakBFmDS5Vck86+LE9LUwMJOyjSog8dQwRFic=;
        b=ZujdAQkPj7QS0oMmTvXsIFzSZFB1PeHBuICMSqR/43vln4IsmQy6ceXlR/y1XOZmof
         u1Q8ZzzLGSVNyzSIJvx1eEGJt/1DmsHwNE6rv9egwBXxaMVFbmy5f87arETX9g7l2I8E
         0OGuEonBjh09XEUO5rdHct6Etpu+xNcSoK/00=
Received: by 10.216.139.37 with SMTP id b37mr2867032wej.41.1310984899154;
        Mon, 18 Jul 2011 03:28:19 -0700 (PDT)
Received: from [192.168.1.106] (78-22-168-200.access.telenet.be [78.22.168.200])
        by mx.google.com with ESMTPS id k9sm2243971weq.3.2011.07.18.03.28.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 03:28:18 -0700 (PDT)
In-Reply-To: <20110718051347.28952.qmail@science.horizon.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177365>

On 18-jul-2011, at 07:13, George Spelvin wrote:

>> Nobody has *ever* given a reason why the cache would be better than
>> just making it explicit.
> 
> I thought I listed a few.  Let me be clearer.
> 
> 1) It involves changing the commit format.  Since the change is
>   backward-compatible, it's not too bad, but this is still fundamentally
>   A Bad Thing, to be avoided if possible.

Git is designed to ignore data in this case afaik, so I do not see any
reason why backwards-compatibility gets broken here.

> 
> 2) It can't be retrofitted to help historical browsing.

I like to see more (valid) arguments, as I do not see what you are
trying to explain.

> 
> 3) You have to support commits without generation numbers forever.
>   This is a support burden.  If you can generate generation numbers for
>   an entire repository, including pre-existing commits, you can *throw
>   out* the commit date heuristic code entirely.

I'll give you a few months to rethink at this statement until this
feature does get used widely. I think there was never a moment where
we would ever think to rebuild older commits as this would break the
hash of the commits where many people are potential looking for.

> 
> 4) It can't be made to work with grafts or replace objects.
> 
> 5) It includes information which is redundant, but hard to verify,
>   in git objects.  Leading to potentially bizarre and version-dependent
>   behaviour if it's wrong.  (Checking that the numbers are consistent
>   is the same work as regenerating a cache.)

The data is *consistent* as long as the hash doesn't change, storing the
data in the commits *can* reduce resource and makes calculations cheaper.
Therefore, I think there are enough reasons to add the generation number
in the commit. Yes, many data can be calculated or can be an overhead,
but as Torvalds already said, it can be used as consistency check.

If the data does get wrong, then its probably caused by something stupid
enough to break the rules. Yes, this is a problem but I think there are
already enough reasons given, look back to the archives of this topic.

Ok, there is one possible thing that *can* go wrong and that is when you
are changing history with generation numbers with an older git client.

(And thats a good reason to communicate with others as clear as possible
about this feature, but its still not version-dependent as it doesn't
require a client to use it)

> 
> 6) It makes git commits slightly larger.  (Okay, that's reaching.)
> 
>> Why is that so hard for people to understand? The cache is just EXTRA WORK.
> 
> That's why it *might* have been a good idea to include the number in
> the original design.  But now that the design is widely deployed, it's
> better to avoid changing the design if not necessary.
> 
> With a bit of extra work, it's not necessary.
> 
>> To take your TLB example: it's like having a TLB for a page table that
>> would be as easy to just create in a way that it's *faster* to look up
>> in the actual data structure than it would be to look up in the cache.
> 
> You've subtly jumped points.  The original point was that it's worth
> precomputing and storing the generation numbers.  I was trying to
> say that this is fundamentally a caching operation.
> 
> Now we're talking about *where* to store the cached generation numbers.
> 
> Your point, which is a very valid one, is that they are to be stored
> on disk, exactly one per commit, can be computed when the commit is
> generated, and are accessed at the same time as the commit, so it makes
> all kinds of sense to store them *with* the commits.  As part of them,
> even.
> 
> This has the huge benefit that it does away with the need for a *separate*
> data structure.  (Kinda sorts like the way AMD stores instruction
> boundaries in the L1 I-cache, avoiding the need for a separate data
> structure.)
> 
> I'm arguing that, despite this annoying overhead, there are valid reasons
> to want to store it separately.  There are some practical ones, but the
> basic one is an esthetic/maintainability judgement of "less cruft in
> the commit objects is worth more cruft in the code".
> 
> Git has done very well partly *because* of the minimality of its basic
> persistent object database format.  I think we should be very reluctant
> to add to that without a demonstrated need that *cannot* be met in
> another way.
> 
> 
> In this particular case, a TLB is not a transport format.  It's okay
> to add redundant cruft to make it faster, because it only lasts until
> the next reboot.  (A more apropos, software-oriented analogy might be
> "struct page".)
> 
> A git commit object *is* a transport format, one specifically designed
> for transporting data a very long way forward in time, so it should be
> designed with considerable care, and cruft ruthlessly eradicated.
> 
> Whatever you add to it has to be supported by every git implementation,
> forever.  As does every implementation bug ever produced.
> 
> A cache, on the other hand, is purely a local implementation detail.
> It can be changed between versions with much less effort.
> 
> I agree it's more implementation work.  But the upside is a cleaner
> struct commit.  Which is a very good thing.

A cache would use more resources because they can become invalid at any
point and *should* be recalculated by every client. We are processing
data that *can* be reused by everybody with a git client which has this
specific feature, but does not break anything with an older client.

So please, calculate things only once as this may save a *lot* of time :-)

I would see more advantage in a cache if the data could differs on
every client, but that still doesn't mean that you should use one.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Maybe I shouldn't even have responded to this as I tend not to agree with
the given opinions to use a cache, even when I think that Torvalds starts
throwing arguments as well for certain reasons, but thats probably my wrong
thinking at it.
