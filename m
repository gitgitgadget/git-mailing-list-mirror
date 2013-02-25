From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] fsck: check "tagger" lines
Date: Mon, 25 Feb 2013 13:46:17 -0500
Message-ID: <20130225184617.GC14438@sigill.intra.peff.net>
References: <20130225183009.GB13912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:46:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA34X-0003ay-SD
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825Ab3BYSqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:46:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60097 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565Ab3BYSqU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:46:20 -0500
Received: (qmail 25694 invoked by uid 107); 25 Feb 2013 18:47:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 13:47:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 13:46:17 -0500
Content-Disposition: inline
In-Reply-To: <20130225183009.GB13912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217080>

The fsck_tag function does not check very much about tags at
all; it just makes sure that we were able to load the
pointed-to object during the parse_tag phase. This does
check some basic things (the "object" line is OK, and the
pointed-to object exists with the expected type).

We did not, however, check the "tagger" line at all; if they
exist, we should feed them to fsck_ident (and it is OK if
they do not, as early versions of git did not include them).

This patch runs through the whole tag object during
fsck_tag, similar to what we do in fsck_commit. Some of
these checks are technically redundant with just checking
that parse_tag filled in the "tag->tagged" field. However:

  1. We have to parse through those lines anyway to get to
     the tagger line, so we need to sanity check our
     parsing.

  2. We can give more specific errors (e.g., report a
     malformed "object" line).

  3. Previously we depended on implementation details of
     parse_tag for our fsck (e.g., that it would never fill
     in "tagged" if the types did not match). Now our
     exhaustive checks are in one place, which makes it
     easier to verify exactly what fsck is checking.

Signed-off-by: Jeff King <peff@peff.net>
---
Unfortunately, this causes t1050 to fail in an interesting way. It runs
"index-pack --strict" while setting GIT_DIR=nonexistent. As a result,
when we try to read the tag object from disk, we can't find it. We
don't run into the same problem verifying commits and trees, because
those objects leave the raw object data in their "buffer" field.

I'm tempted to call what that test is doing insane, but I wonder if
there is another corner case with running "index-pack --strict" as part
of an incoming push or fetch. I haven't investigated that yet.

 fsck.c          | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t1450-fsck.sh | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 99c0497..20d55c4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -340,15 +340,75 @@ static int fsck_tag(struct tag *tag, fsck_error error_func)
 	return 0;
 }
 
-static int fsck_tag(struct tag *tag, fsck_error error_func)
+static int fsck_tag_buffer(char *buf, struct tag *tag, fsck_error error_func)
 {
 	struct object *tagged = tag->tagged;
+	unsigned char sha1[20];
+	char *eol;
+
+	buf = skip_prefix(buf, "object ");
+	if (!buf)
+		return error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'object' line");
+	if (get_sha1_hex(buf, sha1) || buf[40] != '\n')
+		return error_func(&tag->object, FSCK_ERROR, "invalid 'object' line format - bad sha1");
+	buf += 41;
 
+	/*
+	 * We already called parse_tag, so we don't have to bother looking up
+	 * the sha1 again.
+	 */
 	if (!tagged)
 		return error_func(&tag->object, FSCK_ERROR, "could not load tagged object");
+
+	buf = skip_prefix(buf, "type ");
+	if (!buf)
+		return error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'type' line");
+	eol = strchr(buf, '\n');
+	if (!eol)
+		return error_func(&tag->object, FSCK_ERROR, "invalid format - truncation at 'type' line");
+	*eol = '\0';
+	if (type_from_string(buf) != tagged->type)
+		return error_func(&tag->object, FSCK_ERROR, "'type' line does not match type of tagged object");
+	*eol = '\n';
+
+	buf = skip_prefix(eol + 1, "tag ");
+	if (!buf)
+		return error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'tag' line");
+	eol = strchr(buf, '\n');
+	if (!eol)
+		return error_func(&tag->object, FSCK_ERROR, "invalid format - truncation at 'tag' line");
+
+	/*
+	 * A missing tagger is OK, as very old versions of git did not produce
+	 * such a line. But if we do have it, we should verify its contents.
+	 */
+	buf = skip_prefix(eol + 1, "tagger ");
+	if (buf) {
+		int err = fsck_ident(&buf, &tag->object, error_func);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
+static int fsck_tag(struct tag *tag, fsck_error error_func)
+{
+	char *buf;
+	unsigned long size;
+	enum object_type type;
+	int err;
+
+	buf = read_sha1_file(tag->object.sha1, &type, &size);
+	if (!buf)
+		return error_func(&tag->object, FSCK_ERROR, "could not read tag object");
+
+	err = fsck_tag_buffer(buf, tag, error_func);
+
+	free(buf);
+	return err;
+}
+
 int fsck_object(struct object *obj, int strict, fsck_error error_func)
 {
 	if (!obj)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index d730734..3a3bce6 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -180,6 +180,49 @@ test_expect_success 'tag pointing to something else than its type' '
 	test_must_fail git fsck --tags
 '
 
+test_expect_success 'tag with missing tagger is OK' '
+	sha=$(echo blob | git hash-object -w --stdin) &&
+	test_when_finished "remove_object $sha" &&
+	cat >good-tag <<-EOF &&
+	object $sha
+	type blob
+	tag missing-tagger-ok
+
+	This is totally fine.
+	EOF
+
+	tag=$(git hash-object -t tag -w --stdin <good-tag) &&
+	test_when_finished "remove_object $tag" &&
+	git update-ref refs/tags/good $tag &&
+	test_when_finished "git update-ref -d refs/tags/good" &&
+	git fsck >out 2>&1 &&
+	>expect &&
+	test_cmp expect out
+'
+
+test_expect_success 'tag with bogus tagger is not OK' '
+	sha=$(echo blob | git hash-object -w --stdin) &&
+	test_when_finished "remove_object $sha" &&
+	cat >wrong-tag <<-EOF &&
+	object $sha
+	type blob
+	tag bogus-tagger
+	tagger T A Gger <tagger@example.com> Mon Feb 25 12:32:51 2013 -0500
+
+	That date is bogus (it should be an epoch + timezone). Any bogus ident
+	line should trigger, but this was chosen to match a breakage seen in
+	the wild.
+	EOF
+
+	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
+	test_when_finished "remove_object $tag" &&
+	git update-ref refs/tags/wrong $tag &&
+	test_when_finished "git update-ref -d refs/tags/wrong" &&
+	git fsck --tags >out 2>&1 &&
+	cat out &&
+	grep "error in tag $tag.* - bad date" out
+'
+
 test_expect_success 'cleaned up' '
 	git fsck >actual 2>&1 &&
 	test_cmp empty actual
-- 
1.8.1.4.4.g265d2fa
