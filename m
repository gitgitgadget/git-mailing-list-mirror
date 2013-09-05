From: Hiroshige Umino <hiroshige88@gmail.com>
Subject: [PATCH v2] cherry-pick: allow "-" as abbreviation of '@{-1}'
Date: Thu,  5 Sep 2013 23:57:23 +0900
Message-ID: <1378393043-55403-1-git-send-email-hiroshige88@gmail.com>
Cc: Hiroshige Umino <hiroshige88@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 16:58:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHb0x-0002Vg-QS
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 16:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab3IEO61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 10:58:27 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60793 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab3IEO60 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 10:58:26 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so2008062pad.19
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=V0mcGury95hOP3odmzAsllhMrYshMOvNzZsfFut6r8I=;
        b=avGW73ZmRJirwQUoN3tpKnv58UuaL3BoteGB1F1CEOAxC1Nlkh9fkMtk6viJ1pxb/y
         ukWXsyDKAEmKeZPLQz3AaomDUAubqzzOv2N66hBUNqNWkACb6+1Y14ivhGsq7T4yceRs
         xak7LqzLmx5hOAbJ936mvj3fmmtezOqxaZoxvKHfN/673/xNJh6Tl3WdFzJcHoyPXVlD
         Rof7LyiWyhl26drZWsKfE8gje4h/kzTvkRLan1zIJL4yJG3U4kSImO9lYRunXjcU+Yl2
         SZjjf743aNNJdwF/WkXFNakiy/mLiWxQSrvRMyAO1DP6gNTt9hM0BTfqQclUEpZNBHB7
         rKvQ==
X-Received: by 10.66.221.8 with SMTP id qa8mr2339970pac.188.1378393106527;
        Thu, 05 Sep 2013 07:58:26 -0700 (PDT)
Received: from localhost.localdomain (p1210-ipbf5109marunouchi.tokyo.ocn.ne.jp. [118.8.112.210])
        by mx.google.com with ESMTPSA id dg3sm36174350pbc.24.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 07:58:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233960>

"-" abbreviation is handy for "cherry-pick" like "checkout" and "merge".

It's also good for uniformity that a "-" stands as
the name of the previous branch where a branch name is
accepted and it could not mean any other things like stdin.

Signed-off-by: Hiroshige Umino <hiroshige88@gmail.com>
---
 builtin/revert.c  |  2 ++
 t/t3500-cherry.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8e87acd..52c35e7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -202,6 +202,8 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
+	if (!strcmp(argv[1], "-"))
+		argv[1] = "@{-1}";
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index f038f34..547dbf8 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -55,4 +55,19 @@ test_expect_success \
      expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
 '
 
+test_expect_success \
+    '"cherry-pick -" does not work initially' \
+    'test_must_fail git cherry-pick -
+'
+
+test_expect_success \
+    'cherry-pick the commit in the previous branch' \
+    'git branch other &&
+     test_commit commit-to-pick newfile content &&
+     echo content >expected &&
+     git checkout other &&
+     git cherry-pick - &&
+     test_cmp expected newfile
+'
+
 test_done
-- 
1.8.3.4
