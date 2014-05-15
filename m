From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 17/44] fast-import.c: change update_branch to use ref
 transactions
Date: Thu, 15 May 2014 14:47:45 -0700
Message-ID: <20140515214745.GN26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-18-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 23:47:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl3VI-0000LG-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 23:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbaEOVrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 17:47:49 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43529 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbaEOVrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 17:47:48 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so1594569pad.16
        for <git@vger.kernel.org>; Thu, 15 May 2014 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kNUr51k3cJO3GzcrsYYYfhuvHWEac38hES3xuHYWDcI=;
        b=fYBkpwKELnhCOruix9wDYP5g8xj1J+a+3jv8+4I4ztMY0kW3hwozuIO48YuZoNM4/E
         yyPQ6ZdMMYIpayaC3v+MHQKJY8Sam5v5zkfrsMbbEbd59zew5IRafJyUukYgzFc2vGRm
         V41Nq8OAd1Zjdv8l41B1HqXtCcWF2iw7ybJ9S9hmAYqtm4+KXK+kKJsm9Rm6Dn8lRGMi
         Rse90HcT/0mPBtZQjzGCogHwuoEaJEMD2dkpYtAQkU41WZP0lj+X6E2X4j03lNkAlxhn
         4+zs9qBP/+F9L4lc3lMVMNYoA9g8g8/yRfQ/+WoY3xvxGzs+MrUsABLajBNbjMNIwuj4
         JeFQ==
X-Received: by 10.68.110.65 with SMTP id hy1mr15583176pbb.67.1400190468335;
        Thu, 15 May 2014 14:47:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wp3sm10817441pbc.67.2014.05.15.14.47.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 14:47:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-18-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249205>

Ronnie Sahlberg wrote:

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1679,39 +1679,45 @@ found_entry:
>  static int update_branch(struct branch *b)
>  {
>  	static const char *msg = "fast-import";
> -	struct ref_lock *lock;
> +	struct ref_transaction *transaction;
>  	unsigned char old_sha1[20];
> +	struct strbuf err = STRBUF_INIT;
>  
>  	if (read_ref(b->name, old_sha1))
>  		hashclr(old_sha1);
> +
>  	if (is_null_sha1(b->sha1)) {
>  		if (b->delete)
>  			delete_ref(b->name, old_sha1, 0);
>  		return 0;
>  	}
> -	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
> -	if (!lock)
> -		return error("Unable to lock %s", b->name);
>  	if (!force_update && !is_null_sha1(old_sha1)) {
>  		struct commit *old_cmit, *new_cmit;
>  
>  		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
>  		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
>  		if (!old_cmit || !new_cmit) {
> -			unlock_ref(lock);
>  			return error("Branch %s is missing commits.", b->name);
>  		}

(style) Now that there's only one line in the "if" body, we can
drop the braces.

>  
>  		if (!in_merge_bases(old_cmit, new_cmit)) {
> -			unlock_ref(lock);
>  			warning("Not updating %s"
>  				" (new tip %s does not contain %s)",
>  				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
>  			return -1;

(not about this patch, feel free to ignore) This could
return warning("...")

>  	}
> -	if (write_ref_sha1(lock, b->sha1, msg) < 0)
> -		return error("Unable to update %s", b->name);
> +	transaction = ref_transaction_begin();
> +	if ((!transaction ||
> +	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
> +				   0, 1)) ||

Would be more idiomatic to drop a layer of parentheses:

	if (!transaction ||
	    ref_transaction_update(...) ||

> +	    (ref_transaction_commit(transaction, msg, &err) &&
> +	     !(transaction = NULL))) {

Would be clearer if ref_transaction_commit didn't take care of the
rollback (or in other words if patch 21 were earlier in the series).

> +		ref_transaction_rollback(transaction);
> +		error("Unable to update branch %s: %s", b->name, err.buf);
> +		strbuf_release(&err);
> +		return -1;
> +	}

Example old message:

	error: Unable to lock refs/heads/master

New message:

	error: Unable to update branch refs/heads/master: Cannot lock the ref 'refs/heads/master'.

So 'error("%s", err.buf)' would probably work better.

The only call site is dump_branches:

	for (i = 0; i < branch_table_sz; i++) {
		for (b = branch_table[i]; b; b = b->table_next_branch)
			failure |= update_branch(b);
	}

Should these happen in a single transaction?  I haven't thought
through whether it would be a good idea, if it should be optional, or
what.

Anyway, that would be a bigger behavior change, but it's interesting
to think about.

Thanks,
Jonathan
