From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 17/37] merge-recursive: Move rename/delete handling into dedicated function
Date: Mon, 20 Sep 2010 02:28:50 -0600
Message-ID: <1284971350-30590-18-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblR-0006R4-2O
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab0ITI33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:29:29 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63878 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab0ITI2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:06 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1072016pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dnN8vUCaukUCFIzJQGQoP+GkIVbHo3APtBQK5hXEz7A=;
        b=VLcTOrUsyaU0vESLwewfNwksXyV+Xq3J99VsD3XzD/OtCPVnLSmkL2JdnWsbW5KeRv
         BE3JXYdVk2azCOcuvFfcc5IN+SbW9eGPNmp222bjJkRHPcNx+cilL6Nt3U/Yt3f0Uajo
         iT5x626hda7Z4xNVnoAHAm04+YcY7vN81/NJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IchSWNjYnYZF7DWJzJzmS1hrfgHW8ql4uOBtkoug0wVX010KukwA0VJyQvYv5ON1JB
         2DN2ZxPFpofpCpUwDYbHvkA++Kncs1V1ojLnUN4ooiz2vglCCaJ2ovg3mw/IZqEPilJ4
         gZNvQ90l+CQuL0CJ6El8Ix0Vnf4GA8bnrG78U=
Received: by 10.142.248.37 with SMTP id v37mr7328794wfh.349.1284971286663;
        Mon, 20 Sep 2010 01:28:06 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156594>

This move is in preparation for the function growing and being called from
multiple places in order to handle D/F conflicts.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f7591a3..87be24c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -731,6 +731,25 @@ static struct merge_file_info merge_file(struct merge_options *o,
 	return result;
 }
 
+static void conflict_rename_delete(struct merge_options *o,
+				   struct diff_filepair *pair,
+				   const char *rename_branch,
+				   const char *other_branch)
+{
+	char *dest_name = pair->two->path;
+
+	output(o, 1, "CONFLICT (rename/delete): Rename %s->%s in %s "
+	       "and deleted in %s",
+	       pair->one->path, pair->two->path, rename_branch,
+	       other_branch);
+	if (!o->call_depth)
+		update_stages(dest_name, NULL,
+			      rename_branch == o->branch1 ? pair->two : NULL,
+			      rename_branch == o->branch1 ? NULL : pair->two,
+			      1);
+	update_file(o, 0, pair->two->sha1, pair->two->mode, dest_name);
+}
+
 static void conflict_rename_rename_1to2(struct merge_options *o,
 					struct rename *ren1,
 					const char *branch1,
@@ -937,17 +956,7 @@ static int process_renames(struct merge_options *o,
 
 			if (sha_eq(src_other.sha1, null_sha1)) {
 				clean_merge = 0;
-				output(o, 1, "CONFLICT (rename/delete): Rename %s->%s in %s "
-				       "and deleted in %s",
-				       ren1_src, ren1_dst, branch1,
-				       branch2);
-				update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
-				if (!o->call_depth)
-					update_stages(ren1_dst, NULL,
-							branch1 == o->branch1 ?
-							ren1->pair->two : NULL,
-							branch1 == o->branch1 ?
-							NULL : ren1->pair->two, 1);
+				conflict_rename_delete(o, ren1->pair, branch1, branch2);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
 				/* Added file on the other side
-- 
1.7.3.271.g16009
