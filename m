Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20DBC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 17:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A006124C
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 17:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhGJRae (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 13:30:34 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:41180 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229490AbhGJRad (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 13:30:33 -0400
Received: from localhost (avs3.comp.nus.edu.sg [192.168.49.7])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id 9668D256E3A;
        Sun, 11 Jul 2021 01:27:47 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.7]) (amavisd-new, port 10024)
        with ESMTP id xuE-dpAxnjkK; Sun, 11 Jul 2021 01:27:27 +0800 (+08)
Received: from mailauth1.comp.nus.edu.sg (mailauth1.comp.nus.edu.sg [192.168.49.3])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Sun, 11 Jul 2021 01:27:27 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth1.comp.nus.edu.sg (Postfix) with ESMTPSA id 211DB601A7FE3;
        Sun, 11 Jul 2021 01:27:27 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] commit: remove irrelavent prompt on `--allow-empty-message`
Date:   Sun, 11 Jul 2021 01:26:55 +0800
Message-Id: <20210710172655.2731007-1-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <xmqq7dhz711a.fsf@gitster.g>
References: <xmqq7dhz711a.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> > +		const char *hint_cleanup_all = allow_empty_message ?
> > +			_("Please enter the commit message for your changes."
> > +			  " Lines starting\nwith '%c' will be ignored.\n") :
> > +			_("Please enter the commit message for your changes."
> > +			  " Lines starting\nwith '%c' will be ignored, and an empty"
> > +			  " message aborts the commit.\n");
> > +		const char *hint_cleanup_space = allow_empty_message ?
> > +			_("Please enter the commit message for your changes."
> > +			  " Lines starting\n"
> > +			  "with '%c' will be kept; you may remove them"
> > +			  " yourself if you want to.\n") :
> > +			_("Please enter the commit message for your changes."
> > +			  " Lines starting\n"
> > +			  "with '%c' will be kept; you may remove them"
> > +			  " yourself if you want to.\n"
> > +			  "An empty message aborts the commit.\n");
> 
> Local convention in this file seems to be that multi-line ?:
> expressions are folded with ? and : operators at the beginning, not
> at the end, of the lines, e.g. I see this construct in the same file.
> 
> 			reflog_msg = is_from_cherry_pick(whence)
> 					? "commit (cherry-pick)"
> 					: is_from_rebase(whence)
> 					? "commit (rebase)"
> 					: "commit";
> 
> So, let's mimick and make the above more like this:
> 
> 		const char *hint_cleanup_all = allow_empty_message
> 			? _("Please enter the commit message for your changes."
> 			    " Lines starting\nwith '%c' will be ignored.\n")
> 			: _("Please enter the commit message for your changes."
> 			    " Lines starting\nwith '%c' will be ignored, and an empty"
> 			    " message aborts the commit.\n");

Another statement several lines below, whose style I conformed to, reads,

	status_printf_ln(
		s, GIT_COLOR_NORMAL,
		whence == FROM_MERGE ?
			      _("\n"
			  "It looks like you may be committing a merge.\n"
			  "If this is not correct, please run\n"
			  "	git update-ref -d MERGE_HEAD\n"
			  "and try again.\n") :
			      _("\n"
			  "It looks like you may be committing a cherry-pick.\n"
			  "If this is not correct, please run\n"
			  "	git update-ref -d CHERRY_PICK_HEAD\n"
			  "and try again.\n"));

So I am a little confused which local style convention to follow... :S

	$ grep -nE ':$' builtin/commit.c
	  904:                                      "and try again.\n") :
	$ grep -nE '^\s*:' builtin/commit.c 
	  1754:                                   : is_from_rebase(whence)
	  1756:                                   : "commit";
