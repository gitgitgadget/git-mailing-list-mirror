From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 14/42] sequencer.c: use ref transactions for all ref
 updates
Date: Thu, 15 May 2014 10:35:57 -0700
Message-ID: <20140515173557.GL9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-15-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 19:36:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzZh-0000xp-Sa
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbaEORgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:36:03 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:38434 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbaEORgB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:36:01 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so1376993pbc.12
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f9oFg4KqNZMzZw9pRHRxN9fDlmHiQLp7o+H88z5GrbE=;
        b=Z7BklGEnb3rRJ0JyXepXalvmqTdIYGNm8zB8K9mHkBbXSRamZXLHBtiuuLBf4biSBv
         bHqQEmVeeV4xnnQuQlVCI6GVi49+08s3xHVxTrOaUY/n+IfsIiciM9grPAtTTXas/sHK
         Tl5VNPaFcmPPigcsyeYv2p4yfEnxMWHa62u6BZIqANC53oW16pvyyIKjtUCUqbnlv3u0
         mpqJXgLRXxrIXSwKhmu9EJhSDPJJYBDnx+jNNKGKki8OuXGYne3dLz8qiZsrs5JrAIWR
         Qwzn948QqEbUmY3n0w/UWshrBZpb1K/BcYOpctav48N9bnQi40ugAhIzj8Je2D4PqHso
         K0Dw==
X-Received: by 10.66.180.141 with SMTP id do13mr14155079pac.93.1400175360565;
        Thu, 15 May 2014 10:36:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id au4sm10154507pbc.10.2014.05.15.10.35.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 10:36:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-15-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249167>

Ronnie Sahlberg wrote:

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -272,23 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
>  static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  			int unborn, struct replay_opts *opts)
>  {
> -	struct ref_lock *ref_lock;
> +	struct ref_transaction *transaction;
>  	struct strbuf sb = STRBUF_INIT;
> -	int ret;
> +	struct strbuf err = STRBUF_INIT;
>  
>  	read_cache();
>  	if (checkout_fast_forward(from, to, 1))
>  		exit(1); /* the callee should have complained already */
> -	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
> -					   0, NULL);
> -	if (!ref_lock)
> -		return error(_("Failed to lock HEAD during fast_forward_to"));
>  
>  	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
> -	ret = write_ref_sha1(ref_lock, to, sb.buf);
> +
> +	transaction = ref_transaction_begin();
> +	if ((!transaction ||
> +	    ref_transaction_update(transaction, "HEAD", to, from,
> +				   0, !unborn)) ||

These parentheses make it harder to parse.  Other patches in this
series do

	if (!transaction ||
	    ref_transaction_update(...) ||
	    ref_transaction_commit(...)) {

so this could do

	if (!transaction ||
	    ref_transaction_update(...) ||
	    (ref_transaction_commit(...) && !(transaction = NULL))) {

> +	    (ref_transaction_commit(transaction, sb.buf, &err) &&
> +	     !(transaction = NULL))) {
> +		ref_transaction_rollback(transaction);

Earlier patches in the series didn't bother rolling back.  Should they
have?

Thanks,
Jonathan
