Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA8C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 05:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9388F6135F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 05:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhE1F7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 01:59:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56561 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhE1F7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 01:59:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B9C2C758B;
        Fri, 28 May 2021 01:57:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IytV5s1ZPr8k8QI9+R3G4w5Pssj+ggBxYCwtLE
        sYciU=; b=sEvcyKnViLbNaGyFaR5ZYRJaf8DCKp3QVx9QH+Ab2qJ+PySJk7bO14
        NiNkO17MYQieuoAO/V/9AmxBMLkLc/aQfVPOdKmGieBEL7ZuWXNnLRIhPEh6yGy2
        azlXKH9kglGnY7iN4nD9GQq6zEsDI8eH5Vec4Z5Ckf/8TliM/GG+8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1CCBC758A;
        Fri, 28 May 2021 01:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE029C7589;
        Fri, 28 May 2021 01:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Dietrich Epp <depp@moria.us>, Git List <git@vger.kernel.org>
Subject: Re: git rm --pathspec-from-file does not work in subdirectories
References: <CAKGua8U25GF=mC+vRARRY99ZgaHoUOA7vppmOUdWoeB=bf3NAA@mail.gmail.com>
        <xmqqlf7z78sb.fsf@gitster.g>
        <CAPig+cT6ztfUYjbsfFmYZ=UOcyk=9rFKqEuE=EE4y2rdBftGag@mail.gmail.com>
Date:   Fri, 28 May 2021 14:56:59 +0900
In-Reply-To: <CAPig+cT6ztfUYjbsfFmYZ=UOcyk=9rFKqEuE=EE4y2rdBftGag@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 28 May 2021 01:08:41 -0400")
Message-ID: <xmqqh7in7650.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8480FC14-BF79-11EB-A5FF-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 28, 2021 at 1:07 AM Junio C Hamano <gitster@pobox.com> wrote:
>> I wonder if the attached patch would make both issues better.
>
> The "attached patch" is missing.

Heh.  Something along this line, but I think pathspec-from-file
still needs a bit more work even with this patch.

 builtin/rm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/builtin/rm.c w/builtin/rm.c
index 8a24c715e0..a4a8a1ad8d 100644
--- c/builtin/rm.c
+++ w/builtin/rm.c
@@ -265,7 +265,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			     builtin_rm_usage, 0);
 
 	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD,
+		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
 	if (pathspec_from_file) {
@@ -273,7 +273,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
 
 		parse_pathspec_file(&pathspec, 0,
-				    PATHSPEC_PREFER_CWD,
+				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
 		die(_("--pathspec-file-nul requires --pathspec-from-file"));
