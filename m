From: Tom Preston-Werner <tom@mojombo.com>
Subject: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Tue, 18 Aug 2009 00:04:53 -0700
Message-ID: <1250579093-40706-1-git-send-email-tom@mojombo.com>
Cc: Tom Preston-Werner <tom@mojombo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 09:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdIlz-0001eS-IG
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 09:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbZHRHGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 03:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbZHRHGO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 03:06:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:22564 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZHRHGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 03:06:13 -0400
Received: by wa-out-1112.google.com with SMTP id j5so594497wah.21
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 00:06:14 -0700 (PDT)
Received: by 10.114.55.7 with SMTP id d7mr5387788waa.129.1250579174095;
        Tue, 18 Aug 2009 00:06:14 -0700 (PDT)
Received: from localhost.localdomain (c-67-180-209-73.hsd1.ca.comcast.net [67.180.209.73])
        by mx.google.com with ESMTPS id j15sm11853039waf.16.2009.08.18.00.06.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 00:06:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126354>

A post-upload-pack hook is desirable for Git hosts that need to
collect statistics on how many clones and/or fetches are made
on each repository.

The hook is called with either "clone" or "fetch" as the only
argument, depending on whether a full pack file was sent to the
client or not.

Signed-off-by: Tom Preston-Werner <tom@mojombo.com>
---
 upload-pack.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index f7d308a..96231dc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -141,6 +141,13 @@ static int do_rev_list(int fd, void *create_full_pack)
 	return 0;
 }
 
+static void run_post_upload_pack_hook(int create_full_pack)
+{
+	const char *fetch_type;
+	fetch_type = (create_full_pack) ? "clone" : "fetch";
+	run_hook(get_index_file(), "post-upload-pack", fetch_type);
+}
+
 static void create_pack_file(void)
 {
 	struct async rev_list;
@@ -314,6 +321,8 @@ static void create_pack_file(void)
 	}
 	if (use_sideband)
 		packet_flush(1);
+
+	run_post_upload_pack_hook(create_full_pack);
 	return;
 
  fail:
-- 
1.6.3.1
