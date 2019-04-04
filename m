Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE7120248
	for <e@80x24.org>; Thu,  4 Apr 2019 12:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfDDMGP (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 08:06:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:46606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726269AbfDDMGP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 08:06:15 -0400
Received: (qmail 26832 invoked by uid 109); 4 Apr 2019 12:06:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 12:06:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16058 invoked by uid 111); 4 Apr 2019 12:06:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 08:06:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 08:06:13 -0400
Date:   Thu, 4 Apr 2019 08:06:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Feature request: Add --no-edit to git tag command
Message-ID: <20190404120613.GB22324@sigill.intra.peff.net>
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
 <20190404015744.GF4409@sigill.intra.peff.net>
 <20190404032606.GA39148@Taylors-MBP.hsd1.wa.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404032606.GA39148@Taylors-MBP.hsd1.wa.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 08:26:06PM -0700, Taylor Blau wrote:

> Agreed.
> 
> I think that the implement is a little different than "add a --no-edit"
> flag, though. 'git tag' already has a OPT_BOOL for '--edit', which means
> that '--no-edit' exists, too.
> 
> But, when we look and see how the edit option is passed around, we find
> that the check whether or not to launch the editor (again, in
> builtin/tag.c within 'create_tag()') is:
> 
>   if (!opt->message_given || opt->use_editor)
> 
> So, it's not that we didn't take '--no-edit', it's that we didn't get a
> _message_, so we'll open the editor to get one (even if '--no-edit' was
> given).

Yeah, I think the fundamental issue with --no-edit is that it is not a
tristate, so we cannot tell the difference between --edit, --no-edit,
and nothing.

I think regardless of the "re-use message bits", we'd want something
like:

diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..260adcaa60 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -196,7 +196,7 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
 
 struct create_tag_options {
 	unsigned int message_given:1;
-	unsigned int use_editor:1;
+	int use_editor;
 	unsigned int sign;
 	enum {
 		CLEANUP_NONE,
@@ -227,7 +227,7 @@ static void create_tag(const struct object_id *object, const char *tag,
 		    tag,
 		    git_committer_info(IDENT_STRICT));
 
-	if (!opt->message_given || opt->use_editor) {
+	if ((!opt->message_given && opt->use_editor != 0) || opt->use_editor > 0) {
 		int fd;
 
 		/* write the template message before editing: */
@@ -380,7 +380,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct ref_format format = REF_FORMAT_INIT;
 	int icase = 0;
-	int edit_flag = 0;
+	int edit_flag = -1;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),

which even does the right thing with "git tag --no-edit -a foo" (it dies
with "fatal: no tag message?"

> This makes me think that we should do two things:
> 
>   1. Make !opt->message_give && !opt->use_editor an invalid invocation.
>      If I (1) didn't give a message but I did (2) give '--no-edit', I'd
>      expect a complaint, not an editor window.
> 
>   2. Then, do what Robert suggests, which is to "make opt->message_given
>      true", by re-using the previous tag's message.

I think I misunderstood Robert's proposal. I thought it was just about
fixing --no-edit, but it's actually about _adding_ (2). Which I think
we'd want to do differently. See Junio's reply elsewhere in the thread
(and my reply there).

> > I think it wouldn't be very hard to implement, either. Maybe a good
> > starter project or #leftoverbits for somebody.
> 
> Maybe. I think that it's made a little more complicated by the above,
> but it's certainly doable. Maybe good for GSoC?

I was thinking it was just the --no-edit fix. :) Even with the "--amend"
thing, though, it's probably a little light for a 3-month-long GSoC
project. :)

-Peff
