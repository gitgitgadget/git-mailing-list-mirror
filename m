From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] --seed as an alias for --dissociate --reference
Date: Wed, 20 May 2015 22:01:49 -0700
Message-ID: <xmqqmw0yle0y.fsf@gitster.dls.corp.google.com>
References: <20150521041435.GA18978@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 07:01:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIcG-0000ym-EY
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 07:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbbEUFBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 01:01:51 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36579 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbbEUFBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 01:01:51 -0400
Received: by iepj10 with SMTP id j10so275540iep.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 22:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=40t1wx66AKvY1gIMNAGh7RcauwDoMNoHnm7lj7fxxyQ=;
        b=ISh8I3HWTIbzQ/n0eC2Z5ftaDCKJ6G3/pOw2dTZXbK7qV6mKTByc4nIlfL0gZpiRef
         N/RyLg4CRDT5SjAi10UTDE46t3kUgLLP/vXephgpboM4pDJrNwyrSai1xEACByQa5mCX
         n6QXOfA1ahAnNSbOBnnRrJYqy5+SGYCQW/iovpHZICFmJhGS6Q+c97QYGG0ZYvwdktfD
         XdhI39VvEHfN57MfsU00SIAg0SgYZbVUBzr1ZoY2B50yQth9AdPkK+/yEWixz5cy69tJ
         3YT1OWMcfuxvb//TdEZF5YI2YLzUtO5+wFqBJL/NbZwUKVjlgmtyqJ71kE3S7fAhBMoC
         lYTQ==
X-Received: by 10.50.225.35 with SMTP id rh3mr32250296igc.29.1432184510475;
        Wed, 20 May 2015 22:01:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id g12sm14068156ioe.28.2015.05.20.22.01.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 22:01:49 -0700 (PDT)
In-Reply-To: <20150521041435.GA18978@peff.net> (Jeff King's message of "Thu,
	21 May 2015 00:14:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269558>

Jeff King <peff@peff.net> writes:

> .... Having just read through it, I think a succinct name for the
> idea is "seed". That is, we seed the clone with objects from another
> repository.

That's a nice name.

> That thread also brought up the idea that we do not necessarily need to
> seed from a local repository; we could do something like:
>
>   1. Fetch from the seed repo into refs/seed/*
>
>   2. Fetch from the real clone source; the fetch is optimized by the
>      presence of refs/seed/*.
>
>   3. Delete refs/seed/*. Optionally repack to drop any objects needed
>      only by the seed refs.
>
> This is awkward with the "--reference" interface, because its
> implementation is publicly tied to the concept of alternates. Whereas
> "--seed" is about the end result you want; we can implement it using
> alternates or with a clone, depending on where the repo is located.

> There are a few open issues with this series:
>
>   1. Assuming that "seed" is a reasonable verb for this concept, is
>      "--seed=<repo>" OK for the option?  Would "--seed-from=<repo>" be
>      better? (Also, the response "bleh, seed is a terrible name" is
>      fine, too, but only if accompanied by your own suggestion :) ).

The seed may not even have to be a repository.  A bundle file hosted
on CDN that is reachable via (resumable) wget would be another good
way to prime the well, and it would fit with the above framework
nicely.  Grab it, fetch from it into a temporary hierarchy and then
run "fetch --prune" against the repository you originally wanted to
clone from.

>   2. My main goal here is making the concept easier to explain to users.
>      The documentation in the third patch explains "--seed" as an alias
>      for the other options, which probably isn't helping much. It might
>      make sense to have a patch 4/3 that explains "--seed" first, and
>      then explains "--reference" as "like --seed, but keep the
>      relationship after the clone". Or maybe they should just get their
>      own descriptions entirely.
>
>   3. We can't dissociate from a specific alternate, so using "--seed"
>      implies that all "--reference" options get dissociated. In this
>      series, I issue a warning in that case.  But that would be easily
>      solved if "--seed" used the fetch strategy described above, even
>      for local clones (which would probably still be quite fast if we
>      took clone's usual hard-link shortcut instead of actually fetching
>      from a local clone).
>
> I don't have particular plans to implement generic "--seed" from remotes
> anytime soon. I think this takes us a step in the right direction
> interface-wise, and it does introduce a succinct concept and
> option.

Yes.  I like the name, the concept and the general direction.
