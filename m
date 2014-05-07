From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/3] After chdir to run grep, return to old directory
Date: Tue, 06 May 2014 20:33:51 -0700
Organization: Twitter
Message-ID: <1399433631.11843.57.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <1399072451-15561-2-git-send-email-dturner@twopensource.com>
	 <xmqqtx92czqv.fsf@gitster.dls.corp.google.com>
	 <1399421211.11843.53.camel@stross>
	 <20140507030037.GB20726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 05:34:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhscM-0002Zu-IO
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 05:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbaEGDd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 23:33:57 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:56172 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaEGDd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 23:33:56 -0400
Received: by mail-qa0-f50.google.com with SMTP id j15so428759qaq.9
        for <git@vger.kernel.org>; Tue, 06 May 2014 20:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=gyIZrtPGDIchXn8UeHtVeRpik1/GjKEifLCSvw28Os8=;
        b=ZMTVHza9bvVCRQh4IeS7bDZLHsJTMigxdnqSOx3Vmp35HAWge91zsNJqBnlJ3G7YZH
         54KP+LUXjO6aVtdMRC8juJ2oAzxjH+Jmnynwe1fxMKN3AN348WD3ekmqJvvyXMmGz527
         oMNrqkbajCYT9AR58r/nnSGxSZb8d58mIQbyeIkGqqcHns/qKWw1UVxLMrigoR4GkgGD
         +8fTAOo0sPnCys5o6DERK3vCBu2i1Wtd0uVgq68KrNvjtdID/MEVcfkziqABf/WJvap1
         J4/ouR+hQDTqXN5bK4MsHUj68+Q+lguQNRKV56IyeoqqVUHX7fCLyzbFQJ+gJRtVlOnm
         fdlg==
X-Gm-Message-State: ALoCoQnr7cQjNjuvdP8GX0wVf295sr7cdlnfuY0bUgx0ZDo3J91esdligi6RgGORYPQ1n5JbMr9T
X-Received: by 10.224.12.74 with SMTP id w10mr61439788qaw.34.1399433635325;
        Tue, 06 May 2014 20:33:55 -0700 (PDT)
Received: from [172.25.144.67] ([8.25.197.27])
        by mx.google.com with ESMTPSA id j1sm27257713qan.32.2014.05.06.20.33.53
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 06 May 2014 20:33:54 -0700 (PDT)
In-Reply-To: <20140507030037.GB20726@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248281>

This causes my test to pass and generally seems correct to me.

On Tue, 2014-05-06 at 23:00 -0400, Jeff King wrote:
...
> That being said, this really seems like something that the run-command
> interface should be doing, since it can handle the chdir in the forked
> child. And indeed, it seems to support that.
> 
> Maybe:
> 
> -- >8 --
> Subject: grep: use run-command's "dir" option for --open-files-in-pager
> 
> Git generally changes directory to the repository root on
> startup.  When running "grep --open-files-in-pager" from a
> subdirectory, we chdir back to the original directory before
> running the pager, so that we can feed the relative
> pathnames to the pager.
> 
> We currently do this chdir manually, but we can ask
> run_command to do it for us. This is fewer lines of code,
> and as a bonus, the chdir is limited to the child process,
> which avoids any unexpected surprises for code running after
> the pager (there isn't any currently, but this is
> future-proofing).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/grep.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 69ac2d8..43af5b7 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -361,9 +361,7 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
>  		argv[i] = path_list->items[i].string;
>  	argv[path_list->nr] = NULL;
>  
> -	if (prefix && chdir(prefix))
> -		die(_("Failed to chdir: %s"), prefix);
> -	status = run_command_v_opt(argv, RUN_USING_SHELL);
> +	status = run_command_v_opt_cd_env(argv, RUN_USING_SHELL, prefix, NULL);
>  	if (status)
>  		exit(status);
>  	free(argv);
