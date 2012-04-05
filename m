From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Thu, 5 Apr 2012 20:02:15 +0700
Message-ID: <CACsJy8BbNEJBn5i0Rntv21d8qvhPwkrNBdaj+sGh2W-aN9jYGg@mail.gmail.com>
References: <201203291818.49933.mfick@codeaurora.org> <201204021024.49706.mfick@codeaurora.org>
 <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
 <201204021049.04901.mfick@codeaurora.org> <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
 <20120402203728.GB26503@sigill.intra.peff.net> <CACsJy8DGaFg=oEwLWWo33cJa=SDuuZshW4=cZpifCWLp5gGcTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 15:02:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFmKy-0003NO-I5
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 15:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab2DENCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 09:02:47 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47300 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab2DENCq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 09:02:46 -0400
Received: by wejx9 with SMTP id x9so845210wej.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=12OnAMkj9PGeCCOxJp5ihMuHAc1LaKddn6wVNMwGvmo=;
        b=s9GWNL82E8i1f7YrCMM6Y18B+nEmuHZvi7wWGwiyk7NMDdUCnfimsVH/K+4haCP/oI
         8c4fNHij063valqmXCBWiEfAYjPcQYOoeXbs8Pw2sHNiT1Y+IJY4DmIuMrx/3443w37R
         r6GmcNqbFIVHfjN6iVLI+NhqFElS5JbQRuz4qi0tYHpDecPinQsUHET6eO01uGak77gk
         AGWPOKHgnBrMwjjv98o/QOUWTB1owAmMm8Zo/wuku1brVIuwD72BPd6RpimXOXbl/9HP
         uxpuHVtJq2E2c3r7bLvXVaIlG8WKkR0gY1U8VoCYXdqsuAXeY+PttQryPamapeemFpHX
         Vrcg==
Received: by 10.216.134.226 with SMTP id s76mr1601435wei.115.1333630965496;
 Thu, 05 Apr 2012 06:02:45 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Thu, 5 Apr 2012 06:02:15 -0700 (PDT)
In-Reply-To: <CACsJy8DGaFg=oEwLWWo33cJa=SDuuZshW4=cZpifCWLp5gGcTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194771>

On Tue, Apr 3, 2012 at 10:49 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> Has anyone looked seriously at a new index format that stores the
>> redundant information in a more easily accessible way? It would increase
>> our disk usage, but for something like linux-2.6, only by 10MB per
>> 32-bit word. On most of my systems I would gladly spare some extra RAM
>> for the disk cache if it meant I could avoid inflating a bunch of
>> objects. And this could easily be made optional for systems that don't
>> want to make the tradeoff (if it's not there, you fall back to the
>> current procedure; we could even store the data in a separate file to
>> retain indexv2 compatibility).
>>
>> So it's sort-of a cache, in that it's redundant with the actual data.
>> But staleness and writing issues are a lot simpler, since it only gets
>> updated when we index the pack (and the pack index in general is a
>> similar concept; we are "caching" the location of the object in the
>> packfile, rather than doing a linear search to look it up each time).
>
> I think I have something like that, (generate a machine-friendly
> commit cache per pack, staying in $GIT_DIR/objects/pack/ too). It's
> separate cache staying in $GIT_DIR/objects/pack, just like pack-.idx
> files. It does improve rev-list time, but I'd rather wait for packv4,
> or at least be sure that packv4 will not come anytime soon, before
> pushing the cache route.

When I looked at commit cache for rev-list, I tried to cache trees too
but the result cache was too big. I managed to shrink the tree cache
down and measured the performance gain. Sorry no code here because
it's ugly, just numbers, but you can look at the cache generation code
at [1]

On linux-2.6.git, one 521MB pack, it generates a 356MB cache and a
30MB index companion. Though if you are willing to pay extra 5 seconds
for decompressing, then the cache can go down to 94MB. We can cut
nearly half "rev-list --objects --all" time with this cache
(uncompressed cache):

$ time ~/w/git/git rev-list --objects --all --quiet </dev/null
real    2m31.310s
user    2m28.735s
sys     0m1.604s

$ time TREE_CACHE=cache ~/w/git/git rev-list --objects --all --quiet </dev/null
real    1m6.810s
user    1m6.091s
sys     0m0.708s

 $ time ~/w/git/git rev-list --all --quiet </dev/null
real    0m14.261s  # should be cut down to one third with commit cache
user    0m14.088s
sys     0m0.171s

Not really good. "rev-list --objects"'s taking less than 30s would be
nicer. lookup_object() is on top from 'perf' report with cache on. Not
sure what to do with it.

[1] https://gist.github.com/2310819
-- 
Duy
