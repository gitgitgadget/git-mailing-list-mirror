From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 20:42:19 +0100
Message-ID: <1456931.yaNzKr1t0X@al>
References: <6997784.RuzRO1AFsK@al> <20141119190800.GB9908@peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4741814.Yvl7VsgZbe"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 20:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrB95-0004Uf-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 20:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976AbaKSTm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 14:42:27 -0500
Received: from lekensteyn.nl ([178.21.112.251]:45872 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751AbaKSTm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 14:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=r2fLl5/EovKBDGxdm9srxFfBVofw3uUDaMklrBvEcLY=;
	b=Yn/O84rmR7T1KEwVBXt2x72OFQ78HgzfRPTwm+zMMYhHg0CrXwUtuLWbez+SXjtlCoMskYweSriPGTbG2wd5J1YKF8uVM+IWKg3Agj8bVGwLXb8kS74HTHskqTqpwAxk7v3kLcuvUmmJnbqGQ6Q2JsRkPS9l7rEL4/hAQXx65tljAl171DNgNRH6z3pXXftR4ZkAPgBgUbE5NBMWl3haIaA1dVcjfYQg3bdNyrInqTRkVR+smMxx0Ezlljy5ZXJ9LjbtFclTk8tYLkRV3++IpyaIX4QggSyNkcK7iZmxZxh5Pxvb7efwl66bDi7vfJXZBtp/MCWU9ittbT4lscwvcQ==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XrB8u-00082T-6p; Wed, 19 Nov 2014 20:42:21 +0100
User-Agent: KMail/4.13.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.2; x86_64; ; )
In-Reply-To: <20141119190800.GB9908@peff.net>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart4741814.Yvl7VsgZbe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 19 November 2014 14:08:00 Jeff King wrote:
> On Wed, Nov 19, 2014 at 04:18:02PM +0100, Peter Wu wrote:
> 
> > git remote set-url knew about the '--push' option to update just the
> > pushurl, but it does not have a similar option for "update fetch URL and
> > leave whatever was in place for the push URL".
> 
> Isn't that what:
> 
>   git remote set-url foo new-fetch-url
> 
> does already? It affects only the "url" setting, which is the de-facto
> fetch setting (it is _also_ the push setting if there is no pushurl
> defined).

If pushurl is not set, then this will implicitly change the fetch URL
which is unwanted and fixed in this patch by introducing a --fetch
option.

> You gave this example:
> 
> >     git remote add gh git@github.com:Lekensteyn/git.git
> >     # Avoid needing SSH for pulling from a repo, so change fetch URL
> >     git remote set-url https://github.com/Lekensteyn/git.git
> >     # Hmm, the fetch URL got changed too, let's fix that.
> >     git remote add --push gh git@github.com:Lekensteyn/git.git
> 
> But here you do not have a pushurl defined in the first place. So I
> guess this is really just a shortcut for swapping the two, like:
> 
>   git remote set-url --push gh $(git config remote.gh.url)
>   git remote set-url gh new-fetch-url

Indeed, and not having a push URL is not uncommon (that is, always the
case when a new remote is added or just cloned). Compare the above
against this one:

    git remote set-url --fetch new-fetch-url

This is less verbose and is much more intuitive.

> I dunno. I guess that is more convenient, but it seems like a lot of
> code for a very marginal use case. But more importantly, I'm a little
> worried that the presence of --fetch creates confusion about what
> set-url without a --fetch or --push does. That is, it implies to me
> that:
> 
>   git remote add gh old-url
>   git remote set-url gh --push push-url
>   git remote set-url gh new-url
> 
> would replace both the "url" _and_ "pushurl" values in the third step,
> since we did not specify --fetch.  But it is in fact identical whether
> you run it with "--fetch" or not.  That is, it creates a weirdly
> non-orthogonal interface.

Step three currently only replaces the fetch URL as an explicit push URL
(remote.gh.pushurl) is set in step two (and therefore remote.gh.url does
not become the implicit push URL).

This might be a bug, but since it has been so long this way I was
worried that people actually rely on this behavior. The following sets
both url and pushurl (even if the URLs are equal):

    git remote set-url --push --fetch gh pushurl

The patch is not tiny, but also not overly large either even if it has
similar pieces of code duplicated. Care has been taken of to keep
backwards compatibility which has also increased the size.

By the way, in the old code there was a memleak as strbuf was not
released at the end of the function, isn't it? A new patch can be found
on the bottom, it fixes an issue in the tests (no change in other
parts).
-- 
Kind regards,
Peter
https://lekensteyn.nl

--nextPart4741814.Yvl7VsgZbe
Content-Disposition: inline; filename="0001-remote-add-new-fetch-option-for-set-url.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-remote-add-new-fetch-option-for-set-url.patch"

>From 6be164f68b4f625ac90f998ae4073e031ebed8ba Mon Sep 17 00:00:00 2001
From: Peter Wu <peter@lekensteyn.nl>
Date: Wed, 19 Nov 2014 15:57:40 +0100
Subject: [PATCHv2] remote: add new --fetch option for set-url

git remote set-url knew about the '--push' option to update just the
pushurl, but it does not have a similar option for "update fetch URL and
leave whatever was in place for the push URL".

This patch adds support for a '--fetch' option which implements that use
case in a backwards compatible way: if neither --push nor --fetch are
given, then the push URL is modified too if it was not set before. This
is the case since the push URL is implicitly based on the fetch URL.

The documentation has also been updated and a missing '--push' option
is added to the 'git remote -h' command.

Tests are also added to verify the documented behavior.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 Documentation/git-remote.txt |  12 +++--
 builtin/remote.c             | 106 +++++++++++++++++++++++++++++--------------
 t/t5505-remote.sh            |  54 ++++++++++++++++++++++
 3 files changed, 134 insertions(+), 38 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index cb103c8..7bb21a2 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -15,9 +15,9 @@ SYNOPSIS
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
 'git remote set-branches' [--add] <name> <branch>...
-'git remote set-url' [--push] <name> <newurl> [<oldurl>]
-'git remote set-url --add' [--push] <name> <newurl>
-'git remote set-url --delete' [--push] <name> <url>
+'git remote set-url' [--fetch] [--push] <name> <newurl> [<oldurl>]
+'git remote set-url' [--fetch] [--push] '--add' <name> <newurl>
+'git remote set-url' [--fetch] [--push] '--delete' <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
@@ -134,7 +134,11 @@ Changes URL remote points to. Sets first URL remote points to matching
 regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
 <oldurl> doesn't match any URL, error occurs and nothing is changed.
 +
-With '--push', push URLs are manipulated instead of fetch URLs.
+With '--push', push URLs are manipulated.
++
+With '--fetch', fetch URLs are manipulated. If neither '--push' nor '--fetch'
+are given, then (1) '--fetch' is assumed if no push URL is set in the
+configuration or (2) '--fetch --push' otherwise.
 +
 With '--add', instead of changing some URL, new URL is added.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..26caa6f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -18,9 +18,9 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url [--fetch] [--push] <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url [--fetch] [--push] --add <name> <newurl>"),
+	N_("git remote set-url [--fetch] [--push] --delete <name> <url>"),
 	NULL
 };
 
@@ -66,9 +66,9 @@ static const char * const builtin_remote_update_usage[] = {
 };
 
 static const char * const builtin_remote_seturl_usage[] = {
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url [--fetch] [--push] <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url [--fetch] [--push] --add <name> <newurl>"),
+	N_("git remote set-url [--fetch] [--push] --delete <name> <url>"),
 	NULL
 };
 
@@ -1505,18 +1505,19 @@ static int set_branches(int argc, const char **argv)
 
 static int set_url(int argc, const char **argv)
 {
-	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
+	int i, fetch_only = 0, push_only = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
 	const char *remotename = NULL;
 	const char *newurl = NULL;
 	const char *oldurl = NULL;
 	struct remote *remote;
 	regex_t old_regex;
-	const char **urlset;
-	int urlset_nr;
-	struct strbuf name_buf = STRBUF_INIT;
+	struct strbuf name_buf_fetch = STRBUF_INIT;
+	struct strbuf name_buf_push = STRBUF_INIT;
 	struct option options[] = {
-		OPT_BOOL('\0', "push", &push_mode,
+		OPT_BOOL('\0', "fetch", &fetch_only,
+			 N_("manipulate fetch URLs")),
+		OPT_BOOL('\0', "push", &push_only,
 			 N_("manipulate push URLs")),
 		OPT_BOOL('\0', "add", &add_mode,
 			 N_("add URL")),
@@ -1545,24 +1546,39 @@ static int set_url(int argc, const char **argv)
 		die(_("No such remote '%s'"), remotename);
 	remote = remote_get(remotename);
 
-	if (push_mode) {
-		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
-		urlset = remote->pushurl;
-		urlset_nr = remote->pushurl_nr;
-	} else {
-		strbuf_addf(&name_buf, "remote.%s.url", remotename);
-		urlset = remote->url;
-		urlset_nr = remote->url_nr;
-	}
+	strbuf_addf(&name_buf_fetch, "remote.%s.url", remotename);
+	strbuf_addf(&name_buf_push, "remote.%s.pushurl", remotename);
+
+	/* Backwards compatibility: do not copy fetch URL to push URL if push
+	 * URL is unset and --fetch and --push re missing */
+	if (!fetch_only && !push_only)
+		fetch_only = -1;
 
 	/* Special cases that add new entry. */
 	if ((!oldurl && !delete_mode) || add_mode) {
-		if (add_mode)
-			git_config_set_multivar(name_buf.buf, newurl,
-				"^$", 0);
-		else
-			git_config_set(name_buf.buf, newurl);
-		strbuf_release(&name_buf);
+		/* If --fetch was explicitly given, then ensure that the value
+		 * of push URL does not change by copying the fetch URL. */
+		if (fetch_only == 1 && !push_only &&
+				remote->pushurl_nr == 0 && remote->url_nr > 0)
+			for (i = 0; i < remote->url_nr; i++)
+				git_config_set_multivar(name_buf_push.buf,
+					remote->url[i], "^$", 0);
+
+		if (add_mode) {
+			if (fetch_only)
+				git_config_set_multivar(name_buf_fetch.buf,
+					newurl, "^$", 0);
+			if (push_only)
+				git_config_set_multivar(name_buf_push.buf,
+					newurl, "^$", 0);
+		} else {
+			if (fetch_only)
+				git_config_set(name_buf_fetch.buf, newurl);
+			if (push_only)
+				git_config_set(name_buf_push.buf, newurl);
+		}
+		strbuf_release(&name_buf_fetch);
+		strbuf_release(&name_buf_push);
 		return 0;
 	}
 
@@ -1570,22 +1586,44 @@ static int set_url(int argc, const char **argv)
 	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
 		die(_("Invalid old URL pattern: %s"), oldurl);
 
-	for (i = 0; i < urlset_nr; i++)
-		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
+	for (i = 0; fetch_only && i < remote->url_nr; i++)
+		if (!regexec(&old_regex, remote->url[i], 0, NULL, 0))
+			matches++;
+		else
+			negative_matches++;
+	if (delete_mode && !negative_matches && fetch_only)
+		die(_("Will not delete all non-push URLs"));
+	for (i = 0; push_only && i < remote->pushurl_nr; i++)
+		if (!regexec(&old_regex, remote->pushurl[i], 0, NULL, 0))
 			matches++;
 		else
 			negative_matches++;
 	if (!delete_mode && !matches)
 		die(_("No such URL found: %s"), oldurl);
-	if (delete_mode && !negative_matches && !push_mode)
-		die(_("Will not delete all non-push URLs"));
 
 	regfree(&old_regex);
 
-	if (!delete_mode)
-		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
-	else
-		git_config_set_multivar(name_buf.buf, NULL, oldurl, 1);
+	/* If --fetch was explicitly given, then ensure that the value
+	 * of push URL does not change by copying the fetch URL. */
+	if (fetch_only == 1 && !push_only &&
+			remote->pushurl_nr == 0 && remote->url_nr > 0)
+		for (i = 0; i < remote->url_nr; i++)
+			git_config_set_multivar(name_buf_push.buf,
+				remote->url[i], "^$", 0);
+
+	if (!delete_mode) {
+		if (fetch_only)
+			git_config_set_multivar(name_buf_fetch.buf, newurl, oldurl, 0);
+		if (push_only)
+			git_config_set_multivar(name_buf_push.buf, newurl, oldurl, 0);
+	} else {
+		if (fetch_only)
+			git_config_set_multivar(name_buf_fetch.buf, NULL, oldurl, 1);
+		if (push_only)
+			git_config_set_multivar(name_buf_push.buf, NULL, oldurl, 1);
+	}
+	strbuf_release(&name_buf_fetch);
+	strbuf_release(&name_buf_push);
 	return 0;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ac79dd9..a1bd383 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -961,6 +961,60 @@ test_expect_success 'remote set-url --push zot' '
 	cmp expect actual
 '
 
+test_expect_success 'remote set-url --fetch zox' '
+	git remote set-url --fetch someremote zox &&
+	echo zox >expect &&
+	echo "YYY" >>expect &&
+	echo zot >>expect &&
+	git config --get-all remote.someremote.url >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.pushurl >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --fetch --push foo' '
+	git remote set-url --fetch --push someremote foo &&
+	echo foo >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --delete --push foo' '
+	git remote set-url --delete --push someremote foo &&
+	echo "YYY" >expect &&
+	echo foo >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --push zot' '
+	git remote set-url --push someremote zot &&
+	echo zot >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --fetch baz foo' '
+	git remote set-url --fetch someremote baz foo &&
+	echo zot >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'remote set-url --push qux zot' '
 	git remote set-url --push someremote qux zot &&
 	echo qux >expect &&
-- 
2.1.2


--nextPart4741814.Yvl7VsgZbe--
