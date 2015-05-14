From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/clean.c: Handle disappearing files
Date: Thu, 14 May 2015 14:45:27 -0700
Message-ID: <xmqqk2waj0js.fsf@gitster.dls.corp.google.com>
References: <1431638200-20449-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:45:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0wh-0004zm-PM
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbbENVpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:45:31 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36790 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161024AbbENVpa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:45:30 -0400
Received: by igbpi8 with SMTP id pi8so179107886igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=O7i7Ao/YULlFYoG0LBB+F1pawErx8+xTqcMrWItu/7I=;
        b=RhBNWVg3AaB2jGUTXle2oEKPjKSMKfQ0q4RlsevRC9gFHlk7KBP+jNApMZTQhoiPUi
         BGZo6khLOWn5bfu5iSvmk4YDYp8663lRtQOamqX4KdDxRZdbwGD+0q1vhwTh9KTKY6TG
         /MClPv4E4lKvNsAziqYDt+cPkgwLKjQCtLo7k9VCgoVguo4GTlf4mBiNMAmV+yppuR4Z
         WwO2fvuXYPV9BT6P3TwEkb7rUdz9wFA5tPnL5JQuwVjCfW0R9Qc0GRy/m1ThqUBl3rNm
         bwIEdlSdgjotWhZuNMiMwQacpeg4Cf68RMWC1aYdLoxivKreLOgvRsLy7cfQpWEds494
         4uSw==
X-Received: by 10.107.10.79 with SMTP id u76mr8073520ioi.79.1431639929682;
        Thu, 14 May 2015 14:45:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id g2sm131043igt.8.2015.05.14.14.45.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 14:45:28 -0700 (PDT)
In-Reply-To: <1431638200-20449-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Thu, 14 May 2015 17:16:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269103>

David Turner <dturner@twopensource.com> writes:

> During a git clean, some other process might be deleting files as
> well.  If this happens, make git clean no longer die.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

I am having a hard time to convince myself that this is a good
change.

For this change to be an improvement that matters, you must be
allowing some other process mucking around with the files in your
working tree when you run "git clean".  The original catches such
situation as an anomaly that the user would want to be aware of (and
investigate), but this patch essentially declares that having such a
random process touching your working tree from sideways is a normal
situation.  I do not think I am willing to make such a declaration
myself; I'd rather want to know why other people are touching my
working tree while I am working in it.

>  builtin/clean.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 98c103f..3ae44c2 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -941,8 +941,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		if (!cache_name_is_other(ent->name, ent->len))
>  			continue;
>  
> -		if (lstat(ent->name, &st))
> -			die_errno("Cannot lstat '%s'", ent->name);
> +		/*
> +		 * Some concurrent process might have already removed
> +		 * ent->name.
> +		 */
> +		if (lstat(ent->name, &st)) {
> +			if (errno == ENOENT || errno == ENOTDIR)
> +				continue;
> +			else
> +				die_errno("Cannot lstat '%s'", ent->name);
> +		}
>  
>  		if (pathspec.nr)
>  			matches = dir_path_match(ent, &pathspec, 0, NULL);
