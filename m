From: newren@gmail.com
Subject: [PATCH] fast-export: Avoid dropping files from commits
Date: Wed, 25 Mar 2009 14:55:19 -0600
Message-ID: <1238014519-11683-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 21:58:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmaAr-0007F1-L3
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 21:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbZCYU4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 16:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbZCYU4h
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 16:56:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:43938 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbZCYU4g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 16:56:36 -0400
Received: by rv-out-0506.google.com with SMTP id f9so217360rvb.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/1TmsJB5zQTfMn+LQ1o48cggOKw3DJwDDGBd9wc24wU=;
        b=srdP9mcsrA9OxSF4swCZpCc/Mo4aCTX9KvGiPu3tltbtb1iKnlFNUT7ZvEGwyLqvQf
         zuy+PHxE73TukyAhkcsDynKWAHCPjzG2/za+i3nGQHa2sHfU0F16Jgh2xI0TtOAmIoTk
         wZDszZ0RXbJqIEyhIKZzM702HG6DFUWjc/LSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YfqNdHchCuxKmik6bCqyofcLAXC3msmg6ANeqYHd4qqm/0X4ncfXo/k9rRNwnDpW4+
         X0ZAFvATfNzdeDVzQWR1zOYj3OqqS8cLqmssphpt1kUc+ghbpbaNkK6NnWmZhvCzNA3V
         ocRAqKVHNCqyEXDsBVNihzIwe9FtVSdf2weRM=
Received: by 10.140.127.13 with SMTP id z13mr23670rvc.30.1238014594384;
        Wed, 25 Mar 2009 13:56:34 -0700 (PDT)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id f21sm17959929rvb.25.2009.03.25.13.56.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 13:56:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.317.g3d051
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114662>

From: Elijah Newren <newren@gmail.com>

When exporting a subset of commits on a branch that do not go back to a
root commit (e.g. master~2..master), we still want each exported commit to
have the same files in the exported tree as in the original tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin-fast-export.c  |    3 ++-
 t/t9301-fast-export.sh |    7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index fdf4ae9..34a419c 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -221,7 +221,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	if (message)
 		message += 2;
 
-	if (commit->parents) {
+	if (commit->parents &&
+	    get_object_mark(&commit->parents->item->object) != 0) {
 		parse_commit(commit->parents->item);
 		diff_tree_sha1(commit->parents->item->tree->object.sha1,
 			       commit->tree->object.sha1, "", &rev->diffopt);
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 86c3760..b860626 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -8,6 +8,9 @@ test_description='git fast-export'
 
 test_expect_success 'setup' '
 
+	echo break it > file0 &&
+	git add file0 &&
+	test_tick &&
 	echo Wohlauf > file &&
 	git add file &&
 	test_tick &&
@@ -57,8 +60,8 @@ test_expect_success 'fast-export master~2..master' '
 		(cd new &&
 		 git fast-import &&
 		 test $MASTER != $(git rev-parse --verify refs/heads/partial) &&
-		 git diff master..partial &&
-		 git diff master^..partial^ &&
+		 git diff --exit-code master partial &&
+		 git diff --exit-code master^ partial^ &&
 		 test_must_fail git rev-parse partial~2)
 
 '
-- 
1.6.0.6
