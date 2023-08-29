Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31481C71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbjH2XnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbjH2XnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:43:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0281BC
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:43:06 -0700 (PDT)
Received: (qmail 14742 invoked by uid 109); 29 Aug 2023 23:43:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:43:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19720 invoked by uid 111); 29 Aug 2023 23:43:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:43:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:43:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/22] Yet Another Unused Parameter Series
Message-ID: <20230829234305.GA226944@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 05:46:04PM -0400, Jeff King wrote:

> I'm back with another exciting installment of -Wunused-parameter warning
> fixes. Most of these are pretty boring and obvious; the first two are
> the most interesting in terms of rationale.
> 
> I promise we're closing in on the finish line here. I only have about 20
> patches left after this, at which point we should be able to turn on the
> warning by default for developer builds.

And here's a v2 based on feedback from round 1. The changes are small,
so I'll let the range-diff below speak for itself.

 1:  6009723d8a !  1:  c11e9b9bd6 sequencer: use repository parameter in short_commit_name()
    @@ Commit message
         the_repository, but this pushes us one small step forward to eventually
         getting rid of those.
     
    +    Note that a few of these functions have a "rev_info" whose "repo"
    +    parameter could probably be used instead of the_repository. I'm leaving
    +    that for further cleanups, as it's not immediately obvious that
    +    revs->repo is always valid, and there's quite a bit of other possible
    +    refactoring here (even getting rid of some "struct repository" arguments
    +    in favor of revs->repo).
    +
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## sequencer.c ##
    @@ sequencer.c: static int walk_revs_populate_todo(struct todo_list *todo_list,
      		subject_len = find_commit_subject(commit_buffer, &subject);
      		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
     -			short_commit_name(commit), subject_len, subject);
    -+			short_commit_name(opts->revs->repo, commit),
    ++			short_commit_name(the_repository, commit),
     +			subject_len, subject);
      		repo_unuse_commit_buffer(the_repository, commit,
      					 commit_buffer);
    @@ sequencer.c: static int make_script_with_merges(struct pretty_print_context *pp,
      			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
      				warning(_("skipped previously applied commit %s"),
     -					short_commit_name(commit));
    -+					short_commit_name(revs->repo, commit));
    ++					short_commit_name(the_repository, commit));
      			skipped_commit = 1;
      			continue;
      		}
 2:  f9068919f9 !  2:  3d0030ed7a sequencer: mark repository argument as unused
    @@ Commit message
         sequencer: mark repository argument as unused
     
         In sequencer_get_last_command(), we don't ever look at the repository
    -    parameter. It _should_ be used when calling into git_path_* functions,
    +    parameter. This is due to ed5b1ca10b (status: do not report errors in
    +    sequencer/todo, 2019-06-27), which dropped the call to parse_insn_line().
    +
    +    However, it _should_ be used when calling into git_path_* functions,
         but the one we use here is declared with the non-REPO variant of
         GIT_PATH_FUNC(), and so just uses the_repository internally.
     
 3:  cf28e8793a =  3:  deca060ede ref-filter: mark unused parameters in parser callbacks
 4:  baba1341f3 =  4:  4c15910f4e pack-bitmap: mark unused parameters in show_object callback
 5:  444d67676b =  5:  9125111e5e worktree: mark unused parameters in each_ref_fn callback
 6:  4d5fbed1aa !  6:  4e044c1005 commit-graph: mark unused data parameters in generation callbacks
    @@ Commit message
         get/set generation operations. Some callers don't need the extra void
         data pointer, which should be annotated to appease -Wunused-parameter.
     
    +    Note that we can drop the assignment of the "data" parameter in
    +    compute_generation_numbers(), as we've just shown that neither of the
    +    callbacks it uses will access it. This matches the caller in
    +    ensure_generations_valid(), which already does not bother to set "data".
    +
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## commit-graph.c ##
    @@ commit-graph.c: static void compute_topological_levels(struct write_commit_graph
      {
      	struct commit_graph_data *g = commit_graph_data_at(c);
      	g->generation = t;
    +@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
    + 		.commits = &ctx->commits,
    + 		.get_generation = get_generation_from_graph_data,
    + 		.set_generation = set_generation_v2,
    +-		.data = ctx,
    + 	};
    + 
    + 	if (ctx->report_progress)
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
      }
      
 7:  b5ad1e7e6a =  7:  8441011ab3 ls-tree: mark unused parameter in callback
 8:  d0d9fb3c7e =  8:  4ee523564a stash: mark unused parameter in diff callback
 9:  eefe7daf5d =  9:  21a23b51a9 trace2: mark unused us_elapsed_absolute parameters
10:  38021bc8ce = 10:  76db35e8f1 trace2: mark unused config callback parameter
11:  a6eccfab8b = 11:  312c6bd59b test-trace2: mark unused argv/argc parameters
12:  6d971c4381 = 12:  e74362f5a8 grep: mark unused parameter in output function
13:  ac7347663c = 13:  a8525ab460 add-interactive: mark unused callback parameters
14:  d14aab5b51 = 14:  27df60c02f negotiator/noop: mark unused callback parameters
15:  2d405dc294 = 15:  4eeac4bc33 worktree: mark unused parameters in noop repair callback
16:  9c1f3b668b = 16:  d81464b1f1 imap-send: mark unused parameters with NO_OPENSSL
17:  ad63f999b9 = 17:  ea865a1077 grep: mark unused parmaeters in pcre fallbacks
18:  af414f38fc = 18:  335c42823b credential: mark unused parameter in urlmatch callback
19:  14694671eb = 19:  f06f36371b fetch: mark unused parameter in ref_transaction callback
20:  a375abd8fa = 20:  b1fe7e7e34 bundle-uri: mark unused parameters in callbacks
21:  611dc4d367 = 21:  c9e258e0fa gc: mark unused descriptors in scheduler callbacks
22:  0ec53b7a46 = 22:  7c2c8fd614 update-ref: mark unused parameter in parser callbacks

  [01/22]: sequencer: use repository parameter in short_commit_name()
  [02/22]: sequencer: mark repository argument as unused
  [03/22]: ref-filter: mark unused parameters in parser callbacks
  [04/22]: pack-bitmap: mark unused parameters in show_object callback
  [05/22]: worktree: mark unused parameters in each_ref_fn callback
  [06/22]: commit-graph: mark unused data parameters in generation callbacks
  [07/22]: ls-tree: mark unused parameter in callback
  [08/22]: stash: mark unused parameter in diff callback
  [09/22]: trace2: mark unused us_elapsed_absolute parameters
  [10/22]: trace2: mark unused config callback parameter
  [11/22]: test-trace2: mark unused argv/argc parameters
  [12/22]: grep: mark unused parameter in output function
  [13/22]: add-interactive: mark unused callback parameters
  [14/22]: negotiator/noop: mark unused callback parameters
  [15/22]: worktree: mark unused parameters in noop repair callback
  [16/22]: imap-send: mark unused parameters with NO_OPENSSL
  [17/22]: grep: mark unused parmaeters in pcre fallbacks
  [18/22]: credential: mark unused parameter in urlmatch callback
  [19/22]: fetch: mark unused parameter in ref_transaction callback
  [20/22]: bundle-uri: mark unused parameters in callbacks
  [21/22]: gc: mark unused descriptors in scheduler callbacks
  [22/22]: update-ref: mark unused parameter in parser callbacks

 add-interactive.c       |  8 ++++----
 builtin/fetch.c         |  2 +-
 builtin/gc.c            |  6 +++---
 builtin/ls-tree.c       |  3 ++-
 builtin/stash.c         |  2 +-
 builtin/update-ref.c    | 14 +++++++-------
 builtin/worktree.c      |  8 ++++----
 bundle-uri.c            |  6 +++---
 commit-graph.c          |  9 +++++----
 credential.c            |  4 ++--
 grep.c                  | 12 +++++++-----
 imap-send.c             | 10 ++++++++--
 negotiator/noop.c       | 12 +++++++-----
 pack-bitmap.c           |  5 +++--
 ref-filter.c            |  8 +++++---
 sequencer.c             | 27 ++++++++++++++-------------
 t/helper/test-trace2.c  |  6 +++---
 trace2/tr2_sysenv.c     |  3 ++-
 trace2/tr2_tgt_event.c  | 23 +++++++++++++----------
 trace2/tr2_tgt_normal.c | 20 ++++++++++++--------
 worktree.c              |  6 ++++--
 21 files changed, 110 insertions(+), 84 deletions(-)
