Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBFBC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 16:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiGFQtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 12:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiGFQtK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 12:49:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE62A413
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 09:49:09 -0700 (PDT)
Received: (qmail 3797 invoked by uid 109); 6 Jul 2022 16:49:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 16:49:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25419 invoked by uid 111); 6 Jul 2022 16:49:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 12:49:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 12:49:08 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: How to display "HEAD~*" in "git log"
Message-ID: <YsW9BI61tWGh9OJo@coredump.intra.peff.net>
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
 <20220705092514.hsm7cou5bqvajvgq@carbon>
 <YsWebbaOJbaOZ6i7@coredump.intra.peff.net>
 <20220706162856.mkgfdr2lnjdbxgn4@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220706162856.mkgfdr2lnjdbxgn4@carbon>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2022 at 07:28:56PM +0300, Konstantin Khomoutov wrote:

> > You can use "name-rev" to annotate commits with names that respect the
> > history. It only matches full oids, so try:
> > 
> >   git log --oneline --no-abbrev | git name-rev --stdin
> 
> I pondered about `git name-rev` but failed to figure out how to make it accept
> just "HEAD" as the point of reference. Passing it "--refs=HEAD"
> (or "--refs HEAD", FWIW) does not appear to do what I'd expect it to: a couple
> of top commits are not annotated at all, and then they start to get annotated
> relative to "origin/HEAD". Note that I've tested this on a detached HEAD which
> contains an unmerged line of history.

Right. The problem is that it gets the set of possible ref tips with
for_each_ref(), which will not include HEAD. And then worse, since the
argument to "--refs" is a pattern, it matches junk like origin/HEAD.

You'd perhaps need a new option, something like:

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c4dc143c4b..ec36e48ca3 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -568,10 +568,12 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
 	int all = 0, annotate_stdin = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
+	int head_only = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
+		OPT_BOOL(0, "head", &head_only, N_("only use HEAD to name the commits")),
 		OPT_STRING_LIST(0, "refs", &data.ref_filters, N_("pattern"),
 				   N_("only use refs matching <pattern>")),
 		OPT_STRING_LIST(0, "exclude", &data.exclude_filters, N_("pattern"),
@@ -652,7 +654,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	adjust_cutoff_timestamp_for_slop();
 
-	for_each_ref(name_ref, &data);
+	if (head_only)
+		head_ref(name_ref, &data);
+	else
+		for_each_ref(name_ref, &data);
 	name_tips();
 
 	if (annotate_stdin) {

though there are some open issues. E.g., can it be combined with other
--refs options? If not, should we detect that case and complain?

Another option is to just teach it to always look at HEAD and see if
name_ref() wants to accept it. Like:

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c4dc143c4b..afd9f93a95 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -652,6 +652,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	adjust_cutoff_timestamp_for_slop();
 
+	head_ref(name_ref, &data);
 	for_each_ref(name_ref, &data);
 	name_tips();
 

That has the nice advantage of not needing a new option. But:

  - it does change the default output; it may be that people would
    prefer not to see HEAD~5, in favor of the actual branch name.

  - if you want just HEAD, you'll have to say so, and then ask to
    exclude origin/HEAD, etc, with a pattern. Like:

      git name-rev --stdin --refs=HEAD --exclude='*/*'

    which is perhaps a little counter-intuitive (though an example in
    the manpage might lead people in the right direction).

I dunno. I would not be sad to see either direction turned into a real
patch, if somebody cares to clean it up and make a convincing argument.
I doubt I would use either myself (nor have I ever really used name-rev
much, tbh).

-Peff
