Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40105C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 23:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259C62065C
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 23:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgHOXXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 19:23:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:60302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgHOXXR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 19:23:17 -0400
Received: (qmail 8526 invoked by uid 109); 15 Aug 2020 06:34:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Aug 2020 06:34:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31615 invoked by uid 111); 15 Aug 2020 06:34:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Aug 2020 02:34:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Aug 2020 02:34:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] config: drop git_config_get_string_const()
Message-ID: <20200815063437.GA619381@coredump.intra.peff.net>
References: <20200814161328.GA153929@coredump.intra.peff.net>
 <20200814161921.GD595698@coredump.intra.peff.net>
 <xmqq364pvv03.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq364pvv03.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 01:21:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As evidenced by the leak fixes in the previous commit, the "const" in
> > git_config_get_string_const() clearly misleads people into thinking that
> > it does not allocate a copy of the string. We can fix this by renaming
> > it, but it's easier still to just drop it.
> 
> This turns out to be a bit more painful than I imagined.
> 
> Do we want to do the same with repo_config_get_string_const(), by
> the way?  Which would open the wound even wider, but may be worth
> doing for consistency.

Whoops, I actually meant to do so (and made sure we didn't have any
callers) but forgot to actually include it in patch 4. It doesn't make
any sense to keep those other variants.

The diff is pretty straightforward (see below). I'll include it in a
re-roll (squashed into patch 4), but will wait for any other comments.

It doesn't look like there's any extra fallout from merging this with
"seen".

diff --git a/config.c b/config.c
index 8bb1945aa9..f0367c76ad 100644
--- a/config.c
+++ b/config.c
@@ -2006,20 +2006,15 @@ const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
 	return e ? &e->value_list : NULL;
 }
 
-int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
+int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
 {
 	const char *value;
 	if (!git_configset_get_value(cs, key, &value))
-		return git_config_string(dest, key, value);
+		return git_config_string((const char **)dest, key, value);
 	else
 		return 1;
 }
 
-int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
-{
-	return git_configset_get_string_const(cs, key, (const char **)dest);
-}
-
 int git_configset_get_string_tmp(struct config_set *cs, const char *key,
 				 const char **dest)
 {
@@ -2161,24 +2156,17 @@ const struct string_list *repo_config_get_value_multi(struct repository *repo,
 	return git_configset_get_value_multi(repo->config, key);
 }
 
-int repo_config_get_string_const(struct repository *repo,
-				 const char *key, const char **dest)
+int repo_config_get_string(struct repository *repo,
+			   const char *key, char **dest)
 {
 	int ret;
 	git_config_check_init(repo);
-	ret = git_configset_get_string_const(repo->config, key, dest);
+	ret = git_configset_get_string(repo->config, key, dest);
 	if (ret < 0)
 		git_die_config(key, NULL);
 	return ret;
 }
 
-int repo_config_get_string(struct repository *repo,
-			   const char *key, char **dest)
-{
-	git_config_check_init(repo);
-	return repo_config_get_string_const(repo, key, (const char **)dest);
-}
-
 int repo_config_get_string_tmp(struct repository *repo,
 			       const char *key, const char **dest)
 {
diff --git a/config.h b/config.h
index d4d22c34c6..91cdfbfb41 100644
--- a/config.h
+++ b/config.h
@@ -458,7 +458,6 @@ void git_configset_clear(struct config_set *cs);
  */
 int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 
-int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 int git_configset_get_string_tmp(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
@@ -475,8 +474,6 @@ int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value);
 const struct string_list *repo_config_get_value_multi(struct repository *repo,
 						      const char *key);
-int repo_config_get_string_const(struct repository *repo,
-				 const char *key, const char **dest);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
 int repo_config_get_string_tmp(struct repository *repo,
