Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0DA71F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 15:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfHNPgJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 11:36:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:43334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726166AbfHNPgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 11:36:08 -0400
Received: (qmail 17141 invoked by uid 109); 14 Aug 2019 15:36:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Aug 2019 15:36:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17273 invoked by uid 111); 14 Aug 2019 15:37:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2019 11:37:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Aug 2019 11:36:07 -0400
From:   Jeff King <peff@peff.net>
To:     "Paolo Pettinato (ppettina)" <ppettina@cisco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git fetch bug in git 2.21+ "Could not access submodule '%s'"
Message-ID: <20190814153607.GB12093@sigill.intra.peff.net>
References: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 14, 2019 at 09:57:50AM +0000, Paolo Pettinato (ppettina) wrote:

> The issue happens when fetching an updated ref from a remote, and that 
> ref updates a submodule which is not checked out but whose folder is dirty.
> 
> Steps to reproduce (on *nix) with repositories on GitHub:
> [...]
> # Repo now contains a folder named "sm" which is bound to contain a 
> submodule checkout. But the submodule is not checked out yet.
> # Dirty that folder:
> $ touch sm/test
> 
> # Fetching another branch will fail
> $ git fetch origin branch_1

Thanks, I was able to reproduce here. Since this worked in v2.18.1, it
was an easy candidate for bisecting.  The resulting commit is 26f80ccfc1
(submodule: migrate get_next_submodule to use repository structs,
2018-11-28).

It looks like your case falls afoul of this logic added by that commit
in get_next_submodule():

  repo = get_submodule_repo_for(spf->r, submodule);
  if (repo) {
          ...
  } else {
          /*
	   * An empty directory is normal,
	   * the submodule is not initialized
	   */
	  if (S_ISGITLINK(ce->ce_mode) &&
	      !is_empty_dir(ce->name)) {
		  spf->result = 1;
		  strbuf_addf(err,
			      _("Could not access submodule '%s'"),
			      ce->name);
	  }
  }

Because you created a file in the uninitialized submodule directory, it
fools the is_empty_dir() check. It seems like there should be a more
robust way to check whether the submodule is initialized. Maybe:

diff --git a/submodule.c b/submodule.c
index 77ace5e784..748ebe5909 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1294,6 +1294,9 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
+		if (!is_submodule_active(spf->r, ce->name))
+			continue;
+
 		submodule = submodule_from_path(spf->r, &null_oid, ce->name);
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);

but that seems to fail t5526's "on-demand works without .gitmodules
entry" test.

I think is_submodule_populated_gently() more exactly matches what the
current code is trying to do, like so:

diff --git a/submodule.c b/submodule.c
index 77ace5e784..4b26faee5d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1347,8 +1347,7 @@ static int get_next_submodule(struct child_process *cp,
 			 * An empty directory is normal,
 			 * the submodule is not initialized
 			 */
-			if (S_ISGITLINK(ce->ce_mode) &&
-			    !is_empty_dir(ce->name)) {
+			if (is_submodule_populated_gently(ce->name, NULL)) {
 				spf->result = 1;
 				strbuf_addf(err,
 					    _("Could not access submodule '%s'"),

but it feels odd to me. Even if the submodule is not currently checked
out, we'd presumably still want to do the recursive fetch as long as we
have a repo under $GIT_DIR/modules? And anyway, it fails another test in
t5526 ("fetching submodule into a broken repository").

Maybe somebody with more submodule expertise can jump in.

> # Re-issuing the command succeeds
> $ git fetch origin branch_1
> [...]
> I'd expect the command not to fail, or to fail consistently.

I think that part is expected. After receiving new objects, `fetch`
tries to see if it found out about any new submodules that might need to
be recursively fetched. In your first command, we actually received the
new objects (but then erroneously complained because the submodule was
not initialized). In the second, we already had those objects and didn't
need to do that check.

-Peff
