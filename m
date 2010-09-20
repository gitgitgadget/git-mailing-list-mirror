From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 21/37] merge-recursive: New function to assist resolving renames in-core only
Date: Mon, 20 Sep 2010 02:28:54 -0600
Message-ID: <1284971350-30590-22-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblI-0006R4-1K
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab0ITI2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39104 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854Ab0ITI2O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:14 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1070490pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LKh4Ijck1evev/DfCfke5LPAfoQdxDfodub8qjWwNpI=;
        b=d61BqJJG6QiSsT5Ch9kbBFMF5HIKQFFfWdrFuqdvGif4yBo/ulAvVlpIXBSo35QX3d
         vvY2+PLdcU/qEJFXPl3FF+cDx3sI2P8kbLbxBVwiyhj9v5jY9q9knZjFFMk+amHX/BFp
         6TNA92AZyMfpQG/egc+0JDBZhmdnNUqUWZizk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AQMW1S+xw5v3IgW/PduG0UkeqOQG7ru/iDOsz97gx4EA+FHA9N8H+Rm8wQeEIA6J1R
         +4fqq2db671lYEDeWCWcUxcO1ub4vUq9MOeDT2C/OCbM7zWHfTKqgBYk7pAxIu0lAw21
         eRZv5vfibe6e02QpBSq8skl2M2TnH7qCmv5gk=
Received: by 10.142.217.9 with SMTP id p9mr7336776wfg.296.1284971294673;
        Mon, 20 Sep 2010 01:28:14 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156580>

process_renames() and process_entry() have nearly identical code for
doing three-way file merging to resolve content changes.  Since we are
already deferring some of the current rename handling in order to better
handle D/F conflicts, it seems to make sense to defer content merging as
well and remove the (nearly) duplicated code sections for handling this
merging.

To facilitate this process, add a new update_stages_and_entry() function
which will map the higher stage index entries from two files involved in a
rename into the resulting rename destination's index entries, and update
the associated stage_data structure.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f15291e..ec47d56 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -418,11 +418,10 @@ static struct string_list *get_renames(struct merge_options *o,
 	return renames;
 }
 
-static int update_stages(const char *path, struct diff_filespec *o,
+static int update_stages_options(const char *path, struct diff_filespec *o,
 			 struct diff_filespec *a, struct diff_filespec *b,
-			 int clear)
+			 int clear, int options)
 {
-	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
 	if (clear)
 		if (remove_file_from_cache(path))
 			return -1;
@@ -438,6 +437,32 @@ static int update_stages(const char *path, struct diff_filespec *o,
 	return 0;
 }
 
+static int update_stages(const char *path, struct diff_filespec *o,
+			 struct diff_filespec *a, struct diff_filespec *b,
+			 int clear)
+{
+	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+	return update_stages_options(path, o, a, b, clear, options);
+}
+
+static int update_stages_and_entry(const char *path,
+				   struct stage_data *entry,
+				   struct diff_filespec *o,
+				   struct diff_filespec *a,
+				   struct diff_filespec *b,
+				   int clear)
+{
+	entry->processed = 0;
+	entry->stages[1].mode = o->mode;
+	entry->stages[2].mode = a->mode;
+	entry->stages[3].mode = b->mode;
+	hashcpy(entry->stages[1].sha, o->sha1);
+	hashcpy(entry->stages[2].sha, a->sha1);
+	hashcpy(entry->stages[3].sha, b->sha1);
+	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
+	return update_stages_options(path, o, a, b, clear, options);
+}
+
 static int remove_file(struct merge_options *o, int clean,
 		       const char *path, int no_wd)
 {
-- 
1.7.3.271.g16009
