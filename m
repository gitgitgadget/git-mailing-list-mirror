Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD6FC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiHVToB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiHVTn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:43:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412B1EECB
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:43:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F35FD134AC0;
        Mon, 22 Aug 2022 15:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FTAEzYoBa0uQ
        qzJXHLWFavIFtF3ClOtMgq1Ar8LICng=; b=mb0u/R82eh655WzLWNlaauHkGciI
        xmPoGyfHOjqMd4/H1ZVSTPuss5gkaji3Vs9UjA0Co3K67RoTkkgkqc5YG9RppBCR
        N00e5zjMzpr4CCX2I0c936hvB/TTmymdRdFjNeNO1MCpwMOKSVVhB8/cu4Pvs7IC
        36oZg0UzZI7UcyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA3BA134ABF;
        Mon, 22 Aug 2022 15:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62019134ABE;
        Mon, 22 Aug 2022 15:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mohamed Akram <mohd.akram@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git diff prints long usage help if not run in git repo
References: <A2326287-9808-4479-95C5-E54979E21F95@outlook.com>
Date:   Mon, 22 Aug 2022 12:43:54 -0700
In-Reply-To: <A2326287-9808-4479-95C5-E54979E21F95@outlook.com> (Mohamed
        Akram's message of "Mon, 22 Aug 2022 18:22:21 +0000")
Message-ID: <xmqq5yikcbd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1E7401C-2252-11ED-894B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mohamed Akram <mohd.akram@outlook.com> writes:

> When running `git diff` in a directory that=E2=80=99s not a git repo, i=
t
> prints a warning that this is the case, followed by a very long
> help text that, on your average terminal, causes it to scroll so
> much that the warning isn=E2=80=99t even visible. It should only print
> the warning and nothing else like other git commands. This was
> tested with git version 2.37.2 on macOS.

Thanks for a clearly written feature request.  I think it is not
unreasonable to stop after telling the user to use the --no-index
option.

But on the other hand, not using "--no-index" is not what causes
such a "git diff" outside any repository fail.  If the user said

     $ cd / && git diff

it is clear that the user does not know they need to say what they
want to compare against what.  The reason why the command fails is
not because the user did not say

     $ cd / && git diff --no-index

but because the user did not say

     $ cd / && git diff --no-index etc/passwd etc/group

So, I dunno.

Perhaps somebody can try the following patch and tell us if it is an
improvement.  I know it is for the specific case "cd / && git diff"
but it really depends on the reason why (1) the command was run
outside any repository and why (2) the command was run without any
arguments.  A shallow answer to both of them are "by mistake", but
what I am trying to get at is that understanding the reason why such
a mistake was made is probably the key to evaluate if the behaviour
updated by the attached patch is a good idea.

Thanks.


 diff-no-index.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git c/diff-no-index.c w/diff-no-index.c
index 9a8b09346b..c8f2cdce05 100644
--- c/diff-no-index.c
+++ w/diff-no-index.c
@@ -259,9 +259,10 @@ int diff_no_index(struct rev_info *revs,
 			     diff_no_index_usage, 0);
 	if (argc !=3D 2) {
 		if (implicit_no_index)
-			warning(_("Not a git repository. Use --no-index to "
-				  "compare two paths outside a working tree"));
-		usage_with_options(diff_no_index_usage, options);
+			die(_("Not a git repository. Use --no-index to "
+			      "compare two paths outside a working tree"));
+		else
+			usage_with_options(diff_no_index_usage, options);
 	}
 	FREE_AND_NULL(options);
 	for (i =3D 0; i < 2; i++) {
