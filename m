From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 13/41] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Wed, 28 May 2014 10:07:00 -0700
Message-ID: <20140528170700.GM12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-14-git-send-email-sahlberg@google.com>
 <20140528004200.GK12314@google.com>
 <CAL=YDWkQhq2oCkyBG0-ojUDwgApYj1qZt1vXa2gnYsJOEbnvxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:07:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WphJo-0001RR-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 19:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbaE1RHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 13:07:06 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:42750 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbaE1RHD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 13:07:03 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so11477562pbc.4
        for <git@vger.kernel.org>; Wed, 28 May 2014 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hGQ2+ZIN5lNul0asIyW0BlTPvKwNGewqza8e2By3DAk=;
        b=ffY6OSuLsm9L1LsjJ52/dOBJ9B51v+XfROPNtroOrvAOzYSV9y98GRUjCTyWZu7h2c
         OU4bDBe8AdYX6feEOIIK/kdpRzH4ytlvscR5fHzXaFhyGJ6Y0sOUY9P+Ma8TvoHqVZ5i
         lXB/t7EPYbuZ8YI6mzsHAjpfbZ2GbRWw1mISgopJhsOpOZm6P6bX1+TChXM+jhtcsneg
         vOcKJpxA2ZI+rZOpTzoZAHUC1eEUlPCIpx8ApGcGVEx6xzynNeC764V3iS+vFAJhy1MR
         O6LhV7g1dLnrMYiRQBHRt0hniTCv04AF3z+rTOGD9fGWmRvFqw3rB1oGgy9429n0c9Sc
         bD9A==
X-Received: by 10.68.193.193 with SMTP id hq1mr961112pbc.107.1401296822911;
        Wed, 28 May 2014 10:07:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nx12sm91361990pab.6.2014.05.28.10.07.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 10:07:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWkQhq2oCkyBG0-ojUDwgApYj1qZt1vXa2gnYsJOEbnvxQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250295>

Ronnie Sahlberg wrote:

> Updated the comment in refs.h

Thanks.

> +++ b/refs.h
> @@ -215,6 +215,31 @@ enum action_on_err {
>  };
>  
>  /*
> + * On error, transaction functions append a message about what
> + * went wrong to the 'err' argument.  The message mentions what
> + * ref was being updated (if any) when the error occurred so it
> + * can be passed to 'die' or 'error' as-is:
> + *
> + *     if (ref_transaction_update(..., &err)) {
> + *         ret = error("%s", err.buf);
> + *         goto cleanup;
> + *     }
> + *
> + * The message is appended to err without first clearing err.
> + * This allow shte caller to prepare preamble text to the generated

s/allow shte/allows the/

> + * error message:
> + *
> + *     strbuf_addf(&err, "Error while doing foo-bar: ");
> + *     if (ref_transaction_update(..., &err)) {
> + *         ret = error("%s", err.buf);
> + *         goto cleanup;
> + *     }

Nice.

> + *
> + * If the caller wants err to only contain the message for the current error
> + * and nothing else caller will need to guarantee that err is empty or
> + * call strbuf_reset before calling the transaction function.

I don't think this paragraph is needed --- especially with the
clarification about how to add a preamble, the contract is clear.

> + */
> +/*
>   * Begin a reference transaction.  The reference transaction must
>   * be freed by calling ref_transaction_free().
>   */

Now that the comment is longer, it's harder to miss, but it still is
in an odd place for someone looking to understand what the 'err'
argument to ref_transaction_update() means.

How about this patch for squashing in?

diff --git i/refs.h w/refs.h
index c741a6c..913ca93 100644
--- i/refs.h
+++ w/refs.h
@@ -10,6 +10,45 @@ struct ref_lock {
 	int force_write;
 };
 
+/*
+ * A ref_transaction represents a collection of ref updates
+ * that should succeed or fail together.
+ *
+ * Calling sequence
+ * ----------------
+ * - Allocate and initialize a `struct ref_transaction` by calling
+ *   `ref_transaction_begin()`.
+ *
+ * - List intended ref updates by calling functions like
+ *   `ref_transaction_update()` and `ref_transaction_create()`.
+ *
+ * - Call `ref_transaction_commit()` to execute the transaction.
+ *   If this succeeds, the ref updates will have taken place and
+ *   the transaction cannot be rolled back.
+ *
+ * - At any time call `ref_transaction_free()` to discard the
+ *   transaction and free associated resources.  In particular,
+ *   this rolls back the transaction if it has not been
+ *   successfully committed.
+ *
+ * Error handling
+ * --------------
+ *
+ * On error, transaction functions append a message about what
+ * went wrong to the 'err' argument.  The message mentions what
+ * ref was being updated (if any) when the error occurred so it
+ * can be passed to 'die' or 'error' as-is.
+ *
+ * The message is appended to err without first clearing err.
+ * This allows the caller to prepare preamble text to the generated
+ * error message:
+ *
+ *     strbuf_addf(&err, "Error while doing foo-bar: ");
+ *     if (ref_transaction_update(..., &err)) {
+ *         ret = error("%s", err.buf);
+ *         goto cleanup;
+ *     }
+ */
 struct ref_transaction;
 
 /*
@@ -215,31 +254,6 @@ enum action_on_err {
 };
 
 /*
- * On error, transaction functions append a message about what
- * went wrong to the 'err' argument.  The message mentions what
- * ref was being updated (if any) when the error occurred so it
- * can be passed to 'die' or 'error' as-is:
- *
- *     if (ref_transaction_update(..., &err)) {
- *         ret = error("%s", err.buf);
- *         goto cleanup;
- *     }
- *
- * The message is appended to err without first clearing err.
- * This allow shte caller to prepare preamble text to the generated
- * error message:
- *
- *     strbuf_addf(&err, "Error while doing foo-bar: ");
- *     if (ref_transaction_update(..., &err)) {
- *         ret = error("%s", err.buf);
- *         goto cleanup;
- *     }
- *
- * If the caller wants err to only contain the message for the current error
- * and nothing else caller will need to guarantee that err is empty or
- * call strbuf_reset before calling the transaction function.
- */
-/*
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
