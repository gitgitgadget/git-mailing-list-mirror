From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 11:59:14 -0700
Message-ID: <20121030185914.GI15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTH4f-000586-0I
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934249Ab2J3TBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:01:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40656 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965594Ab2J3S7T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:59:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so386508pbb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y932s3Z/YLodpB2swAKXlrm1CxH/1DBAgd3sKpB8FbY=;
        b=RwQhWahquMgdi27JRMPL2eEucyC+1Nd4yYgn2dU6bm3NDll4u0vIYOVWVSP/SBnSLZ
         1jS/z5uLdCDt6YliQkBRi4HV9e9VNH3sQOF51Dih1T/M1rBL3PPAeJZRxG1kHRQixeu/
         NQWQLgcjOCuYwMU908NJimzdsCtb1vVKhWhTMvqxA23w0P6VacmRVl10ew+ZIQrmUAxy
         nbCY4p5hpizSV2jjViUbu2Oz2ww+POgGsaeIY5Yk60pqRfWvOSOTuxJ7uGAkp94z/IN0
         9krvj2mp/tDVopztNProbOPW1125a3ULvSHpQmw7KZSvIlUltfMprhLJWgaVioGbOd8S
         JzUg==
Received: by 10.68.132.41 with SMTP id or9mr106622023pbb.67.1351623558732;
        Tue, 30 Oct 2012 11:59:18 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pw2sm930987pbb.59.2012.10.30.11.59.17
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 11:59:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208725>

Felipe Contreras wrote:

> They have been marked as UNINTERESTING for a reason, lets respect that.

This patch looks unsafe, and in the examples listed in the patch
description the changed behavior does not look like an improvement.
Worse, the description lists a few examples but gives no convincing
explanation to reassure about the lack of bad behavior for examples
not listed.

Perhaps this patch has a prerequisite and has come out of order.

Hope that helps,
Jonathan

Patch left unsnipped so we can get a copy in the list archive.

> Currently the first ref is handled properly, but not the rest, so:
> 
>  % git fast-export master ^master
> 
> Would currently throw a reset for master (2nd ref), which is not what we
> want.
> 
>  % git fast-export master ^foo ^bar ^roo
>  % git fast-export master salsa..tacos
> 
> Even if all these refs point to the same object; foo, bar, roo, salsa,
> and tacos would all get a reset.
> 
> This is most certainly not what we want. After this patch, nothing gets
> exported, because nothing was selected (everything is UNINTERESTING).
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/fast-export.c  | 7 ++++---
>  t/t9350-fast-export.sh | 6 ++++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 065f324..7fb6fe1 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -523,10 +523,11 @@ static void get_tags_and_duplicates(struct object_array *pending,
>  				typename(e->item->type));
>  			continue;
>  		}
> -		if (commit->util)
> +		if (commit->util) {
>  			/* more than one name for the same object */
> -			string_list_append(extra_refs, full_name)->util = commit;
> -		else
> +			if (!(commit->object.flags & UNINTERESTING))
> +				string_list_append(extra_refs, full_name)->util = commit;
> +		} else
>  			commit->util = full_name;
>  	}
>  }
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 49bdb44..6ea8f6f 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -440,4 +440,10 @@ test_expect_success 'fast-export quotes pathnames' '
>  	)
>  '
>  
> +test_expect_success 'proper extra refs handling' '
> +	git fast-export master ^master master..master > actual &&
> +	echo -n > expected &&
> +	test_cmp expected actual
> +'
> +
>  test_done
> -- 
> 1.8.0
