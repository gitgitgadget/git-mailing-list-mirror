Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E513C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 10:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKUKoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUKo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 05:44:29 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B375175D83
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 02:44:27 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 765021F910;
        Mon, 21 Nov 2022 10:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1669027467;
        bh=K6mCVFCriPlpEXx81bb5gPbQ9vUToE9zfuReLU7pD7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoxBmTrsLaTYlMtqIpSRNiynMuD+Uc6RZiVOq7vkkQrvYoNv3rMh84vgatQ0Ntwlm
         qZ+pA8HIjXXG3yFoxCTqL/+OY0xI3uNG2Vf2+wxdPJi/XCLK8kUmoqqqAB7rFDqex9
         WFdx64O9yGWjNQmvA3M499bBR3T7TyU9Xmw+2ts4=
Date:   Mon, 21 Nov 2022 10:44:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: quiet ENOENT on missing directories
Message-ID: <20221121104427.M268307@dcvr>
References: <20221119201213.2398081-1-e@80x24.org>
 <xmqq5yf8yhe0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yf8yhe0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > $GIT_DIR/objects/pack may be removed to save inodes in shared
> > repositories.  Quiet down prune in cases where either
> > $GIT_DIR/objects or $GIT_DIR/objects/pack is non-existent,
> 
> Wouldn't setup.c::is_git_directory() say "nope, you do not have a
> repository there" if you are missing $GIT_DIR/objects?  So I suspect
> that the only case this matters in practice is a missing pack/
> subdirectory.

Right.  Removing $GIT_DIR/objects isn't currently OK, but maybe
someday it could be...  Supporting missing pack/ is the primary
reason for this change, but making a small step towards allowing
objects/-free $GIT_DIR doesn't seem harmful.

> I agree that silently ignoring missing objects/pack/ is perfectly
> fine, whether we auto-vivify it when we actually create a pack.
> 
> > but emit the system error in other cases to help users diagnose
> > permissions problems or resource constraints.
> 
> OK.
> 
> > @@ -127,7 +127,9 @@ static void remove_temporary_files(const char *path)
> >  
> >  	dir = opendir(path);
> >  	if (!dir) {
> > -		fprintf(stderr, "Unable to open directory %s\n", path);
> > +		if (errno != ENOENT)
> > +			fprintf(stderr, "Unable to open directory %s: %s\n",
> > +				path, strerror(errno));
> >  		return;
> >  	}
> 
> This is called twice, with $GIT_OBJECT_DIRECTORY and its pack
> subdirectory, as it does not recurse.  

Right.

> This is a tangent, I have to wonder how effective the first call
> would be, though.  When writing a loose object file, we compute its
> object name first in-core and determine the final filename, create a
> temporary file in the same directory as the final file, write into
> it and then finally rename the temporary to the final name.  The
> fan-out $GIT_OBJECT_DIRECTORY/??/ directories may have temporary
> files left when such a process crashed, but do we create cruft "git
> prune" should remove in $GIT_OBJECT_DIRECTORY/ itself?

Good question, perhaps this could be a followup:

diff --git a/builtin/prune.c b/builtin/prune.c
index 2719220108..041c45ecbe 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -188,7 +188,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 				      prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
-	remove_temporary_files(get_object_directory());
 	s = mkpathdup("%s/pack", get_object_directory());
 	remove_temporary_files(s);
 	free(s);

OTOH, perhaps there's some 3rd-party tools (e.g. backup tools)
that leave stuff in top-level objects/ and we'd risk breaking
a rare setup via ENOSPC.
