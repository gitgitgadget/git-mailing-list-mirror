From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] path-list documentation: document all functions and data structures
Date: Sat, 14 Jun 2008 02:56:04 +0200
Message-ID: <1213404964-25161-1-git-send-email-vmiklos@frugalware.org>
References: <48530331.70807@free.fr>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Don Zickus <dzickus@redhat.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sat Jun 14 02:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7K5A-0005ZH-VB
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 02:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbYFNA4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 20:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbYFNA4E
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 20:56:04 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45104 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbYFNA4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 20:56:04 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 8E3921DDC5B;
	Sat, 14 Jun 2008 02:56:00 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7D66018DFDC; Sat, 14 Jun 2008 02:56:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <48530331.70807@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84956>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Updated patch, obviously we want to init the struct with '\0', not '0'.

 Documentation/technical/api-path-list.txt |   92 +++++++++++++++++++++++++++-
 1 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-path-list.txt b/Documentation/technical/api-path-list.txt
index d077683..313d088 100644
--- a/Documentation/technical/api-path-list.txt
+++ b/Documentation/technical/api-path-list.txt
@@ -1,9 +1,93 @@
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
+. Allocates and clears (`memset(&list, \'\0', sizeof(list));`) a
+  `struct path_list` variable.
+
+. Initializes the members. You can manually set the `items` member, but
+  then you have to set `nr`, accordingly. Also don't forget to set
+  `strdup_paths` if you need it.
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
+
+Data structures
+---------------
+
+* `struct path_list_item`
+
+Represent an item of the list. The `path` member is a pointer to the
+string, and you may use the `util` member for any purpose, if you want.
+
+* `struct path_list`
+
+Represents the list itself.
+
+. The array of items are available via the `items` member.
+. The `nr` member contains the number of items stored in the list.
+. The `alloc` member is used for `ALLOC_GROW()`.
+. Setting the `strdup_paths` member to 1 means that the added paths are
+  copied to the path list and not just a pointer to them is stored.
-- 
1.5.6.rc2.dirty
