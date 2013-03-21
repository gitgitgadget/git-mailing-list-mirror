From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Thu, 21 Mar 2013 12:43:49 +0700
Message-ID: <20130321054349.GA18101@duynguyen-vnpc.dek-tpc.internal>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
 <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
 <20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 06:44:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIYIf-0003e2-MU
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 06:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab3CUFoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 01:44:01 -0400
Received: from mail-da0-f47.google.com ([209.85.210.47]:33282 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab3CUFoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 01:44:00 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so1429813dak.34
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 22:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kPOHu7XkWp+pDha/cV8XPmrwYl7GtpP1j3hPjLWnSSo=;
        b=KoxXj6RS1eI3dcPuHu6z+w/dx29ru44pho0g+R5/dDsE/0CENzlkzH3RxDsIQkQOH8
         vW4FaOiMfVanPNXTV5DREsW8JEGBM8w27oQI5aJYfjHvkoj+s+DFEjUapdalAMrA4a69
         6nJjRp4q7Yn9MQxhu7b/GH84xH/K8dkQmJLaHInpWg9vNwK8paFXaOwaZ5khZMVgjL0Y
         4luKaCurbr+bhaE+/viUz0ruN1lVWO/Mrz2Sw6AXDpWxHI/FGQBWJxEGeCK6r1cCJYo0
         WcSIZjZ14R0RYujIIz8T4aC9kGzKaSYmjVKcU5nGGzqLh0H6pjUgT1mOUCRXWN5oM8Xg
         2eGg==
X-Received: by 10.68.130.1 with SMTP id oa1mr13257898pbb.134.1363844640153;
        Wed, 20 Mar 2013 22:44:00 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pg7sm4780411pbc.5.2013.03.20.22.43.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 22:43:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 21 Mar 2013 12:43:49 +0700
Content-Disposition: inline
In-Reply-To: <20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218695>

On Thu, Mar 21, 2013 at 12:33:26PM +0700, Duy Nguyen wrote:
> > I am still getting this out of 7300, though.
> 
> I still can't reproduce it. But I think I found a bug that
> miscalculates prefix length from absolute paths. Does this "fix" your
> test?
> 
> -- 8< --
> diff --git a/setup.c b/setup.c
> index 3584f22..6ae147a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -14,6 +14,7 @@ char *prefix_path_gently(const char *prefix, int *p_len, const char *path)
>  		const char *temp = real_path(path);
>  		sanitized = xmalloc(len + strlen(temp) + 1);
>  		strcpy(sanitized, temp);
> +		*p_len = 0;
>  	} else {
>  		sanitized = xmalloc(len + strlen(path) + 1);
>  		if (len)
> 
> -- 8< --

Nope, that one could cause more crashes. Try this

-- 8< --
diff --git a/setup.c b/setup.c
index 3584f22..3d8eb97 100644
--- a/setup.c
+++ b/setup.c
@@ -14,6 +14,8 @@ char *prefix_path_gently(const char *prefix, int *p_len, const char *path)
 		const char *temp = real_path(path);
 		sanitized = xmalloc(len + strlen(temp) + 1);
 		strcpy(sanitized, temp);
+		if (p_len)
+			*p_len = 0;
 	} else {
 		sanitized = xmalloc(len + strlen(path) + 1);
 		if (len)
-- 8< --
