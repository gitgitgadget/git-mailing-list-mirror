From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 18/19] fsck: git receive-pack: support excluding objects
 from fsck'ing
Date: Mon, 22 Jun 2015 17:27:18 +0200
Organization: gmx
Message-ID: <0f26e80844745a9005eb4073289ea56dd452bbe2.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:27:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73dI-0007cJ-Pu
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbbFVP1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:27:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:63507 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923AbbFVP1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:27:25 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M5tzh-1Ys9Cp1wCH-00xtoa; Mon, 22 Jun 2015 17:27:18
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:fcUzZHcgDKD9nh1by4++pbga9zfTzyAUjnHtkID8Rd8vKWLDDy6
 57vgjMVHhFS9tWpiLLeIRHttDvq3cxPjc1yuQLxuwP5BcCjScgxm44NDIJbk74HZPBxlVaH
 eBuhbEYNTXu8MNg6Vd/ChkwXb7rk4YOhCJjaxF+vmIpl4sqRBjVUQVTQ8M58VD7hgx4SECA
 oshIYfmP30JetRYHR1/4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yYmATtCaYUc=:Qw2avZT6S8KBAs9fw8wc2e
 uZHywmEm3bYE7AKqr5OpCD77eTUZqNrLmgmqFzORlBnPKxH1eaLPPViwMFYK4mVUBeyRXBkLi
 Hl1efPm3RQLYbDC2RY04GMkGh4mUOx4PSh0slU0YbwdYgDlAZuVQSgBK/kWPcfFREx7JXdAIx
 Di9uiljtC0dU0uWt9c0e/cJ1W99ICQe1AJu9ppz/petvYsvjrsvBHqSLopjeJMJoMQdJcAFQ/
 mUCQsW0/mQM2k1+7nJvbhkKGWUB67Hl2zubH7fAV0QJIRIKWeL7aMPHIhocJ9gZkTvw9eyJgB
 8msNN7m2jrwjkFHHjnJVovqA2/NJvZGa2rlP2VmlEl51J9i6Raf3fbPL8SnbgEO55rReHIyzz
 Btj1eHuehAmlMb29S9KozKWIXbP3FMvpWZiHAxPdk5iq7S0rDIxSIOrd3cECdQlKb1sLaPetB
 OdHq7hZl1WD8KNjEIRcpDukVng/+NbjomvkxYYtlq3+qq5h+qsWHRIqKgsvFyjHsUKaQP7od/
 oBaFspvLDG9iQtFx8SuNOzRS3zenkuIC8iEiF5Vu2UqdFlaY1CSliWvarqEmlICrtDJAZQKcB
 lAsPHf6vmxn+8xyEgJKsuwtCYXoBm22ApOT0f7oS5TlR4winwRpzEjmm/ITdxhAnnfsDNfyJF
 OdazDvii2uAGu/Z/mwmrjHBnh16JEkooecwDF0LuSVsORD2NJ1Gbl/+U7P2YeUlGwJCw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272390>

The optional new config option `receive.fsck.skipList` specifies the path
to a file listing the names, i.e. SHA-1s, one per line, of objects that
are to be ignored by `git receive-pack` when `receive.fsckObjects = true`.

This is extremely handy in case of legacy repositories where it would
cause more pain to change incorrect objects than to live with them
(e.g. a duplicate 'author' line in an early commit object).

The intended use case is for server administrators to inspect objects
that are reported by `git push` as being too problematic to enter the
repository, and to add the objects' SHA-1 to a (preferably sorted) file
when the objects are legitimate, i.e. when it is determined that those
problematic objects should be allowed to enter the server.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt        |  8 +++++++
 builtin/receive-pack.c          | 11 +++++++++
 fsck.c                          | 50 +++++++++++++++++++++++++++++++++++++++++
 fsck.h                          |  1 +
 t/t5504-fetch-receive-strict.sh | 12 ++++++++++
 5 files changed, 82 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bfccd2b..ed7f37f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2230,6 +2230,14 @@ which would not pass pushing when `receive.fsckObjects = true`, allowing
 the host to accept repositories with certain known issues but still catch
 other issues.
 
+receive.fsck.skipList::
+	The path to a sorted list of object names (i.e. one SHA-1 per
+	line) that are known to be broken in a non-fatal way and should
+	be ignored. This feature is useful when an established project
+	should be accepted despite early commits containing errors that
+	can be safely ignored such as invalid committer email addresses.
+	Note: corrupt objects cannot be skipped with this setting.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3afe8f8..3fbed23 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -117,6 +117,17 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.fsck.skiplist") == 0) {
+		const char *path;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
+		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
+			fsck_msg_types.len ? ',' : '=', path);
+		free((char *) path);
+		return 0;
+	}
+
 	if (skip_prefix(var, "receive.fsck.", &var)) {
 		if (is_valid_msg_type(var, value))
 			strbuf_addf(&fsck_msg_types, "%c%s=%s",
diff --git a/fsck.c b/fsck.c
index f6fc384..a677b50 100644
--- a/fsck.c
+++ b/fsck.c
@@ -8,6 +8,7 @@
 #include "fsck.h"
 #include "refs.h"
 #include "utf8.h"
+#include "sha1-array.h"
 
 #define FSCK_FATAL -1
 #define FSCK_INFO -2
@@ -127,6 +128,43 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 	return msg_type;
 }
 
+static void init_skiplist(struct fsck_options *options, const char *path)
+{
+	static struct sha1_array skiplist = SHA1_ARRAY_INIT;
+	int sorted, fd;
+	char buffer[41];
+	unsigned char sha1[20];
+
+	if (options->skiplist)
+		sorted = options->skiplist->sorted;
+	else {
+		sorted = 1;
+		options->skiplist = &skiplist;
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		die("Could not open skip list: %s", path);
+	for (;;) {
+		int result = read_in_full(fd, buffer, sizeof(buffer));
+		if (result < 0)
+			die_errno("Could not read '%s'", path);
+		if (!result)
+			break;
+		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
+			die("Invalid SHA-1: %s", buffer);
+		sha1_array_append(&skiplist, sha1);
+		if (sorted && skiplist.nr > 1 &&
+				hashcmp(skiplist.sha1[skiplist.nr - 2],
+					sha1) > 0)
+			sorted = 0;
+	}
+	close(fd);
+
+	if (sorted)
+		skiplist.sorted = 1;
+}
+
 static int parse_msg_type(const char *str)
 {
 	if (!strcmp(str, "error"))
@@ -190,6 +228,14 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 			buf[equal] = tolower(buf[equal]);
 		buf[equal] = '\0';
 
+		if (!strcmp(buf, "skiplist")) {
+			if (equal == len)
+				die("skiplist requires a path");
+			init_skiplist(options, buf + equal + 1);
+			buf += len + 1;
+			continue;
+		}
+
 		if (equal == len)
 			die("Missing '=': '%s'", buf);
 
@@ -228,6 +274,10 @@ static int report(struct fsck_options *options, struct object *object,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
+	if (options->skiplist && object &&
+			sha1_array_lookup(options->skiplist, object->sha1) >= 0)
+		return 0;
+
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
 	else if (msg_type == FSCK_INFO)
diff --git a/fsck.h b/fsck.h
index 1dab276..dded84b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -32,6 +32,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	int *msg_type;
+	struct sha1_array *skiplist;
 };
 
 #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index af373ba..6a1f89e 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -123,6 +123,18 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
+test_expect_success 'push with receive.fsck.skipList' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckObjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config receive.fsck.skipList SKIP &&
+	echo $commit >dst/.git/SKIP &&
+	git push --porcelain dst bogus
+'
+
 test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
-- 
2.3.1.windows.1.9.g8c01ab4
