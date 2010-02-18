From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2] Add an optional argument for --color options
Date: Thu, 18 Feb 2010 01:56:44 -0800
Message-ID: <4B7D0EDC.8070309@gmail.com>
References: <1266382558-26325-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 10:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni38b-00073H-Qp
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 10:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab0BRJ4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 04:56:50 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:56662 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461Ab0BRJ4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 04:56:48 -0500
Received: by gxk27 with SMTP id 27so2431415gxk.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 01:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=dMS/ja1cFjSW3/aDhGsyKebMuKLz1RdpqAKWcqcGJpE=;
        b=FydS1malil6gYLPMct4MrCBU9KPiuJnPaRnwmSKIDr3/KceutdQTZiONf1Tq6HgLEC
         W04u/V30aK4ekmNC9T/A6T5/p1HRnAeSo4i3SgY+jOFNA8FSl2vD988mteCMUI7o9CAp
         YOg8YGoDql90OSuiRgHjlrF2vfQnhqk22JReM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MyZknezm3GKshNg+51fZhoNNg24fRSwWvAD0UpiXMDeMWQ0eUssUTKosewAGKKNqyI
         liHmAUAI3PDTWp31e5fI+m6drZMmYb4q8Lm8ShZpk/cyrauxE6LRLVpFGVvQfDNWvyPc
         pxM+c78DmJUbZn0x1NtV3XtXee89uQJSNz+/k=
Received: by 10.150.60.14 with SMTP id i14mr3431945yba.28.1266487007613;
        Thu, 18 Feb 2010 01:56:47 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm8922875iwn.0.2010.02.18.01.56.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 01:56:46 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <1266382558-26325-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140309>

On 02/16/2010 08:55 PM, Mark Lodato wrote:
> @@ -599,6 +600,22 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> +int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
> +			    int unset)
> +{
> +	int value;
> +	if (unset && arg)
> +		return opterror(opt, "takes no value", OPT_UNSET);
>   

We can't have unset and arg both set at the same time. This exact case
is handled by get_value() in parse-options.c (did you copy that?)

> +	if (!arg)
> +		arg = unset ? "never" : (const char *)opt->defval;
>   

I've always been annoyed that the OPTION_CALLBACK doesn't set the
option's value to the defval before calling the callback when it's
PARSE_OPT_OPTARG. If it did we could drop half of this if condition too.

Here's something to squash
--->8----

diff --git a/parse-options.c b/parse-options.c
index 22da9be..0986314 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -604,8 +604,6 @@ int parse_opt_color_flag_cb(const struct option *opt, const 
                            int unset)
 {
        int value;
-       if (unset && arg)
-               return opterror(opt, "takes no value", OPT_UNSET);
        if (!arg)
                arg = unset ? "never" : (const char *)opt->defval;
        value = git_config_colorbool(NULL, arg, -1);
