From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Wed, 15 Aug 2012 13:50:01 -0700
Message-ID: <CAOeW2eGcVQ74WLOOHWvKao9WXfWnJpOhQwE8Jxip_E4SzkFjyA@mail.gmail.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
	<50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
	<7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
	<CAOeW2eEbe9_m_QSbsJUbWPhf6G17X3vqbh__TCefrB0G2VKXdw@mail.gmail.com>
	<7vehnacxkf.fsf@alter.siamese.dyndns.org>
	<CAOeW2eH--Y_gq4jBBhd5EQRw+uuaNWrMT-Sua7CeJO-N9KHCLg@mail.gmail.com>
	<7vk3x06ppi.fsf@alter.siamese.dyndns.org>
	<CAOeW2eFK+cKt9Tnh5oe74dU+f8rOOTaWk3KvE2rtUpgcOeDD7g@mail.gmail.com>
	<7vr4r857au.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:50:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1kXc-0004Bx-7N
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 22:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab2HOUuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 16:50:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42564 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab2HOUuC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 16:50:02 -0400
Received: by pbbrr13 with SMTP id rr13so364900pbb.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jAVe4TfhL2kj5Pi8Xwib4bKs35fp87JwUwueEGncnEQ=;
        b=09dmhk0305DCJD3hHDNOe26zBvBuw8wEKz95nTcGJpG4tuhegt9gc9CAoGpKJe1TfL
         nZEuuPofHcgyISifqowOPHsyUhtKGmR/hvrY3YgBddaZ8D+8hwjeA41i1anuzc4cu6Hr
         V1xHWP9/D8TmeiTWlWEcv+BemU1Au6lJAWJ4LdEghBhvNIj9ZZYYDzYm1ZjQS8zet35p
         8uN/dcYbsm0gGGDGHxjMZ9G2BGHmWACOCrEa8/t1I8QSYds4OFsm4uI2Xj0fJ+LGVImT
         q8y4kwVln1gg1iZTm2O9b9+uLadOTh84clXZ86vHtKstVhP4SVfOKrrDSwDA9vSQtCwV
         PsHw==
Received: by 10.68.220.201 with SMTP id py9mr15918763pbc.137.1345063801520;
 Wed, 15 Aug 2012 13:50:01 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Wed, 15 Aug 2012 13:50:01 -0700 (PDT)
In-Reply-To: <7vr4r857au.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2012 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> Makes sense, I'll try to implement it that way. I was afraid that
>> we would need to call prepare_revision_walk() once first and then
>> if we afterwards find out that we should not walk, we would need
>> to call it again without the reverse option.
>
>> But after looking at
>> how rev_info.reverse is used, it seem like it's only used in
>> get_revision(), so we can leave it either on or off during the
>> prepare_revision_walk() and the and set appropriately before
>> calling get_revision(), like so:
>>
>>   init_revisions(&revs);
>>   revs.no_walk = REVISION_WALK_NO_WALK_UNSORTED;
>>   setup_revisions(...);
>>   prepare_revision_walk(&revs);
>>   revs.reverse = !revs.no_walk;
>
> Sorry, but I do not understand why you frutz with "reverse" after
> prepare, and not before.
>
> I think you can just set no_walk and let setup_revisions() turn it
> off upon seeing a range (this happens in add_pending_object()).

Ah, of course. For some reason I thought that was called from
prepare_revision_walk()

> After setup_revisions() returns, if no_walk is still set, you only
> got individual refs without ranges, so no reversing required.

Yes, it's in the other case (e.g. 'git cherry-pick A..C', when
no_walk is not set), that we need to set reverse before walking.

> You also need to be careful about "revert" that shares the code;
> when reverting range A..C in your example, you want to undo C and
> then B, and you do not want to reverse them.

Yep. It looks like this, so should be safe. But thanks for the reminder.

  if (opts->action != REPLAY_REVERT)
        opts->revs->reverse ^= 1;
