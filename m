Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32A8207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbcI2NYa (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 09:24:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:49903 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbcI2NY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 09:24:29 -0400
Received: (qmail 27080 invoked by uid 109); 29 Sep 2016 13:24:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 13:24:27 +0000
Received: (qmail 1469 invoked by uid 111); 29 Sep 2016 13:24:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 09:24:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 09:24:25 -0400
Date:   Thu, 29 Sep 2016 09:24:25 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
Message-ID: <20160929132425.of7m5t4tsqcb6bbk@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
 <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
 <841D4FC2-9673-486A-8D94-8967188CCC60@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <841D4FC2-9673-486A-8D94-8967188CCC60@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 06:01:51AM -0700, Kyle J. McKay wrote:

> But perhaps it makes sense to actually pick one if there's only one
> disambiguation of the type you're looking for.
> 
> For example given:
> 
> 235234a blob
> 2352347 tag
> 235234f tree
> 2352340 commit
> 
> If you are doing "git cat-file blob 235234" it should pick the blob and spit
> out a warning (and similarly for other cat-file types).  But "git cat-file
> -p 235234" would give the fatal error with the disambiguation hints because
> it wants type "any".

That code is already there; it's just a matter of whether git has enough
information to know the context. E.g. (in git.git):

  $ git show b2e11
  error: short SHA1 b2e11 is ambiguous
  hint: The candidates are:
  hint:   b2e1196 tag v2.8.0-rc1
  hint:   b2e11d1 tree
  ...

  $ git log b2e11
  commit ab5d01a29eb7380ceab070f0807c2939849c44bc (tag: v2.8.0-rc1)
  ...

The "show" command can show anything, but "log" really wants
committishes, so it's able to disambiguate. It looks like cat-file never
learned to feed its context, but it's probably something like this:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 94e67eb..ecbb959 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -56,12 +56,22 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_info oi = {NULL};
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = LOOKUP_REPLACE_OBJECT;
+	unsigned sha1_flags = 0;
 	const char *path = force_path;
 
 	if (unknown_type)
 		flags |= LOOKUP_UNKNOWN_OBJECT;
 
-	if (get_sha1_with_context(obj_name, 0, oid.hash, &obj_context))
+	if (exp_type) {
+		if (!strcmp(exp_type, "commit"))
+			sha1_flags |= GET_SHA1_COMMITTISH;
+		else if(!strcmp(exp_type, "tree"))
+			sha1_flags |= GET_SHA1_TREEISH;
+		else if(!strcmp(exp_type, "blob"))
+			sha1_flags |= GET_SHA1_BLOB;
+	}
+
+	if (get_sha1_with_context(obj_name, sha1_flags, oid.hash, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
 	if (!path)

> If you are doing "git show 235234" it should pick the tag (if it peels to a
> committish) because Git has already set a precedent of preferring tags over
> commits when it disambiguates ref names and otherwise pick the commit.

I'm not convinced that picking the tag is actually helpful in this case;
I agree with Linus that feeding something to "git show" almost always
wants to choose the commit.

I also don't think tag ambiguity in short sha1s is all that interesting.
There are a tiny number of tag objects. Most of your collisions are
going to be with trees or blobs, which should generally outnumber
commits by a factor of 5-10, though it depends on your workflow (git.git
does not have a deep tree, so it's only a factor of 4).

And if you just want to choose a committish over trees and blobs, well,
then; I invite you to check out the core.disambiguate patch I sent
elsewhere in the thread. :)

-Peff
