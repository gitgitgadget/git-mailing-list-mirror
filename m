From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Thu, 2 Apr 2015 19:37:20 +0700
Message-ID: <CACsJy8Cj97NrvuAXjqRbd52ivaHZ_oqy+k-3_LeRSe2Jy6U33Q@mail.gmail.com>
References: <20150302092136.GA30278@lanh> <1425685087-21633-1-git-send-email-sbeller@google.com>
 <xmqqr3t1vefz.fsf@gitster.dls.corp.google.com> <CAGZ79kZBYFSwR6E86BF6Dt7xdh0zs07tkGnQAKfEJpSduTK-aw@mail.gmail.com>
 <xmqqr3szql9r.fsf@gitster.dls.corp.google.com> <xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 14:38:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdeNk-0003aD-3x
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 14:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbbDBMhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 08:37:54 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34024 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbbDBMhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 08:37:51 -0400
Received: by iedfl3 with SMTP id fl3so75716724ied.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A3AwWfUkJNSBrbBX+vwiW7eb6THjBnvNPz8kmENMjFw=;
        b=qT3pljzhTRYtfoJVOcXGzi5AUwISmLXWgP260/an556KhM4+PZ5MN+K1GD5/Y5jz5J
         epiupHkS6dUkH3e1DM43m7uDVXHeiXbmlOJiHvA1CoiWvesijFmo6xNVckyn4zk5q4ce
         EDS1lfkED2lFkbeRdNwqV6UCmjpom3ZkO57SM+j3GxIY3mXGHgKp8l4PQU3a06BVbJVV
         dSG5qLpUdFCKpoFLVA/NywtydOZgOL15XnhuCU0eMjs9bWqVJHwwKHrOb8SSmIiZDbd4
         cyQws5AtgwtHBgPm26JxkjdbjsK/8devvaz24lgpRfDYH3sv7Swwdv8ThlMHF11QMYeQ
         Pf2g==
X-Received: by 10.42.191.138 with SMTP id dm10mr32535389icb.65.1427978270820;
 Thu, 02 Apr 2015 05:37:50 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Thu, 2 Apr 2015 05:37:20 -0700 (PDT)
In-Reply-To: <xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266639>

On Wed, Apr 1, 2015 at 2:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This is a follow-up on $gmane/264553, which is a continuation of
> $gmane/264000, but instead of giving two required readings to
> readers, I'll start with reproduction of the two, and add a few more
> things the current protocol lacks that I would want to see in the
> updated protocol.

I think the important thing to get v2 started is making sure we do not
need v3 to get rid of any of these limitations. In other words v2
should be extensible enough to implement them later. I'm looking from
this perspective.

> The current protocol has the following problems that limit us:
>
>  - It is not easy to make it resumable, because we recompute every
>    time.  This is especially problematic for the initial fetch aka
>    "clone" as we will be talking about a large transfer. Redirection
>    to a bundle hosted on CDN might be something we could do
>    transparently.

Sending multiple packs or some redirection instructions could be done
even with v1. The only recompute part that is unavoidable in v1 is ref
advertisement, which I think is solved.

>  - The protocol extension has a fairly low length limit.

One pkt-line per protocol extension should do it.

>  - Because the protocol exchange starts by the server side
>    advertising all its refs, even when the fetcher is interested in
>    a single ref, the initial overhead is nontrivial, especially when
>    you are doing a small incremental update.  The worst case is an
>    auto-builder that polls every five minutes, even when there is no
>    new commits to be fetched.

One of the reason v2 is started, should be ok with current v2 design.

>  - Because we recompute every time, taking into account of what the
>    fetcher has, in addition to what the fetcher obtained earlier
>    from us in order to reduce the transferred bytes, the payload for
>    incremental updates become tailor-made for each fetch and cannot
>    be easily reused.

Well, we reuse at a lower level, pack-objects would try to copy
existing deltas instead of making new ones. We can cache new deltas in
hope that they may be useful for the next fetch. But that has nothing
to do with the protocol..

>  - The semantics of the side-bands are unclear.
>
>    - Is band #2 meant only for progress output (I think the current
>      protocol handlers assume that and unconditionally squelch it
>      under --quiet)?  Do we rather want a dedicated "progress" and
>      "error message" sidebands instead?
>
>    - Is band #2 meant for human consumption, or do we expect the
>      other end to interpret and act on it?  If the former, would it
>      make sense to send locale information from the client side and
>      ask the server side to produce its output with _("message")?

The interpretation of side-band could be changed by introducing a new
extension, couldn't it?

>  - The semantics of packet_flush() is suboptimal, and this
>    shortcoming seeps through to the protocol mapped to the
>    smart-HTTP transport.
>
>    ...

I don't have an answer to this one. So the reaction is, if it is not
"broken" (in pratice, not in theory), don't touch it. I know I'm
burying my head in the sand..

>  - The fetch-pack direction does the common-parent discovery but the
>    push-pack direction does not.  This is OK for the normal
>    fast-forward push, in which case we will see a known commit on
>    the tip of the branch we are pushing into, but makes forced push
>    inefficient.

Introducing the ref exchange in push-pack could be done in an
extension too, I think.

>  - The existing common-parent discovery done on the fetch-pack side
>    enumerates commits contiguously traversing the history to the
>    past.  We might want to go exponential or Fibonacci to quickly
>    find an ancient common commit and bisect the history from there
>    (or it might turn out not to be worth it).

Hm.. i'm wondering if we can already do this with v1 if we have enough
man power.

>  - We may want to revamp the builtin/receive-pack.c::report() that
>    reports the final result of a push back to the pusher to tell the
>    exact object name that sits at the updated tips of refs, not just
>    refnames.  It will allow the server side to accept a push of
>    commit X to a branch, do some "magic" on X (e.g. rebase it on top
>    of the current tip, merge it with the current tip, or let a hook
>    to rewrite the commit in any way it deems appropriate) and put
>    the resulting commit Y at the tip of the branch.  Without such a
>    revamp, it is currently not possible to sensibly allow the server
>    side to rewrite what got pushed.

Sounds more coding than changing the protocol, which should be
possible with another extension.

>  - If we were to start allowing the receiver side to rewrite pushed
>    commits, the updated send-pack protocol must be able to send the
>    new objects created by that "magic" back to the pusher.  The
>    current protocol does not allow the receive-pack to send packdata
>    back to send-pack.

Is it cleaner to just initiate another fetch to get that pack? Maybe
race conditions make it not a good option?
-- 
Duy
