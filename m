From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Tue, 28 Jul 2015 16:17:56 +0200
Message-ID: <vpqh9oov017.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 16:18:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK5hz-0003vt-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 16:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbbG1OSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 10:18:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33539 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932312AbbG1OSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 10:18:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6SEHt7V020037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 16:17:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SEHuNb000650;
	Tue, 28 Jul 2015 16:17:56 +0200
In-Reply-To: <1438067468-6835-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:41:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 28 Jul 2015 16:17:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6SEHt7V020037
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438697880.00072@T4LC1wSbALxcVc4owhFTzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274773>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -458,7 +345,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
>  	}
>  
>  	if (item->kind == REF_LOCAL_BRANCH)
> -		fill_tracking_info(&stat, item->refname, filter->verbose > 1);
> +		fill_tracking_info(&stat, refname, filter->verbose > 1);

Why can't you continue using item->refname?

(It's a real question)

> @@ -635,14 +495,21 @@ static void print_ref_list(struct ref_filter *filter)
>  	/* Print detached heads before sorting and printing the rest */
>  	if (filter->detached) {
>  		print_ref_item(array.items[index - 1], maxwidth, filter, remote_prefix);
> -		index -= 1;
> +		array.nr--;
>  	}
>  
> -	qsort(array.items, index, sizeof(struct ref_array_item *), ref_cmp);
> +	if (!sorting) {
> +		def_sorting.next = NULL;
> +		def_sorting.atom = parse_ref_filter_atom(sort_type,
> +							 sort_type + strlen(sort_type));
> +		sorting = &def_sorting;
> +	}
> +	ref_array_sort(sorting, &array);

Does this belong to print_ref_list()? Is it not possible to extract it
to get a code closer to the simple:

	filter_refs(...);
	ref_array_sort(...);
	print_ref_list(...);

?

> -	for (i = 0; i < index; i++)
> +	for (i = 0; i < array.nr; i++)
>  		print_ref_item(array.items[i], maxwidth, filter, remote_prefix);

Now that we have show_ref_array_item, it may make sense to rename
print_ref_item to something that make the difference between these
functions more explicit. Well, ideally, you'd get rid of it an actually
use show_ref_array_item, but if you are to keep it, maybe
print_ref_item_default_branch_format (or something shorter)?

> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -49,7 +49,6 @@ struct ref_sorting {
>  struct ref_array_item {
>  	unsigned char objectname[20];
>  	int flag, kind;
> -	int ignore : 1;

You should explain why you needed it and why you don't need it anymore
(I guess, because it was used to implement --merge and you now get it
from ref-filter).

> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -38,7 +38,7 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
>  	test_must_fail git fast-import <input
>  '
>  
> -test_expect_success 'git branch shows badly named ref' '
> +test_expect_failure 'git branch does not show badly named ref' '

I'm not sure what's the convention, but I think the test description
should give the expected behavior even with test_expect_failure.

And please help the reviewers by saying what's the status wrt this test
(any plan on how to fix it?).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
