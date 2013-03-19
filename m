From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] add -A: only show pathless 'add -A' warning when changes
 exist outside cwd
Date: Mon, 18 Mar 2013 20:49:11 -0700
Message-ID: <20130319034910.GM5062@elie.Belkin>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 04:49:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHnYU-0003wq-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 04:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab3CSDtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 23:49:16 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62702 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab3CSDtP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 23:49:15 -0400
X-Greylist: delayed 16707 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2013 23:49:15 EDT
Received: by mail-pd0-f180.google.com with SMTP id g10so16270pdj.11
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 20:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HzEvXitgQUWmLqk/mXe+YLMR06RIkiGmlndwKHLXViM=;
        b=pYjAzhE+WNauGEBZmZwCZG9wfiwHwRj+mSL5ccOOtMthRye0o5PA9LfE/f1eaf/l5z
         Y160oUhiwaP184K4Go8C3X8y0WPz1DzQ8xxp2Dh8+iyCn3yOdzYzbitKGisOlqANAq+m
         AXSb4pwZz8eIgFINQf0b91ijgKpS3JL5l4xJ1LZQbYJTPWC8hOIxWwTUJFmQ56UxpUBK
         uxVUXyJ8bSiij2uhAI9WWHIlL+TiV2qmb3DlenO6XdKFc86xjuL/Eg/HzYSCe/AIhte7
         dEx7mxSPmvPRsXZ7bhLzr+wGZNVtFcijZgVNht+u4niytEdmR3Ao4SRxRoD0YGrzRqNy
         m/rQ==
X-Received: by 10.66.242.48 with SMTP id wn16mr1026144pac.54.1363664954989;
        Mon, 18 Mar 2013 20:49:14 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id hu2sm22491519pbc.38.2013.03.18.20.49.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 20:49:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319034415.GI5062@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218477>

In the spirit of the recent similar change for 'git add -u', avoid
pestering users that restrict their attention to a subdirectory and
will not be affected by the coming change in the behavior of pathless
'git add -A'.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f05ec1c1..56ac4519 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -160,7 +160,9 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 	return !!data.add_errors;
 }
 
-static char *prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
+#define WARN_IMPLICIT_DOT (1u << 0)
+static char *prune_directory(struct dir_struct *dir, const char **pathspec,
+			     int prefix, unsigned flag)
 {
 	char *seen;
 	int i, specs;
@@ -177,6 +179,16 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
 		if (match_pathspec(pathspec, entry->name, entry->len,
 				   prefix, seen))
 			*dst++ = entry;
+		else if (flag & WARN_IMPLICIT_DOT)
+			/*
+			 * "git add -A" was run from a subdirectory with a
+			 * new file outside that directory.
+			 *
+			 * "git add -A" will behave like "git add -A :/"
+			 * instead of "git add -A ." in the future.
+			 * Warn about the coming behavior change.
+			 */
+			warn_pathless_add();
 	}
 	dir->nr = dst - dir->entries;
 	add_pathspec_matches_against_index(pathspec, seen, specs);
@@ -423,8 +435,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	if (option_with_implicit_dot && !argc) {
 		static const char *here[2] = { ".", NULL };
-		if (prefix && addremove)
-			warn_pathless_add();
 		argc = 1;
 		argv = here;
 		implicit_dot = 1;
@@ -464,9 +474,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		}
 
 		/* This picks up the paths that are not tracked */
-		baselen = fill_directory(&dir, pathspec);
+		baselen = fill_directory(&dir, implicit_dot ? NULL : pathspec);
 		if (pathspec)
-			seen = prune_directory(&dir, pathspec, baselen);
+			seen = prune_directory(&dir, pathspec, baselen,
+					implicit_dot ? WARN_IMPLICIT_DOT : 0);
 	}
 
 	if (refresh_only) {
-- 
1.8.2.rc3
