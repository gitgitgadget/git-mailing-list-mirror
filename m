From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/6] add -A: only show pathless 'add -A' warning when changes
 exist outside cwd
Date: Tue, 19 Mar 2013 15:51:34 -0700
Message-ID: <20130319225134.GF19014@google.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 23:52:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI5O3-00043S-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 23:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934117Ab3CSWvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 18:51:40 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:33113 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436Ab3CSWvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 18:51:39 -0400
Received: by mail-pb0-f42.google.com with SMTP id xb4so811378pbc.15
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Vc17kYuIJDPzUh6sWVasUJ/NFrRgtcv9MWX9GzL7n2k=;
        b=UGkNO9sV5IOy43KArKNiMpkhH6HhYcIKq8CQ3kxJHaYzc22iXWHskC6vcnpBtuLCQe
         v9Y22pf1XnOAnSs6GJMUQbfgOiV49AAJhq+njidTsZiahPfY/3n+FTiDxp4b89rwWapK
         sH6uzzT1uLjp1NpVQeTqj/bT+NZvSJBEIvM51BP0zpixJ00L60xaPPefbpsKjZEcVvx0
         O/Sa5cMG5MEeM070L+u8Pth2I3MDghkZZRcuBA1vJD6dlnwkIIFFEsJCtAS0TI9t/6gV
         zHR5KnAYRyCSPYyngtDhLfSIh3Ptiqk9PfTaYqVBhmt6KWVkJRhOOHBjpHK771/jhmHe
         1rMQ==
X-Received: by 10.68.212.135 with SMTP id nk7mr5751526pbc.120.1363733499082;
        Tue, 19 Mar 2013 15:51:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id eh5sm25784059pbc.44.2013.03.19.15.51.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 15:51:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319224400.GA19014@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218565>

In the spirit of the recent similar change for 'git add -u', avoid
pestering users that restrict their attention to a subdirectory and
will not be affected by the coming change in the behavior of pathless
'git add -A'.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.

 builtin/add.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4d8d441..2493493 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -170,7 +170,9 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 	return !!data.add_errors;
 }
 
-static char *prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
+#define WARN_IMPLICIT_DOT (1u << 0)
+static char *prune_directory(struct dir_struct *dir, const char **pathspec,
+			     int prefix, unsigned flag)
 {
 	char *seen;
 	int i, specs;
@@ -187,6 +189,16 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
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
@@ -433,8 +445,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	if (option_with_implicit_dot && !argc) {
 		static const char *here[2] = { ".", NULL };
-		if (prefix && addremove)
-			warn_pathless_add();
 		argc = 1;
 		argv = here;
 		implicit_dot = 1;
@@ -475,9 +485,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
