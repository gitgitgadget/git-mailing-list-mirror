From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 31/37] merge-recursive: Delay modify/delete conflicts if D/F conflict present
Date: Mon, 20 Sep 2010 02:29:04 -0600
Message-ID: <1284971350-30590-32-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblM-0006R4-6z
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927Ab0ITI2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab0ITI2f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:35 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PBN8FLwcoo0C19nFUKUluOhYz4jwj9apWbJZzygYI34=;
        b=IqwMjOwZWW1xImKcieaA1a4ZJFjkZyxn1/vuAAOkeBnCn+aKx/HWTjUWNRk46JL41L
         8RkqseBf1i6wpmSmbqzeWa9bB7zEhxalhWmiIpzqlEFhxVd1XGEN2kLEAMZ0vuMV0wrK
         ZIrcXWlBJLgDpKjKN7Et+oUwvTagGq5pYR3/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O/pg5zYX//X/SnX+cpMzzWWGgeVcp1bf0YA7GHeDIGyBQGK8fhLwlUR2EEcRZE4a6G
         A7+qV5/Rw5Ni4vSntW88xBWDYEk+6HkwVq10q7GRvqEzOZ4JpUykeeqlJxj86lGJTGKW
         qLVwvpL0LMZsfovTs/GoKZWKlvi4ax0OR+kaI=
Received: by 10.142.110.6 with SMTP id i6mr6912275wfc.276.1284971314838;
        Mon, 20 Sep 2010 01:28:34 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156587>

When handling merges with modify/delete conflicts, if the modified path is
involved in a D/F conflict, handle the issue in process_df_entry() rather
than process_entry().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 008cacb..d9fcd6d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1249,6 +1249,10 @@ static int process_entry(struct merge_options *o,
 				output(o, 2, "Removing %s", path);
 			/* do not touch working file if it did not exist */
 			remove_file(o, 1, path, !a_sha);
+		} else if (string_list_has_string(&o->current_directory_set,
+						  path)) {
+			entry->processed = 0;
+			return 1; /* Assume clean till processed */
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;
@@ -1367,6 +1371,11 @@ static int process_df_entry(struct merge_options *o,
 			entry->processed = 0;
 			break;
 		}
+	} else if (o_sha && (!a_sha || !b_sha)) {
+		/* Modify/delete; deleted side may have put a directory in the way */
+		clean_merge = 0;
+		handle_delete_modify(o, path,
+				     a_sha, a_mode, b_sha, b_mode);
 	} else if (!o_sha && !!a_sha != !!b_sha) {
 		/* directory -> (directory, file) */
 		const char *add_branch;
-- 
1.7.3.271.g16009
