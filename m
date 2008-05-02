From: Richard Quirk <richard.quirk@gmail.com>
Subject: [PATCH] git-cherry: add color to the output
Date: Fri,  2 May 2008 20:01:44 +0200
Message-ID: <1209751304-25304-1-git-send-email-richard.quirk@gmail.com>
Cc: git@vger.kernel.org, Richard Quirk <richard.quirk@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 02 20:04:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrzai-0005UW-HL
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 20:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbYEBSBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 14:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758668AbYEBSBu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 14:01:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:32395 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318AbYEBSBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 14:01:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so733681nfc.21
        for <git@vger.kernel.org>; Fri, 02 May 2008 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=zO+Ss40eFBiMSEBST92CLowbyWPIz6bFVSmVgNdvZb0=;
        b=lAywbCDxnnszy831dpU3523GEZ8tjfVVgIOBKT24X6Rr3h95F9BM9GpptjrDgXiCKA3X+CjGxyo+ra6YrCct/NbaFNjR6C470h9rQdpnigNQlc9FmEVzxya6Shk8PVTpLQiycpCR8tZWUZRo1uMvpd91/zynho7VfI68D6JR9ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=p70GYNL8a3MGLT64UGgodMAhS1FZ8Lg9jvdO8GcOh3VE1d1w03YAbOFTexdPa6OjIB0ovoETj5zf3iZEvTcIQ/lVpq2+h5EQvCoV+6cpVkCWn4QCLYGyDFyI3VQqd/Ijwn+QqB0RxJGuXQPpdbseUFhJRWioDqGo6nDxAfvwq2w=
Received: by 10.210.71.13 with SMTP id t13mr3270474eba.130.1209751307114;
        Fri, 02 May 2008 11:01:47 -0700 (PDT)
Received: from localhost ( [84.77.0.229])
        by mx.google.com with ESMTPS id d24sm35202873nfh.2.2008.05.02.11.01.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 May 2008 11:01:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.116.ge4b9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81014>

If color.diff is set then patches not yet cherry-picked are marked green
and already picked ones are marked red. This makes it easier to tell at a
glance which changes have not been cherry-picked.

A possible inconsistency is that the sha1 is marked in red or green here
whereas it is yellow elsewhere. The other possibility was to mark only
the +/- sign in the appropriate color, but this was more difficult to
distinguish between not-picked/picked changes.

Signed-off-by: Richard Quirk <richard.quirk@gmail.com>
---
 builtin-log.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1670d0b..bca6dd7 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1083,6 +1083,11 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	const char *limit = NULL;
 	int verbose = 0;
 
+	git_config(git_log_config);
+
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	if (argc > 1 && !strcmp(argv[1], "-v")) {
 		verbose = 1;
 		argc--;
@@ -1136,26 +1141,32 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 
 		commit_list_insert(commit, &list);
 	}
+	const char *reset = diff_get_color(diff_use_color_default, DIFF_RESET);
+	const char *old = diff_get_color(diff_use_color_default, DIFF_FILE_OLD);
+	const char *new = diff_get_color(diff_use_color_default, DIFF_FILE_NEW);
 
 	while (list) {
 		char sign = '+';
+		const char * line_color = new;
 
 		commit = list->item;
-		if (has_commit_patch_id(commit, &ids))
+		if (has_commit_patch_id(commit, &ids)) {
 			sign = '-';
+			line_color = old;
+		}
 
+		printf("%s%c %s%s", line_color, sign,
+		       sha1_to_hex(commit->object.sha1), reset);
 		if (verbose) {
 			struct strbuf buf;
 			strbuf_init(&buf, 0);
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
 			                    &buf, 0, NULL, NULL, 0, 0);
-			printf("%c %s %s\n", sign,
-			       sha1_to_hex(commit->object.sha1), buf.buf);
+			printf(" %s\n", buf.buf);
 			strbuf_release(&buf);
 		}
 		else {
-			printf("%c %s\n", sign,
-			       sha1_to_hex(commit->object.sha1));
+			printf("\n");
 		}
 
 		list = list->next;
-- 
1.5.5.1.116.ge4b9c
