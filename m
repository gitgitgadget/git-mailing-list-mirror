From: blacksimit <cengoguzhanunlu@gmail.com>
Subject: [PATCH] Rewritten fsck.c:fsck_commit() through using starts_with() instead of memcmp()
Date: Thu, 20 Mar 2014 07:48:28 +0200
Message-ID: <1395294508-18301-1-git-send-email-cengoguzhanunlu@gmail.com>
Cc: blacksimit <cengoguzhanunlu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 06:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQVqv-0001q7-5d
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 06:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbaCTFsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 01:48:50 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:41113 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbaCTFst (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 01:48:49 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so207801eek.38
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UqgNbs0H735yjisnkvXWAfxFSZ3Q7SPB7/LWY0WYWY8=;
        b=njmfCXNAmpxGKQrhPxmwichWh26w/OhcLjFSRfFLRU8rIW0LBrrNbFfEXaKd5OlocV
         GOWjmNlQlmiiqxWUgXgUWM5vs73LgAqQmR0mgWB7B8np3TWMRFWjmIpkT3zCNbjNsT8j
         +5zFeSIvqwbe9/zeDrW3nzs6cEiL/IWaCo1jl0RQYYHjbE7fNz1WsY2dgOtPK5n07FgB
         XXqA63ZvPbbPnxfaKq1eiQP+iapeKKGg4O5ER4lYD9VtUiE/YhyrTUfExvn2NOOAzvul
         V9xo8l8cHGtFDwVgmRMxeIiLAaiVZURCNAmBaA0RBcXEJxy7dLYV6mLtllxJzbH6jWRb
         cklw==
X-Received: by 10.15.51.1 with SMTP id m1mr39973829eew.25.1395294528389;
        Wed, 19 Mar 2014 22:48:48 -0700 (PDT)
Received: from localhost.localdomain (pc-112-144.idemiray.metu.edu.tr. [144.122.112.144])
        by mx.google.com with ESMTPSA id y51sm1818413eeu.0.2014.03.19.22.48.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 22:48:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.286.g5172cb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244520>

Hi, I've done a microproject, number 15, "Rewrite fsck.c:fsck_commit() to use starts_with() and/or skip_prefix()." I used only starts_with().

memcmp() returns 0 when both are equal, therefore when replacing with starts_with() , I used "!" or deleted where appropriate.

I plan to apply for the GSoC 2014. I expect your feedbacks!

Signed-off-by: Oguzhan Unlu <cengoguzhanunlu@gmail.com>
---
 fsck.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 64bf279..d43be98 100644
--- a/fsck.c
+++ b/fsck.c
@@ -290,12 +290,12 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	int parents = 0;
 	int err;
 
-	if (memcmp(buffer, "tree ", 5))
+	if (!starts_with(buffer, "tree "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
 	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (starts_with(buffer, "parent ")) {
 		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
@@ -322,13 +322,13 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	if (memcmp(buffer, "author ", 7))
+	if (!starts_with(buffer, "author "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
 	buffer += 7;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	if (memcmp(buffer, "committer ", strlen("committer ")))
+	if (!starts_with(buffer, "committer "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
 	buffer += strlen("committer ");
 	err = fsck_ident(&buffer, &commit->object, error_func);
-- 
1.9.1.286.g5172cb3
