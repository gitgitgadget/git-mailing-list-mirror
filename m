From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] transport: Remove git_transport_options.push_cert
Date: Fri, 14 Aug 2015 16:14:30 -0700
Message-ID: <xmqqmvxtfoo9.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<1439492451-11233-6-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 01:14:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQOBI-0004Pv-BF
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 01:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbbHNXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 19:14:32 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35651 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbbHNXOb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 19:14:31 -0400
Received: by pacgr6 with SMTP id gr6so68484651pac.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Acv3eW1SZlMod3R/yh6DqCu3PPanoF7yFLpbHd/MVA4=;
        b=oVlR2BZHzfuvYT3OuIXApujix5uxZ4gUWX58mtiqWicVb8LzBs1ifL7e+PUARdYDzF
         Ds3fDUp5G2pIx7oGBn4aTV5REl2/f6XEbKXhdHfT73Oanm+BzZg5pimeEtPsD72Nijun
         fvMkitliXgmKlSyQgre+5TF3N1PnSt2t0SeeI2Su52ejFGAOPusV80eq8RpW2NGcv2GR
         O7aMnpL2ay/cvbjy3Lpb2k40Vmil//BdK/hG/voNoh4VTYVte4LFInd7R9fETD/G9sMp
         CJQhMLLiJRDfZtKfChADBf0sryGzXzoJ8wSvFPA3DW7LhMJZ6FeRcS0hmpSQ9fqPMh0D
         /yqA==
X-Received: by 10.68.143.40 with SMTP id sb8mr90952710pbb.21.1439594071127;
        Fri, 14 Aug 2015 16:14:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id dm6sm7206970pdb.36.2015.08.14.16.14.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 16:14:30 -0700 (PDT)
In-Reply-To: <1439492451-11233-6-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Thu, 13 Aug 2015 15:00:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275975>

Dave Borowitz <dborowitz@google.com> writes:

> This field was set in transport_set_option, but never read in the push
> code. The push code basically ignores the smart_options field
> entirely, and derives its options from the flags arguments to the
> push* callbacks. Note that in git_transport_push there are already
> several args set from flags that have no corresponding field in
> git_transport_options; after this change, push_cert is just like
> those.
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---

Thanks for cleaning up my mess.

Honestly, to me, the smart transport is always a second-class
citizen (and http walkers are not even citizens ;-)) and any support
of new feature is added as an after-thought once the feature starts
working with the native transport, and that development pattern
clearly shows in a place like this.

>  transport.c | 3 ---
>  transport.h | 1 -
>  2 files changed, 4 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 40692f8..3dd6e30 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -476,9 +476,6 @@ static int set_git_option(struct git_transport_options *opts,
>  				die("transport: invalid depth option '%s'", value);
>  		}
>  		return 0;
> -	} else if (!strcmp(name, TRANS_OPT_PUSH_CERT)) {
> -		opts->push_cert = !!value;
> -		return 0;
>  	}
>  	return 1;
>  }
> diff --git a/transport.h b/transport.h
> index 18d2cf8..79190df 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -12,7 +12,6 @@ struct git_transport_options {
>  	unsigned check_self_contained_and_connected : 1;
>  	unsigned self_contained_and_connected : 1;
>  	unsigned update_shallow : 1;
> -	unsigned push_cert : 1;
>  	int depth;
>  	const char *uploadpack;
>  	const char *receivepack;
