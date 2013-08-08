From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 8 Aug 2013 09:18:47 +0700
Message-ID: <CACsJy8DoZkKP5QVN33=6VXc10mhEDyA6khaDww+L9eeyc20B1w@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com> <201308061810.46562.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Aug 08 04:19:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Fox-0000Wu-0r
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 04:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145Ab3HHCTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 22:19:19 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:63545 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506Ab3HHCTS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 22:19:18 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so4681407obb.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 19:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ygPwWmy1CDeLjnxo5fsayIGMGz/50ipzKLwv2kFJ+Jo=;
        b=Wt81OZ1Kllam3u7l2BMirSz6Wd5GgqgtLp1GpddgoBTZUPFCDXwfjxoJjPPNFCRqHz
         fpbNxDEdjNbuzZEyQ9es0/qjN2EgXsI5WECg0XkHIa8hpHcnMC2Yve9fkgG2HAPginFK
         qvtWh2CBh6YPe23Sf0zsNQFHHeb5+JgctBwLQ5ElUJY6rdaBG/9NLHcDohMDb7Rbx865
         epoEcWxRilOvWIHTrBDlxyyPI6o8ghOoh1j8QBO8ct0GUUi+vDXDsdHZQN2YBa+w4OVk
         SgSw6lxeGvyTwhTkbdGDhNOsVpBS1Ma2aQZ6qN50uaP4vpWLqOgzg1XqdmxYp1DNmOAZ
         ieOw==
X-Received: by 10.60.47.230 with SMTP id g6mr1352696oen.62.1375928357987; Wed,
 07 Aug 2013 19:19:17 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 7 Aug 2013 19:18:47 -0700 (PDT)
In-Reply-To: <201308061810.46562.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231857>

On Wed, Aug 7, 2013 at 7:10 AM, Martin Fick <mfick@codeaurora.org> wrote:
>> I wonder if a simpler approach may be nearly efficient as
>> this one: keep the largest pack out, repack the rest at
>> fetch/push time so there are at most 2 packs at a time.
>> Or we we could do the repack at 'gc --auto' time, but
>> with lower pack threshold (about 10 or so). When the
>> second pack is as big as, say half the size of the
>> first, merge them into one at "gc --auto" time. This can
>> be easily implemented in git-repack.sh.
>
> It would definitely be better than the current gc approach.
>
> However, I suspect it is still at least one to two orders of
> magnitude off from where it should be.  To give you a real
> world example, on our server today when gitexproll ran on
> our kernel/msm repo, it consolidated 317 pack files into one
> almost 8M packfile (it compresses/dedupes shockingly well,
> one of those new packs was 33M).  Our largest packfile in
> that repo is 1.5G!
>
> So let's now imagine that the second closest packfile is
> only 100M, it would keep getting consolidated with 8M worth
> of data every day (assuming the same conditions and no extra
> compression).  That would take (750M-100M)/8M ~ 81 days to
> finally build up large enough to no longer consolidate the
> new packs with the second largest pack file daily.  During
> those 80+ days, it will be on average writing 325M too much
> per day (when it should be writing just 8M).
>
> So I can see the appeal of a simple solution, unfortunately
> I think one layer would still "suck" though.  And if you are
> going to add even just one extra layer, I suspect that you
> might as well go the full distance since you probably
> already need to implement the logic to do so?

I see. It looks like your way is the best way to go.
-- 
Duy
