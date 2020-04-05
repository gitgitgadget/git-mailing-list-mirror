Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB52C2BA19
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 21:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31850206F8
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 21:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hgjngOpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDEVq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:46:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57452 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgDEVq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 17:46:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD78DC5362;
        Sun,  5 Apr 2020 17:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9gH/d+FmKveomascSP/jR8XW830=; b=hgjngO
        pt/ZtumhsdhM/1f5aEp5MH2BqEP1FiRKZLJdauUTYXQYC0zOiTBwjkC/T1Khv64q
        9eVhfcsDTeHamsjBMG6ptqr94s5vF5hFl3AA5xwXf0X2Zuhb8FwXLJ41L6VnFzc/
        +LYtygZDGGbJNDm2WucjSLGgNTbFCbkeTbhWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tVoQL7B4dUFKfZ3VrgBjQUvYT7a4TfmP
        YWQYwRJTrHsg7g+BaMLxq2SipRnv3t4tnhbYNiDE2GCT8pgsglLhA/nfeio5jMw+
        z9ZbCmIhS8BLths3um564ibkfCuMMPLQ0O9yJ6sKSYdq12FaRpr8jwGfrhSSNeOi
        9/FlrGhwbRU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4B34C5361;
        Sun,  5 Apr 2020 17:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C787C5360;
        Sun,  5 Apr 2020 17:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 04/23] sequencer: reuse strbuf_trim() in read_oneliner()
References: <cover.1584782450.git.liu.denton@gmail.com>
        <cover.1585962672.git.liu.denton@gmail.com>
        <c7a3cfa20005aeeedc27d2eb4af1e2c4470ad73d.1585962672.git.liu.denton@gmail.com>
Date:   Sun, 05 Apr 2020 14:46:47 -0700
In-Reply-To: <c7a3cfa20005aeeedc27d2eb4af1e2c4470ad73d.1585962672.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 3 Apr 2020 21:11:17 -0400")
Message-ID: <xmqqr1x1wqpk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F40C2266-7786-11EA-B6F6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> @@ -2471,7 +2467,6 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
>  
>  static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
>  {
> -	strbuf_reset(buf);
>  	if (!read_oneliner(buf, rebase_path_strategy(), 0))
>  		return;
>  	opts->strategy = strbuf_detach(buf, NULL);
> @@ -2494,7 +2489,6 @@ static int read_populate_opts(struct replay_opts *opts)
>  				free(opts->gpg_sign);
>  				opts->gpg_sign = xstrdup(buf.buf + 2);
>  			}
> -			strbuf_reset(&buf);
>  		}
>  
>  		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
> @@ -2526,7 +2520,6 @@ static int read_populate_opts(struct replay_opts *opts)
>  			opts->keep_redundant_commits = 1;
>  
>  		read_strategy_opts(opts, &buf);
> -		strbuf_reset(&buf);
>  

>  		if (read_oneliner(&opts->current_fixups,
>  				  rebase_path_current_fixups(), 1)) {

Is this conversion correct around here?  read_oneliner() used to
"append" what was read from the file to what is already in the
strbuf, and many strbuf_reset() in this function was because these
callers of read_oneliner() in this function that has strbuf_reset()
immediately before did *not* want the "append" semantics.  But this
one looks different.  Where in the original does the current_fixups
strbuf get emptied for this read_oneliner() to ignore the previous
contents?  Or are we relying on the caller not to have done anything
to current_fixups before it calls this function?

In other words, the original behaviour of read_oneliner() having the
"append" semantics suggests me that there were callers that wanted
to keep the current contents and append---this current_fixups may
not be one of them, but nevertheless, changing the semantics of the
function from "append" to "discard and read from scratch" without
vetting all the existing callers smells iffy to me.

