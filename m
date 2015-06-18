From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 10/31] am: refresh the index at start
Date: Thu, 18 Jun 2015 14:28:04 -0700
Message-ID: <xmqqlhfgd7vf.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-11-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:28:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hM3-0007MD-MG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbbFRV2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:28:08 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35328 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbFRV2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:28:06 -0400
Received: by iefd2 with SMTP id d2so6953963ief.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mzSeZLlCW8BvO6OjzNmUCdg/0tWyAq1XpOHVq4mRQnY=;
        b=n2jasGS5rtk11kikFUb51B0aFWGQ7/43W5Jt2x+nnZdodgXUzFKMaTGBgK6SJ4etrM
         d+o90MkEVGsgtOC74MCtKdb5BHqO4UU7cBRbglMvY4xEO59mR3ZjcdY9UuHg+pb+SBYc
         mt4bdTWyq8jjW700V0FZp0hIvzcmQYWHu6FHLb3zPTNOJzDuSJOC9jUjlfh9d8ELe+pb
         PGqSRNX4kamEurYNYhsRrKfIMLrCM0Mtd2+2AuabKTauqpUvljKJPHU/wMsKfpTQC6R+
         jC38DhSQiSzN+dmHywJHE9IqBnkfHuok8SqULV0Jpb6aLM0Dy15xbZc+POt/cKFx69vX
         HqLg==
X-Received: by 10.43.96.5 with SMTP id ce5mr8076194icc.96.1434662886034;
        Thu, 18 Jun 2015 14:28:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id fm3sm2561751igb.1.2015.06.18.14.28.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 14:28:05 -0700 (PDT)
In-Reply-To: <1434626743-8552-11-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Thu, 18 Jun 2015 19:25:22 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272081>

Paul Tan <pyokagan@gmail.com> writes:

> If a file is unchanged but stat-dirty, git-apply may erroneously fail to
> apply patches, thinking that they conflict with a dirty working tree.
>
> As such, since 2a6f08a (am: refresh the index at start and --resolved,
> 2011-08-15), git-am will refresh the index before applying patches.
> Re-implement this behavior.

Good.

I would actually have expected to see this as part of 08/31, though.

>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index dfb6f7e..a7efe85 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -13,6 +13,7 @@
>  #include "cache-tree.h"
>  #include "refs.h"
>  #include "commit.h"
> +#include "lockfile.h"
>  
>  /**
>   * Returns 1 if the file is empty or does not exist, 0 otherwise.
> @@ -471,6 +472,20 @@ static const char *msgnum(const struct am_state *state)
>  }
>  
>  /**
> + * Refresh and write index.
> + */
> +static void refresh_and_write_cache(void)
> +{
> +	static struct lock_file lock_file;
> +
> +	hold_locked_index(&lock_file, 1);
> +	refresh_cache(REFRESH_QUIET);
> +	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> +		die(_("unable to write index file"));
> +	rollback_lock_file(&lock_file);
> +}
> +
> +/**
>   * Parses `patch` using git-mailinfo. state->msg will be set to the patch
>   * message. state->author_name, state->author_email, state->author_date will be
>   * set to the patch author's name, email and date respectively. The patch's
> @@ -607,6 +622,8 @@ static void do_commit(const struct am_state *state)
>   */
>  static void am_run(struct am_state *state)
>  {
> +	refresh_and_write_cache();
> +
>  	while (state->cur <= state->last) {
>  		const char *patch = am_path(state, msgnum(state));
>  
> @@ -696,6 +713,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix, am_options, am_usage, 0);
>  
> +	if (read_index_preload(&the_index, NULL) < 0)
> +		die(_("failed to read the index"));
> +
>  	if (am_in_progress(&state))
>  		am_load(&state);
>  	else {
