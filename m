From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Feature Request] git blame showing only revisions from git
 rev-list --first-parent
Date: Sun, 13 Sep 2015 22:19:33 -0700
Message-ID: <CAPc5daUcwCferagupF+iy3gxxorfMyEMn0oFMRWBNjc0=2r4og@mail.gmail.com>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
 <20150911140133.GA14311@sigill.intra.peff.net> <xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
 <xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com> <20150912033054.GA30431@sigill.intra.peff.net>
 <xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com> <20150913100728.GA26562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 07:20:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbMBN-0002p1-8T
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 07:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbbINFT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 01:19:56 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:32888 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbbINFTx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 01:19:53 -0400
Received: by iofh134 with SMTP id h134so153993673iof.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 22:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7yInEdD6nvzyu5xBRxNeEJKXCVf1De0vx+4yfifqD2Q=;
        b=WT9Zj/fgnIm3ztzIKrEL7aPhHVoc7onDABCJFjm1GYkigib5NIQlmQ1QiHtn8Hno0x
         BGe6NH/QEyFUgk8BQdfaJ+IEQkhcp2A2ZGpOLXl1jvfSPULPd2tnr1OZBKoftbUzpQh+
         ccH8sX3rSL2l1QCklxzbvvj7MvtLkRxyDowQ+mJ1b/aqhO5a7VZdnF/yJ17eLIjen8OD
         SRb1fKMT/nFVnqJgAhkfC804oQrCp/+r/8btrNRbGsiYXStXA+l2fT6VFZ+n56UnHh1H
         h9NDwaJpLG41U5/uBmP9zRkPqERv8IAHP+1RE8T8zM4roZUxZjFV5RotvFFSi1hiqA0p
         LdDg==
X-Received: by 10.107.148.72 with SMTP id w69mr1416392iod.82.1442207992991;
 Sun, 13 Sep 2015 22:19:52 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Sun, 13 Sep 2015 22:19:33 -0700 (PDT)
In-Reply-To: <20150913100728.GA26562@sigill.intra.peff.net>
X-Google-Sender-Auth: d44Cx9KkZogANBt6_6Y2H8UJ0ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277806>

On Sun, Sep 13, 2015 at 3:07 AM, Jeff King <peff@peff.net> wrote:
>> The thing is, traversing first-parent chain in reverse fundamentally
>> is undefined.  You can fork multiple topics at the tip of 'master'
>> and each of the topics may be single strand of pearls, but which one
>> of the topics is the first-child-chain---there is no answer to that
>> question.
>
> In general I think I agree, but in the case of blame, we know that we
> are starting from a single tip (and we know because we are using
> first-parent that we remain in a single strand of pearls, because we
> follow only one parent and there are no cycles).

The thing is that the patch is inside revision.c machinery for --children,
and "rev-list --first-parent --children ^A ^B C" (i.e. range with multiple
bottoms) may be a perfectly a reasonable request. The requestor does
not necessarily know if A or B is an ancestor of C on the first-parent
chain. I am not sure if we are introducing unintended consequences
on this unrelated request only to change the behaviour of "blame".

For that matter, I am not sure how "blame A..B" with first-parent &
reverse should behave when A is not an ancestor on the first-parent
chain. Wouldn't we try to find a cut-point on the first-parent chain by
traversing first-parent chain from B and painting them as positive,
while traversing _all_ parents from B and painting them as negative,
until the traversal intersect? And wouldn't we discover at least two
children (one positive and one negative) for the cut point we discover
by that traversal? That cut point would be the (fake) latest state the
blame traversal starts at, and then we try to use the first (fake) parent
that in real life is the first child (which we do not have a good definition
for). And at that point a simple panda brain explodes ;-)

We might end up doing the right thing even in that case, but I haven't
convinced myself about that (yet).  If the change were limited to "blame",
the change may be much less problematic.
