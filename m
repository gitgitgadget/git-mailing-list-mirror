From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] pretty: Pass graph width to pretty formatting for use in '%>|(N)'
Date: Mon, 21 Sep 2015 12:40:25 -0700
Message-ID: <xmqqa8sfa7di.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2rwzlhi.fsf@gitster.mtv.corp.google.com>
	<1442013913-2970-1-git-send-email-josef@kufner.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, sunshine@sunshineco.com
To: Josef Kufner <josef@kufner.cz>
X-From: git-owner@vger.kernel.org Mon Sep 21 21:40:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze6x1-0007A9-91
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 21:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401AbbIUTka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 15:40:30 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33595 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623AbbIUTk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 15:40:27 -0400
Received: by pacex6 with SMTP id ex6so124939640pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wovj0kCfbIr5cqaky7KTxPM0nSCBy5MClca698DmABA=;
        b=05ri999MDliuXp584q2jsoR8D9d2pRXyfsxvM0tcUUxiVOuAS5PwHZBBRGYJsQ+h1M
         rZFuCMb6dOb68Wg2XfXIref+jN+mIc6XdasO3/4BG3u2FmN674dFov+4uyR2YwdynIhp
         myH8PnRtneuSOEh87gvtqPUyaU9yw2ZD7UzWGlWqk1JPKRlKkseKA42qbKwx8oxG/m+I
         /hs4zW9SdZL84jzjVHfWCNiR4q4YLvxofk5r/tSx+F7790tiU3txGOI9x4oEbeAUjDDE
         IxqAfCNx0QHNbD+C+XDbGhIuBhoz0ZaPGOWwzJ5TVba0GxH1gvhs5+DuHXIbkfRpcPHM
         elCA==
X-Received: by 10.66.221.68 with SMTP id qc4mr26201201pac.26.1442864427446;
        Mon, 21 Sep 2015 12:40:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id vw7sm26138757pab.15.2015.09.21.12.40.26
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 12:40:26 -0700 (PDT)
In-Reply-To: <1442013913-2970-1-git-send-email-josef@kufner.cz> (Josef
	Kufner's message of "Sat, 12 Sep 2015 01:25:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278326>

Josef Kufner <josef@kufner.cz> writes:

> Pass graph width to pretty formatting, so N in '%>|(N)' includes columns
> consumed by graph rendered when --graph option is in use.
>
> Example:
>   git log --all --graph --pretty='format: [%>|(20)%h] %ar%d'
>
>   All commit hashes should be aligned at 20th column from edge of the
>   terminal, not from the edge of the graph.
>
> Signed-off-by: Josef Kufner <josef@kufner.cz>
> ---

[CC'ed Duy for ideas, as the "%>|(ALIGN)" thing is his invention]

If you imagine an entry for a commit in the "git log" output as a
rectangle that has its commit log message, "--graph" draws a bunch
of lines on the left hand side and place these rectangles on the
right of these lines.  Space allocated to each of these rectangles
may and do begin at a different column.  For example, here is an
output from

 $ git log -12 --graph --oneline

 *   7d211c9 Merge branch 'jk/graph-format-padding' into pu
 |\
 | * ead86db pretty: pass graph width to pretty formatting
 * |   5be4874 Merge branch 'ld/p4-detached-head' into pu
 |\ \
 | * | 4086903 git-p4: work with a detached head
 | * | 6d2be82 git-p4: add failing test for submit from detached
 head
 * | |   7cec6a3 Merge branch 'ls/p4-lfs' into pu
 |\ \ \
 | * | | 5fac7db git-p4: add Git LFS backend for large file system
 | * | | 53b938f git-p4: add support for large file systems
 | * | | 760e31c git-p4: return an empty list if a list config has
 no values
 | * | | c1e88b8 git-p4: add gitConfigInt reader
 | * | | 465af7a git-p4: add optional type specifier to gitConfig
 reader
 * | | |   5197bd3 Merge branch 'nd/clone-linked-checkout' into pu

I can understand why you would want to include the varying width of
the river on the left hand side in the "space allocated for the
commit", and under that mental model, the patch makes sense, but at
the same time, it is also a perfectly good specification to make
"%>|(20)%h" pad "%h" to 20 columns from the left edge of the space
given to the commit.

I have a suspicion that 50% of the users would appreciate this
change, and the remainder of the users see this break their
expectation.  To avoid such a regression, we may be better off if we
introduced a new alignment operator that is different from '%>|(N)'
so that this new behaviour is available to those who want to use it,
without negatively affecting existing uses.

And the use of ctx->graph_width in the hunk below would be the only
thing that needs to be changed (i.e. added to occupied only when the
new alignment operator is used).

Other than that, this round of reroll looks ready for 'next'.

Duy what do you think?

Thanks.

> diff --git a/pretty.c b/pretty.c
> index 151c2ae..f1cf9e2 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1297,6 +1297,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
>  		if (!start)
>  			start = sb->buf;
>  		occupied = utf8_strnwidth(start, -1, 1);
> +		occupied += c->pretty_ctx->graph_width;
>  		padding = (-padding) - occupied;
>  	}
>  	while (1) {
