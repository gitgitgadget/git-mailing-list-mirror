Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D0C433EF
	for <git@archiver.kernel.org>; Sun,  1 May 2022 05:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbiEAFUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 01:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbiEAFUo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 01:20:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A245C758
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 22:17:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EE5819A4B6;
        Sun,  1 May 2022 01:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=f
        J/WntmQnig+COWvuyL/yeBCyyd5au86kAH/zLzQ/dc=; b=ttdb9BsC6HpsPMkvN
        WL/w/FSphWJnO3bKH6Jrw4wEolPZmFde7VXgv2uw63S/H09nGygGSb7mWQXgCFJ0
        QYVKtp5/btuGICsq6yrWRydgcWvbt4fdTjWtInGPWYiWEwrXxUk3ApJP/xjg32Mh
        j64fUINTIbO86rMeNEGjXYKWfs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27D8119A4B5;
        Sun,  1 May 2022 01:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A7ED619A4B4;
        Sun,  1 May 2022 01:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] clone: plug a miniscule leak
Date:   Sat, 30 Apr 2022 22:17:15 -0700
Message-ID: <xmqqlevl4ysk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F793875A-C90D-11EC-B361-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The remote_name variable is first assigned a copy of the value of
the "clone.defaultremotename" configuration variable and then by the
value of the "--origin" command line option.  The former is prepared
to see multiple instances of the variable by freeing the current
value of the variable before a copy of the newly discovered value
gets assigned to it.  The latter blindly assigned a copy of the new
value to it, thereby leaking the value read from the configuration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    This was discovered by a recently removed bogus coccinelle
    rewrite rule---if you apply an incorrect change suggested by the
    bogus rewrite rule to unconditionally assign to remote_name a
    copy of option_origin, or NULL, the value read from the
    configuration would be lost and never be used, thereby breaking
    a test to ensure the configuration is used, instead of the
    default remote nickname "origin".

    Perhaps a Coccinelle rule like this might have caught similar
    leaks:

	@@
	expression E;
	expression V;
	@@
	- if (E)
	-   V = xstrdup(E);
	+ if (E) {
	+   free(V);
	+   V = xstrdup(E);
	+ }

    The fact that the result of xstrdup() is assigned to V is that V
    is meant to hold a pointer to an allocated piece of memory.

    With the preimage of the above semantic patch, it is reasonable
    to expect that V may be initialized to NULL or may be holding a
    pointer to a piece of allocated memory when the control reaches
    here, because otherwise, V will be either need to be freed (when
    E was not NULL, in which case we assigned the result of
    xstrdup() to it) or V has garbage that cannot be freed later.
   
 builtin/clone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/builtin/clone.c w/builtin/clone.c
index 5231656379..194d50f75f 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -1106,8 +1106,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
 	 */
-	if (option_origin != NULL)
+	if (option_origin != NULL) {
+		free(remote_name);
 		remote_name = xstrdup(option_origin);
+	}
 
 	if (remote_name == NULL)
 		remote_name = xstrdup("origin");
