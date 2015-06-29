From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 5/9] ref-filter: add option to match literal pattern
Date: Mon, 29 Jun 2015 11:20:55 -0700
Message-ID: <xmqqy4j29y0o.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
	<1435232596-27466-1-git-send-email-karthik.188@gmail.com>
	<1435232596-27466-5-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 20:21:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dg0-0005Ug-Ho
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 20:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbbF2SVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 14:21:00 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33169 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbF2SU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 14:20:58 -0400
Received: by ieqy10 with SMTP id y10so121101434ieq.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xm2ATCubVQ/1yiUN7vUqIFTxTc0nv6xUm8SPMWL9irA=;
        b=Jp3ReGgesM+37rK1aVSTRwcYxrvuE9Y31Utij899/9wLivtH4nDXmRLa854Ajcz7Jk
         mCBY8H2knXYJPnWczR6UGIBLZpI2XFIcvPKrTB8gXcmmDjcSx55/UBuOiiL2AcTglviw
         wTYZa5FgGI09sL/dfoHkKJqjoBY1swJt2s6Tf3T91b8rmZI6VRE8iOCSk1ydGbi0YwAN
         ct2pI8ZnxOpFFZUWzfkf5OyQ7okfm/pRpS9BQXt9lvmSWOtD8Oejl3YqP2O0h/vKH1vF
         U3KFYLu1MHRBAs0a9D+yBeudxgZCxkUFD6f2OAu9VslABK7pa99Wx8JR4bIXgZiNj82G
         dvqA==
X-Received: by 10.107.46.2 with SMTP id i2mr21865767ioo.18.1435602057772;
        Mon, 29 Jun 2015 11:20:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id m92sm5070014ioi.41.2015.06.29.11.20.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 11:20:57 -0700 (PDT)
In-Reply-To: <1435232596-27466-5-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jun 2015 17:13:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272990>

Karthik Nayak <karthik.188@gmail.com> writes:

> Since 'ref-filter' only has an option to match path names.

That is not a whole sentence ;-)

> Add an option for regular pattern matching.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

> -	if (flag & REF_BAD_NAME) {
> -		  warning("ignoring ref with broken name %s", refname);
> -		  return 0;
> -	}
> -

Hmm, where did this check go in the new code?  Or is it now OK not
to warn or ignore, and if so why?

>  	if (flag & REF_ISBROKEN) {
>  		warning("ignoring broken ref %s", refname);
>  		return 0;
>  	}
>  
> -	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
> +	if (!filter_pattern_match(filter, refname))
>  		return 0;
>  
>  	if (!match_points_at(&filter->points_at, oid->hash, refname))

> diff --git a/ref-filter.h b/ref-filter.h
> index 6b6fb96..a4809c8 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -54,7 +54,8 @@ struct ref_filter {
>  	} merge;
>  	struct commit *merge_commit;
>  
> -	unsigned int with_commit_tag_algo: 1;
> +	unsigned int with_commit_tag_algo: 1,
> +		match_as_path: 1;

Lose SP on both sides of the colon, or have SP on both sides
(same for the last patch in the previous series).
