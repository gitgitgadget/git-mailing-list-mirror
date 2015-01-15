From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Introducing different handling for small/large transactions
Date: Thu, 15 Jan 2015 15:24:15 -0800
Message-ID: <CAGZ79kbXYm66StsAwHFdTovkYeDVHWV2PdCK0abVXwWiD7sAAg@mail.gmail.com>
References: <1421361371-30221-1-git-send-email-sbeller@google.com>
	<20150115224605.GD19021@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:24:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBtm1-0003ZF-BM
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 00:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbbAOXYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 18:24:17 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33058 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbbAOXYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 18:24:16 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar1so17940197iec.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 15:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7wjmP8H60tpA5lJeqwtvQ+v3bjYNRhQo44zux522Xeo=;
        b=kbxZYqxPMEE7p0AsMFUdcsTKfrro96DVKRfRPTbyd36XNYtuLtGxxYBBKgyqbsgdDV
         FzJkMHzPiDGVO5MwBI9vHnumqrNn0i/h+fCto/Fz9QjTy14nYDxmioN50ks66D/PolDw
         n4SFAXvCmiZ+QHZa1WqUGzwkApUIfizIxXJzCux0+Ir9TiStT+kItc14QWXLvF79ecZU
         3/2FH5zf6WePvY2G/nHl6h0lL3H5R0DxTeRXCG2Y+V/w0JE4fay2HjVC/DBunB3MS+/y
         ybm4gZzMbDjfEBPmFG4ZhG+khOokW8aOUt4Ao9vzDiNK9WLLZUjKdaQt/Y/Je3F+c3w9
         JmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7wjmP8H60tpA5lJeqwtvQ+v3bjYNRhQo44zux522Xeo=;
        b=TkM1eNDh5gkTlKpZRhNppofM8pVN+Qe3N5w6CRQrMX1deHE9HDxnLbeVdnvHKuW+XJ
         gP+eqAlmysJ75fXmL+oHInNIIUB1L4kfyabRkhALK/lhx8veYC7oDex3Kghfk0Eo0F+4
         GG75EaV3osSyUvCQclKZQe94h6PyQXqXR3Kkbzt4YLqiuCKVepFh2E2u7+KbzjiFhYbS
         LRJmTYpIQFKRVf7KeA7icuYcrUGln/YUp5YgfRMxy1Ocu6y5k5JJlvOPG9CvkI5NbId3
         vggu4nPsgTfv0trgftVD8kE+uguHhGFt1sqv8LuwKpNUKCHiISM8LnfT6X5njZzy4h9E
         gX8w==
X-Gm-Message-State: ALoCoQkq6veQkBgFNR/LndCYLCRtmO0dtYHuVG2mjyU5FXI04q1Z2PWZ5Sfz7yX8NxmpUcwFkVam
X-Received: by 10.50.122.68 with SMTP id lq4mr574842igb.10.1421364255240; Thu,
 15 Jan 2015 15:24:15 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Thu, 15 Jan 2015 15:24:15 -0800 (PST)
In-Reply-To: <20150115224605.GD19021@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262521>

On Thu, Jan 15, 2015 at 2:46 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 15, 2015 at 02:36:11PM -0800, Stefan Beller wrote:
>
>> So for here is my proposal for small transactions:
>> (just one ref [and/or reflog] touched):
>
> The implication being that a "large" transaction is any with more than
> one update.

Exactly.

>
> I think performance may suffer if you do not also take into account the
> size of the packed-refs file. If you are updating 5 refs and there are
> 10 in the packed-refs file, rewriting the extra 5 is probably not a big
> deal. If there are 400,000 in the packed-refs file, it probably is. I'm
> not sure where the cutoff is (certainly the per-ref cost is less for
> packed-refs once you have started writing the file, so there is probably
> some crossover percentage that you could measure).
>
>>       * detect if we transition to a large transaction
>>         (by having more than one entry in transaction->updates)
>>         if so:
>>               * Pack all currently existing refs into the packed
>>                 refs file, commit the packed refs file and delete
>>                 all loose refs. This will avoid (d/f) conflicts.
>>
>>               * Keep the packed-refs file locked and move the first
>>                 transaction update into the packed-refs.lock file
>
> This increases lock contention, as now independent ref updates all need
> to take the same packed-refs.lock. This can be a problem on a busy
> repository, especially because we never retry the packed-refs lock.
> We already see this problem somewhat on GitHub. Ref deletions need the
> packed-refs.lock file, which can conflict with another deletion, or with
> running `git pack-refs`.
>
> -Peff

I see the performance problem as well as the contention problem
you're pointing out. Dealing with loose refs however creates other
problems such as directory/file conflicts on renaming. I am trying to
think of a way which moves most of the failures to the transaction_update
phase, such that the transaction_commit is rather easy and not expected
to produce many errors.

So I think dealing with a generic large transaction cannot be really solved
outside the packed refs file. There could be another special case for mass
deleting refs however. Or retries for the packed refs file. Or we first check if
we *really* need to lock the packed refs file (just realized we
already do that :/)

(just curious:)
May I ask on which kinds of repository you can see packed-refs.lock contention?

I want to improve git atomicity, specially for 'weird' cases as presented in my
previous mail[1]. Eventually I even want to have cross repository atomicty in
git, so an example could be:
(
    cd API-Provider &&
    edit files # new changes breaking the API
    git commit -a -m "..."
) &&
(
    cd API-consumer
    edit files # use new and shiny API
    git commit -a -m "..."
) &&
git multipush --atomic API-Provider:origin:master API-consumer:origin:master

When having such a goal a reliable and easy to use ref transaction API makes
life lots more easier. By reliable I mean that there are no sudden problems
as pointed out in [1], these kinds of rejections make users unhappy. And by
easy to use I mean there are only a few functions I need to know and no
proliferation of functions exposed in the API. Internally we can do all we want
such as special cases for delete-only transactions.

As another unrelated thought (400,000 refs is quite a lot)
Would it make sense to have packed-refs files grouped by topic directory, i.e.
one packed-ref for
    topic/1
    topic/2
    topic/*
and another packed ref for
    feature/a
    feature/b
    feature/*

This would rather help your problems with contention instead of making things
more atomic though. But that would avoid 400,000 refs in one packed refs file,
which then may still be easier to handle for larger transactions.

Thanks,
Stefan

[1] http://www.mail-archive.com/git@vger.kernel.org/msg63919.html
