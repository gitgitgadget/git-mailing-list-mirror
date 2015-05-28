From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/WIP v3 2/4] for-each-ref: introduce new structures for better organisation
Date: Thu, 28 May 2015 22:26:02 +0200
Message-ID: <vpqegm0o3dx.fsf@anie.imag.fr>
References: <5567527A.6090607@gmail.com>
	<1432835025-13291-2-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 22:26:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4Nb-00022M-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbbE1U0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:26:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38012 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbbE1U0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:26:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SKQ0sx011436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 22:26:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SKQ2NN017782;
	Thu, 28 May 2015 22:26:02 +0200
In-Reply-To: <1432835025-13291-2-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 28 May 2015 23:13:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 22:26:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SKQ0sx011436
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433449564.32437@3JYmwca05hm5pp38MQwF4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270190>

Karthik Nayak <karthik.188@gmail.com> writes:

> Rename 'refinfo' to 'ref_array_item' and intoduce 'ref_filter_cbdata'

The fact that you need to use "and" to describe your changes is a hint
that you can split better.

The patch looks much better, but I think you still need to split more to
make it easier to review.

> - * of properties that we need to extract out of objects.  refinfo
> + * of properties that we need to extract out of objects. ref_array_item

Not very important, but two spaces after a period is what one is
supposed to do in English. Not everybody follow the rule, but it seems
backward to change the code to break it.

>  	if (flag & REF_BAD_NAME) {
> -		  warning("ignoring ref with broken name %s", refname);
> -		  return 0;
> +		warning("ignoring ref with broken name %s", refname);
> +		return 0;

Whitespace fix mixed with actual code.

> -static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
> +/* Free all memory allocated for ref_filter_cbdata */
> +void ref_filter_clear_data(struct ref_filter_cbdata *ref_cbdata)
> +{
> +	int i;
> +
> +	for (i = 0; i < ref_cbdata->array.nr; i++)
> +		free(ref_cbdata->array.items[i]);
> +	free(ref_cbdata->array.items);
> +	ref_cbdata->array.items = NULL;
> +	ref_cbdata->array.nr = ref_cbdata->array.alloc = 0;
> +}

And this one is a real behavior change, which would be much better
documented in its own patch with a proper commit message (we had a
memory leak before, we didn't care because it happened right before
exiting, but we can't accept that in a clean library).

Reviewing is not just about having a look and seeing if there's
something stupid. Reviewers are actually taking a lot of time to see if
the patch does not introduce new bugs, or looking for better ways to do
the same thing. Be nice with them!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
