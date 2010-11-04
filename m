From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] Start to replace locate_rename_dst() with a generic
 function.
Date: Thu, 4 Nov 2010 15:45:55 -0500
Message-ID: <20101104204555.GA18187@burratino>
References: <1288902795-8597-1-git-send-email-ydirson@altern.org>
 <1288902795-8597-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6hW-00039G-Bl
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab0KDUqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:46:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56293 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab0KDUqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:46:20 -0400
Received: by wyb36 with SMTP id 36so346079wyb.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=43gu3KaOPyyYfbrPlAihBWkmo3NsyJUZjw6aE3e8CKU=;
        b=HYzHdNhglEkZcHnkSh4TJuiPJvft/ybrlvmUw3sHxlGDWOnJR76oB8L0/ZikfxO1Gc
         kD0gORsaY8kARrQHuc10hqDrNR7HrVAOgC4hGV/wiX7JVHKRp/YjohG+Mv7Ikx7C6/2C
         PBQATITeNcjtekGS1exPHjqmq5ybWdTRjGYGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jqcnDOaKhGRfPour/K9XHUJJaxP2pyrmp1tUhb05A4c4eA4S0RPYO1HGcqgTIyOgzr
         V3Ss6iHZS9Abu8gAuRTnX5lC3LmSW64BQXunMQg5JUWibbLRmFrMEQfoPribwCCBBtVS
         iqgUIRSHQMpo8mm5ocrgMcgEPySq4DeuP8bmU=
Received: by 10.216.16.211 with SMTP id h61mr1122587weh.106.1288903579175;
        Thu, 04 Nov 2010 13:46:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w8sm279710wei.21.2010.11.04.13.46.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 13:46:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288902795-8597-2-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160763>

Yann Dirson wrote:

> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -6,6 +6,10 @@
>  #include "diffcore.h"
>  #include "hash.h"
>  
> +#define locate_element(list,elem,insert_ok)			\
> +	_locate_element(elem, &list##_nr, &list##_alloc,	\
> +			insert_ok)
> +

Is this syntactic sugar needed?

 static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
						  insert_ok)
 {
	return locate_element(&rename_dst_nr, &rename_dst_alloc, elem, insert_ok);
 }

takes more advantage of the compiler's typechecking and looks easy
enough to read.

Since this is local to diffcore-rename, I don't mind the locate_element()
name, but if this is to be used more widely I think it would need to be
named more precisely.  (find_or_insert_in_array()?)

> @@ -13,14 +17,17 @@ static struct diff_rename_dst {
[...]
> -static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
> -						 int insert_ok)
> +static struct diff_rename_dst *_locate_element(struct diff_filespec *two,
> +					       int *elem_nr_p, int *elem_alloc_p,
> +					       int insert_ok)
>  {
>  	int first, last;
>  
>  	first = 0;
> -	last = rename_dst_nr;
> +	last = (*elem_nr_p);

I guess these parentheses came from search+replace?  It's more
readable without them.

[...]
> +	(*elem_nr_p)++;

Except for this one.

Generally, the approach seems sane so far.
