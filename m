Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D1E1F461
	for <e@80x24.org>; Mon, 20 May 2019 10:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbfETKCN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 06:02:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:33718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725951AbfETKCN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 06:02:13 -0400
Received: (qmail 18657 invoked by uid 109); 20 May 2019 10:02:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 10:02:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2628 invoked by uid 111); 20 May 2019 10:02:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 06:02:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 06:02:11 -0400
Date:   Mon, 20 May 2019 06:02:11 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Sanchez <asanchez1987@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Abort (core dumped)
Message-ID: <20190520100211.GA26426@sigill.intra.peff.net>
References: <CAA4phoGrA=AsBFHkqZ54=6ev5BH+F7rLd0Hcr-t2kF_YFNrs2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA4phoGrA=AsBFHkqZ54=6ev5BH+F7rLd0Hcr-t2kF_YFNrs2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 10:35:53AM +0200, Alejandro Sanchez wrote:

> alex@polaris:~/slurm/source$ git add -u
> alex@polaris:~/slurm/source$ git am -i --continue
> Applying: Handle duplicate archive file names.
> error: object 861d3c6f689a3ca5eb5fb5c409d46de0ad5555e1 is a commit, not a tree
> BUG: diff-lib.c:526: run_diff_index must be passed exactly one tree
> Aborted (core dumped)

Hmm. So I think the interesting error is probably that first line: some
code expects to look up a tree but sees a commit, and then as a result
it probably feeds too few items to run_diff_index(), triggering the
assertion failure.

Just grepping around, this looks quite suspicious:

  $ git grep -hW get_oid_tree builtin/am.c
  static void write_index_patch(const struct am_state *state)
  ...
  if (!get_oid_tree("HEAD", &head))
	tree = lookup_tree(the_repository, &head);
  else
	tree = lookup_tree(the_repository,
			   the_repository->hash_algo->empty_tree);

Using get_oid_tree() does not actually return a tree; it just
prioritizes trees when disambiguating names (which is pointless here,
since we're not feeding an ambiguous oid). HEAD will always be a commit,
and then lookup_tree() similarly does not peel that down to an actual
tree. And this whole function is called only in interactive-mode, so
it's possible that it's simply not used much and nobody noticed.

I haven't tried to reproduce yet. Is the repository (and patch) that you
used to demonstrate this publicly available? Or alternatively, is it
possible to show a backtrace from the coredump?

If my blind guess is right, then something like this probably fixes it:

diff --git a/builtin/am.c b/builtin/am.c
index bdd1bbc35d..93305560c1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1339,9 +1339,17 @@ static void write_index_patch(const struct am_state *state)
 	struct rev_info rev_info;
 	FILE *fp;
 
-	if (!get_oid_tree("HEAD", &head))
-		tree = lookup_tree(the_repository, &head);
-	else
+	if (!get_oid("HEAD", &head)) {
+		struct object *obj;
+		struct commit *commit;
+
+		obj = parse_object_or_die(&head, NULL);
+		commit = object_as_type(the_repository, obj, OBJ_COMMIT, 0);
+		if (!commit)
+			die("unable to parse HEAD as a commit");
+
+		tree = get_commit_tree(commit);
+	} else
 		tree = lookup_tree(the_repository,
 				   the_repository->hash_algo->empty_tree);
 

-Peff
