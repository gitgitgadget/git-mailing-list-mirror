From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Wed, 19 Oct 2011 22:51:49 -0400
Message-ID: <20111020025149.GA31549@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 04:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGije-0006xz-4r
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 04:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab1JTCvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 22:51:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35937
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab1JTCvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 22:51:52 -0400
Received: (qmail 4952 invoked by uid 107); 20 Oct 2011 02:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Oct 2011 22:51:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2011 22:51:49 -0400
Content-Disposition: inline
In-Reply-To: <20111019193834.GA14168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183999>

On Wed, Oct 19, 2011 at 03:38:34PM -0400, Jeff King wrote:

> It also parameterizes the desired sha1, so you could easily find hashes
> ending in 31337, or any other pattern. Or add "git commit
> --collide=31337".

I couldn't resist:

  $ git commit -q -m foo --collide=deadbeef &&
    git rev-list -1 HEAD
  deadbeefdbd6e62a2185606a4fad653e22509b56

You can also do:

  $ SHA1=0000000000000000000000000000000000031337
  $ MASK=00000000000000000000000000000000000fffff
  $ git commit -q -m foo --collide=$SHA1/$MASK &&
    git rev-list -1 HEAD
  ea49af84db92ed0d2bc3ed13810f5990e7c31337

Keep in mind that each hex character you add increases the search space
by a factor of 16. deadbeef took about 70 seconds to find on my machine.
I'm tempted to look for "3133700..0031337", but it would probably
take about 4 hours.

Patch is below.

-Peff

---
diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d1..734a7ab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -105,6 +105,10 @@
 static const char *only_include_assumed;
 static struct strbuf message;
 
+static int collide;
+static unsigned char collide_sha1[20];
+static unsigned char collide_mask[20];
+
 static int null_termination;
 static enum {
 	STATUS_FORMAT_LONG,
@@ -125,6 +129,52 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_partial_sha1(const char *s, unsigned char sha1[20])
+{
+	unsigned int i;
+
+	hashclr(sha1);
+
+	for (i = 0; i < 40 && s[i]; i++) {
+		unsigned int v = hexval(s[i]);
+		if (v & ~0xf)
+			break;
+		if (!(i & 1))
+			v <<= 4;
+		sha1[i/2] |= v;
+	}
+	return i;
+}
+
+static void fill_sha1_mask(int n, unsigned char mask[20]) {
+	int i;
+
+	hashclr(mask);
+	for (i = 0; i < n/2; i++)
+		mask[i] = 0xff;
+	if (n & 1)
+		mask[i] = 0xf0;
+}
+
+static int opt_parse_collide(const struct option *opt, const char *arg,
+			     int unset)
+{
+	if (unset)
+		collide = 0;
+	else {
+		int n = parse_partial_sha1(arg, collide_sha1);
+		if (!arg[n])
+			fill_sha1_mask(n, collide_mask);
+		else if (arg[n] == '/')
+			parse_partial_sha1(arg + n + 1, collide_mask);
+		else
+			die("invalid --collide sha1: %s", arg);
+		collide = 1;
+	}
+	return 0;
+}
+
+
 static struct option builtin_commit_options[] = {
 	OPT__QUIET(&quiet, "suppress summary after successful commit"),
 	OPT__VERBOSE(&verbose, "show diff in commit message template"),
@@ -144,6 +194,7 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 	OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
+	OPT_CALLBACK(0, "collide", NULL, "sha1[/mask]", "choose commit sha1 like <sha1>", opt_parse_collide),
 	/* end commit message options */
 
 	OPT_GROUP("Commit contents options"),
@@ -1483,8 +1534,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, sha1,
-			author_ident.buf)) {
+	if (commit_tree_collide(sb.buf, active_cache_tree->sha1, parents, sha1,
+				author_ident.buf,
+				collide ? collide_sha1 : NULL, collide_mask)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
diff --git a/commit.c b/commit.c
index 73b7e00..24ddccd 100644
--- a/commit.c
+++ b/commit.c
@@ -840,6 +840,54 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static inline int sha1_match_mask(const unsigned char *sha1,
+				  const unsigned char *want,
+				  const unsigned char *mask)
+{
+	int i;
+	for (i = 0; i < 20; i++)
+		if ((want[i] & mask[i]) != (sha1[i] & mask[i]))
+		    return 0;
+	return 1;
+}
+
+static void collide_commit(struct strbuf *data,
+			   const unsigned char *want,
+			   const unsigned char *mask)
+{
+	static const char terminator[] = { 0 };
+	char header[32];
+	int header_len;
+	unsigned int lulz;
+	SHA_CTX base;
+
+	header_len = snprintf(header, sizeof(header),
+			      "commit %lu",
+			      data->len + 1 + sizeof(lulz)) + 1;
+	SHA1_Init(&base);
+	SHA1_Update(&base, header, header_len);
+	SHA1_Update(&base, data->buf, data->len);
+	SHA1_Update(&base, terminator, sizeof(terminator));
+
+	lulz = 0;
+	do {
+		SHA_CTX guess;
+		unsigned char sha1[20];
+
+		memcpy(&guess, &base, sizeof(guess));
+		SHA1_Update(&guess, &lulz, sizeof(lulz));
+		SHA1_Final(sha1, &guess);
+
+		if (sha1_match_mask(sha1, want, mask)) {
+			strbuf_add(data, terminator, sizeof(terminator));
+			strbuf_add(data, &lulz, sizeof(lulz));
+			return;
+		}
+
+		lulz++;
+	} while (1);
+}
+
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
@@ -849,6 +897,15 @@ int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author)
 {
+	return commit_tree_collide(msg, tree, parents, ret, author,
+				   NULL, NULL);
+}
+
+int commit_tree_collide(const char *msg, unsigned char *tree,
+			struct commit_list *parents, unsigned char *ret,
+			const char *author, const unsigned char *want,
+			const unsigned char *mask)
+{
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
@@ -890,6 +947,9 @@ int commit_tree(const char *msg, unsigned char *tree,
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
 		fprintf(stderr, commit_utf8_warn);
 
+	if (want && mask)
+		collide_commit(&buffer, want, mask);
+
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
 	strbuf_release(&buffer);
 	return result;
diff --git a/commit.h b/commit.h
index 009b113..337dcbd 100644
--- a/commit.h
+++ b/commit.h
@@ -184,5 +184,9 @@ static inline int single_parent(struct commit *commit)
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
+extern int commit_tree_collide(const char *msg, unsigned char *tree,
+			       struct commit_list *parents, unsigned char *ret,
+			       const char *author, const unsigned char *sha1,
+			       const unsigned char *mask);
 
 #endif /* COMMIT_H */
