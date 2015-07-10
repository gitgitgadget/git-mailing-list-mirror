From: Jeff King <peff@peff.net>
Subject: Re: [RFC] ident: support per-path configs by matching the path
 against a pattern
Date: Fri, 10 Jul 2015 12:46:52 -0400
Message-ID: <20150710164652.GA30113@peff.net>
References: <0000014e7752e758-a0bf7acb-2d0f-4492-8004-8eeeb9b2f042-000000@eu-west-1.amazonses.com>
 <xmqqr3ogkpz5.fsf@gitster.dls.corp.google.com>
 <20150710154308.GA29395@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 18:47:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDbS0-0001Kk-3r
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 18:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbbGJQq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 12:46:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:58629 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932349AbbGJQqz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 12:46:55 -0400
Received: (qmail 18018 invoked by uid 102); 10 Jul 2015 16:46:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 11:46:54 -0500
Received: (qmail 9655 invoked by uid 107); 10 Jul 2015 16:46:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 12:46:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jul 2015 12:46:52 -0400
Content-Disposition: inline
In-Reply-To: <20150710154308.GA29395@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273825>

On Fri, Jul 10, 2015 at 11:43:08AM -0400, Jeff King wrote:

> But something like:
> 
>   [include "gitdir:bar"]
>   path = foo
> 
> could do so only when the "gitdir:bar" conditional is satisfied (where
> that is just a syntax I made up to mean fnmatch("bar", $GIT_DIR)). So
> like user.<pattern>.*, we still put our section-specific hack into one
> special section, but that one place is capable of chaining to multiple
> other config keys. :)

Here's a sketch if anybody is inclined to pick it up and run with it.
Note that I did not think too hard about little things like the
de-anchoring.

---
diff --git a/config.c b/config.c
index 29fa012..47b01f0 100644
--- a/config.c
+++ b/config.c
@@ -139,9 +139,45 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	return ret;
 }
 
+static int include_condition_is_true(const char *cond, int cond_len)
+{
+	const char *value;
+
+	/* no condition (i.e., "include.path") is always true */
+	if (!cond)
+		return 1;
+
+	/*
+	 * It's OK to run over cond_len in our checks here, as that just pushes
+	 * us past the final ".", which cannot match any of our prefixes.
+	 */
+	if (skip_prefix(cond, "gitdir:", &value)) {
+		struct strbuf text = STRBUF_INIT;
+		struct strbuf pattern = STRBUF_INIT;
+		int ret;
+
+		strbuf_add_absolute_path(&text, get_git_dir());
+
+		/* de-anchor match for convenience */
+		strbuf_addstr(&pattern, "**");
+		strbuf_add(&pattern, value, cond_len - (value - cond));
+		strbuf_addstr(&pattern, "**");
+
+		ret = !wildmatch(pattern.buf, text.buf, 0, NULL);
+		strbuf_release(&pattern);
+		strbuf_release(&text);
+		return ret;
+	}
+
+	/* unknown conditionals are always false */
+	return 0;
+}
+
 int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	const char *cond, *key;
+	int cond_len;
 	int ret;
 
 	/*
@@ -152,8 +188,12 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(value, inc);
+	if (!parse_config_key(var, "include", &cond, &cond_len, &key) &&
+	    include_condition_is_true(cond, cond_len)) {
+		if (!strcmp(key, "path"))
+			ret = handle_path_include(value, inc);
+		/* else we do not know about this type of include; ignore */
+	}
 	return ret;
 }
 
