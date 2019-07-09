Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2594A1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 05:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfGIFQz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 01:16:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58275 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIFQy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 01:16:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BB2D15D57B;
        Tue,  9 Jul 2019 01:16:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lrGYvVi3Ip5cpx26q7P2blsqKoI=; b=mwPKy0
        tcyUuXacbxltZFwFwhgJh7S8JmLZi7XWfcR1MKjHXNboPlpj+EhF3kes8NLh0voC
        s7eotjy6fADorXIMdy/SfvvOe6o6zYMxH4CgcQu6N68qLxDgDBJ/i5zVyzZFIhgv
        p7RwkbPXZ+WvXTZ/ddulQ8nepY7TBuLppoHyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q3JBBQntNzuIsfNCyr0Sga2WTT1Gu849
        Eov8dmLH3P/i3eeRyk4OD4VZl6WJgkNRQlprVgZqApUGeGdQ3RXwMJS05G61kPWZ
        nG+YXqXeeG9Hgt8JX+gFsYMbE1WPCK87z7qp5CA7fEyyYodI9oc2ePFvyP1MnP0+
        Qz4zKcUw5IY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CFC015D578;
        Tue,  9 Jul 2019 01:16:52 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D549115D577;
        Tue,  9 Jul 2019 01:16:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
References: <20190704080907.GA45656@book.hvoigt.net>
        <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
        <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 08 Jul 2019 22:16:50 -0700
In-Reply-To: <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 08 Jul 2019 21:55:00 -0700")
Message-ID: <xmqqk1crwzwd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C28BE66C-A208-11E9-A1EE-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The "--all" in rev-list family (including "git log") unconditionally
> include HEAD.  The glitch here is that "--all" in rev-parse does
> not.  And 4d5e1b1319 was an attempt to "fix" that, i.e. make "--all"
> imply "HEAD".

And it becomes really tempting to get rid of that "let's tweak
--all" hack and declare that "rev-parse --all" is simply buggy,
proposing a simple "bugfix" that may look like this (not even
compile tested, but you get the idea).

 builtin/rev-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index f8bbe6d47e..94f9a6efba 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -766,6 +766,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--all")) {
 				for_each_ref(show_reference, NULL);
+				head_ref(show_reference, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
