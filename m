From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 24/44] fetch.c: use a single ref transaction for all
 ref updates
Date: Fri, 16 May 2014 15:52:11 -0700
Message-ID: <20140516225211.GI12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-25-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat May 17 00:54:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlR1j-0003OT-HC
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 00:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbaEPWyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 18:54:51 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43099 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbaEPWwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 18:52:14 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so3129317pab.38
        for <git@vger.kernel.org>; Fri, 16 May 2014 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J1oYdJEZev/aZ9rR9J2bcnPIhEOXSwideC3g/5yThnU=;
        b=VZfx2s7ZzyZZ2N+B6spvuJ7f+Wbz/c8cW0M7EVOLconY3KQxTpU6hYfHSFqYAaxDJW
         RFAvGMrJ1NF67dbANRVcbJLXfmY/AUcRtp/7c+a8iXNV4ee26qYT3fGPAYXz22myJFPA
         b7KHguvlnEBjSwihf+rTqQIIn5fszyRm0xjaVRerdrSN1MkgZMHXHJZwN+phU//znRFX
         WG6834ikABSsGBdNmoLEYS4pIuLL3jTUn1q1tETSFntqtauMkr+hzYJn6gZ9I1+WvY38
         mxsV2E6w8Fl0W3SyAHkZRY6y0b8C34UC+gRAkYYBFyZ5JGw003PVD2gIyRG5HS4Ta1A5
         b1dA==
X-Received: by 10.68.224.101 with SMTP id rb5mr24507232pbc.135.1400280734157;
        Fri, 16 May 2014 15:52:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id su8sm16458994pbc.72.2014.05.16.15.52.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 15:52:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-25-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249429>

Ronnie Sahlberg wrote:

> Change store_updated_refs to use a single ref transaction for all refs that
> are updated during the fetch. This makes the fetch more atomic when update
> failures occur.

Fun.

[...]
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
[...]
> @@ -373,27 +374,13 @@ static int s_update_ref(const char *action,
>  			struct ref *ref,
>  			int check_old)
>  {
> -	char msg[1024];
> -	char *rla = getenv("GIT_REFLOG_ACTION");
> -	struct ref_transaction *transaction;

Previously fetch respected GIT_REFLOG_ACTION, and this is dropping
that support.  Intended?

[...]
> +	if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
> +			       ref->old_sha1, 0, check_old))
> +		return STORE_REF_ERROR_OTHER;

Should pass a strbuf in to get a message back.

[...]
> +
>  	return 0;
>  }
>  
> @@ -565,6 +552,13 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		goto abort;
>  	}
>  
> +	errno = 0;
> +	transaction = ref_transaction_begin();
> +	if (!transaction) {
> +		rc = error(_("cannot start ref transaction\n"));
> +		goto abort;

error() appends a newline on its own, so the message shouldn't
end with newline.

More importantly, this message isn't helpful without more detail about
why _transaction_begin() failed.  The user doesn't know what

	error: cannot start ref transaction

means.

	error: cannot connect to mysqld for ref storage: [etc]

would tell what they need to know.  That is:

	transaction = ref_transaction_begin(err);
	if (!transaction) {
		rc = error("%s", err.buf);
		goto abort;
	}

errno is not used here, so no need to set errno = 0.

[...]
> @@ -676,6 +670,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  			}
>  		}
>  	}
> +	if ((ret = ref_transaction_commit(transaction, NULL)))
> +		rc |= ret == -2 ? STORE_REF_ERROR_DF_CONFLICT :
> +				STORE_REF_ERROR_OTHER;

(I cheated and stole the newer code from your repo.)

Yay!  Style nit: git avoids assignments in "if" conditionals.

	ret = ref_tr...
	if (ret == -2)
		rc |= ...
	else if (ret)
		rc |= ...

Does _update need the too as futureproofing for backends that can
detect the name conflict sooner?

Thanks,
Jonathan
