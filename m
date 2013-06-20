From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] remote: make prune work for mixed mirror/non-mirror
 repos
Date: Fri, 21 Jun 2013 01:07:16 +0200
Message-ID: <1371769636.17896.44.camel@localhost>
References: <1371763424.17896.32.camel@localhost>
	 <1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
	 <7vppvgpfib.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 01:07:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upnwr-0007pb-Me
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 01:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758021Ab3FTXHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 19:07:20 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:61756 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab3FTXHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 19:07:19 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so107363wgg.4
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 16:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding
         :x-gm-message-state;
        bh=BzGM6IVSKkwMbT3ROSJ85Dqi1VYw+O7aA2CdG7jgIHw=;
        b=hH8B8gtWhqkDc+JLFEhb7l+pe+kdNQscqZqexmDyiboMlbx69Slc3RmKlFXQjyfRNE
         UC23nHKcaTIp9DRFCrHyFzaFy2N0Fi6/o2By+7CVwPxo8/Zk42uRspdoj01cXGqQu1m8
         Kl4LPy5zuE+PQ9YLuSpYOI08WRm3y0gvixyzkVKN9yYMhEdWOp7xFllU7zPxMzMNjIOL
         Mil73XmOa6EcG1ClbaL7btRtWE0/GBcjKvKhCRyhJlMFUy1DHkOUxvKYXgbyyOfhWHX1
         g9xeIfUcPY4j5uh9/pkt2t7uWpCd1bnZD3k8TVCMe1eUNhUW/h/it+AgSW35g5vcwIdb
         xFTw==
X-Received: by 10.194.120.7 with SMTP id ky7mr7184934wjb.89.1371769638424;
        Thu, 20 Jun 2013 16:07:18 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id cw8sm19250805wib.7.2013.06.20.16.07.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 16:07:17 -0700 (PDT)
In-Reply-To: <7vppvgpfib.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQmsI6XiXy/46R1EkxQ3nk4UNCkaZAhbQEuva5WqXg1tCM3U7LuO1znGvrKNlFF5yjMinpst
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228556>

(Sorry, I sent v2 before seeing this mail)

On do, 2013-06-20 at 15:46 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > When cloning a repo with --mirror, and adding more remotes later,
> > get_stale_heads for origin would mark all refs from other repos as stale. In
> > this situation, with refs-src and refs->dst both equal to refs/*, we should
> > ignore refs/remotes/* when looking for stale refs to prevent this from
> > happening.
> 
> I do not think it is a right solution to single out refs/remotes/*.
> 
> Going back to your original example:
> 
>     [remote "origin"]
>             url = git://github.com/git/git.git
>             fetch = +refs/*:refs/*
>             mirror = true
>     [remote "peff"]
>             url = git://github.com/peff/git.git
>             fetch = +refs/heads/*:refs/remotes/peff/*
> 
> Wouldn't you obtain "refs/remotes/github/html" from your "origin"
> via "git pull origin"?  What happens to your local copy of that ref,
> when it goes away from the origin and then you try to "fetch --prune
> origin" the next time with this patch (and without this patch)?

git pull origin gives me refs/html in this case. I did not try fetch
--prune, but prune origin DTRT: if the html branch goes away at the
origin, it goes away locally. Both with and without this patch.

It's refs/remotes/peff/somebranch that in this case *also* goes away
without this patch, but is untouched with this patch

> What should happen?

Exactly that.

> What if you had this instead of the above version of remote.peff.*?
> 
>     [remote "peff"]
>             url = git://github.com/peff/git.git
>             fetch = +refs/heads/*:refs/remotes/github/*

That doesn't change anything.

> I think this is an unsolvable problem, and I _think_ the root cause
> of the issue is the configuration above that allows the RHS of
> different fetch refspecs to overlap.  refs/* is more generic and
> covers refs/remotes/peff/* and refs/remotes/github/*.  You cannot
> even know, just by looking at "origin" and your local repository,
> if refs/remotes/github/html you have should go away or it might have
> come from somewhere else.
> 
> The best we _could_ do, without contacting all the defined remotes,
> is probably to check each ref that we did not see from "origin" (for
> example, you find "refs/remotes/peff/frotz" that your origin does
> not have) and see if it could match RHS of fetch refspec of somebody
> else (e.g. RHS of "refs/heads/*:refs/remotes/peff/*" matches that
> ref).  Then we can conclude that refs/remotes/peff/frotz _might_
> have come from Peff's repository and not from "origin", and then we
> can optionally issue a warning and refrain from removing it.

I like that idea, though I also like the simplicity of simply singling
out "remotes" as that's where normal remotes usually sit. And don't
forget about tags (see patch v2).

> This inevitably will have false positives and leave something that
> did originally came from "origin", because peff may no longer have
> 'frotz' branch in his repository.  I do not think we can do better
> than that, because we are trying to see if we can improve things
> without having to contact all the remotes.

But then the ref would have to be called "refs/remotes/peff/frotz"
upstream. Hmm, that is of course completely possible: cloning something
that's already a clone.

> But if you go that route, the logic needs to go the same way when
> you are pruning against 'peff', and anything that you do not see in
> his repository right now but you have in refs/remotes/peff/ cannot
> be pruned, because it might have come from your origin via more
> generic refs/*:refs/* mapping.  It follows that you could never
> prune anything under refs/remotes/peff/* hierarchy.
> 
> You could introduce a "assume that more specific mapping never
> overlaps with a more generic mapping" rule (i.e. refs/* from RHS of
> remote.origin.fetch is more generic than refs/remotes/peff/* from
> RHS of remote.peff.fetch, and assume everything that you see in your
> local refs/remotes/peff/* came from peff and not from origin, I
> think, but at that point, is it worth the possible complexity to
> code that rule in the prune codepath and brittleness of that
> assumption that your origin will never add a new ref under that
> hierarchy, e.g. refs/remotes/peff/xyzzy?
> 
> So, I dunno.

Yeah, I'm starting to think this is not such a good idea. How about plan
B: issuing a warning when adding a remote with a refspec that also
matches another remote's refspec?

Or plan C: add a per-remote pruneIgnore setting that in this case I
could set to refs/tags/* refs/remotes/* as I know it's correct? Could
even be combined with plan B.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
