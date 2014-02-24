From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] fsck: report integer overflow in author timestamps
Date: Mon, 24 Feb 2014 02:39:04 -0500
Message-ID: <20140224073904.GB9969@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 08:39:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHq89-0005ZU-29
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 08:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbaBXHjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 02:39:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:55857 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751200AbaBXHjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 02:39:07 -0500
Received: (qmail 14432 invoked by uid 102); 24 Feb 2014 07:39:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 01:39:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 02:39:04 -0500
Content-Disposition: inline
In-Reply-To: <20140224073348.GA20221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242567>

When we check commit objects, we complain if commit->date is
ULONG_MAX, which is an indication that we saw integer
overflow when parsing it. However, we do not do any check at
all for author lines, which also contain a timestamp.

Let's actually check the timestamps on each ident line
with strtoul. This catches both author and committer lines,
and we can get rid of the now-redundant commit->date check.

Note that like the existing check, we compare only against
ULONG_MAX. Now that we are calling strtoul at the site of
the check, we could be slightly more careful and also check
that errno is set to ERANGE. However, this will make further
refactoring in future patches a little harder, and it
doesn't really matter in practice.

For 32-bit systems, one would have to create a commit at the
exact wrong second in 2038. But by the time we get close to
that, all systems will hopefully have moved to 64-bit (and
if they haven't, they have a real problem one second later).

For 64-bit systems, by the time we get close to ULONG_MAX,
all systems will hopefully have been consumed in the fiery
wrath of our expanding Sun.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that tags don't get checked here, because we do not feed their
ident lines to fsck_ident at all. This is still a step forward, though,
as if we ever teach them to check ident lines, they'll get this new
check automatically.

 fsck.c          | 12 ++++++------
 t/t1450-fsck.sh | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fsck.c b/fsck.c
index 99c0497..760e072 100644
--- a/fsck.c
+++ b/fsck.c
@@ -245,6 +245,8 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 
 static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
 {
+	char *end;
+
 	if (**ident == '<')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
 	*ident += strcspn(*ident, "<>\n");
@@ -264,10 +266,11 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
 	(*ident)++;
 	if (**ident == '0' && (*ident)[1] != ' ')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - zero-padded date");
-	*ident += strspn(*ident, "0123456789");
-	if (**ident != ' ')
+	if (strtoul(*ident, &end, 10) == ULONG_MAX)
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - date causes integer overflow");
+	if (end == *ident || *end != ' ')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad date");
-	(*ident)++;
+	*ident = end + 1;
 	if ((**ident != '+' && **ident != '-') ||
 	    !isdigit((*ident)[1]) ||
 	    !isdigit((*ident)[2]) ||
@@ -287,9 +290,6 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	int parents = 0;
 	int err;
 
-	if (commit->date == ULONG_MAX)
-		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
-
 	if (memcmp(buffer, "tree ", 5))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index d730734..8c739c9 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -142,6 +142,20 @@ test_expect_success '> in name is reported' '
 	grep "error in commit $new" out
 '
 
+# date is 2^64 + 1
+test_expect_success 'integer overflow in timestamps is reported' '
+	git cat-file commit HEAD >basis &&
+	sed "s/^\\(author .*>\\) [0-9]*/\\1 18446744073709551617/" \
+		<basis >bad-timestamp &&
+	new=$(git hash-object -t commit -w --stdin <bad-timestamp) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	git fsck 2>out &&
+	cat out &&
+	grep "error in commit $new.*integer overflow" out
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
-- 
1.8.5.2.500.g8060133
