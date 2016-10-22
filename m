Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B58520229
	for <e@80x24.org>; Sat, 22 Oct 2016 05:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbcJVF1B (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 01:27:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:32806 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751678AbcJVF1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 01:27:00 -0400
Received: (qmail 14219 invoked by uid 109); 22 Oct 2016 05:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 05:27:00 +0000
Received: (qmail 9567 invoked by uid 111); 22 Oct 2016 05:27:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 01:27:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2016 01:26:57 -0400
Date:   Sat, 22 Oct 2016 01:26:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: detect and reject too-long paths
Message-ID: <20161022052657.tbaoopai4ud5v7m7@sigill.intra.peff.net>
References: <20161022045938.h3xa3yapzlg427vy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161022045938.h3xa3yapzlg427vy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2016 at 12:59:38AM -0400, Jeff King wrote:

> When we are checking the path via path_ok(), we use some
> fixed PATH_MAX buffers. We write into them via snprintf(),
> so there's no possibility of overflow, but it does mean we
> may silently truncate the path, leading to potentially
> confusing errors when the partial path does not exist.
> 
> We're better off to reject the path explicitly.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Another option would be to switch to strbufs here. That potentially
> introduces cases where a client can convince us to just keep allocating
> memory, but I don't think so in practice; the paths and interpolated
> data items all have to come in 64K pkt-lines, which places a hard
> limit. This is a much more minimal change, though, and I don't hear
> anybody complaining about the inability to use large paths.

For reference, the switch to dynamic memory looks something like this.
We don't even need strbufs, and we can get rid of the static variables
entirely (they weren't about buffer reuse, but just about extending the
lifetime past the return value).

Though we do have to add some free()s to avoid leaking error cases, this
looks simpler to me (the return value _is_ leaked in the success case,
because the caller doesn't know if we returned the original value or a
newly allocated one. In practice it doesn't matter because we call this
function once per process; compare to the 8K of BSS being wasted in the
original).

diff --git a/daemon.c b/daemon.c
index 425aad0507..4575ce5 100644
--- a/daemon.c
+++ b/daemon.c
@@ -158,8 +158,7 @@ static size_t expand_path(struct strbuf *sb, const char *placeholder, void *ctx)
 
 static const char *path_ok(const char *directory, struct hostinfo *hi)
 {
-	static char rpath[PATH_MAX];
-	static char interp_path[PATH_MAX];
+	char *to_free = NULL;
 	const char *path;
 	const char *dir;
 
@@ -187,9 +186,9 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 			namlen = slash - dir;
 			restlen -= namlen;
 			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
-			snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
-				 namlen, dir, user_path, restlen, slash);
-			dir = rpath;
+			dir = to_free = xstrfmt("%.*s/%s%.*s",
+						namlen, dir, user_path,
+						restlen, slash);
 		}
 	}
 	else if (interpolated_path && hi->saw_extended_args) {
@@ -207,11 +206,8 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 
 		strbuf_expand(&expanded_path, interpolated_path,
 			      expand_path, &context);
-		strlcpy(interp_path, expanded_path.buf, PATH_MAX);
-		strbuf_release(&expanded_path);
-		loginfo("Interpolated dir '%s'", interp_path);
-
-		dir = interp_path;
+		dir = to_free = strbuf_detach(&expanded_path, NULL);
+		loginfo("Interpolated dir '%s'", dir);
 	}
 	else if (base_path) {
 		if (*dir != '/') {
@@ -219,8 +215,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
 			return NULL;
 		}
-		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
-		dir = rpath;
+		dir = to_free = xstrfmt("%s%s", base_path, dir);
 	}
 
 	path = enter_repo(dir, strict_paths);
@@ -229,12 +224,15 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		 * if we fail and base_path_relaxed is enabled, try without
 		 * prefixing the base path
 		 */
+		free(to_free);
+		to_free = NULL;
 		dir = directory;
 		path = enter_repo(dir, strict_paths);
 	}
 
 	if (!path) {
 		logerror("'%s' does not appear to be a git repository", dir);
+		free(to_free);
 		return NULL;
 	}
 
@@ -265,6 +263,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 	}
 
 	logerror("'%s': not in whitelist", path);
+	free(to_free);
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
