From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 02/42] refs.c: allow passing NULL to
 ref_transaction_free
Date: Tue, 13 May 2014 15:44:22 -0700
Message-ID: <20140513224422.GX9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:44:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLR0-0005Mt-8W
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbaEMWo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:44:27 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37496 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbaEMWo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:44:26 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so815648pab.29
        for <git@vger.kernel.org>; Tue, 13 May 2014 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+1w7a5ZZAVIbjfm6NTFDU2qVtNMF4lEuk1nr7/J6BjY=;
        b=Ztb4UkqohmmclWoN0gVsR02mYXypJ0EXIWO8+WR2X5jTz4xZTdR0mwF/k7JGxHMeX3
         QHbM7ZT5FdrSIlBtLA8d+2KG3Oqw2uVNfB4qeDRGYQI/E1u5RZzpVewPPBaC+N3l5Sw+
         DuGlhw4w5MuXgYNBRNG6q1ycUAgsebUAGaYX0wbkMTad4O21A4dldjxxrrc4/M7HvIDS
         knfagltTN7hH9Lx1OzQ86kr+IFiG1V10wI1a3UjhjwYUd0r97GTXNt2qKxvs11oN80ig
         7q55ZVrLFeMt7X3oXe9HUvcEnhKAdb+DLy3Z887Kae5TgxcZWHGoawGZhujAbUJ4zMJi
         /Cwg==
X-Received: by 10.68.197.195 with SMTP id iw3mr8382538pbc.139.1400021065574;
        Tue, 13 May 2014 15:44:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sh5sm30142067pbc.21.2014.05.13.15.44.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 15:44:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-3-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248879>

Ronnie Sahlberg wrote:

> Allow ref_transaction_free to be called with NULL and in extension allow
> ref_transaction_rollback to be called for a NULL transaction.

In extension = as a result?

Makes sense.  It lets someone do the usual

	struct ref_transaction *transaction;
	int ret = 0;

	if (something_fails()) {
		ret = -1;
		goto cleanup;
	}
	...

 cleanup:
	ref_transaction_free(transaction);
	return ret;

just like you can already do with free().

> This allows us to write code that will
>
>   if ( (!transaction ||
>         ref_transaction_update(...))  ||
>       (ref_transaction_commit(...) && !(transaction = NULL)) {
>           ref_transaction_rollback(transaction);
>           ...
>   }

Somewhere in the whitespace and parentheses I'm lost.

Is the idea that when ref_transaction_commit fails it will have
freed the transaction so we need not to roll back to prevent a
double free?  I think it would be simpler for the caller to
unconditionally set transaction to NULL after calling
ref_transaction_commit in such a case to avoid use-after-free.

Even better if it is the caller's responsibility to free
the transaction.  At any rate, it doesn't seem related to this
patch.

> --- a/refs.c
> +++ b/refs.c
> @@ -3303,6 +3303,9 @@ static void ref_transaction_free(struct ref_transaction *transaction)
>  {
>  	int i;
>  
> +	if (!transaction)
> +		return;

Except for the unclear commit message,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
