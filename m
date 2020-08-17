Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB710C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2782065D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHQVca (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:32:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:33540 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHQVca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:32:30 -0400
Received: (qmail 6665 invoked by uid 109); 17 Aug 2020 21:32:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 21:32:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22226 invoked by uid 111); 17 Aug 2020 21:32:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 17:32:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 17:32:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/7] leak fixes
Message-ID: <20200817213228.GA1854603@coredump.intra.peff.net>
References: <20200814161328.GA153929@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814161328.GA153929@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 12:13:28PM -0400, Jeff King wrote:

> There were quite a few false positives, but it did actually uncover some
> legitimate leaks. This series fixes those. I did it independently of the
> leak-fix in [2], but it would be fine to just lump it all together as
> one topic.

Here's a re-roll that drops the repo_config_get_string_const() and
git_configset_get_string_const() helpers in patch 4, as noticed by
Junio. That's the only patch with changes (range-diff below).

(I also rolled in the earlier leak-fix as "patch 1", which matches what
got queued in jk/leakfix).

  [1/7]: clear_pattern_list(): clear embedded hashmaps
  [2/7]: submodule--helper: use strbuf_release() to free strbufs
  [3/7]: checkout: fix leak of non-existent branch names
  [4/7]: config: fix leaks from git_config_get_string_const()
  [5/7]: config: drop git_config_get_string_const()
  [6/7]: config: fix leak in git_config_get_expiry_in_days()
  [7/7]: submodule--helper: fix leak of core.worktree value

 Documentation/MyFirstContribution.txt |  4 +--
 apply.c                               |  4 +--
 builtin/checkout.c                    |  4 ++-
 builtin/fetch.c                       |  2 +-
 builtin/submodule--helper.c           | 16 ++++-----
 cache.h                               |  4 +--
 checkout.c                            |  3 +-
 config.c                              | 47 +++++++++++++++++----------
 config.h                              | 15 +++++----
 connect.c                             |  4 +--
 dir.c                                 |  2 ++
 editor.c                              |  2 +-
 environment.c                         |  4 +--
 help.c                                |  2 +-
 protocol.c                            |  2 +-
 submodule.c                           |  4 +--
 t/helper/test-config.c                |  2 +-
 17 files changed, 69 insertions(+), 52 deletions(-)

1:  7a878fa4d3 = 1:  24248d0203 clear_pattern_list(): clear embedded hashmaps
2:  84d8edd867 = 2:  5bdbb11601 submodule--helper: use strbuf_release() to free strbufs
3:  76ae8ffb83 = 3:  44f3539461 checkout: fix leak of non-existent branch names
4:  e8f85a47ff = 4:  b1b5444ca1 config: fix leaks from git_config_get_string_const()
5:  9875ddeab3 ! 5:  a82f9724b6 config: drop git_config_get_string_const()
    @@ Commit message
         can swap that call out for the non-allocating "tmp" variant, which fits
         well in the example given.
     
    +    We'll drop the "configset" and "repo" variants, as well (which are
    +    unused).
    +
         Note that this frees up the "const" name, so we could rename the "tmp"
         variant back to that. But let's give some time for topics in flight to
         adapt to the new code before doing so (if we do it too soon, the
    @@ checkout.c: const char *unique_tracking_name(const char *name, struct object_id
      		free(cb_data.default_dst_oid);
     
      ## config.c ##
    +@@ config.c: const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
    + 	return e ? &e->value_list : NULL;
    + }
    + 
    +-int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
    ++int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
    + {
    + 	const char *value;
    + 	if (!git_configset_get_value(cs, key, &value))
    +-		return git_config_string(dest, key, value);
    ++		return git_config_string((const char **)dest, key, value);
    + 	else
    + 		return 1;
    + }
    + 
    +-int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
    +-{
    +-	return git_configset_get_string_const(cs, key, (const char **)dest);
    +-}
    +-
    + int git_configset_get_string_tmp(struct config_set *cs, const char *key,
    + 				 const char **dest)
    + {
    +@@ config.c: const struct string_list *repo_config_get_value_multi(struct repository *repo,
    + 	return git_configset_get_value_multi(repo->config, key);
    + }
    + 
    +-int repo_config_get_string_const(struct repository *repo,
    +-				 const char *key, const char **dest)
    ++int repo_config_get_string(struct repository *repo,
    ++			   const char *key, char **dest)
    + {
    + 	int ret;
    + 	git_config_check_init(repo);
    +-	ret = git_configset_get_string_const(repo->config, key, dest);
    ++	ret = git_configset_get_string(repo->config, key, dest);
    + 	if (ret < 0)
    + 		git_die_config(key, NULL);
    + 	return ret;
    + }
    + 
    +-int repo_config_get_string(struct repository *repo,
    +-			   const char *key, char **dest)
    +-{
    +-	git_config_check_init(repo);
    +-	return repo_config_get_string_const(repo, key, (const char **)dest);
    +-}
    +-
    + int repo_config_get_string_tmp(struct repository *repo,
    + 			       const char *key, const char **dest)
    + {
     @@ config.c: const struct string_list *git_config_get_value_multi(const char *key)
      	return repo_config_get_value_multi(the_repository, key);
      }
    @@ config.c: int git_config_get_pathname(const char *key, const char **dest)
      	if (strcmp(*output, "now")) {
     
      ## config.h ##
    +@@ config.h: void git_configset_clear(struct config_set *cs);
    +  */
    + int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
    + 
    +-int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
    + int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
    + int git_configset_get_string_tmp(struct config_set *cs, const char *key, const char **dest);
    + int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
    +@@ config.h: int repo_config_get_value(struct repository *repo,
    + 			  const char *key, const char **value);
    + const struct string_list *repo_config_get_value_multi(struct repository *repo,
    + 						      const char *key);
    +-int repo_config_get_string_const(struct repository *repo,
    +-				 const char *key, const char **dest);
    + int repo_config_get_string(struct repository *repo,
    + 			   const char *key, char **dest);
    + int repo_config_get_string_tmp(struct repository *repo,
     @@ config.h: void git_config_clear(void);
       * error message and returns -1. When the configuration variable `key` is
       * not found, returns 1 without touching `dest`.
6:  ee69df55de = 6:  7eefd80257 config: fix leak in git_config_get_expiry_in_days()
7:  c4fd15a2ac = 7:  feb66301fc submodule--helper: fix leak of core.worktree value
