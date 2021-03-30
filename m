Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA1C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BCA61989
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhC3HCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:02:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:36698 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhC3HCd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 03:02:33 -0400
Received: (qmail 18008 invoked by uid 109); 30 Mar 2021 07:02:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Mar 2021 07:02:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21900 invoked by uid 111); 30 Mar 2021 07:02:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Mar 2021 03:02:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Mar 2021 03:02:28 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is
 passed
Message-ID: <YGLNBFJv8NKmrbvz@coredump.intra.peff.net>
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 11:05:05PM -0700, Elijah Newren wrote:

> it all works well.  BUT, if I try to use it with branch it doesn't work:
> 
>     $ git branch --contains deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
>     $

I'm not surprised here. The replace mechanism is usually "if you are
trying to access object X, then access the contents of Y instead". But I
don't think we generally rewrite references from other objects. So in
that sense, no ref "contains" deadbeef, because nobody points to it as
an ancestor.

I guess "branch --contains" could convert the mention of the replaced
object on the command-line, something like this:

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 4542d4d3f9..200be4e3d2 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "strvec.h"
 #include "oid-array.h"
+#include "replace-object.h"
 
 /*----- some often used options -----*/
 
@@ -84,6 +85,7 @@ int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 {
 	struct object_id oid;
+	const struct object_id *replace;
 	struct commit *commit;
 
 	BUG_ON_OPT_NEG(unset);
@@ -92,7 +94,9 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 		return -1;
 	if (get_oid(arg, &oid))
 		return error("malformed object name %s", arg);
-	commit = lookup_commit_reference(the_repository, &oid);
+
+	replace = lookup_replace_object(the_repository, &oid);
+	commit = lookup_commit_reference(the_repository, replace);
 	if (!commit)
 		return error("no such commit %s", arg);
 	commit_list_insert(commit, opt->value);

though if we go that route, I suspect we ought to be adding both the
original _and_ the replacement.

I'm not entirely sure this is a good direction, though.

> and possibly worse, if I create a new branch based on it and use it:
> 
>     $ git branch foobar deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
>     $ git checkout foobar
>     $ echo stuff >empty
>     $ git add empty
>     $ git commit -m more
> 
> then it's clear that branch created foobar pointing to the replaced
> object rather than the replacement object -- despite the fact that the
> replaced object doesn't even exist within this repo:
> 
>     $ git cat-file -p HEAD
>     tree 18108bae26dc91af2055bc66cc9fea278012dbd3
>     parent deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
>     author Elijah Newren <newren@gmail.com> 1617083739 -0700
>     committer Elijah Newren <newren@gmail.com> 1617083739 -0700
> 
>     more

Yeah, that's pretty horrible. I do think you're using replace objects in
a way they weren't really intended for, in two ways:

  - usually you'd actually have deadbeef, and you just want to rewrite
    it to something else

  - you wouldn't usually work directly with the replace object on the
    command line like this. Usually the intent is to patch some old
    section of history to get a different view.

None of which is an excuse exactly. But just to say that I'm not too
surprised that the "replace" mechanism is a bit half-baked, and there
are probably a lot of weird implications nobody has thought through.

Patches welcome, of course, though I suspect it may be a rabbit hole
that isn't worth your time. :)

> I poked around in the code a little but it is not at all clear to me
> why some parts of the code (log, diff) translate replace refs
> correctly, while others (branch) don't.  It is clear from the output
> that log is aware that the refs are replaced, which makes me wonder if
> every caller needs to be aware of replace refs for them to work
> correctly everywhere, because I couldn't find a missing environment
> setup for "branch".

Right. To work as you expect above, basically everything that is going
to look at an oid would need to consider whether to use a replace ref.
Shoving the lookup into get_oid() would "fix" that, but I suspect would
confuse some other callers. Right now the rule is "when you access the
object contents, pretend as if it had X instead of Y", so we can enforce
that at the layer of accessing the object database.

-Peff
