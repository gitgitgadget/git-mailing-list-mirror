From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] commit: add message options for rebase --autosquash
Date: Fri, 17 Sep 2010 01:36:27 -0700
Message-ID: <4C93288B.7000908@gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com> <1284687596-236-2-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 10:36:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwWR0-0005l1-3W
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 10:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab0IQIgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 04:36:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62518 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0IQIge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 04:36:34 -0400
Received: by pwi3 with SMTP id 3so615947pwi.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GSvOrDdPQW3IB35s3fnhrnOkbZz0cduA12FNvzrU8EA=;
        b=AqYVcXeu5DsCqS/LbpBKzwtoAInrFdH/UHxZShbRoFM5jX+Vcwz2vPoB3Ig71RS84c
         j0skL+MWcp/Mat884L3xQ3UOlyDr1hyfnrOzgiwsJKSUET5xJBI2pLBt5aeKac82CJbA
         KQFwGiL+hOlwyTaxqNY4lHjtr5+WuOJLJfKX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KXeW/qBeIQ3AQnheKdRvqNJWlVKDdgH8OKM8+X4leqyqi4v+/TuHFjvC3rFRNm/uAW
         pF+bjVxk1TZiNhtUL+fNzmTk//mCwIt+h67BZqEUQRm7WnfblZY/fY3FNq/fGTj5zC8j
         urFFvNB09B07qENCLa2eU2+259WYSef0ypELI=
Received: by 10.142.53.2 with SMTP id b2mr3945041wfa.61.1284712594527;
        Fri, 17 Sep 2010 01:36:34 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id 9sm4253922wfd.0.2010.09.17.01.36.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Sep 2010 01:36:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100831 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <1284687596-236-2-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156376>

On 09/16/2010 06:39 PM, Pat Notz wrote:
> These options make it convenient to construct commit messages for use
> with 'rebase --autosquash'.  The resulting commit message will be
> "fixup! ..." or "squash! ..." where "..." is the subject line of the
> specified commit message.
> 
> Example usage:
>   $ git commit --fixup HEAD~2
>   $ git commit --squash HEAD~5
> 
> Signed-off-by: Pat Notz <patnotz@gmail.com>
> ---

So far I've been using an alias for these, but I suppose making them
real features of git could be worthwhile. What are the benefits with
this approach vs. an alias?

> @@ -863,7 +871,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	if (force_author && renew_authorship)
>  		die("Using both --reset-author and --author does not make sense");
>  
> -	if (logfile || message.len || use_message)
> +	if (logfile || message.len || use_message || fixup_message || squash_message)
>  		use_editor = 0;
>  	if (edit_flag)
>  		use_editor = 1;

The whole point of squash is to combine two commit texts, right?
Otherwise wouldn't you use --fixup where you throw away the text
eventually and thus don't want to open an editor?

> @@ -883,15 +891,19 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		f++;
>  	if (edit_message)
>  		f++;
> +	if (fixup_message)
> +		f++;
> +	if (squash_message)
> +		f++;
>  	if (logfile)
>  		f++;
>  	if (f > 1)
> -		die("Only one of -c/-C/-F can be used.");
> +		die("Only one of -c/-C/-F/--fixup/--squash can be used.");
>  	if (message.len && f > 0)
> -		die("Option -m cannot be combined with -c/-C/-F.");
> +		die("Option -m cannot be combined with -c/-C/-F/--fixup/--squash.");


Furthering that point, perhaps I want to squash this commit into another
commit using the commit text from yet another commit or just with an
extra note from the command line (-m). Perhaps this is where the benefit
over an alias comes in?

>  	if (edit_message)
>  		use_message = edit_message;
> -	if (amend && !use_message)
> +	if (amend && (!use_message && !fixup_message && !squash_message))
>  		use_message = "HEAD";
>  	if (!use_message && renew_authorship)
>  		die("--reset-author can be used only with -C, -c or --amend.");
> @@ -932,6 +944,23 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		if (enc != utf8)
>  			free(enc);
>  	}
> +	if (fixup_message || squash_message) {
> +		unsigned char sha1[20];
> +		struct commit *commit;
> +		const char * target_message = fixup_message ? fixup_message : squash_message;
> +		const char * msg_fmt = fixup_message ? "fixup! %s" : "squash! %s";

Style nit: stick the * to the variable.

I read this and became confused. fixup_message? target_message? Perhaps
it should be renamed to fixup_commit, squash_commit, target_commit?

> +		struct strbuf buf = STRBUF_INIT;
> +		struct pretty_print_context ctx = {0};
> +
> +		if (get_sha1(target_message, sha1))
> +			die("could not lookup commit %s", target_message);
> +		commit = lookup_commit_reference(sha1);
> +		if (!commit || parse_commit(commit))
> +			die("could not parse commit %s", target_message);
> +
> +		format_commit_message(commit, msg_fmt, &buf, &ctx);
> +		fixup_message_buffer = strbuf_detach(&buf, NULL);
> +	}
>  

Is it necessary to do this block of code here? Couldn't you lookup and
format the commit in prepare_to_commit()? Then we wouldn't have to
allocate another strbuf and the "message" code would be more centralized.
