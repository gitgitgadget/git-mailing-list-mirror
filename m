Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E10C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 11:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A872A60EC0
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 11:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhGWKb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 06:31:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:55742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhGWKb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 06:31:57 -0400
Received: (qmail 11356 invoked by uid 109); 23 Jul 2021 11:12:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 11:12:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24868 invoked by uid 111); 23 Jul 2021 11:12:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 07:12:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 07:12:30 -0400
From:   Jeff King <peff@peff.net>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH] submodule: drop unused sm_name parameter from
 show_fetch_remotes()
Message-ID: <YPqkHs47VDFBNZ0Z@coredump.intra.peff.net>
References: <20210708095533.26226-1-raykar.ath@gmail.com>
 <20210710074801.19917-1-raykar.ath@gmail.com>
 <20210710074801.19917-5-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210710074801.19917-5-raykar.ath@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 01:18:01PM +0530, Atharva Raykar wrote:

> +static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
> +{
> +	struct child_process cp_remote = CHILD_PROCESS_INIT;
> +	struct strbuf sb_remote_out = STRBUF_INIT;
> +
> +	cp_remote.git_cmd = 1;
> +	strvec_pushf(&cp_remote.env_array,
> +		     "GIT_DIR=%s", git_dir_path);
> +	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=.");
> +	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
> +	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
> +		char *next_line;
> +		char *line = sb_remote_out.buf;
> +		while ((next_line = strchr(line, '\n')) != NULL) {
> +			size_t len = next_line - line;
> +			if (strip_suffix_mem(line, &len, " (fetch)"))
> +				fprintf(output, "  %.*s\n", (int)len, line);
> +			line = next_line + 1;
> +		}
> +	}
> +
> +	strbuf_release(&sb_remote_out);
> +}

The sm_name parameter is not used here. I don't think it's a bug; we
just don't need it (there's a message that mentions the name, but it
happens right before we call the function). Maybe this should go on top
of ar/submodule-add?

-- >8 --
Subject: submodule: drop unused sm_name parameter from show_fetch_remotes()

This parameter has not been used since the function was introduced in
8c8195e9c3 (submodule--helper: introduce add-clone subcommand,
2021-07-10).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ed4a50c78e..1e65ff599e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2782,7 +2782,7 @@ struct add_data {
 };
 #define ADD_DATA_INIT { .depth = -1 }
 
-static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
+static void show_fetch_remotes(FILE *output, const char *git_dir_path)
 {
 	struct child_process cp_remote = CHILD_PROCESS_INIT;
 	struct strbuf sb_remote_out = STRBUF_INIT;
@@ -2833,8 +2833,7 @@ static int add_submodule(const struct add_data *add_data)
 				fprintf(stderr, _("A git directory for '%s' is found "
 						  "locally with remote(s):"),
 					add_data->sm_name);
-				show_fetch_remotes(stderr, add_data->sm_name,
-						   submod_gitdir_path);
+				show_fetch_remotes(stderr, submod_gitdir_path);
 				free(submod_gitdir_path);
 				die(_("If you want to reuse this local git "
 				      "directory instead of cloning again from\n"
-- 
2.32.0.784.g92e169d3d7

