From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Thu, 17 Sep 2015 17:43:05 +0200
Message-ID: <vpqio79oxva.fsf@anie.imag.fr>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
	<CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
	<vpqpp1hqgcd.fsf@anie.imag.fr>
	<xmqqh9mtkrg0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 17:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcbLB-0001EI-IN
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 17:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbbIQPnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 11:43:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41339 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbbIQPnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 11:43:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HFh230011993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 17 Sep 2015 17:43:03 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HFh570027875;
	Thu, 17 Sep 2015 17:43:05 +0200
In-Reply-To: <xmqqh9mtkrg0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 17 Sep 2015 08:15:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Sep 2015 17:43:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8HFh230011993
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443109384.51825@lWo4LGf7pRqrHFpHMV9ZQw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278124>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> So either we could introduce a new atom for sorting something like
>>> `branch_sort` which uses the FILTER_REFS_(DETACHED_HEAD | BRANCHES |
>>> REMOTES)
>>
>> I don't think you need a new atom. You can just change the sorting
>> function to consider that detached HEAD is always first, and when
>> comparing two non-detached-HEAD branches, use the atom supplied by the
>> user.
>>
>> That would mean the detached HEAD would be displayed first regardless of
>> --sort (which is the case right now).
>
> I am a bit fuzzy about this.  I do not understand why Karthik thinks
> a new atom is necessary in the first place, and I do agree that the
> best way to go would be to teach the sort function to do "the right
> thing", but I am not sure why it has to be "regardless of --sort".

I think Karthik meant that branch could default to
"--sort=my_magic_atom_that_does_the_right_thing". In this case, the
default would be to show HEAD first, but using "--sort" explicitly would
change the order and interleave HEAD within other branches.

IOW, we have:

struct ref_sorting *ref_default_sorting(void)
{
	static const char cstr_name[] = "refname";

	struct ref_sorting *sorting = xcalloc(1, sizeof(*sorting));

	sorting->next = NULL;
	sorting->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
	return sorting;
}

and we could

-	static const char cstr_name[] = "refname";
+	static const char cstr_name[] = "some_magic_atom";

But you convinced me that this is not a good idea.

> When the user does give a custom --sort criteria, the logic in
> default_sort()

The logic itself is not in ref_default_sorting() (I guess this is what
you meant by "default_sort"): this function just builds a struct
ref_sorting that is later used by the more general cmp_ref_sorting.

But that's still workable: struct ref_sorting could contain a flag
"head_first" that would be set by ref_default_sorting() and only it, and
then read by cmp_ref_sorting.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
