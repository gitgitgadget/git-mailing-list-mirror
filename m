Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8605F1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 23:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbcHZXNm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 19:13:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:57466 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754720AbcHZXNl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 19:13:41 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP; 26 Aug 2016 16:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,583,1464678000"; 
   d="scan'208";a="1047844866"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2016 16:13:22 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     jacob.keller@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        jacob.e.keller@intel.com, peff@peff.net, sbeller@google.com,
        stefanbeller@gmail.com
Subject: Re: [PATCH v11 0/8] submodule inline diff format
Date:   Fri, 26 Aug 2016 16:13:20 -0700
Message-Id: <20160826231320.7038-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
In-Reply-To: <CA+P7+xpvtdoeK3uiSGAeNzQaYQhS7p0WT+nCcfKAS7FauFNftQ@mail.gmail.com>
References: <CA+P7+xpvtdoeK3uiSGAeNzQaYQhS7p0WT+nCcfKAS7FauFNftQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

> On Fri, Aug 26, 2016 at 1:04 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, Aug 26, 2016 at 07:58:07PM +0000, Keller, Jacob E wrote:
> >
> >> > >  char *git_pathdup_submodule(const char *path, const char *fmt,
> >> > > ...)
> >> > >  {
> >> > > +       int err;
> >> > >         va_list args;
> >> > >         struct strbuf buf = STRBUF_INIT;
> >> > >         va_start(args, fmt);
> >> > > -       do_submodule_path(&buf, path, fmt, args);
> >> > > +       err = do_submodule_path(&buf, path, fmt, args);
> >> > >         va_end(args);
> >> > > +       if (err)
> >> >
> >> > Here we need a strbuf_release(&buf) to avoid a memory leak?
> >>
> >> No, cause we "strbuf_detach" after this to return the buffer? Or is
> >> that not safe?
> >
> > That code path is OK. I think the question is whether you need to
> > release the buffer in the "err" case where you return NULL and don't hit
> > the strbuf_detach.
> >
> > IOW, does do_submodule_path() promise that when it returns an error,
> > "buf" has been left uninitialized? Some of our strbuf functions do, but
> > I do not know offhand about do_submodule_path().
> >
> > -Peff
> 
> We probably should release for the error case. I'll do that. I don't
> believe do_submodule_path ensures that the passed in argument is
> guaranteed to not be initialized or used.
> 
> Thanks,
> Jake

Here's the squash for this fix.

Thanks,
Jake

---------->8

From Jacob Keller <jacob.keller@gmail.com>
From 9cf89634e6f2b0f3f90f43a553f55eb57bb2f662 Mon Sep 17 00:00:00 2001
From: Jacob Keller <jacob.keller@gmail.com>
Date: Fri, 26 Aug 2016 16:06:54 -0700
Subject: [PATCH] squash! allow do_submodule_path to work even if submodule
 isn't checked out

Add a missing strbuf_release() when returning during the error flow of
git_pathdup_submodule().

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 path.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/path.c b/path.c
index e9369f75319d..b8515973252c 100644
--- a/path.c
+++ b/path.c
@@ -525,8 +525,10 @@ char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 	va_start(args, fmt);
 	err = do_submodule_path(&buf, path, fmt, args);
 	va_end(args);
-	if (err)
+	if (err) {
+		strbuf_release(&buf);
 		return NULL;
+	}
 	return strbuf_detach(&buf, NULL);
 }
 
-- 
2.10.0.rc0.259.g83512d9

