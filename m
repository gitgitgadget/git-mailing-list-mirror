Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782F3C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJVALQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJVALL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:11:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84192582F8
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:11:10 -0700 (PDT)
Received: (qmail 15140 invoked by uid 109); 22 Oct 2022 00:11:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:11:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18807 invoked by uid 111); 22 Oct 2022 00:11:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:11:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:11:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/4] repack: use tempfiles for signal cleanup
Message-ID: <Y1M1HFbmygJDZWYh@coredump.intra.peff.net>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MTJz3wy5xDEPEH@coredump.intra.peff.net>
 <xmqqmt9oizcq.fsf@gitster.g>
 <Y1MqPjnYoWcOgXo6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MqPjnYoWcOgXo6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 07:24:46PM -0400, Jeff King wrote:

> > > @@ -1020,14 +1011,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> > >  			fname_old = mkpathdup("%s-%s%s",
> > >  					packtmp, item->string, exts[ext].name);
> > >  
> > > -			if (data->exts[ext]) {
> > > +			if (data->tempfiles[ext]) {
> > >  				struct stat statbuffer;
> > >  				if (!stat(fname_old, &statbuffer)) {
> > >  					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
> > >  					chmod(fname_old, statbuffer.st_mode);
> > >  				}
> > >  
> > > -				if (rename(fname_old, fname))
> > > +				if (rename_tempfile(&data->tempfiles[ext], fname))
> > >  					die_errno(_("renaming '%s' failed"), fname_old);
> > 
> > It now got a bit confusing that we have 'fname', 'fname_old', and
> > the tempfile.  The path.buf used as the argument to register_tempfile()
> > matches what is used to compute fname_old above.  I wonder if tempfile
> > API does not give us that name so that we can stop using fname_old here?
> 
> It does, and we probably should use get_tempfile_path() in the error
> message here.

Gah, this is not quite true. If the rename fails, we clean up the
tempfile struct entirely, and that invalidates the pointer. I think it
is OK to just report "fname" in this case, though, which is what most
callers do. Arguably the tempfile API should leave the tempfile in place
on a failed rename, letting the callers decide themselves how to handle
things. In most cases they'll just exit anyway, which will clean up the
tempfile.

I also didn't notice that we do some mode-twiddling on fname_old. But I
think if the code becomes (inside this conditional block, once we stop
using it in the other half):

  const char *fname_old = get_tempfile_path(data->tempfiles[ext]);

then those lines don't even need to change.

-Peff
