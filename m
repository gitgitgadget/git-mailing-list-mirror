Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F38C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356598AbiELVbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 17:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358721AbiELVbV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 17:31:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4391393C1
        for <git@vger.kernel.org>; Thu, 12 May 2022 14:31:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02D6319BC4A;
        Thu, 12 May 2022 17:31:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZkydM1NsIpaiiyJco3iRVICGW9nJk4ugXYdZ2I
        RUJ9U=; b=Icc4ltb3VU+C+ekmqJaIP3+xlfAmNhMenjiiXuxjqomdGMdiUhX8ao
        Gs2TStYaT+ms9WJo3D/0YblPXs9087Aep4bOVWm+gPZMoUve+R1t7/is2SbJHWer
        rU5m9/JxoOg0FThhFzoSBNtZU+wAzrtBnUr0JJipAgDjS3OkMk0ag=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EEADC19BC49;
        Thu, 12 May 2022 17:31:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D701C19BC48;
        Thu, 12 May 2022 17:31:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     rsbecker@nexbridge.com,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Johannes Schindelin' <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/7] archive: optionally add "virtual" files
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
        <xmqqtu9x6ovh.fsf@gitster.g>
        <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
        <xmqq8rr955zf.fsf@gitster.g>
        <3cf6e4f8-9151-6d68-21ca-b94d6a7557e6@web.de>
        <xmqqzgjnkgy0.fsf@gitster.g>
        <47ed5a2f-f4aa-1ec1-27c9-9b0b70eb8bca@web.de>
        <xmqqfslefwie.fsf@gitster.g>
Date:   Thu, 12 May 2022 14:31:09 -0700
In-Reply-To: <xmqqfslefwie.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        12 May 2022 11:15:05 -0700")
Message-ID: <xmqqmtfme8v6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D79D3816-D23A-11EC-995C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> So we currently leak permission bits of executable files into ZIP
>> archives, but not tar files. :-|  Normalizing those to 0755 would be
>> more consistent.

Today, I was scanning the "What's cooking" draft and saw too many
topics that are marked with "Expecting a reroll".  It turns out that
this "mode bits" thing will not be a blocker to make us wait for a
reroll of the topic, so let's handle it separately, before we
forget, as an independent fix outside the series under discussion.

Thanks.

--- >8 ---
Subject: [PATCH] archive: do not let on-disk mode leak to zip archives

When the "--add-file" option is used to add the contents from an
untracked file to the archive, the permission mode bits for these
files are sent to the archive-backend specific "write_entry()"
method as-is.  We normalize the mode bits for tracked files way
before we pass them to the write_entry() method; we should do the
same here.

This is not strictly needed for "tar" archive-backend, as it has its
own code to further clean them up, but "zip" archive-backend is not
so well prepared.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index e29d0e00f6..12a08af531 100644
--- a/archive.c
+++ b/archive.c
@@ -342,7 +342,7 @@ int write_archive_entries(struct archiver_args *args,
 		else
 			err = write_entry(args, &fake_oid, path_in_archive.buf,
 					  path_in_archive.len,
-					  info->stat.st_mode,
+					  canon_mode(info->stat.st_mode),
 					  content.buf, content.len);
 		if (err)
 			break;
-- 
2.36.1-338-g1c7f76a54c

