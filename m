From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/3] diff.c: omit hidden entries from namelen calculation with --stat
Date: Fri, 27 May 2011 14:36:40 +0200
Message-ID: <b47e2f0865bac1ad0e7b777ce9f27493292c502c.1306499600.git.git@drmicha.warpmail.net>
References: <4DC0FD3D.9010004@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 14:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPwHd-0005GB-0J
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 14:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab1E0Mgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 08:36:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60285 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753688Ab1E0Mgr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 08:36:47 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 98D9C20A18;
	Fri, 27 May 2011 08:36:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 27 May 2011 08:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=qis5wrIYkpOZ89SrjL9vDiu2r8E=; b=faG7qmXFPjqBFujTMW6YseBvWUsQSxDWyLfpua6QSXskwD1/MylN1ITwHtqbwVIhdzvCttagujvVO0pf1SjugIcadnPGk4EonYxfndbOtL5plQ1sX6A9vixZPLqFWej9nm5NGDRNBOm6dodSPdrvfTBsBya+ba0T4FscOSTvKb4=
X-Sasl-enc: TTNNxvDi4Sa/UYegbIiDbYij15INKVYLfSWe5AK6p6nV 1306499806
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1FA5740777D;
	Fri, 27 May 2011 08:36:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.657.g62c2
In-Reply-To: <4DC0FD3D.9010004@drmicha.warpmail.net>
In-Reply-To: <cover.1306499600.git.git@drmicha.warpmail.net>
References: <cover.1306499600.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174611>

Currently, --stat calculates the longest name from all items but then
drops some (mode changes) from the output later on.

Instead, drop them from the namelen generation and calculation.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This optimizes (tightens) the display potentially, but we never had tests
which are sensitive to that.
---
 diff.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index feced34..4541939 100644
--- a/diff.c
+++ b/diff.c
@@ -1278,6 +1278,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 		uintmax_t change = file->added + file->deleted;
+		if (!data->files[i]->is_renamed &&
+			 (change == 0)) {
+			continue;
+		}
 		fill_print_name(file);
 		len = strlen(file->print_name);
 		if (max_len < len)
@@ -1309,6 +1313,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		uintmax_t deleted = data->files[i]->deleted;
 		int name_len;
 
+		if (!data->files[i]->is_renamed &&
+			 (added + deleted == 0)) {
+			total_files--;
+			continue;
+		}
 		/*
 		 * "scale" the filename
 		 */
@@ -1343,11 +1352,6 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			fprintf(options->file, "  Unmerged\n");
 			continue;
 		}
-		else if (!data->files[i]->is_renamed &&
-			 (added + deleted == 0)) {
-			total_files--;
-			continue;
-		}
 
 		/*
 		 * scale the add/delete
-- 
1.7.5.2.657.g62c2
