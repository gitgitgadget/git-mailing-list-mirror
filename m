From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Wed, 29 Jul 2015 21:02:45 +0530
Message-ID: <CAOLa=ZT28aFqi3WzTvemA4Yc0i28bavV7+SF2qH5S43Bp5LghQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-1-git-send-email-Karthik.188@gmail.com> <vpqh9oov017.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:33:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTM9-0003Al-Rn
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbbG2PdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:33:17 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36233 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbbG2PdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:33:15 -0400
Received: by oibn4 with SMTP id n4so6969987oib.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YFzGs24eQSWUEcjEro3BllT8lgA5kA2UbIVi0GWfnek=;
        b=MWg6x1nAEPirwr7JU/29Qxd7frIj7NKYUm/y6G+on4v9gpPT6i8ingabClYrPMPPsT
         +BdkdxpA9LlO+I2f05hc0y3vQkjbO2djG2fn5LiIY3RzVPhQytqoWOGmVUJs2u6uEIQE
         9kEVMdV6VYjRT1NQ0aP1iPBwj7L85S/q4th/DfXSiargjSw3n5zg0w9o6sAbq8N2CFVS
         wKQlTc0z6F7JjFaGEfbPiB6L8MKncTMbbMN7+bxQDcHInQL32/z8JsORxTLSStnKdIkV
         vvxDcBETCR6TsfRfV/ncocNnSFMVATC4nP3Yj1reNR3JH4QgyxQ8mq1Zl35EAWqUOes3
         tCQg==
X-Received: by 10.202.200.151 with SMTP id y145mr38982821oif.111.1438183994981;
 Wed, 29 Jul 2015 08:33:14 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 08:32:45 -0700 (PDT)
In-Reply-To: <vpqh9oov017.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274896>

Re-sending this as it wasn't sent as plain text and failed.

On Tue, Jul 28, 2015 at 7:47 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -458,7 +345,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
>>       }
>>
>>       if (item->kind == REF_LOCAL_BRANCH)
>> -             fill_tracking_info(&stat, item->refname, filter->verbose > 1);
>> +             fill_tracking_info(&stat, refname, filter->verbose > 1);
>
> Why can't you continue using item->refname?
>
> (It's a real question)

Because we call add_verbose_info() is called in print_ref_item() which calls
add_verbose_info() with refname=desc, where desc is a shortened refname.
And fill_tracking_info expects a shortened refname. hence we give it refname
which is nothing but desc.

>
>> @@ -635,14 +495,21 @@ static void print_ref_list(struct ref_filter *filter)
>>       /* Print detached heads before sorting and printing the rest */
>>       if (filter->detached) {
>>               print_ref_item(array.items[index - 1], maxwidth, filter, remote_prefix);
>> -             index -= 1;
>> +             array.nr--;
>>       }
>>
>> -     qsort(array.items, index, sizeof(struct ref_array_item *), ref_cmp);
>> +     if (!sorting) {
>> +             def_sorting.next = NULL;
>> +             def_sorting.atom = parse_ref_filter_atom(sort_type,
>> +                                                      sort_type + strlen(sort_type));
>> +             sorting = &def_sorting;
>> +     }
>> +     ref_array_sort(sorting, &array);
>
> Does this belong to print_ref_list()? Is it not possible to extract it
> to get a code closer to the simple:
>
>         filter_refs(...);
>         ref_array_sort(...);
>         print_ref_list(...);
>
> ?
>

We have a ref_defaulting_sorting but that defaults to sorting by 'refname'
but what we want in branch.c is to sort by 'type' rather. Hence we
need to have this small segment of code. About its placement, IDK if
print_ref_list() is the right place. But didn't find a better place.

>> -     for (i = 0; i < index; i++)
>> +     for (i = 0; i < array.nr; i++)
>>               print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
>
> Now that we have show_ref_array_item, it may make sense to rename
> print_ref_item to something that make the difference between these
> functions more explicit. Well, ideally, you'd get rid of it an actually
> use show_ref_array_item, but if you are to keep it, maybe
> print_ref_item_default_branch_format (or something shorter)?
>

I guess it'll be converted to a helper for show_ref_array_item()
eventually so keeping that in mind maybe rename it to
get_format_and_print_ref().

>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -49,7 +49,6 @@ struct ref_sorting {
>>  struct ref_array_item {
>>       unsigned char objectname[20];
>>       int flag, kind;
>> -     int ignore : 1;
>
> You should explain why you needed it and why you don't need it anymore
> (I guess, because it was used to implement --merge and you now get it
> from ref-filter).
>

Yeah, I'll add that into the commit message.

>> --- a/t/t1430-bad-ref-name.sh
>> +++ b/t/t1430-bad-ref-name.sh
>> @@ -38,7 +38,7 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
>>       test_must_fail git fast-import <input
>>  '
>>
>> -test_expect_success 'git branch shows badly named ref' '
>> +test_expect_failure 'git branch does not show badly named ref' '
>
> I'm not sure what's the convention, but I think the test description
> should give the expected behavior even with test_expect_failure.
>
> And please help the reviewers by saying what's the status wrt this test
> (any plan on how to fix it?).
>

Well okay will rename the test description.
Since we use filter_refs() there's no real fix for this, ref_filter_handler()
skips over such refs. I'll mention something on these lines in the
commit message.

-- 
Regards,
Karthik Nayak
