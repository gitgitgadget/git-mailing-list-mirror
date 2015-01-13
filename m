From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] git-compat-util: add xstrdup_or_null helper
Date: Mon, 12 Jan 2015 18:21:19 -0800
Message-ID: <20150113022119.GA29365@google.com>
References: <20150113015427.GA5497@peff.net>
 <20150113015736.GA18986@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 03:21:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAr6m-0005qZ-IL
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 03:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbbAMCVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 21:21:24 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58345 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbbAMCVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 21:21:23 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar1so463661iec.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2015 18:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0O138rThKFxJKISP78BiyepFZkXDZeU3p85k2MO2V6Q=;
        b=FzirNd0YWfXoE7Suz5/AIhB87F6bEqs6iuuciS/Z7xN/s+sGIGvCIs832Rd4IJd+Vi
         kNdoGUkVLAub4HTBEITpi16M/KppfnZcscyTCJIkbGSRlehAl+9SOAqgBR0zkGpVuj7P
         Z+tueOAYuobsnI2aZEsBeI0GTgxrLswFfeoOYLbH3zDjT21llRKXYJFhSdRukWiZzJhN
         1zltPPHD5SUWDrMGJgIRgTTDNpaQpG2mXJ1Kj20YUpJxO8hB5qQYWh1PM2a0+HTCrYph
         shlJMpsDJCO4KSpYqSdB4bJV3Zk8MFK5+TdatRwfadukRFJebBVCQIo6vvSO8U0XjB1W
         e5wg==
X-Received: by 10.50.35.195 with SMTP id k3mr18617892igj.11.1421115682832;
        Mon, 12 Jan 2015 18:21:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddc9:e4c7:392b:b11c])
        by mx.google.com with ESMTPSA id q196sm9547717ioe.5.2015.01.12.18.21.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Jan 2015 18:21:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150113015736.GA18986@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262321>

Jeff King wrote:

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -675,6 +675,11 @@ extern char *xgetcwd(void);
>  
>  #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), (alloc) * sizeof(*(x)))
>  
> +static inline char *xstrdup_or_null(const char *str)
> +{
> +	return str ? xstrdup(str) : NULL;
> +}

Would it make sense for xstrdup to always include the NULL check,
avoiding the need for the more verbose xstrdup_or_null?

Jonathan

diff --git i/wrapper.c w/wrapper.c
index 007ec0d..5a835e8 100644
--- i/wrapper.c
+++ w/wrapper.c
@@ -40,7 +40,11 @@ try_to_free_t set_try_to_free_routine(try_to_free_t routine)
 
 char *xstrdup(const char *str)
 {
-	char *ret = strdup(str);
+	char *ret;
+
+	if (!str)
+		return NULL;
+	ret = strdup(str);
 	if (!ret) {
 		try_to_free_routine(strlen(str) + 1);
 		ret = strdup(str);
@@ -125,7 +129,11 @@ void *xmemdupz(const void *data, size_t len)
 
 char *xstrndup(const char *str, size_t len)
 {
-	char *p = memchr(str, '\0', len);
+	char *p;
+
+	if (!str)
+		return NULL;
+	p = memchr(str, '\0', len);
 	return xmemdupz(str, p ? p - str : len);
 }
 
