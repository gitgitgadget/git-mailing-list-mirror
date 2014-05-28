From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 25/41] fast-import.c: use a ref transaction when
 dumping tags
Date: Wed, 28 May 2014 12:47:46 -0700
Message-ID: <20140528194746.GX12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-26-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 21:47:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpjpJ-0007pp-Tz
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 21:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbaE1Tru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 15:47:50 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:60990 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbaE1Trt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 15:47:49 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx10so1709099pab.0
        for <git@vger.kernel.org>; Wed, 28 May 2014 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=v8jXGQyXhFHOZyPuQ2+1hUlzheerOgnOUERBG1jH1zE=;
        b=i28mAZHGeK6+kiJHGvlgETwn6FPQW+dP3R5nklhJ688O7bNkxOw8hnob/RIFmZ/55u
         E7YJrvA0fBa1raQp8CYxmmpFCQYzNydONiuWPoSQX8eBvJzfMZSwz2dNCXCXsf3YrI8F
         JVAXe4Wh/YKY/pGiDR0bYgNvrmHrnn4ZH0xb4vMJCfJRN3BDevkNE+C4r49vAZISJk/B
         qP+Qy/Vpb+ytlReDtJshz3mkHWUdCdCULoXEqix6wJAFm37LsPfZvjUNra4+ZtGda2LQ
         unqNc8YCR//fq9OxG2raJXPpzfzyi/UPwFxhXqdVOpZzoALswRU/DhgGp/Bo5DVy5jds
         KF7Q==
X-Received: by 10.67.29.204 with SMTP id jy12mr1819244pad.37.1401306469388;
        Wed, 28 May 2014 12:47:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bu1sm29724574pbb.54.2014.05.28.12.47.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 12:47:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-26-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250323>

Ronnie Sahlberg wrote:

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1735,15 +1735,22 @@ static void dump_tags(void)
>  {
>  	static const char *msg = "fast-import";
>  	struct tag *t;
> -	struct ref_lock *lock;
>  	char ref_name[PATH_MAX];
> +	struct strbuf err = STRBUF_INIT;
> +	struct ref_transaction *transaction;
>  
> +	transaction = ref_transaction_begin(&err);
>  	for (t = first_tag; t; t = t->next_tag) {
> -		sprintf(ref_name, "tags/%s", t->name);
> +		snprintf(ref_name, PATH_MAX, "refs/tags/%s", t->name);

That ignores the error if the refname happens to go longer than
PATH_MAX.

This is the part of fast-import that doesn't need to be super
fast ;-).  (The objects have been written to the pack, and now
we just need to write some refs.)  Could this use a strbuf?  By that,
I mean something like

diff --git i/fast-import.c w/fast-import.c
index 3db5b3d..d5f6e63 100644
--- i/fast-import.c
+++ w/fast-import.c
@@ -1735,21 +1735,28 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
+	strbuf_addstr(&ref_name, "refs/tags/");
+
 	transaction = ref_transaction_begin(&err);
 	for (t = first_tag; t; t = t->next_tag) {
-		snprintf(ref_name, PATH_MAX, "refs/tags/%s", t->name);
+		strbuf_setlen(&ref_name, strlen("refs/tags/"));
+		strbuf_addstr(&ref_name, t->name);
 
-		if (ref_transaction_update(transaction, ref_name, t->sha1,
-					   NULL, 0, 0, &err))
-			break;
+		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+					   NULL, 0, 0, &err)) {
+			failure |= error("%s", err.buf);
+			goto done;
+		}
 	}
 	if (ref_transaction_commit(transaction, msg, &err))
 		failure |= error("%s", err.buf);
+done:
 	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
 	strbuf_release(&err);
 }
 
