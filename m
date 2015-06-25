From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] git-reflog: add create and exists functions
Date: Thu, 25 Jun 2015 14:01:36 -0700
Message-ID: <xmqq1tgzy027.fsf@gitster.dls.corp.google.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
	<1435265110-6414-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:01:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8EHH-0003V6-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 23:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbbFYVBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 17:01:40 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35727 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbFYVBj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 17:01:39 -0400
Received: by iebrt9 with SMTP id rt9so63096337ieb.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Oi+s8FbClXkYU2myauU+8JKW0i1uKdet7DdaQIOC2ps=;
        b=0ES1zeRhOBC3/9iBY/kcrXODl18YwOK3oma5FNgq/oL945+nHM0ANVlsFetO4O6SD5
         JcfCN2HMTGE4Svf3OiwW3qo3CYTallvOBRLNa4L2W3t0fCqCXlOWLG5ndz3WjFx8sP9G
         NTVCURtNH88vr/6E5ZE/hzPE9Un7EQTuCfzQb0NSXwHwo0uLxtvd6nWS+3EAldAKVnLl
         ZkLurGtZjBzAxI0vIwxboeZaYKfbSarba0/iJQFgUnBcTQus0hlYAS4qpgo8xFw08kWq
         aexxwE4Lj27TxdzQ2o38wM1z0cWFcvNuzfd+BCWh8lYAXA/z/B6W4K2vfuOj44FUjtTq
         M/fA==
X-Received: by 10.107.170.216 with SMTP id g85mr54314701ioj.31.1435266098580;
        Thu, 25 Jun 2015 14:01:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id u38sm20327353ioi.0.2015.06.25.14.01.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 14:01:38 -0700 (PDT)
In-Reply-To: <1435265110-6414-5-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 16:45:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272733>

David Turner <dturner@twopensource.com> writes:

Because...???

> These are necessary because ref backends manage reflogs.

"Because ref backends manage reflogs" may be a good explanation to
implement something as part of ref API, but it does not explain why
that something needs to be implemented in the first place.

> In a moment,
> we will use these functions to make git stash work with alternate
> ref backends.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/reflog.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index c2eb8ff..a64158d 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -13,6 +13,10 @@ static const char reflog_expire_usage[] =
>  "git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
>  static const char reflog_delete_usage[] =
>  "git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
> +static const char reflog_create_usage[] =
> +"git reflog create <refs>...";

It makes sense to take more than one; you may want to prepare more
than one, and you would signal error by exiting with a non-zero
status if any of them failed.

> +static const char reflog_exists_usage[] =
> +"git reflog exists <refs>...";

This is iffy, though.  "git reflog exists foo bar" says "all of them
exist" or "some of them exist"?  Why is it more useful to implement
"all of them exist"?

Perhaps dropping "..." would be simpler to explain and less
confusing.

> @@ -699,12 +703,79 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  	return status;
>  }
>  
> +static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
> +{
> +	int i, status = 0, start = 0;
> +	struct strbuf err = STRBUF_INIT;
> +
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			break;
> +		}
> +		else if (arg[0] == '-')
> +			usage(reflog_create_usage);
> +		else
> +			break;
> +	}
> +
> +	start = i;
> +
> +	if (argc - start < 1)
> +		return error("Nothing to create?");
> +
> +	for (i = start ; i < argc; i++) {

s/start ;/start;/ (everywhere).
