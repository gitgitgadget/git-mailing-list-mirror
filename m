From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 19/44] builtin-am: implement --3way, am.threeWay
Date: Tue, 07 Jul 2015 13:14:44 -0700
Message-ID: <xmqqfv4z3etn.fsf@gitster.dls.corp.google.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<1436278862-2638-20-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:15:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCZGd-00060Z-BW
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 22:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933037AbbGGUOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 16:14:53 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33219 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932951AbbGGUOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 16:14:47 -0400
Received: by iggp10 with SMTP id p10so6171373igg.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XFVr0kSZCoaZ7ErON1ZHclOKtctjn8A1o3IV0r9XjM4=;
        b=w1eh5KyR9xJDs5o8pRPE0VNXPe1wTa//xIZ3ejjnTMXiRLYGfFf9U0aH0VxZ1M8M7R
         DEiBl/1PAEwUslf/ICCib8D5si6r95cfJudlmskY+9o6NMnyo5eCthpDJaZKHqZxEx5N
         yg6tO3RHsyENPp1YT1ZrHBQLlj2bCI71WTqKdpPbO+mJvAtgze1S4M7/FCRkXPi/kM8f
         5Rg3izVrtRc8FEz9TblzVAhaICZGdbNi5nCgdwolcXUcEmLJmgLn7+Sel5tnCKHonFQH
         MgLNi16ELypRw7LjmmoHhR3CwFApZOb6JIEFzAvbka8IhqFhGN2oejYH9Nw2OGn1grWc
         ctjA==
X-Received: by 10.107.136.153 with SMTP id s25mr10270711ioi.65.1436300086381;
        Tue, 07 Jul 2015 13:14:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id i185sm207217ioi.24.2015.07.07.13.14.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 13:14:45 -0700 (PDT)
In-Reply-To: <1436278862-2638-20-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Tue, 7 Jul 2015 22:20:37 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273598>

Paul Tan <pyokagan@gmail.com> writes:

> @@ -82,6 +84,8 @@ struct am_state {
>  	/* number of digits in patch filename */
>  	int prec;
>  
> +	int threeway;
> +
>  	int quiet;
>  
>  	int append_signoff;

These "one line surrounded by blank on both sides" starts to get
irritating, and the structure looksq horrifying after you apply all
these patches.  Perhaps have a clean-up patch at the end to make
them look more like this?

struct am_state {
	/* state directory path */
	char *dir;

	/* current and last patch numbers, 1-indexed */
	int cur;
	int last;

	/* commit metadata and message */
	char *author_name;
	char *author_email;
	char *author_date;
	char *msg;
	size_t msg_len;

	/* when --rebasing, records the original commit the patch came from */
	unsigned char orig_commit[GIT_SHA1_RAWSZ];

	/* number of digits in patch filename */
	int prec;

	/* various operating modes and command line options */
	int interactive;
	int threeway;
	int quiet;
	int append_signoff;
	int utf8;
	int committer_date_is_author_date;
	int ignore_date;
	int allow_rerere_autoupdate;
	const char *sign_commit;
	int rebasing;

	/* one of the enum keep_type values */
	int keep;

	/* pass -m flag to git-mailinfo */
	int message_id;

	/* one of the enum scissors_type values */
	int scissors;

        /* used when spawning "git apply" via run_command() */
	struct argv_array git_apply_opts;

	/* override error message when patch failure occurs */
	const char *resolvemsg;
};
