Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA03DC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 05:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD3720707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 05:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgA3Fvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:51:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:48114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725847AbgA3Fvh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 00:51:37 -0500
Received: (qmail 21176 invoked by uid 109); 30 Jan 2020 05:51:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 05:51:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20997 invoked by uid 111); 30 Jan 2020 05:59:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 00:59:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 00:51:36 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] diff: only prefetch for certain output formats
Message-ID: <20200130055136.GA2184413@coredump.intra.peff.net>
References: <20200129050935.GA601903@coredump.intra.peff.net>
 <20200130013900.181477-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130013900.181477-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 05:39:00PM -0800, Jonathan Tan wrote:

> > You could get pretty specific by putting logic inside diffcore_rename(),
> > which would know if anything is left over after exact rename detection,
> > but I suspect just checking:
> > 
> >   (options->break_opt != -1 || options->detect_rename)
> > 
> > in diffcore_std() would be OK in practice.
> 
> Thanks for taking a look at this patch and for the pointers, especially
> to rename detection. I investigated and found that in practice, with
> respect to rename detection, options->detect_rename is insufficient to
> determine exactly when we need to fetch; we need to fetch when
> (for example) a file is deleted and another added, but not when a file
> is merely changed, and these rules are not reflected in
> options->detect_rename. These rules indeed are in diffcore_rename(), as
> you mentioned, but putting logic inside diffcore_rename() (or copying
> the same logic over to diffcore_std()) complicates things for too little
> benefit, I think.
> 
> To add to this, rename detection is turned on by default, so it wouldn't
> even fix the original issue with "status".
> 
> So I'll abandon this patch, at least until someone finds a use case for
> diffing with no rename detection on a partial clone and would rather not
> have a prefetch.

Ah, true, "options->detect_rename" would be overly broad.

I actually don't think it would be that bad to put the logic in
diffcore_rename(). If we wait until the right moment (after inexact
renames have been resolved, and when we see if there are any candidates
left), it should just be a matter of walking over the candidate lists.

Something like this (it would need the add_if_missing() helper from
diffcore_std()):

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 531d7adeaf..d519ffcc45 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -458,6 +458,7 @@ void diffcore_rename(struct diff_options *options)
 	int i, j, rename_count, skip_unmodified = 0;
 	int num_create, dst_cnt;
 	struct progress *progress = NULL;
+	struct oid_array to_fetch = OID_ARRAY_INIT;
 
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
@@ -538,6 +539,25 @@ void diffcore_rename(struct diff_options *options)
 		break;
 	}
 
+	/*
+	 * At this point we know there's actual work to do: we have rename
+	 * destinations that didn't find an exact match, and we have potential
+	 * sources. So we'll have to do inexact rename detection, which
+	 * requires looking at the blobs. It's worth pre-fetching them as a
+	 * group now.
+	 */
+	for (i = 0; i < rename_dst_nr; i++) {
+		if (rename_dst[i].pair)
+			continue; /* already found exact match */
+		add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
+	}
+	for (i = 0; i < rename_src_nr; i++) {
+		add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);
+	}
+	if (to_fetch.nr)
+		promisor_remote_get_direct(options->repo,
+					   to_fetch.oid, to_fetch.nr);
+
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
