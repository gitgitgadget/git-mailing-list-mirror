From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 36/44] refs.c: pass the ref log message to
 _create/delete/update instead of _commit
Date: Wed, 21 May 2014 16:47:17 -0700
Message-ID: <20140521234717.GL12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-37-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 01:47:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnGEP-0001Gb-55
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 01:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbaEUXrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 19:47:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47474 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbaEUXrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 19:47:20 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so1857165pab.5
        for <git@vger.kernel.org>; Wed, 21 May 2014 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MaMO7DygYyP+bGAfzexgV2UdU3c4D0ZIVLgbIxibx1k=;
        b=TkKytVG0MkV8CWDw/62mQ2xDV+Q0E8gZyOfRCvS+tWtl440pf9B0gHr4+3GlDi29Zm
         PFKzw/9FVdUbWZeR5ggBXucjqu/yu9R5Wy77sDFj7TzF34VsLWJcrQQ4oKCQ5uxFwRdD
         Gyt5mYVg/zcJqXaOwjUbvTFDLX/w6eb7TjG94IDPt0N9oiZTE4eBj4EXl6tRXkOlT6jD
         EHYSxWpu+SApnJdyo6da0MeZlUYPnc91v0V2iiLzBnVaqBT3n2Ctv2cgXpqG0ce7NHEv
         IA2oLZIIbnkmDGmnsnt/DKNqj1hWIWR1L7ok/8Ne61Gc1QZkmEygfad0f35n8hhbzNEc
         esyw==
X-Received: by 10.68.237.67 with SMTP id va3mr11966217pbc.19.1400716040202;
        Wed, 21 May 2014 16:47:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ga1sm9895621pbb.82.2014.05.21.16.47.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 16:47:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-37-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249860>

Ronnie Sahlberg wrote:

> Change the reference transactions so that we pass the reflog message
> through to the create/delete/update function instead of the commit message.

Nice.

[...]
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -673,7 +673,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
> 			}
> 		}
> 	}
> -
> 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
> 		error(_("some local refs could not be updated; try running\n"
> 		      " 'git remote prune %s' to remove any old, conflicting "

Stray whitespace change?

[...]
> --- a/refs.c
> +++ b/refs.c
[...]
> @@ -3264,6 +3264,7 @@ struct ref_update {
>  	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
>  	struct ref_lock *lock;
>  	int type;
> +	const char *msg;
>  	const char refname[FLEX_ARRAY];

Should be 'char *msg' since we own the memory (or perhaps a strbuf).

[...]
> @@ -3297,9 +3298,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  	if (!transaction)
>  		return;
>  
> -	for (i = 0; i < transaction->nr; i++)
> +	for (i = 0; i < transaction->nr; i++) {
> +	  free((char *)transaction->updates[i]->msg);
>  		free(transaction->updates[i]);

Whitespace?

No need to cast.

The rest of the patch looks good.

Thanks,
Jonathan
