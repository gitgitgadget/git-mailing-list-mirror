Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CA01FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 15:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933427AbcLIPWX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 10:22:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:54203 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933318AbcLIPWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 10:22:22 -0500
Received: (qmail 3001 invoked by uid 109); 9 Dec 2016 15:22:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 15:22:22 +0000
Received: (qmail 18831 invoked by uid 111); 9 Dec 2016 15:23:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 10:23:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2016 10:22:19 -0500
Date:   Fri, 9 Dec 2016 10:22:19 -0500
From:   Jeff King <peff@peff.net>
To:     Klaus Ethgen <Klaus@Ethgen.ch>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 03:02:15PM +0100, Klaus Ethgen wrote:

> I have some repositories where I have a colon in the (local) url for a
> remote. That was no problem until now but with 2.11.0, I see the
> following problem:
>    ~> git push
>    Counting objects: 11, done.
>    Delta compression using up to 8 threads.
>    Compressing objects: 100% (10/10), done.
>    Writing objects: 100% (11/11), 1.26 KiB | 0 bytes/s, done.
>    Total 11 (delta 7), reused 0 (delta 0)
>    remote: error: object directory /home/xxx does not exist; check .git/objects/info/alternates.
>    remote: error: object directory yyy.git/objects does not exist; check .git/objects/info/alternates.
>    remote: fatal: unresolved deltas left after unpacking

Hrm. The problem v2.11's new object-quarantine system. The receiving
side of a push will write into a new temporary object directory, and
refer to the original with the GIT_ALTERNATE_OBJECT_DIRECTORIES
environment variable. But that variable splits its entries on ":", and
has no way of representing a path that includes a ":".

So I think the solution would probably be to introduce some kind of
quoting mechanism to that variable, so that it can pass through
arbitrary paths. Or alternatively use a separate variable, but that does
nothing to help other cases where somebody wants to use xxx:yyy.git as
an alternate.

(One other option is to just declare that the quarantine feature doesn't
work with colons in the pathname, but stop turning it on by default. I'm
not sure I like that, though).

Here's a rough idea of what the quoting solution could look like. It
should make your case work, but I'm not sure what we want to do about
backwards-compatibility, if anything.

---
 sha1_file.c  | 41 ++++++++++++++++++++++++++++++-----------
 tmp-objdir.c | 18 ++++++++++++++++--
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9c86d1924..a0b341b5a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -329,13 +329,35 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	return 0;
 }
 
+const char *parse_alt_odb_entry(const char *string, int sep,
+				struct strbuf *out)
+{
+	const char *p;
+	int literal = 0;
+
+	strbuf_reset(out);
+
+	for (p = string; *p; p++) {
+		if (literal) {
+			strbuf_addch(out, *p);
+			literal = 0;
+		} else {
+			if (*p == '\\')
+				literal = 1;
+			else if (*p == sep)
+				return p + 1;
+			else
+				strbuf_addch(out, *p);
+		}
+	}
+	return p;
+}
+
 static void link_alt_odb_entries(const char *alt, int len, int sep,
 				 const char *relative_base, int depth)
 {
-	struct string_list entries = STRING_LIST_INIT_NODUP;
-	char *alt_copy;
-	int i;
 	struct strbuf objdirbuf = STRBUF_INIT;
+	struct strbuf entry = STRBUF_INIT;
 
 	if (depth > 5) {
 		error("%s: ignoring alternate object stores, nesting too deep.",
@@ -348,16 +370,13 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
 
-	alt_copy = xmemdupz(alt, len);
-	string_list_split_in_place(&entries, alt_copy, sep, -1);
-	for (i = 0; i < entries.nr; i++) {
-		const char *entry = entries.items[i].string;
-		if (entry[0] == '\0' || entry[0] == '#')
+	while (*alt) {
+		alt = parse_alt_odb_entry(alt, sep, &entry);
+		if (!entry.len || entry.buf[0] == '#')
 			continue;
-		link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
 	}
-	string_list_clear(&entries, 0);
-	free(alt_copy);
+	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
 }
 
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 64435f23a..900e15af1 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -70,6 +70,17 @@ static void remove_tmp_objdir_on_signal(int signo)
 	raise(signo);
 }
 
+static char *backslash_quote(const char *s, int delim)
+{
+	struct strbuf buf = STRBUF_INIT;
+	while (*s) {
+		if (*s == '\\' || *s == delim)
+			strbuf_addch(&buf, '\\');
+		strbuf_addch(&buf, *s++);
+	}
+	return strbuf_detach(&buf, NULL);
+}
+
 /*
  * These env_* functions are for setting up the child environment; the
  * "replace" variant overrides the value of any existing variable with that
@@ -79,12 +90,15 @@ static void remove_tmp_objdir_on_signal(int signo)
  */
 static void env_append(struct argv_array *env, const char *key, const char *val)
 {
+	char *quoted = backslash_quote(val, PATH_SEP);
 	const char *old = getenv(key);
 
 	if (!old)
-		argv_array_pushf(env, "%s=%s", key, val);
+		argv_array_pushf(env, "%s=%s", key, quoted);
 	else
-		argv_array_pushf(env, "%s=%s%c%s", key, old, PATH_SEP, val);
+		argv_array_pushf(env, "%s=%s%c%s", key, old, PATH_SEP, quoted);
+
+	free(quoted);
 }
 
 static void env_replace(struct argv_array *env, const char *key, const char *val)
-- 
2.11.0.201.g51bd297

