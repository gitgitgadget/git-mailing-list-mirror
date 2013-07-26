From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] builtins: search builtin commands via binary search.
Date: Fri, 26 Jul 2013 13:57:37 -0700
Message-ID: <20130726205737.GI14690@google.com>
References: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 22:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2p5Y-00029q-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 22:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760036Ab3GZU5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 16:57:44 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:64733 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756993Ab3GZU5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 16:57:40 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so3690297pab.17
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xbmV2Li37V86g4vHkU5FyuWNhDbiCKPdfdnaAXtA9Ms=;
        b=gGMpB0qRULz7XVgDUoo8D9iNcJC3ehu6HLfBNYeCrdME8xsZH2v2dPwXptYelTUzCL
         g4erKplsB8psjPEWnPM6WbBbUyQ90iQCE2Yk4wmv+panXSKCOpB4gWOVAbi+6vZiiksR
         SQYHChTeufOnghMvyoCZcxk1iLIgauyopbwPQhCAlWnufzfWGjwohmD8xgpspYEdnduG
         AmsX6h13fQTmpnruLd0K523xNua1I/4XMKUWZBe4BpfHVyZS+9EcqKM6LVMwXK+bwiBY
         jl2joiOQK97p2WZX/94nl8lexp2LLIhThOtWiMo/OrYi2Y0SDTgMEGISJA7qNSOevbbs
         ztMg==
X-Received: by 10.68.137.170 with SMTP id qj10mr7936447pbb.31.1374872260214;
        Fri, 26 Jul 2013 13:57:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id we2sm5557299pab.0.2013.07.26.13.57.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 13:57:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231201>

Hi,

Stefan Beller wrote:

> --- a/git.c
> +++ b/git.c
> @@ -309,9 +309,18 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	return 0;
>  }
>  
> +static int compare_internal_command(const void *a, const void *b) {
> +	/* The first parameter is of type char* describing the name,
> +	   the second is a struct cmd_struct */

Style:

	/*
	 * Multi-line comments in git look like this, with an initial
	 * "/*" line, a leading "*" on each line with text, and a line
	 * with '*' '/' at the end.
	 */

[...]
> @@ -447,12 +456,12 @@ static void handle_internal_command(int argc, const char **argv)
>  		argv[0] = cmd = "help";
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(commands); i++) {
> -		struct cmd_struct *p = commands+i;
> -		if (strcmp(p->cmd, cmd))
> -			continue;
> +	struct cmd_struct *p = (struct cmd_struct *)bsearch(cmd, commands,
> +				ARRAY_SIZE(commands), sizeof(struct cmd_struct),
> +				compare_internal_command);

No need to cast --- this is C.

Fun.  Does this result in a measurable speedup, or is it just for more
pleasant reading?

Thanks and hope that helps,
Jonathan
