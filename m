Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D8820248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbfCASaT (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 13:30:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:34698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388934AbfCASaT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:30:19 -0500
Received: (qmail 20092 invoked by uid 109); 1 Mar 2019 18:30:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 18:30:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32486 invoked by uid 111); 1 Mar 2019 18:30:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 13:30:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 13:30:17 -0500
Date:   Fri, 1 Mar 2019 13:30:17 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190301183017.GB30847@sigill.intra.peff.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301173443.16429-1-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 12:34:40PM -0500, Todd Zullinger wrote:

> Jeff King wrote:
> > I can reproduce your problem, though the test you included passes for me
> > even with the current tip of master.
> 
> Oh, hrm.  I think the issue is that completion.commands needs to be
> set in the global (or system-wide) config, via test_config_global
> rather than the local repo config which test_config sets.
> 
> In hindsight, that seems obvious.  But it's probably worth noting
> that where completion.commands is documented, for anyone who might
> spend a few cycles trying to configure it on a per-repo basis before
> realizing it doesn't work.

I think this is actually a bug. Normally code that is checking config
before we've decide to do setup_git_directory() would use
read_early_config(), which uses discover_git_directory() to tentatively
see if we're in a repo, and if so to add it to the config sequence.

But this code uses the caching configset mechanism. And that code
(rightly) does not use read_early_config(), because it has no idea if
it's being called early or what.

I think we probably ought to be doing something like this:

diff --git a/git.c b/git.c
index 2dd588674f..ba3690245e 100644
--- a/git.c
+++ b/git.c
@@ -62,6 +62,13 @@ static int list_cmds(const char *spec)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int i;
+	int nongit;
+
+	/*
+	 * Set up the repository so we can pick up any repo-level config (like
+	 * completion.commands).
+	 */
+	setup_git_directory_gently(&nongit);
 
 	while (*spec) {
 		const char *sep = strchrnul(spec, ',');

> I'll leave it to those who know better to follow up with a change to
> use string_list_split().

It's less of an improvement than I'd hoped, since most of the code is
actually handling the "-" thing. So I don't think it's really worth the
churn. But here's what it looks like for reference:

---
 help.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/help.c b/help.c
index 026f881715..9e4d258cb8 100644
--- a/help.c
+++ b/help.c
@@ -373,7 +373,9 @@ void list_cmds_by_category(struct string_list *list,
 
 void list_cmds_by_config(struct string_list *list)
 {
-	const char *cmd_list;
+	const char *cmd_str;
+	struct string_list cmd_list = STRING_LIST_INIT_DUP;
+	int i;
 
 	/*
 	 * There's no actual repository setup at this point (and even
@@ -382,26 +384,22 @@ void list_cmds_by_config(struct string_list *list)
 	 * too since the caller (git --list-cmds=) should exit shortly
 	 * anyway.
 	 */
-	if (git_config_get_string_const("completion.commands", &cmd_list))
+	if (git_config_get_string_const("completion.commands", &cmd_str))
 		return;
 
 	string_list_sort(list);
 	string_list_remove_duplicates(list, 0);
 
-	while (*cmd_list) {
-		struct strbuf sb = STRBUF_INIT;
-		const char *p = strchrnul(cmd_list, ' ');
+	string_list_split(&cmd_list, cmd_str, ' ', -1);
+	for (i = 0; i < cmd_list.nr; i++) {
+		const char *cmd = cmd_list.items[0].string;
 
-		strbuf_add(&sb, cmd_list, p - cmd_list);
-		if (sb.buf[0] == '-')
-			string_list_remove(list, sb.buf + 1, 0);
+		if (*cmd == '-')
+			string_list_remove(list, cmd + 1, 0);
 		else
-			string_list_insert(list, sb.buf);
-		strbuf_release(&sb);
-		while (*p == ' ')
-			p++;
-		cmd_list = p;
+			string_list_insert(list, cmd);
 	}
+	string_list_clear(&cmd_list, 0);
 }
 
 void list_common_guides_help(void)
