From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 13/42] commit.c: use ref transactions for updates
Date: Wed, 14 May 2014 18:11:34 -0700
Message-ID: <20140515011134.GJ9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-14-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 03:11:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkkD3-00059I-Mr
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 03:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbaEOBLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 21:11:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53043 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaEOBLh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 21:11:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so333221pab.19
        for <git@vger.kernel.org>; Wed, 14 May 2014 18:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BPDC+oKb8yGKcooGD4xMzjfz2t/+msY2Gcg5O9if578=;
        b=tsaXfiVXCO3EL2gnn1M78KtCKg3ipkktPJ9GVL6cqVIWRaUVTxV4C6JGQiaV3/jz7T
         +q4YX/rSXL08hMhr1vGOmBkdCHFu7Z72UR6M4XHXVzXwxEMP97c49nuGIcoXT9fMwkc4
         2kDCgqpY8EggXCseGMGLsG24HR0UsxsF/tmL1KuTZPkVz1iPCdoE/gHpy/lm/6ATcmTs
         5/cFkoOp8LFn9i+qBSd/RRAJMXffz6vDNA5cNDwjOjQ0TcJxFcvf2hCrFpDPp3LzYOiF
         NSD926YrUw3M/Z2/GwEeNrjolzsa5qpmxI4zHbU0ZcLVqURiOdo2WJdlTCRxIWIp8lGO
         7lgg==
X-Received: by 10.66.139.38 with SMTP id qv6mr8368670pab.123.1400116297073;
        Wed, 14 May 2014 18:11:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gg3sm5771893pbc.34.2014.05.14.18.11.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 18:11:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-14-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249056>

Ronnie Sahlberg wrote:

[...]
> +++ b/builtin/commit.c
> @@ -1541,11 +1541,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
[...]
> @@ -1667,16 +1668,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&author_ident);
>  	free_commit_extra_headers(extra);
>  
> -	ref_lock = lock_any_ref_for_update("HEAD",
> -					   !current_head
> -					   ? NULL
> -					   : current_head->object.sha1,
> -					   0, NULL);
> -	if (!ref_lock) {
> -		rollback_index_files();
> -		die(_("cannot lock HEAD ref"));
> -	}
> -
>  	nl = strchr(sb.buf, '\n');
>  	if (nl)
>  		strbuf_setlen(&sb, nl + 1 - sb.buf);
> 	else
> 		strbuf_addch(&sb, '\n');
>  	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
>  	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
>  
> -	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
> +	transaction = ref_transaction_begin();
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, "HEAD", sha1,
> +				   current_head ?
> +				   current_head->object.sha1 : NULL,
> +				   0, !!current_head) ||
> +	    ref_transaction_commit(transaction, sb.buf, &err)) {
>  		rollback_index_files();
> -		die(_("cannot update HEAD ref"));
> +		die(_("HEAD: cannot update ref: %s"), err.buf);

Same question about !transaction (it also applies to later patches but I
won't mention it any more).

The error message changed from

	fatal: cannot lock HEAD ref

to

	fatal: HEAD: cannot update ref: Cannot lock the ref 'HEAD'.

Does the message from ref_transaction_commit always say what ref
was being updated when it failed?  If so, it's tempting to just use
the message as-is:

	fatal: Cannot lock the ref 'HEAD'

If the caller should add to the message, it could say something about
the context --- e.g.,

	fatal: cannot update HEAD with new commit: cannot lock the ref 'HEAD'

Looking at that,

	die("%s", err.buf)

seems simplest since even if "git commit" was being called in a loop,
it's already clear that git was trying to lock HEAD to advance it.

Thanks,
Jonathan
