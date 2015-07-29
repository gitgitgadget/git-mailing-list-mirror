From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Wed, 29 Jul 2015 17:46:12 +0200
Message-ID: <vpqegjrge63.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
	<vpqh9oov017.fsf@anie.imag.fr>
	<CAOLa=ZT28aFqi3WzTvemA4Yc0i28bavV7+SF2qH5S43Bp5LghQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:46:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTYq-0005K4-QO
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbbG2PqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:46:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56040 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbG2PqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:46:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6TFkBLa006778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 17:46:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TFkCHG020784;
	Wed, 29 Jul 2015 17:46:12 +0200
In-Reply-To: <CAOLa=ZT28aFqi3WzTvemA4Yc0i28bavV7+SF2qH5S43Bp5LghQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 29 Jul 2015 21:02:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 Jul 2015 17:46:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TFkBLa006778
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438789572.76479@d7aU1NGQrnpf0wQ34fs8Iw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274899>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Jul 28, 2015 at 7:47 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>>> -     qsort(array.items, index, sizeof(struct ref_array_item *), ref_cmp);
>>> +     if (!sorting) {
>>> +             def_sorting.next = NULL;
>>> +             def_sorting.atom = parse_ref_filter_atom(sort_type,
>>> +                                                      sort_type + strlen(sort_type));
>>> +             sorting = &def_sorting;
>>> +     }
>>> +     ref_array_sort(sorting, &array);
>>
>> Does this belong to print_ref_list()? Is it not possible to extract it
>> to get a code closer to the simple:
>>
>>         filter_refs(...);
>>         ref_array_sort(...);
>>         print_ref_list(...);
>>
>> ?
>>
>
> We have a ref_defaulting_sorting but that defaults to sorting by 'refname'
> but what we want in branch.c is to sort by 'type' rather. Hence we
> need to have this small segment of code. About its placement, IDK if
> print_ref_list() is the right place. But didn't find a better place.

Hmm, actually I think I misread the code: print_ref_list() does follow
the pattern filter_refs -> sort -> print.

Perhaps the function name is misleading, and you could make it clearer
that it computes the list and displays it. I don't know.

>>> --- a/t/t1430-bad-ref-name.sh
>>> +++ b/t/t1430-bad-ref-name.sh
>>> @@ -38,7 +38,7 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
>>>       test_must_fail git fast-import <input
>>>  '
>>>
>>> -test_expect_success 'git branch shows badly named ref' '
>>> +test_expect_failure 'git branch does not show badly named ref' '
>>
>> I'm not sure what's the convention, but I think the test description
>> should give the expected behavior even with test_expect_failure.
>>
>> And please help the reviewers by saying what's the status wrt this test
>> (any plan on how to fix it?).
>>
>
> Well okay will rename the test description.
> Since we use filter_refs() there's no real fix for this, ref_filter_handler()
> skips over such refs.

Either there's a good rationale for ignoring these refs, and you should
change the test keeping it "test_expect_success" (i.e. "the test
observed corresponds to the expected behavior"), or you should
eventually modify filter_refs() to allow not dropping them.

This

-test_expect_success '...'
+test_expect_failure '...'

explicitly says "I have a known regression in this patch".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
