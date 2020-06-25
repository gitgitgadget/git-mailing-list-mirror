Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D114AC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 00:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7284D2078D
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 00:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qRofvcpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbgFYAiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:38:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53770 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbgFYAiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 20:38:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6005D1DB1;
        Wed, 24 Jun 2020 20:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SaFVgQKpSBrmzhP4JxkX//1ojFc=; b=qRofvc
        pq9FNqjp9SN+5gNHgJVrLJzr4cihqxVL3QyTWZ+4P4rBZUE7IZTsTc9USE+uZwuD
        XzHLPThpynYfoBzeKhI/5sguKOHDtjE/AamfHu3D9MFdgH9raEno6Rl22ZtS6vhK
        cW5X50hvlLqekEuKkn9NzqGiwcHqF1JXXnHKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P37NdYyJ0f7KGYcgxGgbAqlZVA7FHnMW
        FBJJzEgr9pq6UWPolJzTuB5jC7HABCpdK39movUt0xrTmMdg0O2lYmL+DFd5hcmx
        tEU/57DnvTNg43+dDUs6ad779DC0AjSZjbXhk9VwEAMNlqHgS7LIn0HhCa0vY9DE
        4D8TQlUz/fI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDD45D1DAF;
        Wed, 24 Jun 2020 20:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14C1DD1DAD;
        Wed, 24 Jun 2020 20:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: [PATCH] worktree: avoid dead-code in conditional
References: <20200624190541.5253-1-sunshine@sunshineco.com>
        <xmqqsgek5fg3.fsf@gitster.c.googlers.com>
        <CAPig+cRdRyWAjU7QADPt39rDgJ4njDtN_pwo8JMVD=YX09a-Vg@mail.gmail.com>
Date:   Wed, 24 Jun 2020 17:38:18 -0700
In-Reply-To: <CAPig+cRdRyWAjU7QADPt39rDgJ4njDtN_pwo8JMVD=YX09a-Vg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 24 Jun 2020 19:00:37 -0400")
Message-ID: <xmqqbll8569x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AF2B18A-B67C-11EA-A5B0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Callers of get_git_common_dir() aren't forced to care. But after
> applying strbuf_add_absolute_path() we are forced to care. This is the
> result of get_git_common_dir() for the three cases:
>
>     .     (within bare repo)
>     .git  (within any worktree)
>     .     (within .git)
>
> After applying strbuf_add_absolute_path(), we get:
>
>     /whatever/proj.git/.   (within bare proj)
>     /whatever/proj/.git    (within any worktree)
>     /whatever/proj/.git/.  (within .git)

OK, but the point still stands.  

Shouldn't strbuf_add_absolute_path() be what we want to normalize?

> Your puzzlement may arise from the misunderstanding regarding
> get_git_common_dir() vs. strbuf_add_absolute_path()?

Yes, exactly.

Thanks.
