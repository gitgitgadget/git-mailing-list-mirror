Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A251C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 08:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiJZI5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 04:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiJZI5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 04:57:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5189B84B
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 01:57:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF8CD22055
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666774621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVurcytagxdx7k4guAtd5drKRItACGvEgaqQCKY0MfU=;
        b=HeZRT00Of4nMdwukRltBHzG3+e50fCefpJIKmEmjB2BLtoT9igjyvSc+HTlzqYVz9e2DQs
        AnI8mLSqY3Y+O/cdFn2XlmMnl95ijB5mSFg1N55Pw7OYkvMTKPZuM9hHPT4bPonxK74OsL
        HTUNhZoS/tSBmGlfuAWSN+uuF88NWO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666774621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVurcytagxdx7k4guAtd5drKRItACGvEgaqQCKY0MfU=;
        b=0nQuOFkfpEHElCG+OiTnyOPk4pZamQoxTgzvM0A5VOndgK40n8sUj6QAgAv9aqQmJarMTy
        GnbD7H/BSLFPhoAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C252B2C141
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:57:01 +0000 (UTC)
Date:   Wed, 26 Oct 2022 10:57:00 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH] apply: Allow creating files with git patches
Message-ID: <20221026085700.GC28810@kitsune.suse.cz>
References: <20221026083204.21333-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026083204.21333-1-msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

looking closer the patch really is malformed:

--------- series --------
newfile.patch -p2
----- newfile.patch -----
Patch description

diff --git a/someproject/uselesss.c b/someproject/uselesss.c
new file mode 100644
--- /dev/null
+++ b/uselesss.c
@@ -0,0 +1,3 @@
+/*
+ * This patch creates a useless file
+ */
-------------------------

Not sure if it is desirable to handle better, and if there is even a
better way.

Thanks

Michal


On Wed, Oct 26, 2022 at 10:32:04AM +0200, Michal Suchanek wrote:
> In git 2.38.0 it is not possible to create a file with apply when the diff
> looks like git diff.
> 
> It either complains that the source file is not /dev/null or that it is
> not the same as the destination.
> 
> something.patch
> No author found in something.patch
> ---
> Sometext
> 
> Author: A. U. Thor <au@thor.com>
> gitdiff_verify_name: line: b/somefile.c
> @@ -0,0 +1,379 @@
> +/*
> ...
> , isnull: 0, *name: somefile.c, side: 1, another: (null)
> error: git apply: bad git-diff - inconsistent new filename on line 80
> 
> something.patch
> No author found in something.patch
> ---
> Sometext
> 
> Author: A. U. Thor <au@thor.com>
> gitdiff_verify_name: line: a/somefile.c
> +++ b/somefile.c
> @@ -0,0 +1,379 @@
> +/*
> ...
> , isnull: 1, *name: (null), side: 0
> error: git apply: bad git-diff - expected /dev/null on line 80
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  apply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/apply.c b/apply.c
> index 2b7cd930ef..9dd01da271 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -928,7 +928,7 @@ static int gitdiff_verify_name(struct gitdiff_data *state,
>  			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
>  				     *name, state->linenr);
>  		another = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
> -		if (!another || strcmp(another, *name)) {
> +		if (another && strcmp(another, *name)) {
>  			free(another);
>  			return error((side == DIFF_NEW_NAME) ?
>  			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
> -- 
> 2.38.0
> 
