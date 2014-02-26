From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 2/3] merge: Add hints to tell users about "git merge
 --abort"
Date: Wed, 26 Feb 2014 12:38:36 -0800
Message-ID: <20140226203836.GM7855@google.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
 <1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:38:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIlFc-0007SG-R9
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbaBZUik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:38:40 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:60932 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaBZUij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:38:39 -0500
Received: by mail-pa0-f53.google.com with SMTP id ld10so1265027pab.26
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 12:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=E4+bMDRfR0RU758fllsjSirjq1fPdsQLIebLVycDLuc=;
        b=DXyxyT7OG9waXVdYx947KYKJl7tXs0fsYpmQMIdIkf/iPQ2RDrkX3BFmERnPb3GZ6W
         Fy0hR3HsEYCTQmkg68BbQF2d+xRmUtB8jVzzwbxRZIDQ6heBPEpK3GbfqJS2aVnITXiq
         RN7VRmnZj5f3iEC2NvEUASeouQiEGZG7OnzPc4mCRlqGZXwlUu6iqOxy+RR/R0iG2PWQ
         LCj+yNy229eGHYVSmAOsmqGIU5vNJrmnjpSyvgUjEP7OhNpWNldSb46S0sO+BWOz970d
         U7+iqszVGT8CkGwYuM7hUNsm9yGYi/1S0JXwNFfn539uNAZcjQ0HVSwCgMnRADhjG8cm
         zz1g==
X-Received: by 10.66.142.132 with SMTP id rw4mr11336193pab.6.1393447119393;
        Wed, 26 Feb 2014 12:38:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qs1sm6318407pbb.18.2014.02.26.12.38.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 12:38:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242764>

Andrew Wong wrote:

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -909,7 +909,8 @@ static int suggest_conflicts(int renormalizing)
>  	fclose(fp);
>  	rerere(allow_rerere_auto);
>  	printf(_("Automatic merge failed; "
> -			"fix conflicts and then commit the result.\n"));
> +			"fix conflicts and then commit the result.\n"
> +			"To abort the merge, use \"git merge --abort\".\n"));

Seems reasonable, but I worry about the command growing too noisy.

Could this be guarded by an advice.<something> setting?  (See advice.*
in git-config(1) for what I mean.)

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -907,6 +907,9 @@ static void show_merge_in_progress(struct wt_status *s,
>  			status_printf_ln(s, color,
>  				_("  (use \"git commit\" to conclude merge)"));
>  	}
> +	if (s->hints)
> +		status_printf_ln(s, color,
> +			_("  (use \"git merge --abort\" to abort the merge)\n"));

Perhaps:

	...
		_("  (or use \"git merge --abort\" to abort the merge)"));

to clarify that this is an alternative to the advice immediately above.

`status_printf_ln` already prints a newline, so the translated message
shouldn't include an extra one.

Thanks,
Jonathan
