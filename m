From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] builtin-fsck: fix off by one head count
Date: Sun, 18 Jan 2009 18:27:14 +0100
Message-ID: <20090118182714.78422d0e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:28:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObRT-0000Bh-90
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763372AbZARR0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 12:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763987AbZARR0n
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:26:43 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:45988 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763162AbZARR0n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:26:43 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 314624B026F;
	Sun, 18 Jan 2009 18:26:35 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 2DA754B00FA;
	Sun, 18 Jan 2009 18:26:33 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106246>

According to the man page, if "git fsck" is passed one or more
heads, it should verify connectivity and validity of only objects
reachable from the heads it is passed.

But before this patch, when it was passed only one head, then it
behaved as if no heads were passed (that is it used the index file,
all references in $GIT_DIR/refs/* and all reflogs). In fact it just
ignored the first head it was passed.

It looks like this bug was introduced when "builtin-fsck.c" was
changed to use "parse_options" (commit
5ac0a2063e8f824f6e8ffb4d18de74c55aae7131).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-fsck.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

	Sorry if you receive this patch more than once, but it
	seems that something did not work when I tried to send
	it to the mailing list before. 

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 5a08ec1..fb35554 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -629,7 +629,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	heads = 0;
-	for (i = 1; i < argc; i++) {
+	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!get_sha1(arg, head_sha1)) {
 			struct object *obj = lookup_object(head_sha1);
-- 
1.6.1.85.g8ffc
