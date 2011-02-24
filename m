From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] trace: give repo_setup trace its own key
Date: Thu, 24 Feb 2011 15:49:59 -0600
Message-ID: <20110224214959.GH17412@elie>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224143030.GH15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 22:50:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psj5E-0007mh-SC
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 22:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab1BXVuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 16:50:44 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49536 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1BXVun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 16:50:43 -0500
Received: by vws12 with SMTP id 12so858205vws.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 13:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AYTJ2Hqr0Fa4WezoUew6gX57Ewf2ihQOkd0lQINzw/Q=;
        b=CZWjlkR+ZzI2vnEo6EGqXzDyxJnePZQQhBPLy9giYgafLd1ne6JDAXx9TLoLZwYnpx
         HmMzp+sFlKxCuRCFtSwAH1xSCuRBLy5jrFHoh4xA9USl6J0OQVsQXMSiZnm47JcA0uqX
         urg1u+BjXuL193ANAM8X1pxK+6RXaqihxqfvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=x2tbzK+gJBkIkM7erU/ABMJCeYf5D7iCbJ0t9+3L4HcV+ckyfuOnzdM32HkWHc+gLv
         WWeDTcwLgLfBbAQ9KDksoaG0g0i0qpHDlg1iBD2aBx7PGfGRlOMLuPEWwbdfu145zcxl
         n5W8iB5fASTvL9KI1RppIgsLd1S4uzhgZFKvQ=
Received: by 10.52.167.166 with SMTP id zp6mr2744960vdb.93.1298584205537;
        Thu, 24 Feb 2011 13:50:05 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id e37sm6649778vbm.5.2011.02.24.13.50.03
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 13:50:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110224143030.GH15477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167866>

Jeff King wrote:

> You no longer get this output with GIT_TRACE=1; instead, you
> can do GIT_TRACE_SETUP=1.

Thank you. :)

> --- a/trace.c
> +++ b/trace.c
> @@ -155,10 +155,11 @@ static const char *quote_crnl(const char *path)
>  /* FIXME: move prefix to startup_info struct and get rid of this arg */
>  void trace_repo_setup(const char *prefix)
>  {
> +	static const char *key = "GIT_TRACE_SETUP";

Micronit:

	static const char key[] = ...

> @@ -170,10 +171,10 @@ void trace_repo_setup(const char *prefix)
>  	if (!prefix)
>  		prefix = "(null)";
>  
> -	trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
> -	trace_printf("setup: worktree: %s\n", quote_crnl(git_work_tree));
> -	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
> -	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
> +	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
> +	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
> +	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
> +	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));

I wonder if it would make sense for this to be

	trace_printf("setup", "git_dir: %s\n", ...);

and:

 - automatically prefix each line with the key instead of "trace:"
 - enable or redirect based on the content of the GIT_TRACE_$(uc $key)
   variable

But what you have here already works, so:
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
