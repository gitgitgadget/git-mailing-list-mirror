From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] git-rev-list: tolerate multiple --stdin options
Date: Sun,  6 Jul 2008 10:28:57 -0400
Message-ID: <1215354538-1469-2-git-send-email-adambrewster@gmail.com>
References: <7v63rjrfqz.fsf@gitster.siamese.dyndns.org>
 <1215354538-1469-1-git-send-email-adambrewster@gmail.com>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, vmiklos@frugalware.org,
	Adam Brewster <adambrewster@gmail.com>,
	Adam Brewster <asb@bu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 16:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFVFd-0003Td-6x
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 16:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676AbYGFO3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 10:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbYGFO3H
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 10:29:07 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:28501 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbYGFO3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 10:29:03 -0400
Received: by an-out-0708.google.com with SMTP id d40so354227and.103
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=NrqDNt3NnsFVGCNNUhx3YQNe4/7hlTUTSR2TX+gkHnk=;
        b=GmN0xhvlfdwluXxkXOgmDg2RbuZYYb8JVqwYV7HDByX2PtvttF0VJNCydSUsk7qrXX
         aQIZfeHQiED5ArTEoDXg5ypaInxWEg0IVkX5GkRorB8RQQLKgLSLjbg+gfHr+6WclwU3
         KZ2TPRj+I0POlpzYaBLvMoivNztxs1N0JTfpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kI242kKO5e3uB6FU0WzXohMU+y0x/+Tnf7lnY9gb0tHzTwhzqyjH2qiRGj2Lb0fJv6
         RBZLgDr7sz+EwatrseimB+gNrAXW3oFvodIG4Qtna7vgJRUGuQ4fQ9HNV/P4aGCh2Byy
         z/hMYt9pM1z33XeyljMsVUaHZ6KVeN0rQyTjY=
Received: by 10.100.152.5 with SMTP id z5mr2180464and.100.1215354542013;
        Sun, 06 Jul 2008 07:29:02 -0700 (PDT)
Received: from MBE.internal ( [65.96.169.255])
        by mx.google.com with ESMTPS id 33sm3545872yxr.3.2008.07.06.07.28.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 07:28:59 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id 790E410494F; Sun,  6 Jul 2008 10:28:58 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <1215354538-1469-1-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87531>

There's no reason to fail if the user asks for --stdin twice.  Of course
there's only one stdin, and it can only be read once, and there's no
reason to ask for it twice, but --all --all doesn't make sense, and
that's accepted, so accept this too.

Also, with read_revisions_from_stdin in revision.c where it might be
called by other programs, it's better to check that stdin isn't at eof
before trying to read it.

Signed-off-by: Adam Brewster <asb@bu.edu>
---
 builtin-rev-list.c |    3 ---
 revision.c         |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index b4a2c44..7f7c1a7 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -579,7 +579,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
 	int i;
-	int read_from_stdin = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
 	int quiet = 0;
@@ -616,8 +615,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--stdin")) {
-			if (read_from_stdin++)
-				die("--stdin given twice?");
 			read_revisions_from_stdin(&revs);
 			continue;
 		}
diff --git a/revision.c b/revision.c
index 0191160..c1550c4 100644
--- a/revision.c
+++ b/revision.c
@@ -914,7 +914,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 void read_revisions_from_stdin(struct rev_info *revs)
 {
 	char line[1000];
-
+	if (feof(stdin)) return;
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
 		if (len && line[len - 1] == '\n')
-- 
1.5.5.1.211.g65ea3.dirty
