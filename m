From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] http.c: fix parsing of http.sslCertPasswordProtected
 variable
Date: Fri, 12 Jul 2013 12:05:31 -0700
Message-ID: <20130712190531.GD8482@google.com>
References: <7v38rjlif4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 21:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxiex-0005tA-S2
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 21:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327Ab3GLTFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 15:05:36 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:51322 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965299Ab3GLTFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 15:05:35 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so9293038pab.41
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oQRkLhDm1M/r1MUfO9FsFgH+UOi5HoMoIVXbINfNIKc=;
        b=VWRfL+YJT3lVILUgnzBO6C41ehL3Fwu2hh9mwX2n6pWOAatbcDfLGQn3AZdd5Khgkp
         gi/pUlcDoYxnn69WjEXUbA7IpWF+iOKMTXJw/6kfMALzyNXMkxrRgDvbHEf7bVcowTqZ
         LFAOc/701Pk6BiCqwFNe4AC8BxT7WblK6uCjwcIMpcT/5IIDtIveRXWiQlbTE6q2rRT5
         +HAGUXxVeRLeeX9oVIUk94pkZ9+VxRWzmbLrgoBZk75Lib3mD2ElCKTeRgzwH85x9sX1
         lMIoMr3sN/JSWeQrw7101VIFvUHfLMQdd1ea9tQ7NGG23Vf/AOVD8D1r2GCvrxm3b8Ry
         vkYg==
X-Received: by 10.68.163.195 with SMTP id yk3mr20852540pbb.142.1373655935160;
        Fri, 12 Jul 2013 12:05:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ai6sm49543804pad.15.2013.07.12.12.05.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 12:05:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v38rjlif4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230240>

Junio C Hamano wrote:

> The existing code triggers only when the configuration variable is
> set to true.  Once the variable is set to true in a more generic
> configuration file (e.g. ~/.gitconfig), it cannot be overriden to
> false in the repository specific one (e.g. .git/config).
[...]
> --- a/http.c
> +++ b/http.c
> @@ -160,8 +160,7 @@ static int http_options(const char *var, const char *value, void *cb)
>  	if (!strcmp("http.sslcainfo", var))
>  		return git_config_string(&ssl_cainfo, var, value);
>  	if (!strcmp("http.sslcertpasswordprotected", var)) {
> -		if (git_config_bool(var, value))
> -			ssl_cert_password_required = 1;
> +		ssl_cert_password_required = git_config_bool(var, value);

Thanks for catching it.  The documentation doesn't say anything about
this "can only enable and cannot disable" behavior and the usual
pattern is to allow later settings to override earlier ones, so this
change looks good.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

FWIW the GIT_SSL_CERT_PASSWORD_PROTECTED envvar has a similar "can
only enable" behavior, but since it's documented, that's not as big
of a problem.  Do you remember why it was written that way?

When that setting was first added[1], there was some mention of
autodetection if libcurl could learn to do that.  Did it happen?
(Please forgive my ignorance.)

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/122793/focus=122816
