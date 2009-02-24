From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] remote.c: make match_refs() copy src ref before assigning 
	to peer_ref
Date: Tue, 24 Feb 2009 01:53:48 -0500
Message-ID: <76718490902232253o4c7667d9h43f06d81794cef60@mail.gmail.com>
References: <7vzlgcmsan.fsf@gitster.siamese.dyndns.org>
	 <1235448334-36310-1-git-send-email-jaysoffian@gmail.com>
	 <7vfxi4mk8n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 07:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrCI-00021b-7z
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbZBXGxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbZBXGxv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:53:51 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:26584 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbZBXGxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:53:51 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2335819rvb.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 22:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vwbvHLHNAgIUyoT7S3d/D7uQtsjHQ7DR2M2iop1xsPY=;
        b=sOGDWF6GRlcaZJqdXQEvpnTevGpg+vgJBr1FH0EY9Y3qpjzqRcSW6lviTUX4RSIr2w
         8TLG6XKxFwB9VxF776+pJbNB2ptaSUECGrZAQQtVMOiGDyq3KOOlTejVLgClvrSPjF8u
         NIj5LncuE2vyx2PFOnHqMYld7t8DFYnQeugTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=anBR2rHVHjFYRtOOni8zkFFStSPS/JA1bxqi4V4TqoE9DD9pKslnxG0hU99XfcgXiV
         IIqoO+1DwcmlsEdX5Ik33LudmGnDl5pVzDMZ0E/ehPjU/1cqMUGYvxB9+8PNnPhqWgiP
         NHRspuDbyPpBrTQY0GZmBupZBhIuZYmfZZChU=
Received: by 10.141.122.1 with SMTP id z1mr2416694rvm.275.1235458428751; Mon, 
	23 Feb 2009 22:53:48 -0800 (PST)
In-Reply-To: <7vfxi4mk8n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111225>

On Tue, Feb 24, 2009 at 1:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> This issue has gone undetected as the existing callers of match_heads()
>> call it only once and then terminate, w/o ever bothering to free the src
>> or dst lists.
>
> Thanks.
>
> It sounds more like existing function and usage was alright but your new
> caller made it into an issue.

Well, maybe. The existing function alters the passed in dst argument
(a ref list) in two ways:

1) It potentially adds new refs to the tail of the list.
2) For the existing and new refs, it populates their peer_ref field.
When it does this, it sometimes just points it at an existing ref in
the src list, but sometimes it allocates a new ref and points to that.

So there is no sane way to free the result. As there is no indication
that the caller shouldn't be able to free the src and dst lists after
it is done, it was IMO a latent bug.

Initially I tried to fix this by modifying free_refs() to make two
passes over the list passed to it, once to mark each peer_ref, then a
second time to clear only those peer_refs it had not already seen. I
did this because when I first saw the double free I was only freeing
the dst list. It took me a while to realize the cause was two refs in
the dst list having the same peer_ref.

But then I realized my caller needed to clear the src list as well,
and saw that the problem was really in match_heads(), not in free'ing
the result.

> So I'd queue this as the first patch in the 13-patch series, dropping 10/13?
> What should happen to 11/13?

I sent you a message off-list you may not have read yet. I'm
re-rolling the entire js/remote-set-head for you off of the current
master to get rid of any dependencies on pu, with jk/head-lookup on
the end of the series instead of in the middle. I needed to rebase off
master since I have a dependency on cfa1ee6 which is now in master,
but wasn't when you spawned js/remote-set-head initially.

j.
