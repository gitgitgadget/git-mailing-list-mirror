From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Don't do status in submodules if status.SubmoduleSummary
 	unset
Date: Thu, 20 May 2010 19:45:28 +0200
Message-ID: <4BF57538.5040204@web.de>
References: <AANLkTil1QHA3G2VaITdm7DkDmN1IhZ_u2SWLrelyxkF2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 19:45:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF9oR-0007Rz-J1
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 19:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab0ETRpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 13:45:35 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:43000 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab0ETRpe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 13:45:34 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1EEC915A86E80;
	Thu, 20 May 2010 19:45:33 +0200 (CEST)
Received: from [80.128.73.13] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OF9oK-0008LX-00; Thu, 20 May 2010 19:45:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTil1QHA3G2VaITdm7DkDmN1IhZ_u2SWLrelyxkF2@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/w3tfUISLDhwN0ckplJAvc/WG2KjC7kMnXFSzb
	iYO8fI9kva7tGTXpZNLUd23bAhFemtiEpu0ms8zKmnMVnuk174
	fAAlEsgAlhp4aHU+XMtA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147402>

Am 20.05.2010 16:12, schrieb Alex Riesen:
> Maybe because we do a (kind of) gentle status run on submodules
> whether the status.SubmoduleSummary set or not.

Yup, because checking a submodule for its dirtiness has to be done
no matter if the summary output is also wanted.


> Usually a background
> run of "git status" for every submodules goes unnoticed, just
> sometimes a submodule is a little too big.
> 
> I tried this, but feels like a bit of overkill.

This patch seems to disable submodule output completely for the default
case (when status.SubmoduleSummary is false) and breaks 17 test cases.

So no thumbs up from me ;-)


> diff --git a/wt-status.c b/wt-status.c
> index 8ca59a2..d5bcdf9 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -303,7 +303,10 @@ static void
> wt_status_collect_changes_worktree(struct wt_status *s)
>  	init_revisions(&rev, NULL);
>  	setup_revisions(0, NULL, &rev, NULL);
>  	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> -	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
> +	if (s->submodule_summary)
> +		DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
> +	else
> +		DIFF_OPT_SET(&rev.diffopt, IGNORE_SUBMODULES);
>  	if (!s->show_untracked_files)
>  		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
>  	rev.diffopt.format_callback = wt_status_collect_changed_cb;
