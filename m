From: ronnie sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 0/8] Making reflog modifications part of the transactions API
Date: Fri, 12 Dec 2014 16:16:07 -0500
Message-ID: <CAN05THRiMiQCqO1VZX7zQeWLBZMPG_sx1aVvdGirAoEh2Hd9Dw@mail.gmail.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
	<548B150C.2090606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:16:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzXZn-0002Hm-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 22:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbaLLVQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 16:16:31 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:44110 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbaLLVQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 16:16:09 -0500
Received: by mail-lb0-f175.google.com with SMTP id u10so6454695lbd.6
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 13:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rhjjKVd3bAxbPD/wpPCSpR7An3KQBrCgAqt8wgWmSKY=;
        b=kHkT7RegY9g0uoC3obzAqV+B0MvzI/+hIWBWW6Cd3ABel91FTPc17W3t74IRZ1Dwuv
         57YpIsl8zVtT+2XBRXrIJZJyVGziS6mnBzQ0MupRGSx7+nNyO0Vgv49+yQ1u4mSL7mx3
         AfK5+HV6QpuCWP8qBUYon5rDHbO2OFELe7onQCXmrWEngcP4P+5V6eWAu11M+7AHGrji
         +COdJgy+dqa8/LMrEnu2Q2u0NbvkdUfQoM9wlCBeghAo+BZGBtaxfgx3rWW5fELctJoT
         2Mjuv80+rgk0DmLUOxG5nlygdEqe9r7U147zMdShk5143DfIFl6I1vyvIJYuelEXSt0/
         J6Ew==
X-Received: by 10.152.116.101 with SMTP id jv5mr7518310lab.13.1418418968066;
 Fri, 12 Dec 2014 13:16:08 -0800 (PST)
Received: by 10.25.15.67 with HTTP; Fri, 12 Dec 2014 13:16:07 -0800 (PST)
In-Reply-To: <548B150C.2090606@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261373>

On Fri, Dec 12, 2014 at 11:17 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/06/2014 03:46 AM, Stefan Beller wrote:
>> This goes on top of Michaels series. The idea of this series is make the
>> reflogs being part of the transaction API, so it will be part of the contract
>> of transaction_commit to either commit all the changes or none at all.
>>
>> Currently when using the transaction API to change refs, also reflogs are changed.
>> But the changes to the reflogs just happen as a side effect and not as part of
>> the atomic part of changes we want to commit altogether.
>
> Would you please explain why this patch series is still needed if my
> "reflog_expire()" series is accepted?
>
> reflog_expire() already has its own little transaction. Reflog
> expiration never needs to be combined with other reference changes, so
> there is no need for reflog expiration to be done via a ref_transaction.
>
> ref_transaction_commit() already updates the reflog if necessary when a
> reference is updated. That update is part of the containing
> ref_transaction, because it is locked by the lock on the reference
> itself at the beginning of the transaction and unlocked at the end of
> the transaction [1]. It can't fail in normal circumstances because the
> preconditions for the transaction have already been checked.
>
> As far as I can tell, the only thing left to do is provide a substitute
> for log_ref_setup() a.k.a. create_reflog() that can be triggered within
> a transaction. In my opinion the easiest way to do that is to give
> ref_transaction_update()'s flag parameter an additional option,
> REF_CREATE_REFLOG, which forces the reference's reflog to be created if
> it does not already exist.
>
> What am I missing?
>

My original idea was to clean up a bit of the reflog handling API and
have one single transaction API for all  ref and reflog operations.

Think future use cases where you have a database backend for both refs
and reflogs. It would be very nice to have a single atomic transaction
that would either commit or fail atomically any update to refs and/or
reflogs.
Otherwise you would have all consumers of the API have to invent their
own transaction and rewind support : 'oh the ref transaction failed
and I have already done the reflog commit,   have to manually uncommit
...".
And this quickly becomes quite burdensome for consumers.

I think a transaction API should remove this burden from consumers and
make it as easy as possible to use the API.

Conditional of if it is desireable to have transactions for reflogs at all.



About the cleanup part. The current API, and I think also the current
direction of both my old patches (which I think did not go far enough
in the transactifications) or this current patchseries is that they
all
have a very confusing and inconsistent API for reflog updates.
With this I mean,   sometimes reflog updates happen within a
transaction as a side effect of a ref_transaction_update().
Other times reflog updates happens ooutside of transactions by calling
a special reflog API.

I.e.  reflogs sometimes update as part of a transaction and sometimes not.
A follow up question then on this API is what should happen if you
have a transaction open, but not committed, and while the transaction
is open you call the non-transactional reflog API for a reflog for the
same ref that is already beeing/or going to be/ updated as the
ref-update-side-effect ?


I think an api where "sometimes you operate on foo from within a
transaction and sometimes you do not, and if you do the latter when a
transaction is open, it is unclear what should happen" is not great.
IMHO, refs and reflog updates are related and I think:

* a transaction should be the ONLY way to mutate either a ref or a
reflog or both.
* if you update both a ref and a reflog then that should happen as
part of one single transaction.
* (later) it would probably make the API better if the code was
refactored so write_ref_sha1() will NOT call log_ref_write() anymore
and instead make the reflog update that happens explicit perhaps by
calling something like a ref_transaction_update_reflog() as part of
the ref_transaction_update() call.






> Michael
>
> [1] The reflog updates are not atomic in the face of disk errors and
> power outages and stuff, but neither are reference updates. In other
> words, I think reflog updates in ref_transaction_commit() are done as
> safely as reference updates, which is surely good enough for this
> reference backend. Other reference backends can do a better job with
> both while staying within the existing API.
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
