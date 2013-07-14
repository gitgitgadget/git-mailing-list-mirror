From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] templates: Use heredoc in pre-commit hook
Date: Sun, 14 Jul 2013 11:09:16 -0700
Message-ID: <20130714180916.GB1267@google.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
 <1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 20:09:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyQjt-0003m5-3Y
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 20:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800Ab3GNSJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 14:09:21 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39784 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab3GNSJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 14:09:20 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so9965545pdi.7
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=53ghHkj0B8Leot9IheMtEJE1nHgSe7VzZ5BVD+zJi0M=;
        b=fVrOoMCWJIP3oilLBD8Xby0yGsefI+VMS98HdGkYvtEIfGfaIVIuWVrL3ZJFXBkizz
         T9E9uW3rUz+u4tl8XtJUISHFoOaLTRygRrN8JWHr87NHVWuWR91FoHTAgzSvwUk6yYRF
         F4eIKeB4tnT9/Cxh0930V8V9+5ie2HXlVWxR+/5vSZPxlTnqogkhQOsQFIVrI1DhBhhW
         yQrYT7Lm5ec21wjKGoGBU+5n2+niYFkJcIKir1lI2n/KhOj/Ky7F1sJpZfCe/JapjgGb
         2Qd2XgY8RY9+jkb4d4H6SNWkl3WCKiPBRRTXFJ2Xy82Vm3VlDmlmraIIKS9mm98ENaUA
         PmTw==
X-Received: by 10.68.196.165 with SMTP id in5mr7360518pbc.0.1373825360035;
        Sun, 14 Jul 2013 11:09:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dg3sm56559835pbc.24.2013.07.14.11.09.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 11:09:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230378>

Hi,

Richard Hartmann wrote:

> Spawning a new subprocess for every line printed is inefficient.
> Use heredoc, instead.

I think this makes sense as a code clarity, simplicity, and
internationalizability improvement, but don't like the precedent of
eliminating 'echo' for the sake of fork removal (unless we have
measurements showing it's worthwhile, which would be included here).

Maybe a simpler commit message could sidestep the issue?

	Use a heredoc instead of an "echo" for each line.

> Based on 98770971aef8d1cbc78876d9023d10aa25df0526 in original patch
> series from 2013-06-10.

Please don't include this.  The audience for the commit message
doesn't have that commit to compare to.

If you want to preserve the original date, the way to do that is
a "Date:" field at the top of the message body.

	Date: Fri, 28 Jun 2013 21:16:19 +0530

	Spawning a new subprocess for ...

[...]
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -31,18 +31,19 @@ if [ "$allownonascii" != "true" ] &&
>  	test $(git diff --cached --name-only --diff-filter=A -z $against |
>  	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
>  then
> -	echo "Error: Attempt to add a non-ascii file name."
> -	echo
> -	echo "This can cause problems if you want to work"
> -	echo "with people on other platforms."
> -	echo
> -	echo
> -	echo "If you know what you are doing you can disable this"
> -	echo "check using:"
> -	echo
> -	echo "  git config hooks.allownonascii true"
> -	echo
> +	cat <<-EOF
> +Error: Attempt to add a non-ascii file name.

Using

	cat <<\EOF

would make reading easier since the reader then doesn't have to worry
about whether the text being cat'ed is indented or uses variable
substitutions.

> -	echo "To be portable it is advisable to rename the file ..."
> +To be portable it is advisable to rename the file.

Yes, nice.

With the above nits addressed, this change looks to be going in the
right direction.  Thanks.

Hope that helps,
Jonathan
