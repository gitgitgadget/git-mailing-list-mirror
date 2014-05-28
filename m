From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 14/41] refs.c: update ref_transaction_delete to check
 for error and return status
Date: Wed, 28 May 2014 11:42:34 -0700
Message-ID: <20140528184234.GS12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-15-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpioD-0001Wk-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbaE1Smi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:42:38 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55901 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbaE1Smh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:42:37 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so11459551pab.40
        for <git@vger.kernel.org>; Wed, 28 May 2014 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4HVZgtOg/HT8BVDDWAe8L4pWAILqKAhLz9yKBja72K0=;
        b=cVVk6cFrQQ0fh+rBsVOx4tuZ2aSjoMo87SiTqrbNuKTZuTm+gqAoTpI3h38DF4UxgJ
         Yba2HeOoFV1MQKK58o8ZaHLnRoHrKzZDxnZmhWoPCg64s/Oa+45Tqa2D2bJEgGXir5Od
         IxPIqHbklJgBXk6q/H7usOhRQTmhgewWsZ1Y2ws672oQTTn3HlohaKDHJ7OZzMkoLLcb
         UDRMr1mD/1/6xK9bzMC0qRbpeUzZT72TyijU9PO1Gz4+8GYSebCIMhqe9nx5xZNxnFWd
         +jvjipGFIr2xNI0UUIKnN+qmppnp98nFz61klSSVquxdNlEYOW5BZZQBbrYsxZSjqZTf
         GtFw==
X-Received: by 10.68.162.34 with SMTP id xx2mr1887072pbb.120.1401302557059;
        Wed, 28 May 2014 11:42:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id no9sm29547538pbc.83.2014.05.28.11.42.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 11:42:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-15-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250310>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c |  5 +++--
>  refs.c               | 16 +++++++++++-----
>  refs.h               | 12 ++++++++----
>  3 files changed, 22 insertions(+), 11 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> +++ b/refs.c
> @@ -3417,19 +3417,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
>  	return 0;
>  }
>  
> -void ref_transaction_delete(struct ref_transaction *transaction,
> -			    const char *refname,
> -			    const unsigned char *old_sha1,
> -			    int flags, int have_old)
> +int ref_transaction_delete(struct ref_transaction *transaction,
> +			   const char *refname,
> +			   const unsigned char *old_sha1,
> +			   int flags, int have_old,
> +			   struct strbuf *err)
>  {
> -	struct ref_update *update = add_update(transaction, refname);
> +	struct ref_update *update;
>  
> +	if (have_old && !old_sha1)
> +		die("BUG: have_old is true but old_sha1 is NULL");
> +
> +	update = add_update(transaction, refname);
>  	update->flags = flags;
>  	update->have_old = have_old;
>  	if (have_old) {
>  		assert(!is_null_sha1(old_sha1));

Could combine this into the 'if (have_old &&' check.

Thanks,
Jonathan
