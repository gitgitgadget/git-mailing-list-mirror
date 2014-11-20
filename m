From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 1/1] refs.c: use a stringlist for repack_without_refs
Date: Thu, 20 Nov 2014 10:29:01 -0800
Message-ID: <20141120182901.GC15945@google.com>
References: <20141120021540.GF6527@google.com>
 <1416506666-5989-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:29:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWTg-0000u6-Ul
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806AbaKTS3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:29:08 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:64556 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077AbaKTS3H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:29:07 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so3300964igb.11
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c4t3lal1b/i5Z5IdUYqTDlukD3TxKlZvSzU2Hhg+kao=;
        b=JJ9e6vogWkDWYk4SgNSmpCZLa2VWGCcVm1SXFIpPEBi/Vn9Lb/kAhVOaoegVUy3Zk4
         GFBDwo6EDhJFL5GBes15W81HMhBnKjHAgALGNkbmiyxR9zxL5AhHOseXfio+RQz8wymm
         U/+kBzKxolh5wrwYwjjroHs4BvdcxYaajEX/RIbuW367wUWgowWmcf9r8UXlGBKH+S0A
         P5HwNgNWqKRv7jpR4FH+ccM7hgP7WlaIauqfVXiGpnluoIAvIIkgir5ee59Fr1gVz+OG
         cFVmvxqnOhafl0itFhDiggusFUMTfPqoiITa14R8Sx0vVYatmOYz5qEoCyeBmVrU/cOJ
         WuXw==
X-Received: by 10.42.216.77 with SMTP id hh13mr9331245icb.31.1416508146135;
        Thu, 20 Nov 2014 10:29:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id a4sm2852016igx.10.2014.11.20.10.29.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 10:29:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416506666-5989-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Change-Id: Id7eaa821331f2ab89df063e1e76c8485dbcc3aed

Change-id snuck in.

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -163,8 +163,16 @@ extern void rollback_packed_refs(void);
>   */
>  int pack_refs(unsigned int flags);
>  
> -extern int repack_without_refs(const char **refnames, int n,
> -			       struct strbuf *err);
> +/*
> + * Remove the refs listed in 'without' from the packed-refs file.
> + * On error, packed-refs will be unchanged, the return value is
> + * nonzero, and a message about the error is written to the 'err'
> + * strbuf.
> + *
> + * The refs in 'without' may have any order.

Tiny nit: this makes me wonder what the order represents --- how do
I pick which order for the refs in without to have?

I think the idea is just that 'without' doesn't have to be sorted (it's
a shame we don't have separate sorted string list and unsorted string
list types or a string_list_sorted() helper to catch bad callers early
to functions that care).  One way to say that would be

	Remove the refs listed in the unsorted string list 'without' from the
	packed-refs file.  On error, [...]

> + * The err buffer must not be omitted.

s/buffer/strbuf/, or s/The err buffer/'err'/
s/omitted/NULL/

With the Change-Id dropped, and with or without the above comment nits
addressed,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
