Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC0220372
	for <e@80x24.org>; Thu, 12 Oct 2017 13:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756721AbdJLN1d (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 09:27:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:50896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755462AbdJLN1c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 09:27:32 -0400
Received: (qmail 15180 invoked by uid 109); 12 Oct 2017 13:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 13:27:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15527 invoked by uid 111); 12 Oct 2017 13:27:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 09:27:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 09:27:30 -0400
Date:   Thu, 12 Oct 2017 09:27:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Andreas Krey <a.krey@gmx.de>, Git Users <git@vger.kernel.org>
Subject: Re: git repack leaks disk space on ENOSPC
Message-ID: <20171012132730.bvglyiar4h6win4b@sigill.intra.peff.net>
References: <20171011150546.GC32090@inner.h.apk.li>
 <20171012031702.GB155740@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012031702.GB155740@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 08:17:03PM -0700, Jonathan Nieder wrote:

> I can imagine this behavior of retaining tmp_pack being useful for
> debugging in some circumstances, but I agree with you that it is
> certainly not a good default.
> 
> Chasing this down, I find:
> 
>   pack-write.c::create_tmp_packfile chooses the filename
>   builtin/pack-objects.c::write_pack_file writes to it and the .bitmap, calling
>   pack-write.c::finish_tmp_packfile to rename it into place
> 
> Nothing tries to install an atexit handler to do anything special to it
> on exit.
> 
> The natural thing, I'd expect, would be for pack-write to use the
> tempfile API (see tempfile.h) to create and finish the file.  That way,
> we'd get such atexit handlers for free.  If we want a way to keep temp
> files for debugging on abnormal exit, we could set that up separately as
> a generic feature of the tempfile API (e.g. an envvar
> GIT_KEEP_TEMPFILES_ON_FAILURE), making that an orthogonal topic.

Yes, I think this is the right direction. I've had a patch in GitHub's
fork for years that does so (since otherwise failures can fill up your
disk and need manual intervention).

The main reason that I hadn't submitted it upstream was because of the
"you can never free a struct tempfile" requirement. So my patch just
leaks the tempfile structs. That's OK for packs, of which we tend to
create only a few in a given process, but doesn't scale for loose
objects.

Now that 89563ec379 (Merge branch 'jk/incore-lockfile-removal',
2017-09-19) has landed, I think it makes sense to pursue that direction.

My patch roughly looks like:

  diff --git a/builtin/index-pack.c b/builtin/index-pack.c
  index 4ff567db47..7f261e56c4 100644
  --- a/builtin/index-pack.c
  +++ b/builtin/index-pack.c

  @@ -308,9 +348,11 @@ static const char *open_pack_file(const char *pack_name)
                  input_fd = 0;
                  if (!pack_name) {
                          struct strbuf tmp_file = STRBUF_INIT;
  +                       struct tempfile *t = xcalloc(1, sizeof(*t));
                          output_fd = odb_mkstemp(&tmp_file,
                                                  "pack/tmp_pack_XXXXXX");
                          pack_name = strbuf_detach(&tmp_file, NULL);
  +                       register_tempfile(t, pack_name);
                  } else {
                          output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
                          if (output_fd < 0)

but note that's not quite what we'd want. It never closes the tempfile,
so:

  1. Under the new regime, we'd still leak the struct!

  2. Git will still try to unlink the tempfile on exit, even if we
     successfully moved it into place.

So I think all the code around open_pack_file() needs to learn to pass
around the tempfile struct, and eventually use rename_tempfile() to
cement it in place. I also suspect that odb_mkstemp should just take a
"struct tempfile".

-Peff
