From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 7/7] push: clarify rejection of update to non-commit-ish
Date: Mon, 26 Nov 2012 21:52:40 -0600
Message-ID: <CAEUsAPZq1POKQZd5vZy55nEj2kB4CqgxL9_d_0sQs33P_Gcemg@mail.gmail.com>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
	<1353644515-17349-8-git-send-email-chris@rorvick.com>
	<7vk3t8ryap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 04:52:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdCED-0003m4-Kz
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 04:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089Ab2K0Dwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 22:52:42 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50534 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933067Ab2K0Dwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 22:52:41 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so6296938lbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 19:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=kV+PCtrZuFDWxhzFYzxR5u7UriZ8QdT1QWAB0DRBm/4=;
        b=iYRu8/OSdG7xiaTYnoi7n0c8qtdVgkr2evlcFhrmX6JX5mOUfWj5qFsgRNTDNyAmcF
         l81HuJ9v6r9uqpfRvrLA9McQ1WLuzUjDgW2cB1QBILASb/DXcg0Yyp6NUE7qGNjtFwp+
         eBwMqFZfPnb90AaB2O+3tmmugpDkbesUEzthHUw2xo9K2rgm8g6t9bGzGIaG+rJvk02g
         615kZHyyKcTuqlFEWNR/M1w6R5AGVhuf7ZSLRGWo9svsTvAb5ok4ROn5bzbUOT0hwPxx
         uox+kux1xGRGy9IlnfhpuxeHCvuYP63Cof4l1Zx7xIuDOl0g+B8WRuCmMHZ5CJRXk2FX
         t/QQ==
Received: by 10.112.46.37 with SMTP id s5mr5982396lbm.67.1353988360347; Mon,
 26 Nov 2012 19:52:40 -0800 (PST)
Received: by 10.114.13.2 with HTTP; Mon, 26 Nov 2012 19:52:40 -0800 (PST)
In-Reply-To: <7vk3t8ryap.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: QBqng5Wpa1VWRrlxmfEFIrWGn7k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210528>

On Mon, Nov 26, 2012 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Rorvick <chris@rorvick.com> writes:
>
>> Pushes must already (by default) update to a commit-ish due the fast-
>> forward check in set_ref_status_for_push().  But rejecting for not being
>> a fast-forward suggests the situation can be resolved with a merge.
>> Flag these updates (i.e., to a blob or a tree) as not forwardable so the
>> user is presented with more appropriate advice.
>>
>> Signed-off-by: Chris Rorvick <chris@rorvick.com>
>> ---
>>  remote.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/remote.c b/remote.c
>> index f5bc4e7..ee0c1e5 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1291,6 +1291,11 @@ static inline int is_forwardable(struct ref* ref)
>>       if (!o || o->type != OBJ_COMMIT)
>>               return 0;
>>
>> +     /* new object must be commit-ish */
>> +     o = deref_tag(parse_object(ref->new_sha1), NULL, 0);
>> +     if (!o || o->type != OBJ_COMMIT)
>> +             return 0;
>> +
>
> I think the original code used ref_newer() which took commit-ish on
> both sides.

That is still called later in set_ref_status_for_push() to calculate
the nonfastforward flag.  The only reason for even checking the new
here is to exclude trees and blobs now so they are flagged as
already-existing and thus avoid nonsensical fetch-and-merge advice.
Otherwise the behavior is unchanged by this last patch.

ref_newer() does end up redoing computation now done in the new
is_forwardable() function.  I could probably factor this out of
ref_newer() into a commit_newer() function that could be reused in
set_ref_status_for_push() to avoid this overhead, but it didn't seem
like a big deal.  Thoughts?

> With this code, the old must be a commit but new can be a tag that
> points at a commit?  Why?

The old must not be a tag because fast-forwarding from it is
potentially destructive; a tag would likely be left dangling in this
case.  This is not true for the new, though.   I'm not sure
fast-forwarding from a commit to a tag is useful, but I didn't see a
reason to prevent it either.   The refs/tags/ hierarchy is excluded
from fast-forwarding before this check, and refs/heads/ is already
protected against anything but commits.  So it seems very unlikely
that someone would accidentally make use of this behavior.

So, fast-forwarding to a tag seemed fairly benign and unlikely to
cause confusion, so I leaned towards allowing it in case someone found
a use case for it.
