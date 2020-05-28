Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49337C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A13207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391584AbgE1XQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:16:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:59458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391508AbgE1XQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:16:23 -0400
Received: (qmail 32597 invoked by uid 109); 28 May 2020 23:16:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 May 2020 23:16:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19325 invoked by uid 111); 28 May 2020 23:16:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 19:16:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 19:16:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Steven Willis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Steven Willis <onlynone@gmail.com>
Subject: Re: [PATCH] doc: ls-tree paths do not support wildcards
Message-ID: <20200528231622.GB1267915@coredump.intra.peff.net>
References: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com>
 <xmqq4krz3edq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4krz3edq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 03:04:33PM -0700, Junio C Hamano wrote:

> The documentation does not say paths can be wildcards.  It allows a
> list of "patterns to match" and never says they are wildcards.
> 
> I think they take the traditional "leading paths" (i.e. by saying
> "git ls-tree HEAD t/", you can show all paths that are under t/,
> and is different from the "raw path" i.e. "git ls-tree HEAD t").

Hmm, that might be weird if we switch to the pathspec matching code,
because we're sort-of recursive and sort-of not. E.g.:

  $ mkdir -p one/two/three
  $ echo content >one/two/three/file
  $ git init && git add . && git commit -m foo

  $ git ls-tree HEAD
  040000 tree 8f303030860565e9c51101f993e1db4feb2792a7	one

  $ git ls-tree -r HEAD
  100644 blob d95f3ad14dee633a758d2e331151e950dd13e4ed	one/two/three/file

  git ls-tree HEAD one
  040000 tree 8f303030860565e9c51101f993e1db4feb2792a7	one

  $ git ls-tree HEAD one/
  040000 tree c89b49675f4ccf1d03f7c95b5f072566ce0d7f83	one/two

So the pathspec match triggers one level of recursion, which is unlike a
pathspec used with non-recursive diff:

  $ git diff-tree --root --abbrev HEAD
  6f4ed388a766b500bcf3bbd9877cc7213c76a959
  :000000 040000 0000000 8f30303 A	one
  
  $ git diff-tree --root --abbrev -r HEAD
  6f4ed388a766b500bcf3bbd9877cc7213c76a959
  :000000 100644 0000000 d95f3ad A	one/two/three/file
  
  $ git diff-tree --root --abbrev HEAD one
  6f4ed388a766b500bcf3bbd9877cc7213c76a959
  :000000 040000 0000000 8f30303 A	one
  
  $ git diff-tree --root --abbrev HEAD one/
  6f4ed388a766b500bcf3bbd9877cc7213c76a959
  :000000 040000 0000000 8f30303 A	one

I think we should be able to reuse the pathspec matching code, but we
may not be able to reuse other tree-walking bits. Or maybe we can. It
looks like we already use read_tree_recursive(), so I guess our custom
show_tree() callback is able to handle that. But definitely something to
watch out for during any transition.

-Peff
