Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3160C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF137222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aEq/qL2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391647AbgBNRZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:25:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57623 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391680AbgBNRZT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:25:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DEE01B6406;
        Fri, 14 Feb 2020 12:25:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DYaktfaaoCpw7qiGb9Jk7jupLjM=; b=aEq/qL
        2EdxJXG3kpdQ90yzrnUOlUWR5gS5SjuXbn/2gfNsO+DkAg1K/kjri1+HLoizKP7b
        0AnMbNvsxjJSxXIV2PsSlBZqvBQFlMuKEr9RQyuV4WoqV46qdujo1jgA114Jc+CH
        imsL+8SVc1T8h8kTjw0TgcoeWGyWtfO5AvV8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MAtVS2aRsFhvkUKNJDjwos4H1T6lHW37
        sdj9+MuXQyjee3fyedvdTF7EjHegLQDWxuKa56QMrDWACBQSyf3LUOVobAY9Jeel
        /Z4BDGm1fuNYUwIoqFGOxtWerEtrZSKScO5j+fBlTZow8J+3SudxDRL5PZK3q0L4
        mYtQsBBIrBQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7EFFB6405;
        Fri, 14 Feb 2020 12:25:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 03715B6404;
        Fri, 14 Feb 2020 12:25:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <20200214015343.201946-4-emilyshaffer@google.com>
Date:   Fri, 14 Feb 2020 09:25:12 -0800
In-Reply-To: <20200214015343.201946-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 13 Feb 2020 17:53:31 -0800")
Message-ID: <xmqqzhdlnksn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F686DA46-4F4E-11EA-A439-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +	switch (safe_create_leading_directories(report_path.buf)) {

This helper is about creating paths in the working tree and Git
repository, hence it has a call to adjust_shared_perm() which in
turn calls get_shared_repo(), i.e. requiring a repository.

I thought I read somewhere that this tool is meant to be usable
outside a repository?  If that is not the case, then the use of this
helper is OK.  If not, we may want to make sure that it will stay to
be safe to use the helper (I think it happens to be OK right now,
but if the reason why the user is trying to run the tool is because
the user broke Git by writing garbage into .git/config, we may
die("your configuration file is broken") before this helper returns).

Thanks.


