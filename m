Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61CC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbiFPE3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiFPE3q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:29:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0F5AA40
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:29:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FDDC128998;
        Thu, 16 Jun 2022 00:29:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bhFSAOhLmijatrBbZxUsA4s/CZOsoNfZjOzkBJ
        Dn+B0=; b=Cwkug97pfGUyXNiuueXx9az2ndMmStuW5eatXR+dcLPXxA2WEpEUeg
        P7b3ZYnT28mW35xtOBkdLVdjjVMy/Q+o17sDtWY0fWoCi63uv/jgpttdtgO8qouK
        tedgWEqjo95IPoYQkO57C41tl9NF+sHa9jLdUf9opqRK2tyG15Zzk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 063C7128997;
        Thu, 16 Jun 2022 00:29:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 685B3128996;
        Thu, 16 Jun 2022 00:29:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/11] get_oid_with_context_1(): avoid use-after-free
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <cf6bcdb43e5b4abab464c30a914d64dc8e7a9925.1655336146.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 21:29:43 -0700
In-Reply-To: <cf6bcdb43e5b4abab464c30a914d64dc8e7a9925.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:38 +0000")
Message-ID: <xmqqy1xxw7rc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2802AFA-ED2C-11EC-8C98-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  			if (ce_stage(ce) == stage) {
> -				free(new_path);
>  				if (reject_tree_in_index(repo, only_to_die, ce,
> -							 stage, prefix, cp))
> +							 stage, prefix, cp)) {
> +					free(new_path);
>  					return -1;
> +				}
>  				oidcpy(oid, &ce->oid);
>  				oc->mode = ce->ce_mode;
> +				free(new_path);
>  				return 0;
>  			}

Hmph.  Without the "lets make sure we do not leak in the error code
path", it would have been no brainer to avoid this bug in the
original version.  Of course the postimage of the above hunk is
correct, but with extra free() sprinkled, it became ugly to the eye.

I wonder if the following is easier to follow.

Thanks.

 object-name.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git c/object-name.c w/object-name.c
index 4d2746574c..57188db7b0 100644
--- c/object-name.c
+++ w/object-name.c
@@ -1971,13 +1971,16 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
+				int ret = -1;
+
+				if (!reject_tree_in_index(repo, only_to_die, ce,
+							  stage, prefix, cp)) {
+					oidcpy(oid, &ce->oid);
+					oc->mode = ce->ce_mode;
+					ret = 0;
+				}
 				free(new_path);
-				if (reject_tree_in_index(repo, only_to_die, ce,
-							 stage, prefix, cp))
-					return -1;
-				oidcpy(oid, &ce->oid);
-				oc->mode = ce->ce_mode;
-				return 0;
+				return ret;
 			}
 			pos++;
 		}
