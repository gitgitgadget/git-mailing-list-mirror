Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74230C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 19:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCQTRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCQTRL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 15:17:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617E43934
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:16:41 -0700 (PDT)
Received: (qmail 25984 invoked by uid 109); 17 Mar 2023 19:16:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Mar 2023 19:16:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27491 invoked by uid 111); 17 Mar 2023 19:16:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Mar 2023 15:16:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Mar 2023 15:16:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 1/4] mailmap: drop debugging code
Message-ID: <ZBS8illla36MVppa@coredump.intra.peff.net>
References: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's some debugging code in mailmap.c which is only compiled if you
manually tweak the source to set DEBUG_MAILMAP. When it's not set, the
fallback noop uses static inline functions; we couldn't use macros here
because one of the functions is variadic (and variadic macros were
forbidden back then, but aren't now). As a result, this triggers
a -Wunused-parameter warning.

We have a few options here:

  1. Leave it be. Just mark it as UNUSED, or switch to a variadic macro.

  2. Assume the debugging code is useful, compile it always, and trigger
     it with a run-time flag (e.g., with a trace key). This is pretty
     easy to do, and carries a pretty small runtime cost.

  3. Assume the debugging is not very useful, and just rip it out. This
     matches what we did with a similar case in 69c5f17f11 (attr: drop
     DEBUG_ATTR code, 2022-10-06).

The debugging flag has been mentioned only three times on the list.
Once, when it was added in 2009:

  https://lore.kernel.org/git/cover.1234102794.git.marius@trolltech.com/

In 2013, when somebody fixed some compilation errors in the conditional
code (presumably because they used it while making other changes):

  https://lore.kernel.org/git/1373871253-96480-1-git-send-email-sunshine@sunshineco.com/

And finally it seemed to have been useful to somebody in 2021:

  https://lore.kernel.org/git/87eejswql6.fsf@evledraar.gmail.com/

So it's not totally without value. On the other hand, it's not likely to
be useful to non-developers (and certainly isn't if you have to
recompile). And using a debugger or adding your own inspection code is
likely to be as useful. So I've just dropped the code entirely here.

Note that we do still have to mark a few parameters unused in callback
functions which are passed to string_list_clear_func(). Those get an
extra pointer with the string being cleared, which we previously fed to
the debugging code.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm cc-ing folks from those earlier threads. If somebody really wants to
salvage it, I can prepare a patch converting it to a trace variable
instead, but absent any outcry, I'd go with this approach.

 mailmap.c | 42 +++---------------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index da2589b0822..22e90129ea8 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -3,16 +3,6 @@
 #include "mailmap.h"
 #include "object-store.h"
 
-#define DEBUG_MAILMAP 0
-#if DEBUG_MAILMAP
-#define debug_mm(...) fprintf(stderr, __VA_ARGS__)
-#define debug_str(X) ((X) ? (X) : "(none)")
-#else
-__attribute__((format (printf, 1, 2)))
-static inline void debug_mm(const char *format, ...) {}
-static inline const char *debug_str(const char *s) { return s; }
-#endif
-
 const char *git_mailmap_file;
 const char *git_mailmap_blob;
 
@@ -30,23 +20,17 @@ struct mailmap_entry {
 	struct string_list namemap;
 };
 
-static void free_mailmap_info(void *p, const char *s)
+static void free_mailmap_info(void *p, const char *s UNUSED)
 {
 	struct mailmap_info *mi = (struct mailmap_info *)p;
-	debug_mm("mailmap: -- complex: '%s' -> '%s' <%s>\n",
-		 s, debug_str(mi->name), debug_str(mi->email));
 	free(mi->name);
 	free(mi->email);
 	free(mi);
 }
 
-static void free_mailmap_entry(void *p, const char *s)
+static void free_mailmap_entry(void *p, const char *s UNUSED)
 {
 	struct mailmap_entry *me = (struct mailmap_entry *)p;
-	debug_mm("mailmap: removing entries for <%s>, with %"PRIuMAX" sub-entries\n",
-		 s, (uintmax_t)me->namemap.nr);
-	debug_mm("mailmap: - simple: '%s' <%s>\n",
-		 debug_str(me->name), debug_str(me->email));
 
 	free(me->name);
 	free(me->email);
@@ -93,8 +77,6 @@ static void add_mapping(struct string_list *map,
 	}
 
 	if (!old_name) {
-		debug_mm("mailmap: adding (simple) entry for '%s'\n", old_email);
-
 		/* Replace current name and new email for simple entry */
 		if (new_name) {
 			free(me->name);
@@ -106,15 +88,10 @@ static void add_mapping(struct string_list *map,
 		}
 	} else {
 		struct mailmap_info *mi = xcalloc(1, sizeof(struct mailmap_info));
-		debug_mm("mailmap: adding (complex) entry for '%s'\n", old_email);
 		mi->name = xstrdup_or_null(new_name);
 		mi->email = xstrdup_or_null(new_email);
 		string_list_insert(&me->namemap, old_name)->util = mi;
 	}
-
-	debug_mm("mailmap:  '%s' <%s> -> '%s' <%s>\n",
-		 debug_str(old_name), old_email,
-		 debug_str(new_name), debug_str(new_email));
 }
 
 static char *parse_name_and_email(char *buffer, char **name,
@@ -250,11 +227,8 @@ int read_mailmap(struct string_list *map)
 
 void clear_mailmap(struct string_list *map)
 {
-	debug_mm("mailmap: clearing %"PRIuMAX" entries...\n",
-		 (uintmax_t)map->nr);
 	map->strdup_strings = 1;
 	string_list_clear_func(map, free_mailmap_entry);
-	debug_mm("mailmap: cleared\n");
 }
 
 /*
@@ -315,10 +289,6 @@ int map_user(struct string_list *map,
 	struct string_list_item *item;
 	struct mailmap_entry *me;
 
-	debug_mm("map_user: map '%.*s' <%.*s>\n",
-		 (int)*namelen, debug_str(*name),
-		 (int)*emaillen, debug_str(*email));
-
 	item = lookup_prefix(map, *email, *emaillen);
 	if (item) {
 		me = (struct mailmap_entry *)item->util;
@@ -336,10 +306,8 @@ int map_user(struct string_list *map,
 	}
 	if (item) {
 		struct mailmap_info *mi = (struct mailmap_info *)item->util;
-		if (mi->name == NULL && mi->email == NULL) {
-			debug_mm("map_user:  -- (no simple mapping)\n");
+		if (mi->name == NULL && mi->email == NULL)
 			return 0;
-		}
 		if (mi->email) {
 				*email = mi->email;
 				*emaillen = strlen(*email);
@@ -348,11 +316,7 @@ int map_user(struct string_list *map,
 				*name = mi->name;
 				*namelen = strlen(*name);
 		}
-		debug_mm("map_user:  to '%.*s' <%.*s>\n",
-			 (int)*namelen, debug_str(*name),
-			 (int)*emaillen, debug_str(*email));
 		return 1;
 	}
-	debug_mm("map_user:  --\n");
 	return 0;
 }
-- 
2.40.0.581.g8d688c70eca

