From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 32/41] refs.c: make delete_ref use a transaction
Date: Fri, 30 May 2014 10:28:08 -0700
Message-ID: <20140530172808.GG12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-33-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 30 19:28:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQbI-0001lv-S5
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933692AbaE3R2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:28:13 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42721 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933195AbaE3R2L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:28:11 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1180055pdi.27
        for <git@vger.kernel.org>; Fri, 30 May 2014 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BVdnGhdBng8VFvtTB2IEC+A+z2k3zc/bmIBviVeZrSs=;
        b=aKnv245eNJPW9LU4uKEeL9xoL6eJdWzFUzdiW0azw2UAMr1pXmmCwAc/OpBjwP3yAh
         yEqB3s8u/f/o9UsIuvzYilEU4URSE9PNt/tl1CrzNdl9rlrDUftJ6NI35KYmJBb8NiY7
         /2IZE0JbshWmGRnjpGb9Rcnl27+WPDfOLUXHlU6xz5GU66Su1vqr5u+RgiJ1cPL5BuQl
         k5TuCEDf2fmRmxkpdw5Y8kFvowfhwVxjRux8oXSjkGkaetuoiFnugEgxlyfHoPB/OOzu
         kVESrZolV2Q8Vz6pshmo5WVU/qFl3Y8JhMtm1mH6719OoUDs29I8Sx/u6AXq29CPq5UZ
         Auug==
X-Received: by 10.68.242.135 with SMTP id wq7mr20171357pbc.147.1401470891564;
        Fri, 30 May 2014 10:28:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xk3sm7341761pbb.65.2014.05.30.10.28.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 10:28:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-33-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250448>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> +++ b/refs.c
[...]
> @@ -2542,24 +2537,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>  
>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  {
[...]
> +	if (!transaction ||
> +	    ref_transaction_delete(transaction, refname, sha1, delopt,
> +				   sha1 && !is_null_sha1(sha1), &err) ||
> +	    ref_transaction_commit(transaction, NULL, &err)) {
> +		error("%s", err.buf);
> +		ref_transaction_free(transaction);
> +		strbuf_release(&err);
>  		return 1;
> +	}
[...]
> -	ret |= repack_without_ref(lock->ref_name);

The old return value could be 1 or -1 depending on how the deletion
failed.  Now it's consistently 1.

The only callers I see that care are cmd_symbolic_ref and
cmd_update_ref, for which 1 is better (-1 would result in an exit
status of 255, which means something like "died with signal 127").

Thanks,
Jonathan
