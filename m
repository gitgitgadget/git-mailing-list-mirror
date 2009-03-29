From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] bisect: fix reading more than one path in
 "$GIT_DIR/BISECT_NAMES"
Date: Sun, 29 Mar 2009 11:44:57 +0200
Message-ID: <20090329114457.c6fca0fe.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnrcA-0004CJ-Jv
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 11:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbZC2JqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 05:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbZC2JqE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:46:04 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:55858 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977AbZC2JqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 05:46:02 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 669C9D480BD;
	Sun, 29 Mar 2009 11:45:51 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id 1A204D481CD;
	Sun, 29 Mar 2009 11:45:49 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115007>

The implementation of "read_bisect_paths" worked with only one
path in each line of "$GIT_DIR/BISECT_NAMES", but the paths are all
stored on one line by "git-bisect.sh".

So we have to process all the paths that may be on each line.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9e779c1..66df05f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -435,17 +435,17 @@ void read_bisect_paths(void)
 		die("Could not open file '%s': %s", filename, strerror(errno));
 
 	while (strbuf_getline(&str, fp, '\n') != EOF) {
-		char *quoted, *dequoted;
+		char *quoted;
+		int res;
+
 		strbuf_trim(&str);
 		quoted = strbuf_detach(&str, NULL);
-		if (!*quoted)
-			continue;
-		dequoted = sq_dequote(quoted);
-		if (!dequoted)
+		res = sq_dequote_to_argv(quoted, &rev_argv,
+					 &rev_argv_nr, &rev_argv_alloc);
+		if (res)
 			die("Badly quoted content in file '%s': %s",
 			    filename, quoted);
-		ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
-		rev_argv[rev_argv_nr++] = dequoted;
+		free(quoted);
 	}
 
 	strbuf_release(&str);
-- 
1.6.2.1.404.gb0085.dirty
