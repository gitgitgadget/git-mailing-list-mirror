From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: fix truncation of off_t in comparison
Date: Thu, 04 Jun 2015 10:28:12 -0700
Message-ID: <xmqqlhfzv0wj.fsf@gitster.dls.corp.google.com>
References: <20150604123541.GA8888@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:28:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0YwF-0003yS-RD
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbbFDR2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:28:15 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35243 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbbFDR2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:28:15 -0400
Received: by igbzc4 with SMTP id zc4so14075056igb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=e94UXcXvVSakF0HUGJCgDbW1cm/vD8PH0PMYYghSBOo=;
        b=gAqHk3UUiCYBbWtaTbtTuniDxMPTZnvvGm3BJlJc9OGPyB/SCPjqi1dX/wMSEPjQ6D
         BMuF6jUNFprRNjIw1jEXkPZqZTrcbG225wn9iHOOUiRz9mW3FL9Jza1tT6ebWh7/wbRM
         cvoq/gOpJ4KDQnGabVCAB/Dvb4sm+OQ+Nkk32LTzyLS9Z9FvLowlEOrObtNEs5qMkT8g
         UYytVJpCvUx4Bt8SO0fi2rZl4kOTsj4H9ECa7MjXfh+873TjycOJf5wpuWi6Fe/ecA6U
         4FX35M+dN4kLr2EFfbSeSJ9rDzhqr2AcqKSMpAOiN9SwKyJpy7PEqztK84Bx9h2PfWa5
         O1MQ==
X-Received: by 10.50.64.244 with SMTP id r20mr35117148igs.33.1433438894749;
        Thu, 04 Jun 2015 10:28:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id d4sm14630344igl.1.2015.06.04.10.28.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 10:28:14 -0700 (PDT)
In-Reply-To: <20150604123541.GA8888@peff.net> (Jeff King's message of "Thu, 4
	Jun 2015 08:35:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270788>

Jeff King <peff@peff.net> writes:

> On top of nd/slim-index-pack-memory-usage, which introduced the bug (but
> it is already in master).

Thanks.

In this round, I decided to deliberately merge more iffy and larger
topics to 'master' in early part of the cycle, and it seems to be
paying off nicely ;-).

Will queue.

>  builtin/index-pack.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 3ed53e3..06dd973 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -616,7 +616,9 @@ static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
>  	int cmp = type1 - type2;
>  	if (cmp)
>  		return cmp;
> -	return offset1 - offset2;
> +	return offset1 < offset2 ? -1 :
> +	       offset1 > offset2 ?  1 :
> +	       0;
>  }
>  
>  static int find_ofs_delta(const off_t offset, enum object_type type)
> @@ -1051,7 +1053,9 @@ static int compare_ofs_delta_entry(const void *a, const void *b)
>  	const struct ofs_delta_entry *delta_a = a;
>  	const struct ofs_delta_entry *delta_b = b;
>  
> -	return delta_a->offset - delta_b->offset;
> +	return delta_a->offset < delta_b->offset ? -1 :
> +	       delta_a->offset > delta_b->offset ?  1 :
> +	       0;
>  }
>  
>  static int compare_ref_delta_entry(const void *a, const void *b)
