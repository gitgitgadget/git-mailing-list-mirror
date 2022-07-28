Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B2C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiG1R3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1R3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:29:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FB354AC4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:29:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0A9314D588;
        Thu, 28 Jul 2022 13:29:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n/ICOl/da7HPTqKiUgaPTyjLKMdXDXmhBQMNva
        ChIA4=; b=sLm90EJD99z7Ue9AONA76G0Xq3x9HhORubEZIsIKaN6WfD6M8x4e0k
        ly4ZSO8Qm8SHqphR56O6L1RwpwjlU6dy1SWnXxy3/QSsShbyjWl6weji3xi+Z+F5
        SoHrBlVAduVThD9/UXoQAOsHaDCnjOrrLPjFiKov5Yn4MkG7zxiVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B704A14D587;
        Thu, 28 Jul 2022 13:29:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17FE214D586;
        Thu, 28 Jul 2022 13:29:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: include the Python parts in the build
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
Date:   Thu, 28 Jul 2022 10:29:46 -0700
In-Reply-To: <pull.1306.git.1659016906707.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 28 Jul 2022 14:01:46
        +0000")
Message-ID: <xmqqczdpcfhx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1026362-0E9A-11ED-8510-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> While Git for Windows does not _ship_ Python (in order to save on
> bandwidth), MSYS2 provides very fine Python interpreters that users can
> easily take advantage of, by using Git for Windows within its SDK.

It may be an accurate description of the world and there may not be
anything incorrect in the above statement, but it took quite an
effort to try matching that statement to what the patch does.

I think

    Builds on $uname_S==MINGW by default sets NO_PYTHON=YesPlease
    and it benefits Git for Windows by allowing to omit Python.
    However, when "Git for Windows" is used within MSYS2's SDK, we
    can allow users to take advantage of Python interpreter that
    comes with it.  Override NO_PYTHON when the presence of
    ../THIS_IS_MSYSGIT indicates that we are in that situation.

is how the logic in this patch can be explained, but I have to
wonder if a more natural and easier-to-understand solution is to
move NO_PYTHON=YesPlease into "if we do not have ../THIS_IS_MSYSGIT,
do these things" ifneq() block, like the attached patch.

I didn't touch it but NO_GETTEXT does not appear in the common
section above "do we have ../THIS_IS_MSYSGIT?", and gets set 
after "we do not have ../THIS_IS_MSYSGIT", so I do not think
we need "NO_GETTEXT = " that clears it in the "we do have
../THIS_IS_MSYSGIT" part.  We may want to see if there are other
things that needs cleaning up around this area.

 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/config.mak.uname w/config.mak.uname
index ce83cad47a..999a7ae270 100644
--- i/config.mak.uname
+++ w/config.mak.uname
@@ -656,7 +656,6 @@ ifeq ($(uname_S),MINGW)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
-	NO_PYTHON = YesPlease
 	ETAGS_TARGET = ETAGS
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
@@ -686,6 +685,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
+	NO_PYTHON = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS
 else
 	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
