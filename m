From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 11/12] for-each-ref: introduce filter_refs()
Date: Thu, 11 Jun 2015 19:00:12 +0200
Message-ID: <vpq1thixjs3.fsf@anie.imag.fr>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	<1434039003-10928-11-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:00:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z35q2-0002dv-E8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 19:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbbFKRAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 13:00:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34102 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbFKRAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 13:00:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BH09WV031205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2015 19:00:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BH0COm016320;
	Thu, 11 Jun 2015 19:00:12 +0200
In-Reply-To: <1434039003-10928-11-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 11 Jun 2015 21:40:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 11 Jun 2015 19:00:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5BH09WV031205
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434646810.5211@73M/jzpT/wHok2yAVYWHxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271438>

Karthik Nayak <karthik.188@gmail.com> writes:

> +	filter_refs(&array, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN, &filter);

I think it is more common to have options at the end, so I'd write it as

filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);

(changing the declaration too, obviously)

I really like the way cmd_for_each_ref looks like now.

> @@ -905,6 +905,28 @@ void ref_array_clear(struct ref_array *array)
>  	array->nr = array->alloc = 0;
>  }
>  
> +/*
> + * API for filtering a set of refs. Based on the type of refs the user
> + * has requested, we iterate through those refs and apply filters
> + * as per the given ref_filter structure and finally store the
> + * filtered refs in the ref_array structure.
> + */
> +int filter_refs(struct ref_array *array, unsigned int type, struct ref_filter *filter)
> +{
> +	struct ref_filter_cbdata ref_cbdata;
> +
> +	ref_cbdata.array = array;
> +	ref_cbdata.filter = filter;
> +
> +	if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
> +		return for_each_rawref(ref_filter_handler, &ref_cbdata);
> +	else if (type & FILTER_REFS_ALL)
> +		return for_each_ref(ref_filter_handler, &ref_cbdata);
> +	else
> +		die("filter_refs: invalid type");
> +	return 0;
> +}

I thought you would make a helper function that would return a pointer
to either for_each_rawref or for_each_ref (or another later), but that
would probably be overkill.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
