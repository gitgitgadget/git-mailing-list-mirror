From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 20:31:50 +0200
Message-ID: <94a0d4530901211031s18261776rf8abfddcdcb42402@mail.gmail.com>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
	 <49773240.7090605@drmicha.warpmail.net>
	 <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com>
	 <49773E48.90302@drmicha.warpmail.net>
	 <20090121161940.GA20702@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPht7-0005z6-72
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 19:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbZAUSbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 13:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZAUSbw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 13:31:52 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:59447 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbZAUSbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 13:31:51 -0500
Received: by mail-ew0-f20.google.com with SMTP id 13so1703052ewy.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kHzUoAt/r8829Fa4gqyEvw6Hv8Z6w17Plerkc77WT/Y=;
        b=uFzAMqauXFaeAYU/SvcsrO507941tm259T5FcrTOroPaLUx4JP8u3JJSjfy3Kcg37V
         ifI4XmwTqJJl1h/7gTC3ibOwQ5JWwNsAH2FoG2n+9eHomCEa84NoZCOtn0j4j0zS5Vgk
         CbGRHevyB4mbWufSQNaTrrn+wJWVU/Y30eDNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ibjXhnqRIQHMmI5kYNBmt+XANpCumukE1/Qy3V5aTriTUaK3YMXRwqhxZ+nobK1SzH
         Zi3wULM53hMNvfbQ3p6+L7rdzeyEUsFBLuVJCTXV6EiKYpgHfX3ODUELD4kUNQD+SznN
         UDO95qyrstlSPzUR/9yvEAXYe5uuAFjT4fl0s=
Received: by 10.86.93.17 with SMTP id q17mr1865192fgb.50.1232562710911; Wed, 
	21 Jan 2009 10:31:50 -0800 (PST)
In-Reply-To: <20090121161940.GA20702@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106637>

On Wed, Jan 21, 2009 at 6:19 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 21, 2009 at 04:24:56PM +0100, Michael J Gruber wrote:
>
>> So, you get these errors on the local repo when dealing with the remote
>> repo, right? I guess this means two things:
>>
>> 1) You are deleting a remote branch
>
> Actually, he doesn't have to delete the remote branch; somebody else
> can. The problem is that the HEAD pointer for his remote tracking
> branches points to a branch that doesn't exist. This can happen because
> we sometimes update the tracking branches (including deletion) without
> impacting the HEAD pointer.
>
> There are two ways that I can think of (and there may be more) to
> provoke this:
>
>  1. delete a remote branch via push. The local side will helpfully
>     delete your local tracking branch to match what happened on the
>     remote. If it was the remote's HEAD, then you get a broken state
>     (and while we discourage pushing to the remote HEAD on a non-bare
>     repo, it is perfectly OK for a bare one).
>
>  2. somebody else deletes the remote branch that is the HEAD, and you
>     update your tracking branches via "git remote prune", which deletes
>     your tracking branches corresponding to any deleted remote branches.
>
> And actually there is a slight variant on both of the above. The deleted
> branch does not actually have to be the current HEAD on the remote. It
> just has to match your _idea_ of the current HEAD on the remote, which
> may be out of date.
>
> Situation (1) happens entirely locally. So it can be fixed fairly easily
> by checking whether the remote tracking HEAD points to a branch we are
> deleting, and deleting the HEAD in that case (the code should be in
> builtin-send-pack.c:update_tracking_ref). Of course you have probably
> also created a broken situation on the remote, so perhaps receive-pack
> should handle that.
>
> Situation (2) could do something similar: when we see that we are about
> to delete the ref pointed to by the remote tracking HEAD, we could
> delete the HEAD.
>
> But both situations are a little hack-ish to me. You are deleting the
> HEAD because you don't know what the right value is from the remote end.
> A better fix would be to actually pull the HEAD information down during
> fetch. And I seem to recall a patch about that at some point (it
> required a new protocol extension), but I don't know what become of it.
>
> However, even if we kept the tracking HEAD totally in sync with the
> remote's HEAD, it still may be possible that the remote HEAD is broken.
> In which case it might be nice to detect that when pulling it down and
> just leave the tracking HEAD unset.

Why should we care about the remote HEAD? Isn't that relevant only
when cloning to find out the branch to checkout?

Also, it's not nice to leave the remote repo with a broken HEAD
pointer, shouldn't git ask for a new head, or fail with a proper
message?

-- 
Felipe Contreras
