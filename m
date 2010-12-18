From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Improved error messages when temporary file creation
 fails
Date: Sat, 18 Dec 2010 14:05:16 -0600
Message-ID: <20101218200516.GA10031@burratino>
References: <20101207181633.GF25767@bzzt.net>
 <20101218165514.GT25767@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arnout Engelen <arnouten@bzzt.net>
X-From: git-owner@vger.kernel.org Sat Dec 18 21:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU32x-0006Ja-Qq
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 21:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155Ab0LRUGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 15:06:19 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:39833 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab0LRUGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 15:06:18 -0500
Received: by gxk19 with SMTP id 19so1015653gxk.11
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 12:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y+xta8Fx0l5KGhZWyoafNF8rcpX9xVImn9mAeCF5in0=;
        b=LW4wrNzNXlIxFCdvzEvcU/2p5YHgZK0bR3a5G0VXw2/05DpSaZ8LMagdV+jZPBqEdf
         V8qrpp1TQWOp+/CDekoTzvXmg3PDO9rFLDREusFMJOLUquCuVpaHDOG1jMSy3SenNmGH
         r7HE5IxzsSAAhw+P7Sinqkv9R6aOuD6Ea6h7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cCEqh5C1aTBg5yT1s8cc7W4ZzXWl7rvyAY9YcH8fq+KQ5IPtwvmHhFAD3eHQ1vc2MF
         OyKumgCTF+JRutW1u66hAQ37e2knJVkBfYw7BkXQUpc6+dKIdy3k8Pi58egeyppBakuE
         p55EKWrKdKKW4q4fF67EgF/AAKPENbQQDKd0g=
Received: by 10.151.142.4 with SMTP id u4mr4635726ybn.65.1292702776381;
        Sat, 18 Dec 2010 12:06:16 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id y21sm1034275yhc.10.2010.12.18.12.06.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Dec 2010 12:06:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101218165514.GT25767@bzzt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163927>

Hi again,

Arnout Engelen wrote:

> Updated version of the patch

Almost there.  Some remaining nits from my pov:

> , taking into account the feedback from this 
> thread.
[...]

This text above the "---" becomes part of the log message when a patch
is committed to git.git, so it is best to make it self-contained.  The
usual advice is "describe the current behavior, why the proposed
behavior is better, and then how the proposed behavior is achieved."

> --- /dev/null
> +++ b/test-mktemp.c
> @@ -0,0 +1,15 @@
> +/*
> + * test-mktemp.c: code to exercise the creation of temporary files
> + */
> +#include <string.h>
> +#include "git-compat-util.h"

git-compat-util.h takes care of portably including system headers in
the right order.  (For example, #include-ing <string.h> before
setting _POSIX_SOURCE will cause some symbols not to be defined in
_other_ headers on some operating systems, iirc.)  I'd suggest
removing the redundant #include <string.h>.

See Documentation/CodingGuidelines.

> +int main(int argc, char *argv[])
> +{
> +	if (argc != 2)
> +		usage("Expected 1 parameter defining the temporary file template");
> +
> +	xmkstemp(strdup(argv[1]));

Why not xstrdup(), which diagnoses allocation failures?

> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -196,10 +196,22 @@ FILE *xfdopen(int fd, const char *mode)
>  int xmkstemp(char *template)
>  {
>  	int fd;
> +	char origtemplate[PATH_MAX];
> +	strlcpy(origtemplate, template, sizeof(origtemplate));
>  
>  	fd = mkstemp(template);
> -	if (fd < 0)
> -		die_errno("Unable to create temporary file");
> +	if (fd < 0) {
> +		int saved_errno = errno;
> +		const char * nonrelative_template;

It would be more usual not to include a space between the '*' and
'nonrelative_template'.

Thanks for your perseverance.
