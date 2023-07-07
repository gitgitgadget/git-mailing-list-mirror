Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD92DEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 23:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGGXpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 19:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGXpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 19:45:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E632108
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 16:45:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55B7C2A81A;
        Fri,  7 Jul 2023 19:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Kg0ik8Fco8JKAal0Vyu6YnlET15l8YlRWQP7w
        gHxEo=; b=pWpp8O+XwAUyT5wI5nneyVK5XG7Raz5/rJMVDqtkUxY6CFcElaAoK5
        x5D63SWvJUTT2kDMcd3yOASnN+Dawx5OjX9qpP7mt259vmcFMbBtxebfvqtPcvKE
        ssbLHDDolTsUUmNg9HpwpWdgEGBx4fNKIKo1DW168klCpv7Guaapc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EA372A819;
        Fri,  7 Jul 2023 19:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E15732A818;
        Fri,  7 Jul 2023 19:45:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2alt] dir: do not feed path suffix to pathspec match
References: <20230707220457.3655121-1-gitster@pobox.com>
        <20230707220457.3655121-3-gitster@pobox.com>
Date:   Fri, 07 Jul 2023 16:45:32 -0700
In-Reply-To: <20230707220457.3655121-3-gitster@pobox.com> (Junio C. Hamano's
        message of "Fri, 7 Jul 2023 15:04:57 -0700")
Message-ID: <xmqqttuf70bn.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D78166E-1D20-11EE-83D4-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
>  * do_match_pathspec() calls match_pathspec_item() _after_ stripping
>    the common prefix "sub/" from the path, giving it "file", plus
>    the length of the common prefix (4-bytes), so that the pathspec
>    element "(attr:label)sub/" can be treated as if it were "(attr:label)".
>
> The last one is what breaks the match, as the pathspec subsystem
> ends up asking the attribute subsystem to find the attribute
> attached to the path "file".
> ...
> Update do_match_pathspec() so that it does not strip the prefix from
> the path, and always feeding the full pathname to match_pathspec_item().

Here is an alternative approach with a lot smaller code footprint.
Instead of teaching do_match_pathspec() not to strip the common
prefix from the pathname, we teach match_pathspec_item() how to
recover the original pathname before stripping, and use that when
calling match_pathspec_attrs() function.  The same trick is already
used in an earlier part of the same function, so even though it
looks somewhat dirty, it is unlikely that it would introduce
more breakage.

As the test part is the same, I'll just show the code change
relative to the 'master' branch.

I am undecided which one is better.

 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/dir.c w/dir.c
index a7469df3ac..635d1b058c 100644
--- c/dir.c
+++ w/dir.c
@@ -374,7 +374,7 @@ static int match_pathspec_item(struct index_state *istate,
 		return 0;
 
 	if (item->attr_match_nr &&
-	    !match_pathspec_attrs(istate, name, namelen, item))
+	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
 		return 0;
 
 	/* If the match was just the prefix, we matched */
