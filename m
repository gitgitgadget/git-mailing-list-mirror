From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 03/42] refs.c: add a strbuf argument to
 ref_transaction_commit for error logging
Date: Tue, 13 May 2014 16:10:12 -0700
Message-ID: <20140513231012.GY9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:10:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLq5-00060F-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 01:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbaEMXKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 19:10:18 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53384 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbaEMXKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 19:10:16 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so836929pab.40
        for <git@vger.kernel.org>; Tue, 13 May 2014 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Xh3/bxt1wKSRXaPkzhATlmwhgqdDSmjmUe/IB9kElhw=;
        b=0lH+rLy9NASE+UbpUH4YI04rbMOyWQc51E4jqcDo54VmkU4vL1K0ReB6X2qXnJap3Q
         5/kINu7Al4DPgEDyuaOStHQN93t/kZybekBN68dfaPVb+8ZvnkYx0KsoiQatwap2qxNP
         W8R+pae7SGR42XJtjUNkUIeVaJ/tJ0BaJgzHrIY+iLKHO6KH93jQOz1hM8p1qzLeqrY1
         84Kh8ma0HaRB/Rn3bCVlvBSLiTXnycKqVBs/s7ocqgpaR7TRy1f31jVC+u2Rb78ETvtd
         X+bOUacQE6abBvfwOuywc28NpNB7ZYvPYexxDEkX9S02WBOOZjxRV0YK5U5ZP7KmfX6K
         BqDw==
X-Received: by 10.66.66.199 with SMTP id h7mr16490pat.30.1400022615631;
        Tue, 13 May 2014 16:10:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xk3sm30165304pbb.65.2014.05.13.16.10.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 16:10:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-4-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248885>

Ronnie Sahlberg wrote:

> Add a strbuf argument to _commit so that we can pass an error string back to
> the caller. So that we can do error logging from the caller instead of from
> _commit.
>
> Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
> and craft any log messages from the callers themselves and finally remove the
> onerr argument completely.

Very nice.

[...]
> +++ b/refs.c
[...]
> @@ -3443,6 +3444,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  					       update->flags,
>  					       &update->type, onerr);
>  		if (!update->lock) {
> +			if (err)
> +				strbuf_addf(err ,"Cannot lock the ref '%s'.",
> +					    update->refname);

Tiny nit: whitespace.

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -268,9 +268,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
>   * Commit all of the changes that have been queued in transaction, as
>   * atomically as possible.  Return a nonzero value if there is a
>   * problem.  The ref_transaction is freed by this function.
> + * If err is non-NULL we will add an error string to it to explain why
> + * the transaction failed.

Probably worth mentioning the error string doesn't end with a newline
so the caller knows how to use it.

With the whitespace fix and with or without the comment tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/refs.c w/refs.c
index 64e8feb..2ca3169 100644
--- i/refs.c
+++ w/refs.c
@@ -3445,7 +3445,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       &update->type, onerr);
 		if (!update->lock) {
 			if (err)
-				strbuf_addf(err ,"Cannot lock the ref '%s'.",
+				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
 			ret = 1;
 			goto cleanup;
diff --git i/refs.h w/refs.h
index ff87e14..d45212f 100644
--- i/refs.h
+++ w/refs.h
@@ -268,8 +268,8 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.  The ref_transaction is freed by this function.
- * If err is non-NULL we will add an error string to it to explain why
- * the transaction failed.
+ * If err is non-NULL we will append an error string (with no trailing
+ * newline) to it to explain why the transaction failed.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, struct strbuf *err,
