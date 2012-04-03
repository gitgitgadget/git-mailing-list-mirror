From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Tue, 3 Apr 2012 12:02:29 +0530
Message-ID: <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.w-lists@sohovfx.com>,
	Andrew Wong <andrew.w@sohovfx.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 08:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SExIW-0006pA-LM
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 08:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab2DCGcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 02:32:52 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57491 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab2DCGcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 02:32:51 -0400
Received: by wibhj6 with SMTP id hj6so3312905wib.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9nYokn/Lwd7pNHSOwlxYjPQS0kcXUb3c9Peg3Vj+MBM=;
        b=RirMGKOn0KhnORqD7zLwDikyD/36YFpf5epR7Gif/PRH5Lcmfglm5o6gy8enLZWbW2
         xmI/6Q4Cfa4uLstDtykBxuSA+zsSCGQXxgkpBly7Lb2t/BIG1GUWA56RrkYiWWQMCM1H
         1JsP+D9GPvdueep4Qx/GCrqY4liFzjdtR53OJeRISAzeDviMW1lBI3UM+W3CyYAnpXM/
         383nupiVR774wj1+1CVm0uQQVlGv09tTEaTKxJg3ImKg5CSSX7swbYzKaBJNSebljkE+
         /iwF/FadBwZ2XRKBa9FzpIJcB72P1Xrwozqoro0CMIgIgNUU4bp3tqRUNN3ji9ubI3PR
         tXuA==
Received: by 10.180.102.129 with SMTP id fo1mr33071401wib.6.1333434770122;
 Mon, 02 Apr 2012 23:32:50 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Mon, 2 Apr 2012 23:32:29 -0700 (PDT)
In-Reply-To: <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194595>

Hi Andrew,

[+CC: Jonathan Nieder]

Andrew Wong wrote:
> Instead of having the sequencer catch errors and remove CHERRY_PICK_HEAD
> for its caller's sake, let its caller do the work. This way, the
> sequencer doesn't have to check all points of failures where its caller
> doesn't want CHERRY_PICK_HEAD.

This part makes sense.

> For example, the sequencer current doesn't clean up CHERRY_PICK_HEAD if
> 'commit' failed due to an empty commit. Letting 'rebase -i' deal with
> removing CHERRY_PICK_HEAD keeps the sequencer's logic a bit cleaner.

Yes, that's because git-commit is spawned.  The sequencer has no way
to tell if the commit was actually successful.  Incidentally, what is
your motivation for this patch?  Did the "rebase -i" or the sequencer
misbehave in some scenario?  Wouldn't it make sense to add a failing
test for that scenario first?

Also, note that in a previous iteration, we considered the possibility
of making git-commit remove CHERRY_PICK_HEAD, but decided that it
would be ugly subsequently.

> A possible condition would be checking the env var GIT_CHERRY_PICK_HELP,
> which is only set if 'cherry-pick' is called under 'rebase -i'. I never
> liked how we're passing in a help message using an env var, so I don't
> feel like introducing another dependency on this env var is a good idea.

True; this is ugly.  It detracts us from the purpose of the patch
which is to shift the responsibility of cleaning up CHERRY_PICK_HEAD
to the caller.

> Another possible condition would be to add another flag to
> "cherry-pick". But a proper implementation would not only involve adding
> code to parse the flag in 'cherry-pick', but also adding code to
> save/restore the option in sequencer, even though 'rebase -i' only need
> it for single_pick. It's not that adding these codes are difficult, but
> it seems like we're adding a lot of code just to add a behavior that
> only 'rebase -i' needs.

Another ugly solution.

> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> [...]

Bonus: After this patch, the sequencer code is symmetric in
CHERY_PICK_HEAD and REVERT_HEAD.  How do we convince ourselves that
we're not breaking some corner case though?  I'd be more comfortable
with the patch if you can present a failing test first.

Thanks.

    Ram
