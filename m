Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF01E206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbcLLTw1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:52:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:55321 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbcLLTw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:52:26 -0500
Received: (qmail 1637 invoked by uid 109); 12 Dec 2016 19:52:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 19:52:26 +0000
Received: (qmail 8845 invoked by uid 111); 12 Dec 2016 19:53:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 14:53:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2016 14:52:22 -0500
Date:   Mon, 12 Dec 2016 14:52:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: [PATCH 1/2] alternates: accept double-quoted paths
Message-ID: <20161212195222.rxnabok6amklt2zf@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We read lists of alternates from objects/info/alternates
files (delimited by newline), as well as from the
GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable
(delimited by colon or semi-colon, depending on the
platform).

There's no mechanism for quoting the delimiters, so it's
impossible to specify an alternate path that contains a
colon in the environment, or one that contains a newline in
a file. We've lived with that restriction for ages because
both alternates and filenames with colons are relatively
rare, and it's only a problem when the two meet. But since
722ff7f87 (receive-pack: quarantine objects until
pre-receive accepts, 2016-10-03), which builds on the
alternates system, every push causes the receiver to set
GIT_ALTERNATE_OBJECT_DIRECTORIES internally.

It would be convenient to have some way to quote the
delimiter so that we can represent arbitrary paths.

The simplest thing would be an escape character before a
quoted delimiter (e.g., "\:" as a literal colon). But that
creates a backwards compatibility problem: any path which
uses that escape character is now broken, and we've just
shifted the problem. We could choose an unlikely escape
character (e.g., something from the non-printable ASCII
range), but that's awkward to use.

Instead, let's treat names as unquoted unless they begin
with a double-quote, in which case they are interpreted via
our usual C-stylke quoting rules. This also breaks
backwards-compatibility, but in a smaller way: it only
matters if your file has a double-quote as the very _first_
character in the path (whereas an escape character is a
problem anywhere in the path).  It's also consistent with
many other parts of git, which accept either a bare pathname
or a double-quoted one, and the sender can choose to quote
or not as required.

Signed-off-by: Jeff King <peff@peff.net>
---
This also lets you specify paths that start with "#", or ones that
contain newlines in an alternates file, though I doubt anybody really
cares much in practice. I didn't even bother to add them to the test
suite, mostly because of the compatibility hassle (though I guess we
could just mark them with !MINGW and be OK).

 Documentation/git.txt    |  6 ++++++
 sha1_file.c              | 47 ++++++++++++++++++++++++++++++++++++-----------
 t/t5615-alternate-env.sh | 18 ++++++++++++++++++
 3 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index af191c51b..98033302b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -871,6 +871,12 @@ Git so take care if using a foreign front-end.
 	specifies a ":" separated (on Windows ";" separated) list
 	of Git object directories which can be used to search for Git
 	objects. New objects will not be written to these directories.
++
+	Entries that begin with `"` (double-quote) will be interpreted
+	as C-style quoted paths, removing leading and trailing
+	double-quotes and respecting backslash escapes. E.g., the value
+	`"path-with-\"-and-:-in-it":vanilla-path` has two paths:
+	`path-with-"-and-:-in-it` and `vanilla-path`.
 
 `GIT_DIR`::
 	If the `GIT_DIR` environment variable is set then it
diff --git a/sha1_file.c b/sha1_file.c
index 9c86d1924..117307185 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -26,6 +26,7 @@
 #include "mru.h"
 #include "list.h"
 #include "mergesort.h"
+#include "quote.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -329,13 +330,40 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	return 0;
 }
 
+static const char *parse_alt_odb_entry(const char *string,
+				       int sep,
+				       struct strbuf *out)
+{
+	const char *end;
+
+	strbuf_reset(out);
+
+	if (*string == '#') {
+		/* comment; consume up to next separator */
+		end = strchrnul(string, sep);
+	} else if (*string == '"' && !unquote_c_style(out, string, &end)) {
+		/*
+		 * quoted path; unquote_c_style has copied the
+		 * data for us and set "end". Broken quoting (e.g.,
+		 * an entry that doesn't end with a quote) falls
+		 * back to the unquoted case below.
+		 */
+	} else {
+		/* normal, unquoted path */
+		end = strchrnul(string, sep);
+		strbuf_add(out, string, end - string);
+	}
+
+	if (*end)
+		end++;
+	return end;
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
@@ -348,16 +376,13 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
 
-	alt_copy = xmemdupz(alt, len);
-	string_list_split_in_place(&entries, alt_copy, sep, -1);
-	for (i = 0; i < entries.nr; i++) {
-		const char *entry = entries.items[i].string;
-		if (entry[0] == '\0' || entry[0] == '#')
+	while (*alt) {
+		alt = parse_alt_odb_entry(alt, sep, &entry);
+		if (!entry.len)
 			continue;
-		link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
 	}
-	string_list_clear(&entries, 0);
-	free(alt_copy);
+	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
 }
 
diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index eec4137ca..69fd8f891 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -68,4 +68,22 @@ test_expect_success 'access alternate via relative path (subdir)' '
 	EOF
 '
 
+# set variables outside test to avoid quote insanity; the \057 is '/',
+# which doesn't need quoting, but just confirms that de-quoting
+# is working.
+quoted='"one.git\057objects"'
+unquoted='two.git/objects'
+test_expect_success 'mix of quoted and unquoted alternates' '
+	check_obj "$quoted:$unquoted" <<-EOF
+	$one blob
+	$two blob
+'
+
+test_expect_success 'broken quoting falls back to interpreting raw' '
+	mv one.git \"one.git &&
+	check_obj \"one.git/objects <<-EOF
+	$one blob
+	EOF
+'
+
 test_done
-- 
2.11.0.203.g6657065

