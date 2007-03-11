From: Jim Meyering <jim@meyering.net>
Subject: "git-diff -p :/anything" always segfaults
Date: Sun, 11 Mar 2007 19:49:08 +0100
Message-ID: <87d53fsjiz.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQT6k-0005CA-9E
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933993AbXCKStN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933994AbXCKStM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:49:12 -0400
Received: from mx.meyering.net ([82.230.74.64]:38315 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933993AbXCKStL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:49:11 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 1BD628382; Sun, 11 Mar 2007 19:49:08 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41962>

I like the idea of the new ':/<oneline prefix>' notation, and gave it
a try, but all I could get was a segfault.  It was dereferencing a NULL
commit list.  Fix below.  With it, this example now works:

$ mkdir .j; cd .j; touch f
$ (git-init; git-add f; git-commit -mc f; echo x >f; git-commit -md f)>/dev/null
$ git-diff -p :/c :/d
diff --git a/f b/f
index e69de29..587be6b 100644
--- a/f
+++ b/f
@@ -0,0 +1 @@
+x

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 31812d3..6b6270b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -617,7 +617,7 @@ int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	for_each_ref(handle_one_ref, &list);
 	for (l = list; l; l = l->next)
 		commit_list_insert(l->item, &backup);
-	while ((commit = pop_most_recent_commit(&list, ONELINE_SEEN))) {
+	while (list && (commit = pop_most_recent_commit(&list, ONELINE_SEEN))) {
 		char *p;
 		parse_object(commit->object.sha1);
 		if (!commit->buffer || !(p = strstr(commit->buffer, "\n\n")))
--
1.5.0.3.316.gbd1fc
