From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Sun, 13 Sep 2015 14:12:58 +0200
Message-ID: <vpqa8sqv7p1.fsf@anie.imag.fr>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 14:13:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb69j-0002HU-Bu
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 14:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbbIMMNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 08:13:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49970 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbbIMMNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 08:13:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8DCCubS011289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 13 Sep 2015 14:12:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8DCCwlA003978;
	Sun, 13 Sep 2015 14:12:58 +0200
In-Reply-To: <1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 13 Sep 2015 12:53:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 13 Sep 2015 14:12:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8DCCubS011289
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442751178.05394@KmKHtd4H0PWYK7GSKJlgBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277775>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -679,15 +682,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>  	if (verbose)
>  		maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>  
> -	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
> +	index = ref_list.index;
> +
> +	/* Print detached HEAD before sorting and printing the rest */
> +	if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
> +	    !strcmp(ref_list.list[index - 1].name, head)) {
> +		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
> +			       1, remote_prefix);
> +		index -= 1;
> +	}

I think Eric already mentionned it, but I don't remember the conclusion
and can't find it in the archives. Wouldn't it be cleaner to actually
remove the detached head from the array (do "ref_list.index -= 1"
instead of "index -= 1", and possibly free() what needs to be freed?

If you did so, you wouldn't have any possible confusion between the
local variable "index" and ref_list.index in the code below:

> -	detached = (detached && (kinds & REF_LOCAL_BRANCH));
> -	if (detached && match_patterns(pattern, "HEAD"))
> -		show_detached(&ref_list, maxwidth);
> +	qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);
>  
> -	for (i = 0; i < ref_list.index; i++) {
> -		int current = !detached &&
> -			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
> +	for (i = 0; i < index; i++) {
> +		int current = !detached && (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
>  			!strcmp(ref_list.list[i].name, head);
>  		print_ref_item(&ref_list.list[i], maxwidth, verbose,
>  			       abbrev, current, remote_prefix);

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
