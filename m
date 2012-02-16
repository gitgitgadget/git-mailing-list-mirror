From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Thu, 16 Feb 2012 00:47:06 -0800
Message-ID: <94614DF7-9EE3-47CB-BC6E-97069597557E@gmail.com>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr> <20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:47:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxwzm-0006MH-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab2BPIrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:47:12 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33673 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab2BPIrL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2012 03:47:11 -0500
Received: by pbcun15 with SMTP id un15so2290699pbc.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 00:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=EQI5s8dMQNQwgfdUoyfBAdFdDWF/qk6GZ2AvsDy87yY=;
        b=dwSepwYDn7VRi55PnXIQSDK1gyALleCrx2501xQ28l9DeymXpjos9fl2yERD2VM2sF
         ggDYfvNJqJZQ4JXA6cH303N9uC6VtLM7GDsff1AhIUQyXjzrE7ztEqhRV3NYi+lEkAL3
         d+Fma0Nb7r9LA9sNrK6XtEnXvFCNBC6zFe8rc=
Received: by 10.68.216.132 with SMTP id oq4mr11493233pbc.41.1329382031007;
        Thu, 16 Feb 2012 00:47:11 -0800 (PST)
Received: from [192.168.1.114] (c-67-161-24-30.hsd1.ca.comcast.net. [67.161.24.30])
        by mx.google.com with ESMTPS id b6sm1795343pbf.32.2012.02.16.00.47.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Feb 2012 00:47:09 -0800 (PST)
In-Reply-To: <vpq39abrxav.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190886>

On Mac OS X use the open command and the OS will use the correct viewer chosen by the user

open "$pdffile"


On Feb 16, 2012, at 12:34 AM, Matthieu Moy wrote:

> Tim Haga <timhaga@ebene6.org> writes:
> 
>> While testing your script on my office machine i discovered that the
>> following might be a problem:
>> 
>>> +if [ "$view" = 1 ] || [ "$view" = maybe ] && [ "$output" = "" ]; then
>>> +    xpdf "$pdffile"
>>> +fi
>> 
>> Xpdf is not installed on all machines (e.g. it's not installed on my
>> office machine), so maybe it would be a good idea to use a environment
>> variable instead?
> 
> Right. I'm squashing this into the next version to allow configuration
> (environment variable or --pdf-viewer) and sensible auto-detection:
> 
> diff --git a/contrib/latex/git-latexdiff b/contrib/latex/git-latexdiff
> index 13aeb9a..85aafda 100755
> --- a/contrib/latex/git-latexdiff
> +++ b/contrib/latex/git-latexdiff
> @@ -20,6 +20,8 @@ Options:
> 	--no-view	Don't display the resulting PDF file
> 	--view		View the resulting PDF file
> 			(default if -o is not used)
> +	--pdf-viewer CMD
> +			Use CMD to view the PDF file (default: \$PDFVIEWER)
> 	--no-cleanup	Don't cleanup temp dir after running
> 	-o FILE, --output FILE
> 			Copy resulting PDF into FILE
> @@ -46,7 +48,7 @@ verbose_progress () {
> 
> verbose_done () {
>     if [ "$verbose" = 1 ]; then
> -	echo " done."
> +	echo " ${1:-done}."
>     fi
> }
> 
> @@ -75,6 +77,10 @@ while test $# -ne 0; do
> 	"--view")
> 	    view=1
> 	    ;;
> +	"--pdf-viewer")
> +	    shift
> +	    PDFVIEWER="$1"
> +	    ;;
> 	"--no-cleanup")
> 	    cleanup=0
> 	    ;;
> @@ -114,6 +120,28 @@ if [ "$old" = "" ]; then
>     exit 1
> fi
> 
> +verbose "Auto-detecting PDF viewer"
> +for command in xdg-open evince okular xpdf acroread; do
> +    if [ "$PDFVIEWER" = "" ]; then
> +	if command -v "$command" >/dev/null 2>&1; then
> +	    PDFVIEWER="$command"
> +	else
> +	    verbose_progress
> +	fi
> +    fi
> +done
> +verbose_done "$PDFVIEWER"
> +
> +case "$view" in
> +    maybe|1)
> +	if [ "$PDFVIEWER" = "" ]; then
> +	    echo "warning: could not find a PDF viewer on your system."
> +	    echo "warning: Please set \$PDFVIEWER or use --pdf-viewer CMD."
> +	    PDFVIEWER=false
> +	fi
> +	;;
> +esac
> +
> if [ "$main" = "" ]; then
>     printf "%s" "No --main provided, trying to guess ... "
>     main=$(git grep -l '^[ \t]*\\documentclass')
> @@ -212,7 +240,7 @@ if [ "$output" != "" ]; then
> fi
> 
> if [ "$view" = 1 ] || [ "$view" = maybe ] && [ "$output" = "" ]; then
> -    xpdf "$pdffile"
> +    "$PDFVIEWER" "$pdffile"
> fi
> 
> if [ "$cleanup" = 1 ]; then
> 
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
