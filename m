From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/19] pull: implement fetch + merge
Date: Tue, 09 Jun 2015 16:27:50 -0700
Message-ID: <xmqqmw08wjgp.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:28:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Sw1-0006CM-BC
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 01:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbbFIX1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 19:27:54 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38736 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbbFIX1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 19:27:52 -0400
Received: by igblz2 with SMTP id lz2so21935643igb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zW7pnTsnqgdFtUlsik4YNQiucEehJyi+sk22a89WNRs=;
        b=OoyhrMsxLli01NIAiO4GkLvHQ3WTU8swnym804EBjx0tCyvHMZMJUH/7/uV6Zi5eJ3
         2vZCmRKoQ20jf+Xh+6sesRjdzFH7k/YbdxwW6+0Mjro+hmJXgy7z9XzbcaRFRPpsmZou
         BWmq5flxhWKzSVsn3/XDY2Zp8A19LtLWW3Gllzpb9UW1Ghwc1GE4WCHUIVD8i5jXf71r
         8oHqNHhY36kAxZXY/ZHGCjmm/iTmfQ6KmbbGhGhmhbeXTN5pwC993BVIGqnuNHIiDcCH
         rqYWwW/nUR/sMW7DTjOVlRSBl02ktmH7UjOsH/9CKM1F0xWH1yTaLiLhcdvjWE8oaIrP
         LYPg==
X-Received: by 10.50.43.196 with SMTP id y4mr1862091igl.14.1433892472004;
        Tue, 09 Jun 2015 16:27:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id eg3sm2174320igb.0.2015.06.09.16.27.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 16:27:51 -0700 (PDT)
In-Reply-To: <1433314143-4478-6-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Wed, 3 Jun 2015 14:48:49 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271242>

Paul Tan <pyokagan@gmail.com> writes:

> +/**
> + * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
> + * as a string and `refspecs` as a null-terminated array of strings. If `repo`
> + * is not provided in argv, it is set to NULL.
> + */
> +static void parse_repo_refspecs(int argc, const char **argv, const char **repo,
> +		const char ***refspecs)
> +{
> +	if (argc > 0) {
> +		*repo = *argv++;
> +		argc--;
> +	} else
> +		*repo = NULL;
> +	*refspecs = argv;
> +}
> +
> +/**
> + * Runs git-fetch, returning its exit status. `repo` and `refspecs` are the
> + * repository and refspecs to fetch, or NULL if they are not provided.
> + */
> +static int run_fetch(const char *repo, const char **refspecs)
> +{
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	int ret;
> +
> +	argv_array_pushl(&args, "fetch", "--update-head-ok", NULL);
> +	if (repo)
> +		argv_array_push(&args, repo);
> +	while (*refspecs)
> +		argv_array_push(&args, *refspecs++);

As you cannot say "git pull refspecs...", the above might be more
clear if you spelled it like this instead:

	if (repo) {
		argv_array_push(&args, repo);
		argv_array_pushv(&args, refspecs);
	} else if (*refspecs) {
        	die("BUG: refspec without repo?");
	}

> +/**
> + * Runs git-merge, returning its exit status.
> + */
> +static int run_merge(void)
> +{
> +	int ret;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +
> +	argv_array_pushl(&args, "merge", NULL);
> +	argv_array_push(&args, "FETCH_HEAD");
> +	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
> +	argv_array_clear(&args);
> +	return ret;
> +}

No frills yet, which is a good way to start with and show the
overall structure.
