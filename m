From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] remote-curl: Fix push status report when all branches fail
Date: Thu, 19 Jan 2012 14:24:59 -0800
Message-ID: <1327011899-18883-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 23:25:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro0Ps-0000h6-S3
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 23:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab2ASWZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 17:25:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51989 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab2ASWZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 17:25:03 -0500
Received: by iagf6 with SMTP id f6so501653iag.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 14:25:02 -0800 (PST)
Received: by 10.50.173.98 with SMTP id bj2mr26958222igc.27.1327011902129;
        Thu, 19 Jan 2012 14:25:02 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.27.69.16])
        by mx.google.com with ESMTPS id gh9sm44550015igb.3.2012.01.19.14.25.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 14:25:01 -0800 (PST)
X-Mailer: git-send-email 1.7.8.4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188844>

From: "Shawn O. Pearce" <spearce@spearce.org>

The protocol between transport-helper.c and remote-curl requires
remote-curl to always print a blank line after the push command
has run. If the blank line is ommitted, transport-helper kills its
container process (the git push the user started) with exit(128)
and no message indicating a problem, assuming the helper already
printed reasonable error text to the console.

However if the remote rejects all branches with "ng" commands in the
report-status reply, send-pack terminates with non-zero status, and
in turn remote-curl exited with non-zero status before outputting
the blank line after the helper status printed by send-pack. No
error messages reach the user.

This caused users to see the following from git push over HTTP
when the remote side's update hook rejected the branch:

  $ git push http://... master
  Counting objects: 4, done.
  Delta compression using up to 6 threads.
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 301 bytes, done.
  Total 3 (delta 0), reused 0 (delta 0)
  $

Always print a blank line after the send-pack process terminates,
ensuring the helper status report (if it was output) will be
correctly parsed by the calling transport-helper.c. This ensures
the helper doesn't abort before the status report can be shown to
the user.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote-curl.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 48c20b8..d6054e2 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -805,7 +805,7 @@ static int push(int nr_spec, char **specs)
 static void parse_push(struct strbuf *buf)
 {
 	char **specs = NULL;
-	int alloc_spec = 0, nr_spec = 0, i;
+	int alloc_spec = 0, nr_spec = 0, i, ret;
 
 	do {
 		if (!prefixcmp(buf->buf, "push ")) {
@@ -822,12 +822,11 @@ static void parse_push(struct strbuf *buf)
 			break;
 	} while (1);
 
-	if (push(nr_spec, specs))
+	ret = push(nr_spec, specs);
+	xwrite(1, "\n", 1);
+	if (ret)
 		exit(128); /* error already reported */
 
-	printf("\n");
-	fflush(stdout);
-
  free_specs:
 	for (i = 0; i < nr_spec; i++)
 		free(specs[i]);
-- 
1.7.8.4.dirty
