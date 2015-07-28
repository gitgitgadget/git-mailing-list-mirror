From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH] Port branch.c to use ref-filter APIs
Date: Tue, 28 Jul 2015 21:18:06 +0530
Message-ID: <CAOLa=ZTDsYDbyvCfC0Ad1uZ+5wPeFusCoa0JuzOcYS2qB8Wbjg@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <vpqoaiwwgl2.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:48:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK77Q-000381-IF
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 17:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbbG1Psi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 11:48:38 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33654 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbbG1Psg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 11:48:36 -0400
Received: by obdeg2 with SMTP id eg2so87456465obd.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PfeJqf2g660/64Rv4TonRX9XjVjsd3QuEKwzeaCSqQ8=;
        b=GCAaf66r0xOVoDPC+9zoca4D3frAq/W+0ON/0i+aBZRi/k+uTWEJc/vITun11iSyGP
         BPgVNxnKqTJo6RQB/ENI0jIgpkBcB0RxVFKzqHxnkxPGFxgIB1D5Qwzgo05sOb0+6zDE
         tOwd+KdVMHSXZTMCZ/1VKFL470kqcRwK+WAryC4xQuBdybhINWADrTAAMeX+aaQy+AML
         qVK4+r3TkeQidrnRN1QR0gLI4noS8zLfe6/zc1zA0MJ1ZYFS0B3OihzR7faQdmXWixVs
         itbMLkxWA5Jp/lb943Xzh0ZtyLqiSB/mMe4JAaHK+mP/FoSF2x8kwJpakT//MRwXnRVz
         /Nww==
X-Received: by 10.60.42.230 with SMTP id r6mr36730709oel.9.1438098515313; Tue,
 28 Jul 2015 08:48:35 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 08:48:06 -0700 (PDT)
In-Reply-To: <vpqoaiwwgl2.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274778>

On Tue, Jul 28, 2015 at 7:05 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This version also doesn't use the printing options provided by
>> branch.c.
>
> Do you mean "provided by ref-filter.{c,h}"?
>

Yes! my bad.

>> I wanted to discuss how exactly to go about that, because in branch.c,
>> we might need to change the --format based on attributes such as
>> abbrev, verbose and so on. But ref-filter expects us to verify the
>> format before filtering.
>
> I took time to understand the problem, but here's my understanding:
>
> ref-filter expects the code to look like
>
>         format = ...;
>         verify_ref_format(format);
>         filter_refs(...);
>         for (...)
>                 show_ref_array_item(..., format, ...);
>
> and in the case of "git branch -v", you need to align the sha1s based on
> the longest branch name, i.e. use %(padright:N+1) where N is the longest
> branch name. And you can get N only after calling filter_refs, while you
> need it for verify_ref_format().
>
> Is my understanding correct?

Absolutely correct :)

>
> If so, what prevents swapping the order of verify_ref_format and
> filter_refs? I understand that verify_ref_format() builds used_atom and
> other data-structures, hence it has to be called before
> show_ref_array_item() and before sorting, but I don't think you need it
> before filter_refs (I may have missed something though).
>

Nope! This is exactly what I'm trying :D

> So, the code could look like:
>
> filter_refs(...)
> if (--format is given)
>         format = the argument of --format
> else
>         format = STRBUF_INIT;
>         strbuf_add(&format, "%(some_directive_to_display '*' if needed)");
>         if (verbose)
>                 strbuf_addf(&format, "%(padright:%d)", max_width);
>         ...
> verify_ref_format(format);
> ref_array_sort(...);
> for (...)
>         show_ref_array_item(...);
>
> (BTW, a trivial helper function to display the whole ref_array could
> help. It would avoid having each caller write the 'for' loop)
>

This I gotta try! Have been just keeping the flow the same and trying to mess
around with how formatting works instead.

> Ideally, you could also have a modifier atom %(alignleft) that would
> not need an argument and that would go through the ref_array to find the
> maxwidth, and do the alignment. That would give even more flexibility to
> the end users of "for-each-ref --format".

This could work for refname, as each ref_array_item holds the refname,
But other atoms are only filled in after a call to verify_ref_format().
What we could do would be after filling in all atom values, have a loop
through all items with their atom values and maybe implement this.
But I don't see this as priority for now, so will mark it off for later.
Thanks

-- 
Regards,
Karthik Nayak
