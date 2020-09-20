Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF4CC43464
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 02:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42F2208C3
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 02:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fRk8zpG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgITCMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 22:12:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52034 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgITCMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 22:12:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 881B874B72;
        Sat, 19 Sep 2020 22:12:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6mHJHcE5Dsnuxi8/xouNQJKYfgw=; b=fRk8zp
        G6DEd606NCvGM35/fGwtX5gdjGBbCHod9MHebiMUv4zhUjE9t+KslsFMdEENauSv
        Tqgy3ZdH2fcY+HN4xyZmtnbQfb+6H+OwCpcRKAQrJBwOHiKRMLIujJ6wsu3AQ/j1
        Ru4UuZ7nKIELQ5bCzVQdpu5mKGrZFXFDhYXMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RgpJyzPKtDhaARQHAlGPNAqYz4U0fxq8
        /DAE9lP0OtJCWmgmhWOuVs0NIB/ig4EW/fLvw//RcPF31DTU5a+HZAwCpVVJtjjL
        SAMOM2DYKEk0oL7dnt8wqf3kvRNrShz2m01h/bCHYoRGKrCjjyOuTU2NVe6W6l3v
        sGFzgQ/doKA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8023874B70;
        Sat, 19 Sep 2020 22:12:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14BE474B6E;
        Sat, 19 Sep 2020 22:12:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Ash Holland <ash@sorrel.sh>, Aaron Schrab <aaron@schrab.com>
Subject: Re: `git describe --dirty` doesn't consider untracked files to be
 dirty
References: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
        <xmqqh7s8z0qw.fsf@gitster.c.googlers.com>
        <20200908231652.GC1014@pug.qqx.org>
        <xmqqo8m1k542.fsf@gitster.c.googlers.com>
        <xmqq5z89i5j3.fsf@gitster.c.googlers.com>
Date:   Sat, 19 Sep 2020 19:12:20 -0700
In-Reply-To: <xmqq5z89i5j3.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 19 Sep 2020 18:46:40 -0700")
Message-ID: <xmqq1rixi4cb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B72FAF50-FAE6-11EA-B7BA-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The first step would be to allow those who want their "git describe
> --dirty --ignore=none" (untracked files are counted as dirtiness, to
> be consistent with how "git diff" sees submodule directories by
> default) to use presence of untracked files as dirty.  This is a
> safe first step and can be done without breaking any existing users.

It is worse than I thought.  There is zero-th step we need to have,
to fix "git describe --dirty" itself.

Because the command internally uses "diff-index", and by default it
considers that a submodule with untracked path *is* dirty.  Because
of that, you get an inexplicable inconsistent behaviour.

 * If you start from a pristine checkout, and then add an untracked
   path to the current project, "git describe --dirty" won't give
   the -dirty suffix.

 * But if you add an untracked path in its submodule, the command
   does give you the -dirty suffix.

A fix, without the first-step to give the command configurable
definition of what makes a repository 'dirty', would probably look
like the attached untested patch.  A fix to "diff" machinery to make
"--ignore-submodules=untracked" the default would also make "describe"
internally consistent, too.

 builtin/describe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7668591d57..af08d7d8cf 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -45,7 +45,7 @@ static struct commit_names commit_names;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
-	"diff-index", "--quiet", "HEAD", "--", NULL
+	"diff-index", "--quiet", "--ignore-submodules=untracked", "HEAD", "--", NULL
 };
 
 struct commit_name {

   
