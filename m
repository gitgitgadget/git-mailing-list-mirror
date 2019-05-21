Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BC51F462
	for <e@80x24.org>; Tue, 21 May 2019 21:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfEUVqc (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 17:46:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:35416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726907AbfEUVqc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 17:46:32 -0400
Received: (qmail 2179 invoked by uid 109); 21 May 2019 21:46:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 May 2019 21:46:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17463 invoked by uid 111); 21 May 2019 21:47:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 May 2019 17:47:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 May 2019 17:46:30 -0400
Date:   Tue, 21 May 2019 17:46:30 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: HEAD and namespaces
Message-ID: <20190521214630.GD14807@sigill.intra.peff.net>
References: <CAGyf7-Ew8rS8n67Few9+dT6VXy9rQbaYLswuZkQ3-4j_T_d=qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-Ew8rS8n67Few9+dT6VXy9rQbaYLswuZkQ3-4j_T_d=qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 07:59:03PM -0700, Bryan Turner wrote:

> When using GIT_NAMESPACE, it appears the "symref" added to the
> capabilities advertisement doesn't get the namespace stripped. The
> namespace is stripped for the advertised refs, including "HEAD", but
> not on the "symref".
> 
> Lafiel:test bturner$ GIT_NAMESPACE=foo GIT_TRACE_PACKET=1 git ls-remote origin
> 19:51:54.012696 pkt-line.c:80           packet:          git<
> b9acca03606d4c674be8b7e79cd788cedbec957c HEAD\0multi_ack thin-pack
> side-band side-band-64k ofs-delta shallow deepen-since deepen-not
> deepen-relative no-progress include-tag multi_ack_detailed
> symref=refs/namespaces/foo/HEAD:refs/namespaces/foo/refs/heads/master

Yeah, that seems totally broken. It's neat that we find HEAD inside the
namespace. But I think there are two bugs here:

  1. We must call it "HEAD" and not the nonsense
     refs/namespaces/foo/HEAD

  2. We need to similarly remove the namespace from its contents. I
     suppose it's possible that somebody stores the already-truncated
     name in the symref, but as you noted then such a symref would be
     totally broken from the perspective of the non-namespaced repo.

> I don't know whether the client somehow does some stripping on the
> "symref" to decide that HEAD should be
> "refs/namespaces/foo/refs/heads/master", but I'd assume not.

I don't think it can. It has no idea that namespaces are in play at all
(and the point of the feature is for it to be invisible to the client).

> Is this a bug? An oversight? An intentional decision? How is HEAD
> supposed to work when using GIT_NAMESPACE? Perhaps the expectation is
> that namespaces won't have their own HEADs? I'd say perhaps it's that
> even in the namespace the target ref shouldn't be namespaced, but that
> doesn't seem like it could possibly be correct since the namespace
> could contain refs that don't exist outside it, so Git would see the
> symbolic ref as broken.

I think it should be doing:

diff --git a/upload-pack.c b/upload-pack.c
index 24298913c0..4d2129e7fc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1037,8 +1037,8 @@ static int find_symref(const char *refname, const struct object_id *oid,
 	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
-	item = string_list_append(cb_data, refname);
-	item->util = xstrdup(symref_target);
+	item = string_list_append(cb_data, strip_namespace(refname));
+	item->util = xstrdup(strip_namespace(symref_target));
 	return 0;
 }
 

and this case has just been broken since 7171d8c15f (upload-pack: send
symbolic ref information as capability, 2013-09-17). It mostly works
because of fallback to the old guessing behavior, so nobody really
noticed. (I also suspect namespaces are not widely used at all, but I
could be wrong).

-Peff
