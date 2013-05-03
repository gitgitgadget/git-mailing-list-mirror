From: Johan Herland <johan@herland.net>
Subject: Re: another packed-refs race
Date: Fri, 3 May 2013 11:26:11 +0200
Message-ID: <CALKQrgdHudF1fDLSXzaKfb2kne0B3rC5mM95CJGsLqL_2xemnA@mail.gmail.com>
References: <20130503083847.GA16542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 03 11:26:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYCFy-0004zu-B0
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 11:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639Ab3ECJ0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 05:26:17 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:51902 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab3ECJ0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 05:26:16 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UYCFr-000LzX-4E
	for git@vger.kernel.org; Fri, 03 May 2013 11:26:15 +0200
Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UYCFq-000D28-Q2
	for git@vger.kernel.org; Fri, 03 May 2013 11:26:14 +0200
Received: by mail-oa0-f47.google.com with SMTP id m1so1412518oag.6
        for <git@vger.kernel.org>; Fri, 03 May 2013 02:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rI2NccOuS63XuBwRZwzVxe3sxxtULWE02L66PLs48eU=;
        b=NIy0VdY43j3Ti0oO5mzivriHSr+Ss5L5FxSmJGohAWbja6w4jKYTUcnb6bhPM8hSWl
         Yt+EmIn3t7g8EjjliEIEleQnlAFfeonfRYIbt7Xe9Bm4nfIKXMLt6xCEH0XILWL4ReLp
         rqWaZQTknckrO6S+S65iaR2mpzTQGB8z6QNhqRAarT52889BDXRW8DphvgHD/RXusGOm
         FrSyn8gWO1+f1zw8TXR8P3DPkGwmEpoMfr1pvyANICjziTy3wem2arah88waReIQ/5IM
         8Wa099XUDsBz52gPMQWPqOLKFwALLbKBNxeRw7tFGPch0Q+ASgJgh2haQBiHWyfZMSeA
         W/pg==
X-Received: by 10.182.164.8 with SMTP id ym8mr2706604obb.68.1367573171279;
 Fri, 03 May 2013 02:26:11 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Fri, 3 May 2013 02:26:11 -0700 (PDT)
In-Reply-To: <20130503083847.GA16542@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223301>

On Fri, May 3, 2013 at 10:38 AM, Jeff King <peff@peff.net> wrote:
> I found another race related to the packed-refs code. Consider for a
> moment what happens when we are looking at refs and another process does
> a simultaneous "git pack-refs --all --prune", updating packed-refs and
> deleting the loose refs.
>
> [...]
>
> We could fix this by making sure our packed-refs file is up to date
> before using it. E.g., resolving a ref with the following sequence:
>
>   1. Look for loose ref. If found, OK.
>
>   2. Compare inode/size/mtime/etc of on-disk packed-refs to their values
>      from the last time we loaded it. If they're not the same, reload
>      packed-refs from disk. Otherwise, continue.
>
>   3. Look for ref in in-memory packed-refs.
>
> Not too bad. We introduce one extra stat() for a ref that has been
> packed, and the scheme isn't very complicated.
>
> But what about enumerating refs via for_each_ref? It's possible to have
> the same problem there, and the packed-refs file may be moved into place
> midway through the process of enumerating the loose refs. So we may see
> refs/heads/master, but when we get to refs/remotes/origin/master, it has
> now been packed and pruned. I _think_ we can get by with:
>
>   1. Generate the complete sorted list of loose refs.
>
>   2. Check that packed-refs is stat-clean, and reload if necessary, as
>      above.
>
>   3. Merge the sorted loose and packed lists, letting loose override
>      packed (so even if we get repacked halfway through our loose
>      traversal and get half of the refs there, it's OK to see duplicates
>      in packed-refs, which we will ignore).
>
> This is not very far off of what we do now. Obviously we don't do the
> stat-clean check in step 2. But we also don't generate the complete list
> of loose refs before hitting the packed-refs file. Instead we lazily
> load the loose directories as needed. And of course we cache that
> information in memory, even though it may go out of date. I think the
> best we could do is keep a stat() for each individual directory we see,
> and check it before using the in-memory contents. That may be a lot of
> stats, but it's still better than actually opening each loose ref
> separately.
>
> So I think it's possible to fix, but I thought you might have some
> insight on the simplest way to fit it into the current ref code.
>
> Did I explain the problem well enough to understand? Can you think of
> any simpler or better solutions (or is there a case where my proposed
> solutions don't work?).

You don't really need to be sure that packed-refs is up-to-date. You
only need to make sure that don't rely on lazily loading loose refs
_after_ you have loaded packed-refs.

The following solution might work in both the resolve-a-single-ref and
enumerating-refs case:

0. Look for ref already cached in memory. If found, OK.

1. Look for loose ref. If found, OK.

2. If not found, load all loose refs and packed-refs from disk (in
that order), and store in memory for remainder of this process. Never
reload packed-refs from disk (unless you also reload all loose refs
first).

My rationale for this approach is that if you have a packed-refs file,
you will likely have fewer loose refs, so loading all of them in
addition to the pack-refs file won't be that expensive. (Conversely,
if you do have a lot of loose refs, you're more likely to hit #1, and
not have to load all refs.)

That said, my intuition on the number of loose vs. packed refs, or the
relative cost of reading all loose refs might be off here...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
