Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA43FC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A767C2075F
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHYTqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:46:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:40638 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYTqV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 15:46:21 -0400
Received: (qmail 2385 invoked by uid 109); 25 Aug 2020 19:46:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 19:46:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1242 invoked by uid 111); 25 Aug 2020 19:46:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 15:46:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 15:46:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Mismatched HEAD default behavior from git log
Message-ID: <20200825194619.GB1419759@coredump.intra.peff.net>
References: <CAGyf7-G_ciVpgvvOiH1Fq9kNuWunCpM1fhv3ao_RMXBB0K=HMA@mail.gmail.com>
 <xmqq8se21pl1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8se21pl1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 12:40:42PM -0700, Junio C Hamano wrote:

> Bryan Turner <bturner@atlassian.com> writes:
> 
> > It appears the way --stdin processes input discards nonexistent
> > commits before the machinery that decides whether you provided any
> > revs or not runs, and so if every --stdin rev is discarded then you
> > get the default HEAD. If you provide them via the command line,
> > though, then it seems like they're discarded later and you don't get a
> > default.
> >
> > I'm not sure whether this is intentional or not (certainly I don't see
> > it anywhere in the git log documentation for --ignore-missing or
> > --stdin), but it results in a behavior mismatch that's impossible to
> > reconcile without requiring extra git processes. I can't always
> > provide HEAD since, if multiple revs are supplied, if any revs exist
> > then HEAD would not be included regardless of whether the revs were
> > supplied via the command line or --stdin.
> 
> As the intent for adding the "--stdin" option to any subcommand has
> always been "we may need to feed many many things, that may bust the
> command line length limit, hence we let you feed these things from
> the standard input, but otherwise there should be no change in
> behaviour or semantics", when the behaviour of command line and
> "--stdin" differ, it is a bug in the latter.

Agreed. It also helps in this case that the command-line behavior is
sensible and the --stdin one is not. :)

I think the solution is probably something like:

diff --git a/revision.c b/revision.c
index 96630e3186..f5bbefa091 100644
--- a/revision.c
+++ b/revision.c
@@ -2099,12 +2099,13 @@ static void read_pathspec_from_stdin(struct strbuf *sb,
 		strvec_push(prune, sb->buf);
 }
 
-static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct strvec *prune)
+static int read_revisions_from_stdin(struct rev_info *revs,
+				     struct strvec *prune)
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
 	int save_warning;
+	int got_rev_arg = 0;
 
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
@@ -2124,12 +2125,14 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		if (handle_revision_arg(sb.buf, revs, 0,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
+		got_rev_arg = 1;
 	}
 	if (seen_dashdash)
 		read_pathspec_from_stdin(&sb, prune);
 
 	strbuf_release(&sb);
 	warn_on_object_refname_ambiguity = save_warning;
+	return got_rev_arg;
 }
 
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
@@ -2754,7 +2757,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				}
 				if (revs->read_from_stdin++)
 					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data);
+				if (read_revisions_from_stdin(revs, &prune_data))
+					got_rev_arg = 1;
 				continue;
 			}
 

Possibly it would make sense to push that flag into rev_info, though,
and let handle_revision_arg() set it. That would fix this bug and
prevent similar ones in other code paths (though we're not likely to get
revisions from anywhere else, I suppose).

-Peff
