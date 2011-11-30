From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Wed, 30 Nov 2011 20:35:02 +0700
Message-ID: <CACsJy8A6kGmn0h0xdxfTC4krXgc8hzO1fHTdqfk0YnASGN5K0w@mail.gmail.com>
References: <1322546563.1719.22.camel@yos> <20111129090733.GA22046@sigill.intra.peff.net>
 <CACsJy8DboVU4kSbJSV=8NP08OyLYVgOKsm8tt=koZ0=JcGSE=A@mail.gmail.com> <20111129205905.GA1793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bill Zaumen <bill.zaumen+git@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, spearce@spearce.org,
	torvalds@linux-foundation.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 14:35:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVkK3-000174-TF
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 14:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab1K3Nff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 08:35:35 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53471 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab1K3Nfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 08:35:34 -0500
Received: by yenl6 with SMTP id l6so492393yen.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 05:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MXnvz0wve1kG6MEDdsvrTZUaaubqpo34H0kRFjyK0hQ=;
        b=JiELHtWa/Wk5y0kS6Gacaa8PJWJvwD7tKssrakpQXDiSs+wm41QljTANkz6dLmZLAW
         HsZoxmXyzIgwEv34p42SiBg58eHisGlkPlvYr/Lfgm5+8MN7VU8flhaB6I9C+DqCLztt
         XrJRzQMNN2Sg2i1kkIU0WvZG/iI6BZjObrb6M=
Received: by 10.205.128.15 with SMTP id hc15mr2287968bkc.110.1322660133485;
 Wed, 30 Nov 2011 05:35:33 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 30 Nov 2011 05:35:02 -0800 (PST)
In-Reply-To: <20111129205905.GA1793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186125>

On Wed, Nov 30, 2011 at 3:59 AM, Jeff King <peff@peff.net> wrote:
> If you wanted to say "make a digest of all of the sub-objects pointed to
> by the tag", then yes, that does work (security-wise). But it's
> expensive to calculate. Instead, you want to use a "digest of digests"
> as much as possible. Which is what git already does, of course; you hash
> the tree object, which contains hashes of the blob sha1s. Git's
> conceptual model is fine. The only problem is that sha1 is potentially
> going to lose its security properties, weakening the links in the chain.
> So as much as possible, we want to insert additional links at the exact
> same places, but using a stronger algorithm.

What I'm thinking is whether it's possible to decouple two sha-1 roles
in git, as object identifier and digest, separately. Each sha-1
identifies an object and an extra set of digests on the "same" object.
Object database is extended to store all these new digests and mapping
between sha-1 and them. When we need to verify an object, given an
sha-1, we rehash that object and check the result digest with the ones
linked to the sha-1.

These new digests would be "digest of digests" just like how we use
sha-1. In fact this new digest set could be just sha-1. We just don't
hash trees/commits/tags as-is when computing these new digests. When a
tree object is hashed, for example, a new tree object with new digests
will be created for hashing (we keep sha-1 <-> new digest mapping on
disk). Think of duplicating an entire DAG with new digests as links
instead of sha-1, then we keep digests and drop the DAG.

The day sha-1 is broken, a project can generate new digests from its
old good repo and enforce developers to use new digests for
verification instead of sha-1. sha-1 is still used by git as
identifier after that day.

Computing these digests is expensive, but for local, day-to-day use,
we only need sha-1 as identifier (correct me if I'm wrong here), so we
can delay compute/store these new digests until we absolutely need
them (e.g. push/fetch). There is also an interesting case, assume
these digests are strong enough, we could replace sha-1 as identifier
in git with a cheaper hash. A new hash must fit in 160-bit space that
sha-1 takes and should have good distribution, of course. Projects
with a lot of data may like it that way.
-- 
Duy
