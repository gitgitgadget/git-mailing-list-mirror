Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F1AC433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 19:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F6C613A9
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 19:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhD2TrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 15:47:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:40262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237874AbhD2Tqo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 15:46:44 -0400
Received: (qmail 16110 invoked by uid 109); 29 Apr 2021 19:45:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Apr 2021 19:45:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22087 invoked by uid 111); 29 Apr 2021 19:45:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Apr 2021 15:45:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Apr 2021 15:45:56 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Sanchez <alex@schedmd.com>
Cc:     git@vger.kernel.org
Subject: Re: git am / patch utility not applying a .patch to the correct
 function
Message-ID: <YIsM9DDAoqywKmnK@coredump.intra.peff.net>
References: <CAF-Z3RqEz9mnnosew+TfNkV2ysaTkGj_ZXpD-4NWO7th9v_-CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF-Z3RqEz9mnnosew+TfNkV2ysaTkGj_ZXpD-4NWO7th9v_-CA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 04:25:42PM +0200, Alejandro Sanchez wrote:

> When I attempted to git am a patch clearly targeted for
> _eval_nodes_dfly(), the result shown by git show resulted in the
> modified code in _eval_nodes_topo() instead. A colleague also reported
> this is also happening with the 'patch' utility without git, we're not
> sure if they both share any common logic or library behind the scenes.

They don't share code, but this is an inherent issue with patches. If
the file you're applying the patch to is not at the exact same state as
the original (say, some other content has been introduced which moves
the patched lines around), then the tools will use the context lines in
the patch to try to find the right spot.

Usually this does what you want, but it can occasionally find the wrong
spot (e.g., if the lines in the context are repeated, and especially if
the "right" spot was changed so that the context doesn't match).

> I've attached a sequence of commands showing the contents of the patch
> and the result after applying.

Your patch here is corrupted:

> diff --git a/src/plugins/select/cons_tres/job_test.c b/src/plugins/select/cons_tres/job_test.c
> index 2d25345945..ff125fafa3 100644
> --- a/src/plugins/select/cons_tres/job_test.c
> +++ b/src/plugins/select/cons_tres/job_test.c
> @@ -2045,7 +2045,8 @@ static int _eval_nodes_dfly(job_record_t *job_ptr,
>  	rc = SLURM_ERROR;
>  fini:
> -	if (job_ptr->req_switch > 0 && rc == SLURM_SUCCESS) {
> +	if (job_ptr->req_switch > 0 && switch_node_bitmap &&
> +	    rc == SLURM_SUCCESS) {
>  		int leaf_switch_count = 0;
>  		/* Count up leaf switches. */

It claims 7 lines in the pre-image, but there are only 5 (context lines
+ the "-" lien). And likewise, 2 lines are missing from the post-image.

I'm guessing this has to do with cutting-and-pasting into the mail,
because your "git show" output is likewise corrupted. The correct patch
is:

diff --git a/src/plugins/select/cons_tres/job_test.c b/src/plugins/select/cons_tres/job_test.c
index 2d25345945..ff125fafa3 100644
--- a/src/plugins/select/cons_tres/job_test.c
+++ b/src/plugins/select/cons_tres/job_test.c
@@ -2045,7 +2045,8 @@ static int _eval_nodes_dfly(job_record_t *job_ptr,
 	rc = SLURM_ERROR;
 
 fini:
-	if (job_ptr->req_switch > 0 && rc == SLURM_SUCCESS) {
+	if (job_ptr->req_switch > 0 && switch_node_bitmap &&
+	    rc == SLURM_SUCCESS) {
 		int leaf_switch_count = 0;
 
 		/* Count up leaf switches. */

Starting at the state of 63e94c2ccbb62aea84cfb0b808761de2bb64e74c^,
which you mentioned, the context doesn't match line 2045 (which is in
_eval_nodes_dfly):

  $ sed -n '2045,+7p' src/plugins/select/cons_tres/job_test.c
  	rc = SLURM_ERROR;
  
  fini:
  	if (job_ptr->req_switch > 0 && rc == SLURM_SUCCESS) {
  		/* req_switch == 1 here; enforced at the top of the function. */
  		leaf_switch_count = 0;
  
  		/* count up leaf switches */

There's an extra comment at the top of the block, and the case differs
in the lower comment. But the context _does_ match the later block of
code in _eval_nodes_topo():

  $ sed -ne '2626,+7p' src/plugins/select/cons_tres/job_test.c
  	rc = SLURM_ERROR;
  
  fini:
  	if (job_ptr->req_switch > 0 && switch_node_bitmap &&
  	    rc == SLURM_SUCCESS) {
  		int leaf_switch_count = 0;
  
  		/* Count up leaf switches. */

And hence that's where both git and patch will apply it.

One other confusion may be that the hunk header says
"_eval_nodes_dfly()" in it. This is purely informational for a human
reader, and not taken into account by the patch application code (which
does not even understand things like functions in the first place).

-Peff
