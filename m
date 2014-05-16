From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 23/44] fetch.c: change s_update_ref to use a ref
 transaction
Date: Fri, 16 May 2014 12:12:31 -0700
Message-ID: <20140516191231.GE12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-24-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 21:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlNYd-0007Oy-CM
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 21:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbaEPTMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 15:12:35 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:53333 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbaEPTMe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 15:12:34 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so2941632pad.13
        for <git@vger.kernel.org>; Fri, 16 May 2014 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=csDqN0J0zhcT+r0nWqLMkumDb9bvZNihONtvUuvDyLk=;
        b=Oxg0uMcXsWyGIJRDQO5fY/HLIPoFVAdNKcSeI7lnjjRxjmX1EUQnj9sysV0bxR4vN0
         97q0aLs/uXFl/oSnubXKsSjIbWlUI3I4viza2YvOm/+tIRWvrhSR9cFpw/OcgC+u0SvM
         HaP+CRhtqWZvBQht5ASZ9qJOxnVheQw3VisF7oypCLX6mp3QxVlwTNPUEDJtIkO2bqdM
         obQkNNKUJG3CoOlzuf34NanT/o+SmYiBI2M/UTouEPoiEBt0OXjCgVU0Z+FCMSIexkyz
         UJJ3tCgGgIpmt0M02ip0fScdZs4VgAHscOSQUb2z+87+KNRuGIEwGGy/ClA/OsPZXZVl
         TxYQ==
X-Received: by 10.68.231.35 with SMTP id td3mr22949447pbc.137.1400267554435;
        Fri, 16 May 2014 12:12:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id av2sm15921389pbc.16.2014.05.16.12.12.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 12:12:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-24-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249415>

(+cc: peff for STORE_REF_ERROR_DF_CONFLICT expertise)
Ronnie Sahlberg wrote:

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -375,7 +375,7 @@ static int s_update_ref(const char *action,
[...]
> +	transaction = ref_transaction_begin();
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
> +				   ref->old_sha1, 0, check_old) ||
> +	    ref_transaction_commit(transaction, msg, NULL)) {
> +		ref_transaction_rollback(transaction);
>  		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
>  					  STORE_REF_ERROR_OTHER;
> +	}

I'd rather not rely on errno here (see the previous patch for why).
Is there some other way to distinguish the case where a ref couldn't
be created because there was a prefix of that ref in the way?

For example, maybe ref_transaction_commit could return a different
negative integer in this case.

Thanks,
Jonathan
