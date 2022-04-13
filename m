Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F86CC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 23:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiDMXxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiDMXxk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 19:53:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362994BBBC
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 16:51:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7242E128C52;
        Wed, 13 Apr 2022 19:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ucfuyydXCPEvd0UQ4UFMtsn791WqXnfrR/y2U
        72wCE=; b=w8VxzGdWjO5oztSVZQksGQeuhNnw4rXmSdQDhsxtWn/ZPqWaNxmWb5
        RT8+jnCX+5ox8KynSB8BiArOnivMSZP+hb3/uswDxlRHFf4Fp4pjVnwaT7sNp7/4
        rYVifHLsgUzdFyE4ZSbOGY6LXJKVWrYDq37iWqraaKj+MCmGUqdmg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67B1B128C51;
        Wed, 13 Apr 2022 19:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD5E2128C50;
        Wed, 13 Apr 2022 19:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Apr 2022, #03; Tue, 12)
References: <xmqq8rsab5do.fsf@gitster.g>
        <8698e468-5552-77a3-10c7-933affd98832@gmail.com>
Date:   Wed, 13 Apr 2022 16:51:15 -0700
In-Reply-To: <8698e468-5552-77a3-10c7-933affd98832@gmail.com> (Philippe
        Blain's message of "Tue, 12 Apr 2022 13:52:16 -0400")
Message-ID: <xmqqsfqg4k5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BF9F64A-BB84-11EC-8B38-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> This is quite a big behaviour change for some environments [1], so
> I would think maybe it deserves to be fully spelled out in the
> release notes for 2.36.0, instead of just referring readers to the
> release notes for the maintenance release, where they can read a
> full description only in the release notes for 2.30.3 ?

Makes sense.  Here is my quick-and-dirty first draft, based on the
design of the new escape hatch done by Derrick today.

diff --git c/Documentation/RelNotes/2.36.0.txt w/Documentation/RelNotes/2.36.0.txt
index 9f6dd3d868..f4c5e691bb 100644
--- c/Documentation/RelNotes/2.36.0.txt
+++ w/Documentation/RelNotes/2.36.0.txt
@@ -13,6 +13,15 @@ Backward compatibility warts
    top-level a partial clone, while submodules are fully cloned.  This
    behaviour is changed to pass the same filter down to the submodules.
 
+ * With the fixes for CVE-2022-24765 that are common with versions of
+   Git 2.30.4, 2.31.3, 2.32.2, 2.33.3, 2.34.3, and 2.35.3, Git has
+   been taught not to recognise repositories owned by other users, in
+   order to avoid getting affected by their config files and hooks.
+   You can list the path to the safe/trusted repositories that may be
+   owned by others on a multi-valued configuration variable
+   `safe.directory` to override this behaviour, or use '*' to declare
+   that you trust anything.
+
 
 Note to those who build from the source
 
@@ -397,8 +406,6 @@ Fixes since v2.35
    entry it moved.
    (merge b7f9130a06 vd/mv-refresh-stat later to maint).
 
- * Fix for CVE-2022-24765 has been merged up from 2.35.2 and others.
-
  * Other code cleanup, docfix, build fix, etc.
    (merge cfc5cf428b jc/find-header later to maint).
    (merge 40e7cfdd46 jh/p4-fix-use-of-process-error-exception later to maint).
