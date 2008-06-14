From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] path-list documentation: document all functions and data structures
Date: Sun, 15 Jun 2008 01:22:05 +0200
Message-ID: <1213485725-6755-1-git-send-email-vmiklos@frugalware.org>
References: <alpine.DEB.1.00.0806141705050.6439@racer>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 01:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7f5N-0008TY-Od
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 01:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678AbYFNXWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 19:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755651AbYFNXWK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 19:22:10 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:60732 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbYFNXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 19:22:09 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 28AA91DDC5B
	for <git@vger.kernel.org>; Sun, 15 Jun 2008 01:22:05 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8917B18DFDC; Sun, 15 Jun 2008 01:22:05 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <alpine.DEB.1.00.0806141705050.6439@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85052>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Jun 14, 2008 at 07:08:19PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Thanks for doing this... I meant to document it after pushing the
> path_list -> string_list patch.

Here is an updated version, hopefully I added all your suggestion, and
appended a short example as well.

(Sending to the list only, as I accidently removed the list from Cc, sorry for that.)

 Documentation/technical/api-path-list.txt |  125 ++++++++++++++++++++++++++++-
 1 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-path-list.txt b/Documentation/technical/api-path-list.txt
index d077683..654470d 100644
--- a/Documentation/technical/api-path-list.txt
+++ b/Documentation/technical/api-path-list.txt
@@ -1,9 +1,126 @@
 path-list API
 =============
 
-Talk about <path-list.h>, things like
+The path_list API offers a data structure and functions to handle sorted
+and unsorted string lists.
 
-* it is not just paths but strings in general;
-* the calling sequence.
+The name is a bit misleading, a path_list may store not only paths but
+strings in general.
 
-(Dscho)
+The caller:
+
+. Allocates and clears a `struct path_list` variable.
+
+. Initializes the members. You might want to set the flag `strdup_paths`
+  if the strings should be strdup()ed. For example, this is necessary
+  when you add something like git_path("..."), since that function returns
+  a static buffer that will change with the next call to git_path().
++
+If you need something advanced, you can manually malloc() the `items`
+member (you need this if you add things later) and you should set the
+`nr` and `alloc` members in that case, too.
+
+. Adds new items to the list, using `path_list_append` or `path_list_insert`.
+
+. Can check if a string is in the list using `path_list_has_path` or
+  `unsorted_path_list_has_path` and get it from the list using
+  `path_list_lookup` for sorted lists.
+
+. Can sort an unsorted list using `sort_path_list`.
+
+. Finally it should free the list using `path_list_clear`.
+
+Example:
+
+----
+struct path_list list;
+int i;
+
+memset(&list, 0, sizeof(struct path_list));
+path_list_append("foo", &list);
+path_list_append("bar", &list);
+for (i = 0; i < list.nr; i++)
+	printf("%s\n", list.items[i].path)
+----
+
+NOTE: It is more efficient to build an unsorted list and sort it
+afterwards, instead of building a sorted list `(O(n log n)` instead of
+`O(n^2))`.
++
+However, if you use the list to check if a certain string was added
+already, you should not do that (using unsorted_path_list_has_path()),
+because the complexity would be quadratic again (but with a worse factor).
+
+Functions
+---------
+
+* General ones (works with sorted and unsorted lists as well)
+
+`print_path_list`::
+
+	Dump a path_list to stdout, useful mainly for debugging purposes. It
+	can take an optional header argument and it writes out the
+	string-pointer pairs of the path_list, each one in its own line.
+
+`path_list_clear`::
+
+	Free a path_list. The `path` pointer of the items will be freed in case
+	the `strdup_paths` member of the path_list is set. The second parameter
+	controls if the `util` pointer of the items should be freed or not.
+
+* Functions for sorted lists only
+
+`path_list_has_path`::
+
+	Determine if the path_list has a given string or not.
+
+`path_list_insert`::
+
+	Insert a new element to the path_list. The returned pointer can be handy
+	if you want to write something to the `util` pointer of the
+	path_list_item containing the just added string.
++
+Since this function uses xrealloc() (which die()s if it fails) if the
+list needs to grow, it is safe not to check the pointer. I.e. you may
+write `path_list_insert(...)->util = ...;`.
+
+`path_list_lookup`::
+
+	Look up a given string in the path_list, returning the containing
+	path_list_item. If the string is not found, NULL is returned.
+
+* Functions for unsorted lists only
+
+`path_list_append`::
+
+	Append a new string to the end of the path_list.
+
+`sort_path_list`::
+
+	Make an unsorted list sorted.
+
+`unsorted_path_list_has_path`::
+
+	It's like `path_list_has_path()` but for unsorted lists.
++
+This function needs to look through all items, as opposed to its
+counterpart for sorted lists, which performs a binary search.
+
+Data structures
+---------------
+
+* `struct path_list_item`
+
+Represents an item of the list. The `path` member is a pointer to the
+string, and you may use the `util` member for any purpose, if you want.
+
+* `struct path_list`
+
+Represents the list itself.
+
+. The array of items are available via the `items` member.
+. The `nr` member contains the number of items stored in the list.
+. The `alloc` member is used to avoid reallocating at every insertion.
+  You should not tamper with it.
+. Setting the `strdup_paths` member to 1 will strdup() the strings
+  before adding them, see above.
-- 
1.5.6.rc2.dirty
