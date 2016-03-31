From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Thu, 31 Mar 2016 17:09:21 +0200
Message-ID: <vpqwpoi1y72.fsf@anie.imag.fr>
References: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Elena Petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:13:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aleHT-0000eM-Qa
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbcCaPNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 11:13:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59349 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757365AbcCaPJw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 11:09:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u2VF9KxY000774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 31 Mar 2016 17:09:20 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2VF9LP7024914;
	Thu, 31 Mar 2016 17:09:21 +0200
In-Reply-To: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com>
	(Elena Petrashen's message of "Thu, 31 Mar 2016 12:25:27 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 31 Mar 2016 17:09:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2VF9KxY000774
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460041764.7535@egB9o9FZkkMLHoZR/vz9hA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290402>

Elena Petrashen <elena.petrashen@gmail.com> writes:

> --- a/advice.c
> +++ b/advice.c
> @@ -15,6 +15,7 @@ int advice_detached_head = 1;
>  int advice_set_upstream_failure = 1;
>  int advice_object_name_warning = 1;
>  int advice_rm_hints = 1;
> +int advice_delete_branch_via_at_ref = 1;
>  
>  static struct {
>  	const char *name;
> @@ -35,6 +36,7 @@ static struct {
>  	{ "setupstreamfailure", &advice_set_upstream_failure },
>  	{ "objectnamewarning", &advice_object_name_warning },
>  	{ "rmhints", &advice_rm_hints },
> +	{ "deletebranchviaatref", &advice_delete_branch_via_at_ref },
>  
>  	/* make this an alias for backward compatibility */
>  	{ "pushnonfastforward", &advice_push_update_rejected }

This is undocumented.

> +		expand_dash_shortcut (argv, i);
> +		if(!strncmp(argv[i], "@{-", strlen("@{-")))

Style: space after if.

We have a starts_with() function to avoid this strncmp(... strlen()) dance.

> @@ -262,6 +275,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  			       (flags & REF_ISBROKEN) ? "broken"
>  			       : (flags & REF_ISSYMREF) ? target
>  			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +			if (at_shortcut && advice_delete_branch_via_at_ref)
> +			       delete_branch_advice (bname.buf,
> +				find_unique_abbrev(sha1, DEFAULT_ABBREV));

Style: 1-space indent is not sufficient. Either align the arguments (not
applicable here) or indent by one tab to mark "I'm not done with
argument list".

Also, no space between delete_branch_advice and '('.

> +test_expect_success 'test deleting "-" deletes previous branch' '
> +	git checkout -b prev &&
> +	test_commit prev &&
> +	git checkout master &&
> +	git branch -D - >actual &&
> +	sha1=$(git rev-parse prev | cut -c 1-7) &&

Didn't this | cut ... turn into a --short in a previous version?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
