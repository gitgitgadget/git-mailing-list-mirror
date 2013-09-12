From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2] urlmatch.c: recompute ptr after append_normalized_escapes
Date: Thu, 12 Sep 2013 13:38:37 -0700
Message-ID: <85CEBFAA-8905-46EC-88C5-5DDE629B73F9@gmail.com>
References: <75d702a744eb33a456622dd2ff901abef83e51d8.1378979451.git.trast@inf.ethz.ch> <c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79> <xmqqioy5q4dd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 22:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKDfA-0004BC-0b
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 22:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144Ab3ILUio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 16:38:44 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:63545 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127Ab3ILUim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 16:38:42 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so299098pdj.35
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=kIH22cubbIeaz51p8/2LU8XP38i/VETEuRbsckHs2c0=;
        b=v2EysxXOJb4gmurbdDZo36IKopOc0eFJ7NMIFdvh+WkFUvAa7wZI4o/kBkpfJr2AsX
         pgjxek/05XPEPAWLncRGNMyCcx2ohS5KiY9/T4USJc2/f926n1GS2287EXY/1sKyEgZ1
         Z+YA9ow+/ZoTf18Vd2MTIt/hn7u+MHIMz3XlCVxxknwLmwNaEaIwSELYGPMR+vVKR7jr
         K71SBzdVE1hBVX3jOQOY/VXo/nFrWLWDbbrnbuI5vx2T7XkHYmPqPh8yk/VJiuklVmOb
         RAW7YEEPnHgZqhocl3aPozCtNHg2WBIv6CkS18GkuE8h2IOVRagA0zDaKEiceW+2mBjv
         akMw==
X-Received: by 10.68.134.6 with SMTP id pg6mr9606628pbb.67.1379018321791;
        Thu, 12 Sep 2013 13:38:41 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id cx4sm6835020pbc.24.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 13:38:41 -0700 (PDT)
In-Reply-To: <xmqqioy5q4dd.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234695>

On Sep 12, 2013, at 11:30, Junio C Hamano wrote:

>> +		/* append_normalized_escapes can cause norm.buf to change */
>> +		seg_start = norm.buf + seg_start_off;
>
> The change looks good, but I find that this comment is not placed in
> the right place.  It is good if the reader knows about an old bug to
> put it here, but if the first thing a reader reads is this updated
> version, the comment is better placed close to the place where the
> start_ofs variable captures the original value (i.e. "because the
> next call may relocate the buffer, we cannot grab seg_start upfront;
> instead we need to record the start_ofs here, and that is what this
> variable is about").
>
> It is too minor a point for a reroll, so I'll try to tweak it
> locally.  Something like this (but now I think about it, the comment
> may not even be necessary).

The longer comment looks good to me.  If you think the code will be  
safe from
simplification patches without a comment, that works for me too.  I've  
just seen
so many "simplification" patches go by on the list I'm concerned it  
will be a
target otherwise leading to re-introduction of the problem.

> diff --git a/urlmatch.c b/urlmatch.c
> index 01c6746..d1600e2 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -282,9 +282,17 @@ char *url_normalize(const char *url, struct  
> url_info *out_info)
> 	}
> 	for (;;) {
> 		const char *seg_start;
> -		size_t seg_start_off = norm.len;
> +		size_t seg_start_off;
> 		const char *next_slash = url + strcspn(url, "/?#");
> 		int skip_add_slash = 0;
> +
> +		/*
> +		 * record the starting offset; appending escapes may
> +		 * relocate the buffer, so we cannot capture seg_start
> +		 * upfront and use it later.
> +		 */
> +		seg_start_off = norm.len;
> +
> 		/*
> 		 * RFC 3689 indicates that any . or .. segments should be
> 		 * unescaped before being checked for.
> @@ -298,7 +306,7 @@ char *url_normalize(const char *url, struct  
> url_info *out_info)
> 			strbuf_release(&norm);
> 			return NULL;
> 		}
> -		/* append_normalized_escapes can cause norm.buf to change */
> +
> 		seg_start = norm.buf + seg_start_off;
> 		if (!strcmp(seg_start, ".")) {
> 			/* ignore a . segment; be careful not to remove initial '/' */
