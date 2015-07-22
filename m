From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] refs: loosen restrictions on wildcard '*' refspecs
Date: Wed, 22 Jul 2015 12:36:31 -0700
Message-ID: <xmqq380grnls.fsf@gitster.dls.corp.google.com>
References: <1437589929-14546-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzok-0000kn-QC
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbbGVTge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 15:36:34 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36649 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbGVTgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:36:33 -0400
Received: by pachj5 with SMTP id hj5so143358074pac.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Om4hCDAmDYxHjEM+I1P2/x43o34yvuDx4oa/Ec0nSik=;
        b=sDYQKECKpVZwmXZZBCQfvFQ9cZ0bXDoTwfW0oo5ufNTo1Hag9K1RB6uY3Y0VRIYhKT
         VVZTNhMGtUJsgOA1YzI8VrKwBZUdIh37d4Zn5htiivJMpltgXTdxp++vej7eJeGofMin
         x9wa9jrujEyWrqNfeXorwQjWunVNS4Y1h+ykoIRgMshQJSfrWNeLYTcBcrqyhB3rbVaA
         GQLzc2OKz9ewWHH91Z9gCpXV/aOyH+yRt4cIczvMJxQzMfFoJ5WcbRP5RdsCfjdCZk0C
         tv29OtKEljc57GBs1qwoAst4T4WSWQgf6BOobzISltewsyoxR1F1vYU2VmAPFqHRyROP
         f80Q==
X-Received: by 10.66.66.68 with SMTP id d4mr5117615pat.43.1437593793412;
        Wed, 22 Jul 2015 12:36:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2d07:10eb:6a1b:8773])
        by smtp.gmail.com with ESMTPSA id bd5sm4751501pdb.41.2015.07.22.12.36.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jul 2015 12:36:32 -0700 (PDT)
In-Reply-To: <1437589929-14546-1-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Wed, 22 Jul 2015 11:32:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274460>

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/refs.c b/refs.c
> index ce8cd8d45001..a65f16fedaa0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -20,11 +20,12 @@ struct ref_lock {
>   * 2: ., look for a preceding . to reject .. in refs
>   * 3: {, look for a preceding @ to reject @{ in refs
>   * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
> + * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set

The fact that this patch does not have to change the description for
'4:' is an indication that the original description for '4:' was
incomplete.  Otherwise the original would have listed "*" among
others like "~", "^", and this patch would have updated it.

This mixes a fix/cleanup with an enhancement.

>   */
>  static unsigned char refname_disposition[256] = {
>  	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
>  	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
> -	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
> +	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
> @@ -71,11 +72,13 @@ static unsigned char refname_disposition[256] = {
>   * - any path component of it begins with ".", or
>   * - it has double dots "..", or
>   * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
> - * - it ends with a "/".
> - * - it ends with ".lock"
> - * - it contains a "\" (backslash)
> + * - it ends with a "/", or
> + * - it ends with ".lock", or
> + * - it contains a "\" (backslash), or
> + * - it contains a "@{" portion, or
> + * - it contains a '*' unless REFNAME_REFSPEC_PATTERN is set
>   */

This also mixes a fix/cleanup with an enhancement.  The original
should have had these ", or" but it didn't.

Can you split this patch into two, i.e.

 * [1/2] is to only clean-up the places these two hunks apply,
   without changing the behaviour at all.

   Please make sure that updated description for "4:" covers
   everything that is "a bad character".  We noticed the lack of '*'
   only because of your patch, but I do not know (and did not check)
   if that was the only thing that was missing.

 * [2/2] is what you really wanted to do with this patch,
   i.e. updating the entry for '*' in the disposition table and all
   changes outside the above two hunks.

Thanks.
