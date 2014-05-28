From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 23/41] refs.c: change update_ref to use a transaction
Date: Wed, 28 May 2014 12:31:39 -0700
Message-ID: <20140528193139.GW12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-24-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 21:31:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpjZi-0000BK-RL
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 21:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbaE1Tbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 15:31:43 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37867 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaE1Tbm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 15:31:42 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so11520917pad.37
        for <git@vger.kernel.org>; Wed, 28 May 2014 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u6BBWYLwS9er9vve3oFosle9XIyof4LPL7ZifUL2cYo=;
        b=AsmZ4isv5iTmnCHKMPROg8vqXaVmcNWuEI9/Bq2xQ8viQmCL6ZAlM3O6OrL/LCDpL3
         Y4xpeLCjobiDVPTEqurNhA/K4qM00WixJWj/g9FFi1Fo+9u6giW4wiI78MgAxCvEFeSc
         TAvMFhLftHqJSGFU72k1hZNQYDmO7wna1M/bvDjefoB/654iqoj28Jwr3RkXyOikWbHz
         ddIYBgVReTcCycKeIt6u3RmCyeipeRJ3/0Z9mQ4ofV3hPivv7uayuiy5mepB/SiA1gsS
         CEsRKZjnf/cKyR5ox29T0OPy68FSGnsuG/TWa+MRjW3PFeQEV6HRd1S9ScQDpEQa045R
         Ksdg==
X-Received: by 10.66.148.230 with SMTP id tv6mr1975034pab.155.1401305501853;
        Wed, 28 May 2014 12:31:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id si8sm92766937pab.27.2014.05.28.12.31.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 12:31:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-24-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250320>

Ronnie Sahlberg wrote:

> --- a/refs.c
> +++ b/refs.c
> @@ -3474,11 +3474,28 @@ int update_ref(const char *action, const char *refname,
>  	       const unsigned char *sha1, const unsigned char *oldval,
>  	       int flags, enum action_on_err onerr)
>  {
> -	struct ref_lock *lock;
> -	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
> -	if (!lock)
> +	struct ref_transaction *t;
> +	struct strbuf err = STRBUF_INIT;
> +
> +	t = ref_transaction_begin(&err);
> +	if ((!t ||
> +	    ref_transaction_update(t, refname, sha1, oldval, flags,
> +				   !!oldval, &err)) ||

(style) Extra parens.

> +	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {

No need for this assignment-in-if.

With the following squashed in,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/refs.c w/refs.c
index 568b358..fb462a3 100644
--- i/refs.c
+++ w/refs.c
@@ -3474,10 +3474,10 @@ int update_ref(const char *action, const char *refname,
 	struct strbuf err = STRBUF_INIT;
 
 	t = ref_transaction_begin(&err);
-	if ((!t ||
+	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, &err)) ||
-	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+				   !!oldval, &err) ||
+	    ref_transaction_commit(t, action, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_free(t);
