Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6D21F453
	for <e@80x24.org>; Thu, 17 Jan 2019 17:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfAQRAI (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 12:00:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:39974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728649AbfAQRAI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 12:00:08 -0500
Received: (qmail 32127 invoked by uid 109); 17 Jan 2019 17:00:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Jan 2019 17:00:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2268 invoked by uid 111); 17 Jan 2019 17:00:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 17 Jan 2019 12:00:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2019 12:00:06 -0500
Date:   Thu, 17 Jan 2019 12:00:06 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH/RFC] fsck: complain when .gitignore and .gitattributes
 are symlinks
Message-ID: <20190117170005.GA27667@sigill.intra.peff.net>
References: <20190114230902.GG162110@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114230902.GG162110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 14, 2019 at 03:09:02PM -0800, Jonathan Nieder wrote:

> From: Jeff King <peff@peff.net>
> Date: Sun, 13 May 2018 14:14:34 -0400
> 
> This case is already forbidden by verify_path(), so let's
> check it in fsck. It's easier to handle than .gitmodules,
> because we don't care about checking the blob content. This
> is really just about whether the name and mode for the tree
> entry are valid.

Hmm. I think this commit message isn't quite right, because we also
skipped the patches to touch gitignore/gitattributes in verify_path().

Are you thinking we should resurrect that behavior[1], too, or just
protect at the fsck level?

> It was omitted from that series because it does not address any known
> exploit, but to me it seems worthwhile anyway:
> 
> - if a client enables transfer.fsckObjects, this helps them protect
>   themselves against weird input that does *not* have a known exploit
>   attached, to
> 
> - it generally feels more simple and robust.  Git-related tools can
>   benefit from this kind of check as an indication of input they can
>   bail out on instead of trying to support.

I think I may just be restating your two points above, but what I'd
argue is:

  - even though there's no known-interesting exploit, this can cause Git
    to unexpectedly read arbitrary files outside of the repository
    directory. That in itself isn't necessarily evil, but it's weird.

  - there are potentially non-malicious bugs here, where we try to read
    .gitattributes out of the index, but obviously don't follow symlinks
    there

-Peff

[1] This wasn't a separate patch, but just an early iteration of the
    "ban symlinks in .gitmodules" patch. I think the incremental is
    just:

diff --git a/read-cache.c b/read-cache.c
index bfff271a3d..121c0bec69 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -937,7 +937,9 @@ static int verify_dotfile(const char *rest, unsigned mode)
 			return 0;
 		if (S_ISLNK(mode)) {
 			rest += 3;
-			if (skip_iprefix(rest, "modules", &rest) &&
+			if ((skip_iprefix(rest, "modules", &rest) ||
+			     skip_iprefix(rest, "ignore", &rest) ||
+			     skip_iprefix(rest, "attributes", &rest)) &&
 			    (*rest == '\0' || is_dir_sep(*rest)))
 				return 0;
 		}
@@ -966,7 +968,9 @@ int verify_path(const char *path, unsigned mode)
 				if (is_hfs_dotgit(path))
 					return 0;
 				if (S_ISLNK(mode)) {
-					if (is_hfs_dotgitmodules(path))
+					if (is_hfs_dotgitmodules(path) ||
+					    is_hfs_dotgitignore(path) ||
+					    is_hfs_dotgitattributes(path))
 						return 0;
 				}
 			}
@@ -974,7 +978,9 @@ int verify_path(const char *path, unsigned mode)
 				if (is_ntfs_dotgit(path))
 					return 0;
 				if (S_ISLNK(mode)) {
-					if (is_ntfs_dotgitmodules(path))
+					if (is_ntfs_dotgitmodules(path) ||
+					    is_ntfs_dotgitignore(path) ||
+					    is_ntfs_dotgitattributes(path))
 						return 0;
 				}
 			}
