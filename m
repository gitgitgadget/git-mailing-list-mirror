Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412EFC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 22:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJEWPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 18:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJEWPd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 18:15:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68CA844D1
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 15:14:22 -0700 (PDT)
Received: (qmail 9281 invoked by uid 109); 5 Oct 2022 22:14:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Oct 2022 22:14:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18701 invoked by uid 111); 5 Oct 2022 22:14:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Oct 2022 18:14:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Oct 2022 18:14:20 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Yz4BvCDIMWptDMKC@coredump.intra.peff.net>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
 <Yy6JxQz4ZxghQnG1.jacob@initialcommit.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy6JxQz4ZxghQnG1.jacob@initialcommit.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 09:38:29PM -0700, Jacob Stopak wrote:

> Hmm I tried passing in --date=format:... to my patched shortlog command
> along with setting some date placeholder like "... %cd ..." in the code,
> but it's not picking up on the format. Do you know how the date format
> can be wedged into the format_commit_message(...) "format" argument?

It comes to the format code via the pretty_print_context. And we pick up
the --date command via setup_revisions(), where it ends up in
rev_info.date_mode.

In a normal git-log, I think that data gets shuffled across by
show_log(). But shortlog has its own traversal.

I think something like this:

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7a1e1fe7c0..53c379a51d 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -211,7 +211,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
 	ctx.print_email_subject = 1;
-	ctx.date_mode.type = DATE_NORMAL;
+	ctx.date_mode = log->date_mode;
 	ctx.output_encoding = get_log_output_encoding();
 
 	if (!log->summary) {
@@ -407,6 +407,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
 	log.abbrev = rev.abbrev;
 	log.file = rev.diffopt.file;
+	log.date_mode = rev.date_mode;
 
 	if (!log.groups)
 		log.groups = SHORTLOG_GROUP_AUTHOR;
diff --git a/shortlog.h b/shortlog.h
index 3f7e9aabca..ef3a3dbc65 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -15,6 +15,7 @@ struct shortlog {
 	int in2;
 	int user_format;
 	int abbrev;
+	struct date_mode date_mode;
 
 	enum {
 		SHORTLOG_GROUP_AUTHOR = (1 << 0),

is enough. At least it allows:

  git shortlog --format='%ad %s' --date=format:%Y-%m

to work as you'd expect (but of course that's just the output for each
commit that we show, not the actual grouping).

> > Unfortunately there's no way to specify the format as part of the
> > placeholder. The for-each-ref formatter understands this, like:
> > 
> >   %(authordate:format:%Y-%m)
> >
> > I wouldn't be opposed to teaching the git-log formatter something
> > similar.
> 
> Oh that would solve my problem... Would it be a hefty effort to teach
> this to the git-log formatter?

Probably not a huge amount of work. But it puts us in a weird in-between
situation where we support _one_ of the more advanced ref-filter
placeholders, but not the others. And of course no code is shared.

That might be OK, as long as the syntax and semantics are identical to
what ref-filter can do. Then in the long run, if we eventually merge the
two implementations, there's no compatibility problem.

That said, I think it may just be easier to respect --date, as above.
It's not quite as flexible, but it's probably flexible enough.

-Peff
