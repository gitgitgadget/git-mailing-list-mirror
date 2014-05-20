From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 26/44] fast-import.c: use a ref transaction when
 dumping tags
Date: Tue, 20 May 2014 13:38:57 -0700
Message-ID: <20140520203857.GS12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-27-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue May 20 22:39:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmqoU-0007Ps-8T
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 22:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbaETUjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 16:39:01 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33575 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaETUjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 16:39:00 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so666635pab.10
        for <git@vger.kernel.org>; Tue, 20 May 2014 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MvMMjI3wZ24Q7e/aapATaclOg1l09n+TUOnIPTFxF1Y=;
        b=DpNYO1EoIHUxVMwmCeoZ4iCi3Prm1vLzvJc4WH4YfcYUMFFmngCoGHrx0aEDaAfby3
         ZfbcoWt3hV/orLMI7kYkBttyFnPEaeQ+h7C0xSgYBM/++a3Gd/YhsTG5VpT6USClUg/4
         74CPpo48kpUDbBh/HQ/QPc//BDgCF9HPoCljhu0ZPxt+cBpoO0LTlKwDQ8XXoeTI/c9c
         Kd/qktfESqMxhTwNLdOJxV5hgwTKVSAwh8uY8UY+aRTvUaQY5kl2vOlegDLb8jHdclDe
         gNssNpzTTsPYa+Nm43bs/gKk5b9iHD2bhZCNlP18v60sozke4rdoeb+jU+ePaGtgjUWj
         L2ww==
X-Received: by 10.68.219.162 with SMTP id pp2mr53674279pbc.47.1400618340205;
        Tue, 20 May 2014 13:39:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bu1sm4584798pbb.54.2014.05.20.13.38.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 13:38:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-27-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249740>

Ronnie Sahlberg wrote:

> [Subject: fast-import.c: use a ref transaction when dumping tags]

This seems like an odd thing to do: either it would make sense to have
a single transaction for all imported refs so all fail or succeed
together, or there would be separate transactions for each ref.

That said, I don't mind, particularly if it's a step on the way to
using a single transaction for everything being dumped.

[...]
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1736,15 +1736,22 @@ static void dump_tags(void)
>  {
>  	static const char *msg = "fast-import";
>  	struct tag *t;
> -	struct ref_lock *lock;
>  	char ref_name[PATH_MAX];
> +	struct strbuf err = STRBUF_INIT;
> +	struct ref_transaction *transaction;
>  
> +	transaction = ref_transaction_begin();
>  	for (t = first_tag; t; t = t->next_tag) {
> -		sprintf(ref_name, "tags/%s", t->name);
> +		sprintf(ref_name, "refs/tags/%s", t->name);

Can this overflow the buffer?

> -		lock = lock_ref_sha1(ref_name, NULL);
> -		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
> -			failure |= error("Unable to update %s", ref_name);
> +
> +		if (ref_transaction_update(transaction, ref_name, t->sha1,
> +					   NULL, 0, 0, &err)) {
> +			failure |= 1;
> +			break;
> +		}
>  	}
> +	if (failure || ref_transaction_commit(transaction, msg, &err))
> +		failure |= error("Unable to update %s", err.buf);

This 'if (failure || ...) failure |=' idiom seems strange.
Is err.buf always set if failure is nonzero?

Elsewhere failure is 0 or -1 but this introduces the possibility for
it to be temporarily 1.

dump_branches could have caused failure to be -1 before dump_tags
is called.  I think the intent is

		if (ref_transaction_update(...)) {
			failure |= error(...);
			goto out;
		}
	}
	if (ref_transaction_commit(...))
		failure |= error(...);
 out:
	ref_transaction_free(transaction);
	...

Thanks,
Jonathan
