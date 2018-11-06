Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07B11F453
	for <e@80x24.org>; Tue,  6 Nov 2018 19:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeKGFSY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 00:18:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:42660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725975AbeKGFSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 00:18:24 -0500
Received: (qmail 12614 invoked by uid 109); 6 Nov 2018 19:51:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 19:51:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3316 invoked by uid 111); 6 Nov 2018 19:50:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 14:50:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 14:51:32 -0500
Date:   Tue, 6 Nov 2018 14:51:32 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] send-pack: set core.warnAmbiguousRefs=false
Message-ID: <20181106195131.GA5289@sigill.intra.peff.net>
References: <pull.68.git.gitgitgadget@gmail.com>
 <20181106194442.GB8902@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106194442.GB8902@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 02:44:42PM -0500, Jeff King wrote:

> > The fix for this is simple: set core.warnAmbiguousRefs to false for this
> > specific call of git pack-objects coming from git send-pack. We don't want
> > to default it to false for all calls to git pack-objects, as it is valid to
> > pass ref names instead of object ids. This helps regain these seconds during
> > a push.
> 
> I don't think you actually care about the ambiguity check between refs
> here; you just care about avoiding the ref check when we've seen (and
> are mostly expecting) a 40-hex sha1. We have a more specific flag for
> that: warn_on_object_refname_ambiguity.
> 
> And I think it would be OK to enable that all the time for pack-objects,
> which is plumbing that does typically expect object names. See prior art
> in 25fba78d36 (cat-file: disable object/refname ambiguity check for
> batch mode, 2013-07-12) and 4c30d50402 (rev-list: disable object/refname
> ambiguity check with --stdin, 2014-03-12).

I'd probably do it here:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e50c6cd1ff..d370638a5d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3104,6 +3104,7 @@ static void get_object_list(int ac, const char **av)
 	struct rev_info revs;
 	char line[1000];
 	int flags = 0;
+	int save_warning;
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
@@ -3112,6 +3113,9 @@ static void get_object_list(int ac, const char **av)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	save_warning = warn_on_object_refname_ambiguity;
+	warn_on_object_refname_ambiguity = 0;
+
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
 		if (len && line[len - 1] == '\n')
@@ -3138,6 +3142,8 @@ static void get_object_list(int ac, const char **av)
 			die(_("bad revision '%s'"), line);
 	}
 
+	warn_on_object_refname_ambiguity = save_warning;
+
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
 		return;
 

But I'll leave it to you to wrap that up in a patch, since you probably
should re-check your timings (which it would be interesting to include
in the commit message, if you have reproducible timings).

-Peff
