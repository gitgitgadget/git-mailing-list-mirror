From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6] refs.c: use a string_list for repack_without_refs
Date: Thu, 20 Nov 2014 12:36:48 -0800
Message-ID: <20141120203648.GI6527@google.com>
References: <CAGZ79kYogEQuynukSkb9La+7DZxOQonAyuYD=kWB7KRdsXLHOA@mail.gmail.com>
 <1416514066-17049-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 21:36:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrYTB-0004og-N8
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 21:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbaKTUgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 15:36:45 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:38710 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143AbaKTUgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 15:36:44 -0500
Received: by mail-ie0-f176.google.com with SMTP id ar1so3585582iec.35
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 12:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wR8X3p7VN1XgGKZGMQm4oBKlGh4xsdsT9/Kh/8pSduk=;
        b=gunXqCQ6Rm70N8pJpiA/XG+z6YpEn6RPxsIz8MjCdh+drBiM7bNyBhCUW0XJrw4DBR
         hmFN4fvq2HLRh3Tz1SZUpVYRGmRpoiB7kGRr2VdtFew0TOYwLzQb0wpX72isIBk+dBeE
         aXuEU8Wot5LoFEuZ//JI6Om8sIyILu+2R1JB8lkZqC6/nw4aM1my+8/B0qT6+A4UoIaX
         x+Hf5iJ5XnUVc4ZjDf2+VmQXwHkKGgeAtUpc59jmTzB8Nsh1v9aPA9+hKLFBi6tbJAiX
         RgNZxV/2ELbUeXfNgZaOCM/VOoIqfjAeHl/uOIiN7znpkcMDs8sPAZM5kjA0bs3EZGax
         3ggw==
X-Received: by 10.50.30.132 with SMTP id s4mr11437137igh.24.1416515804136;
        Thu, 20 Nov 2014 12:36:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id v84sm1731839ioe.41.2014.11.20.12.36.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 12:36:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416514066-17049-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Yep, looks good now.  Thanks for bearing with me.

[...]
> +++ b/refs.h
> @@ -163,8 +163,16 @@ extern void rollback_packed_refs(void);
[...]
> +/*
> + * Remove the refs listed in the unsorted string list 'without' from
> + * the packed-refs file. On error, packed-refs will be unchanged, the
> + * return value is nonzero, and a message about the error is written
> + * to the 'err' strbuf.
> + *
> + * The refs in 'without' may be unsorted.
> + * 'err' must not be NULL.

I think we've gone back and forth enough on this text and it's not
worth the transactional cost to tweak it further, so I'm not
suggesting a change --- just explaining how I read it for future
reference.

"may be unsorted" is confusing to me.  It sounds like the reader of
this comment (someone calling repack_without_refs) has to be prepared
for that possibility.  But we are saying the opposite --- not "be
prepared", but "don't worry about sorting 'without', since
repack_without_refs can handle it".

It's also redundant, since the paragraph above already says that
'without' is an unsorted string list.

The way I see it, there are four types that for various reasons (lack
of language-level support for subclassing, etc) are conflated into a
single struct in the string-list API:

 * sorted string list that owns its items (i.e., created with DUP)
 * sorted string list that does not own its items (i.e., created with NODUP)
 * unsorted string list that owns its items
 * unsorted string list that does not own its items

Different functions are valid to call on each type, as documented in
the comments in string-list.h.

repack_without_refs accepts all 4 types of string-list.  That's what
it means when the documentation says its argument is unsorted.

Thanks,
Jonathan
