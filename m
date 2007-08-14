From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] attr.c: read .gitattributes from index as well.
Date: Tue, 14 Aug 2007 01:41:02 -0700
Message-ID: <7vwsvycxup.fsf_-_@assigned-by-dhcp.cox.net>
References: <11869508753328-git-send-email-prohaska@zib.de>
	<118695087531-git-send-email-prohaska@zib.de>
	<7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
	<7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
	<46BFFB1A.4070704@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 10:41:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKrxi-0004Vb-4H
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 10:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbXHNIlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 04:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753897AbXHNIlH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 04:41:07 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60334 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbXHNIlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 04:41:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814084103.PIYG325.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 14 Aug 2007 04:41:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bkh31X00C1kojtg0000000; Tue, 14 Aug 2007 04:41:03 -0400
In-Reply-To: <46BFFB1A.4070704@trolltech.com> (Marius Storm-Olsen's message of
	"Mon, 13 Aug 2007 08:32:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55817>

This makes .gitattributes files to be read from the index when
they are not checked out to the work tree.  This is in line with
the way we always allowed low-level tools to operate in sparsely
checked out work tree in a reasonable way.

It swaps the order of new file creation and converting the blob
to work tree representation; otherwise when we are in the middle
of checking out .gitattributes we would notice an empty but
unwritten .gitattributes file in the work tree and will ignore
the copy in the index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c          |   61 ++++++++++++++++++++++++++++++++++++++++-
 entry.c         |   19 +++++++------
 t/t0020-crlf.sh |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 11 deletions(-)

diff --git a/attr.c b/attr.c
index 8d778f1..1293993 100644
--- a/attr.c
+++ b/attr.c
@@ -336,13 +336,70 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	return res;
 }
 
+static void *read_index_data(const char *path)
+{
+	int pos, len;
+	unsigned long sz;
+	enum object_type type;
+	void *data;
+
+	len = strlen(path);
+	pos = cache_name_pos(path, len);
+	if (pos < 0) {
+		/*
+		 * We might be in the middle of a merge, in which
+		 * case we would read stage #2 (ours).
+		 */
+		int i;
+		for (i = -pos - 1;
+		     (pos < 0 && i < active_nr &&
+		      !strcmp(active_cache[i]->name, path));
+		     i++)
+			if (ce_stage(active_cache[i]) == 2)
+				pos = i;
+	}
+	if (pos < 0)
+		return NULL;
+	data = read_sha1_file(active_cache[pos]->sha1, &type, &sz);
+	if (!data || type != OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	return data;
+}
+
 static struct attr_stack *read_attr(const char *path, int macro_ok)
 {
 	struct attr_stack *res;
+	char *buf, *sp;
+	int lineno = 0;
 
 	res = read_attr_from_file(path, macro_ok);
-	if (!res)
-		res = xcalloc(1, sizeof(*res));
+	if (res)
+		return res;
+
+	res = xcalloc(1, sizeof(*res));
+
+	/*
+	 * There is no checked out .gitattributes file there, but
+	 * we might have it in the index.  We allow operation in a
+	 * sparsely checked out work tree, so read from it.
+	 */
+	buf = read_index_data(path);
+	if (!buf)
+		return res;
+
+	for (sp = buf; *sp; ) {
+		char *ep;
+		int more;
+		for (ep = sp; *ep && *ep != '\n'; ep++)
+			;
+		more = (*ep == '\n');
+		*ep = '\0';
+		handle_attr_line(res, sp, path, ++lineno, macro_ok);
+		sp = ep + more;
+	}
+	free(buf);
 	return res;
 }
 
diff --git a/entry.c b/entry.c
index 0625112..fc3a506 100644
--- a/entry.c
+++ b/entry.c
@@ -112,6 +112,16 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		if (!new)
 			return error("git-checkout-index: unable to read sha1 file of %s (%s)",
 				path, sha1_to_hex(ce->sha1));
+
+		/*
+		 * Convert from git internal format to working tree format
+		 */
+		buf = convert_to_working_tree(ce->name, new, &size);
+		if (buf) {
+			free(new);
+			new = buf;
+		}
+
 		if (to_tempfile) {
 			strcpy(path, ".merge_file_XXXXXX");
 			fd = mkstemp(path);
@@ -123,15 +133,6 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 				path, strerror(errno));
 		}
 
-		/*
-		 * Convert from git internal format to working tree format
-		 */
-		buf = convert_to_working_tree(ce->name, new, &size);
-		if (buf) {
-			free(new);
-			new = buf;
-		}
-
 		wrote = write_in_full(fd, new, size);
 		close(fd);
 		free(new);
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index fe1dfd0..0807d9f 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -290,4 +290,85 @@ test_expect_success '.gitattributes says two and three are text' '
 	fi
 '
 
+test_expect_success 'in-tree .gitattributes (1)' '
+
+	echo "one -crlf" >>.gitattributes &&
+	git add .gitattributes &&
+	git commit -m "Add .gitattributes" &&
+
+	rm -rf tmp one dir .gitattributes patch.file three &&
+	git read-tree --reset -u HEAD &&
+
+	if remove_cr one >/dev/null
+	then
+		echo "Eh? one should not have CRLF"
+		false
+	else
+		: happy
+	fi &&
+	remove_cr three >/dev/null || {
+		echo "Eh? three should still have CRLF"
+		false
+	}
+'
+
+test_expect_success 'in-tree .gitattributes (2)' '
+
+	rm -rf tmp one dir .gitattributes patch.file three &&
+	git read-tree --reset HEAD &&
+	git checkout-index -f -q -u -a &&
+
+	if remove_cr one >/dev/null
+	then
+		echo "Eh? one should not have CRLF"
+		false
+	else
+		: happy
+	fi &&
+	remove_cr three >/dev/null || {
+		echo "Eh? three should still have CRLF"
+		false
+	}
+'
+
+test_expect_success 'in-tree .gitattributes (3)' '
+
+	rm -rf tmp one dir .gitattributes patch.file three &&
+	git read-tree --reset HEAD &&
+	git checkout-index -u .gitattributes &&
+	git checkout-index -u one dir/two three &&
+
+	if remove_cr one >/dev/null
+	then
+		echo "Eh? one should not have CRLF"
+		false
+	else
+		: happy
+	fi &&
+	remove_cr three >/dev/null || {
+		echo "Eh? three should still have CRLF"
+		false
+	}
+'
+
+test_expect_success 'in-tree .gitattributes (4)' '
+
+	rm -rf tmp one dir .gitattributes patch.file three &&
+	git read-tree --reset HEAD &&
+	git checkout-index -u one dir/two three &&
+	git checkout-index -u .gitattributes &&
+
+	if remove_cr one >/dev/null
+	then
+		echo "Eh? one should not have CRLF"
+		false
+	else
+		: happy
+	fi &&
+	remove_cr three >/dev/null || {
+		echo "Eh? three should still have CRLF"
+		false
+	}
+'
+
 test_done
-- 
1.5.3.rc4.89.g18078
