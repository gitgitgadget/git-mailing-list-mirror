From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] --format=pretty: avoid calculating expensive expansions
 twice
Date: Sat, 10 Nov 2007 12:18:26 +0100
Message-ID: <47359382.1010600@lsrfire.ath.cx>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqoMg-0007gN-EI
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbXKJLSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 06:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXKJLSs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:18:48 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:39362
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751334AbXKJLSr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 06:18:47 -0500
Received: from [10.0.1.201] (p57B7EF01.dip.t-dialin.net [87.183.239.1])
	by neapel230.server4you.de (Postfix) with ESMTP id 3B6CA873BA;
	Sat, 10 Nov 2007 12:18:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071110004635.GA14992@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64333>

As Jeff King remarked, format strings with duplicate placeholders can
be slow to expand, because each instance is calculated anew.

This patch makes use of the fact that format_commit_message() and its
helper functions only ever add stuff to the end of the strbuf.  For
certain expensive placeholders, store the offset and length of their
expansion with the strbuf at the first occurrence.  Later they
expansion result can simply be copied from there -- no malloc() or
strdup() required.

These certain placeholders are the abbreviated commit, tree and
parent hashes, as the search for a unique abbreviated hash is quite
costly.  Here are the times for next (best of three runs):

$ time git log --pretty=format:%h >/dev/null

real    0m0.611s
user    0m0.404s
sys     0m0.204s

$ time git log --pretty=format:%h%h%h%h >/dev/null

real    0m1.206s
user    0m0.744s
sys     0m0.452s

And here those with this patch (and the previous two); the speedup
of the single placeholder case is just noise:

$ time git log --pretty=format:%h >/dev/null

real    0m0.608s
user    0m0.416s
sys     0m0.192s

$ time git log --pretty=format:%h%h%h%h >/dev/null

real    0m0.639s
user    0m0.488s
sys     0m0.140s

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0c2f83b..ab142b8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -369,8 +369,30 @@ struct format_commit_context {
 	struct chunk committer;
 	struct chunk encoding;
 	size_t body_off;
+
+	/* The following ones are relative to the result struct strbuf. */
+	struct chunk abbrev_commit_hash;
+	struct chunk abbrev_tree_hash;
+	struct chunk abbrev_parent_hashes;
 };
 
+static int add_again(struct strbuf *sb, struct chunk *chunk)
+{
+	if (chunk->len) {
+		strbuf_adddup(sb, chunk->off, chunk->len);
+		return 1;
+	}
+
+	/*
+	 * We haven't seen this chunk before.  Our caller is surely
+	 * going to add it the hard way now.  Remember the most likely
+	 * start of the to-be-added chunk: the current end of the
+	 * struct strbuf.
+	 */
+	chunk->off = sb->len;
+	return 0;
+}
+
 static void parse_commit_header(struct format_commit_context *context)
 {
 	const char *msg = context->commit->buffer;
@@ -447,15 +469,21 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
 		return;
 	case 'h':		/* abbreviated commit hash */
+		if (add_again(sb, &c->abbrev_commit_hash))
+			return;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
 		                                     DEFAULT_ABBREV));
+		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
 		return;
 	case 'T':		/* tree hash */
 		strbuf_addstr(sb, sha1_to_hex(commit->tree->object.sha1));
 		return;
 	case 't':		/* abbreviated tree hash */
+		if (add_again(sb, &c->abbrev_tree_hash))
+			return;
 		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
 		                                     DEFAULT_ABBREV));
+		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
 		return;
 	case 'P':		/* parent hashes */
 		for (p = commit->parents; p; p = p->next) {
@@ -465,12 +493,16 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
 		}
 		return;
 	case 'p':		/* abbreviated parent hashes */
+		if (add_again(sb, &c->abbrev_parent_hashes))
+			return;
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, find_unique_abbrev(
 					p->item->object.sha1, DEFAULT_ABBREV));
 		}
+		c->abbrev_parent_hashes.len = sb->len -
+		                              c->abbrev_parent_hashes.off;
 		return;
 	case 'm':		/* left/right/bottom */
 		strbuf_addch(sb, (commit->object.flags & BOUNDARY)
-- 
1.5.3.5.1651.g30bf
