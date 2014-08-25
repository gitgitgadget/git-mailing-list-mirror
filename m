From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 0/5] fix pack-refs pruning of refs/foo
Date: Mon, 25 Aug 2014 10:38:56 -0700
Message-ID: <CAL=YDWkFpjnsr+eqcOdrYQAPaPMfCdg17+yKvN=CwELbsOi-VA@mail.gmail.com>
References: <20140823052334.GA17813@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:39:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLyER-0001uX-Pz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933071AbaHYRi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 13:38:59 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:40263 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933017AbaHYRi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 13:38:58 -0400
Received: by mail-vc0-f176.google.com with SMTP id id10so15345469vcb.21
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P1XqfFJHz/o6czE5/g8ELtigg2Owo1WqNIFnZa7jSuM=;
        b=aFGdbzZ/wCN8ESBi8wqAVYZIKW3yaQj4P/Aw0b1twskSOVPvWkrBM/UUaftqvRS77V
         H1uaylRQ4x6QBOt+eyVYe7NkC8buc13eDspp4NmkCI66ehO4DCa1zJROthtGuXYnaAdR
         GoVab9CdiVCRPUfuS8qtwoWjwskEUb9BhdrjQ25x+Pd9oVfu6R6ZdaTLKwyUTCGW7IGT
         80CJqUqkMTNC9RufxnqbNNPy2n8/rZGv2BOFjuX5NbxKcOAdvnRFecJAJQiy/5TBVdOk
         OBvJaO/Vt9NndY8je7qd1i71ROSWtnQ03aBFlIZ2X3jp0fxbDK13BRM80dUXPrdLA8nQ
         N2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=P1XqfFJHz/o6czE5/g8ELtigg2Owo1WqNIFnZa7jSuM=;
        b=Rom7vKGW5eKG9PWe475wpKhKJhd+f66merkoiQy1n1dai4A4ywSua//Ra571n3vGzB
         QrlXTffQHPzlwruImd6gH8vq7ENHgIKllvexWOxO1vid0U/t5Xp+IfrRmGH5gjsqgiyQ
         P8hbNQrfAWNtoJXBZPHEmgiCbQJzKomDBRLw9e5Q40ZhzUDiNu86hHn7sjqmfUwzMPYs
         G7HCPptgKpGAvi9xohTQ5KQN4eFEPqWkN0njLcuf8WQmL83zc52IZBMoIsg9i5xYcDgf
         655sE/RtMGMqAyU51q0oPPOLmnrbjRw1WazZaIQhNwH35V98sgUxORdmJRYRyP6Ch7ii
         KH8A==
X-Gm-Message-State: ALoCoQn3nb70xiBJPOVH2dOsFg0ALNOOj42nnd4a7bnNHtpH2xw7Kk1mT2/pqxalfRCdFmaDAMnc
X-Received: by 10.52.246.198 with SMTP id xy6mr16696449vdc.7.1408988336684;
 Mon, 25 Aug 2014 10:38:56 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Mon, 25 Aug 2014 10:38:56 -0700 (PDT)
In-Reply-To: <20140823052334.GA17813@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255841>

On Fri, Aug 22, 2014 at 10:23 PM, Jeff King <peff@peff.net> wrote:
> I noticed that "git pack-refs --all" will pack a top-level ref like
> "refs/foo", but will not actually prune "$GIT_DIR/refs/foo". I do not
> see the point in having a policy not to pack "refs/foo" if "--all" is
> given. But even if we did have such a policy, this seems broken; we
> should either pack and prune, or leave them untouched. I don't see any
> indication that the existing behavior was intentional.
>
> The problem is that pack-refs's prune_ref calls lock_ref_sha1, which
> enforces this "no toplevel" behavior. I am not sure there is any real
> point to this, given that most callers use lock_any_ref_for_update,
> which is exactly equivalent but without the toplevel check.
>
> The first two patches deal with this by switching pack-refs to use
> lock_any_ref_for_update. This will conflict slightly with Ronnie's
> ref-transaction work, as he gets rid of lock_ref_sha1 entirely, and
> moves the code directly into prune_ref. This can be trivially resolved
> in favor of my patch, I think.
>
> The third patch is a cleanup I noticed while looking around, and I think
> should not conflict with anyone (and is a good thing to do).
>
> The last two are trickier. I wondered if we could get rid of
> lock_ref_sha1 entirely. After pack-refs, there are two callers:
> fast-import.c and walker.c. After converting the first, it occurred to
> me that Ronnie might be touching the same areas, and I see that yes,
> indeed, there's quite a bit of conflict (and he reaches the same end
> goal of dropping it entirely).
>
> So in that sense I do not mind dropping the final two patches. Ronnie's
> endpoint is much better, moving to a ref_transaction. However, there is
> actually a buffer overflow in the existing code. Ronnie's series fixes
> it in a similar way (moving to a strbuf), and I'm fine with that
> endpoint. But given that the ref transaction code is not yet merged (and
> would certainly never be maint-track), I think it is worth applying the
> buffer overflow fix separately.
>
> I think the final patch can probably be dropped, then. It is a clean-up,
> but one that we can just get when Ronnie's series is merged.
>
>   [1/5]: git-prompt: do not look for refs/stash in $GIT_DIR
>   [2/5]: pack-refs: prune top-level refs like "refs/foo"
>   [3/5]: fast-import: clean up pack_data pointer in end_packfile
>   [4/5]: fast-import: fix buffer overflow in dump_tags
>   [5/5]: fast-import: stop using lock_ref_sha1
>

+1 on 1-3
+1 on 4. While I have a similar fix in the transaction series, you
should not need to wait for that series to address a security concern.
5: I think this one is not as urgent as the others so would prefer if
it is dropped, just so it doesn't cause more merge conflicts than is
already present in the transaction series.


1-4:
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>


> -Peff
