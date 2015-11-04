From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 3/3] gc: Remove garbage .idx files from pack dir
Date: Tue,  3 Nov 2015 21:05:08 -0600
Message-ID: <1446606308-1668-3-git-send-email-dougk.ff7@gmail.com>
References: <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
 <1446606308-1668-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 04:05:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtoOA-0001aO-0G
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 04:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbbKDDF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 22:05:26 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34643 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbKDDFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 22:05:25 -0500
Received: by iody8 with SMTP id y8so40445238iod.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 19:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8VsiqTXFpJ3sIQslqhTW+vSDibKMmJVYlPiGxmY0+A=;
        b=SatMfy2FRN7khMIWgRw/4UxtN5Rej+XMcDGS2DomcPrTWcmuhNP2benMa+n5fTgk9E
         YQ+y0gaI8dR087f9HOf12eN/9tEk2f7IZPc1mNljDYi2XcLqfFU2YlzWxZ0juYE6q+qH
         S5jNN/oGt4UpKKnAGqpxX2R1Xm5XQirdWKHhxylZGuYoCGWL3cP7+/CLi5qNVmVmE7LH
         gelN2MEjDvMKsyCfTI8YJrtencmnDUlzxAgNuJd/CogEqXSGAfzqtlUFQxBCakU4RwAh
         xdSOv2Cv2JBdx8wmkfqGYm7+p7zuirITSIdG64cMDbYDQaiPE68MIsvhaUyPNxyW3rBc
         Hxvg==
X-Received: by 10.107.9.233 with SMTP id 102mr678944ioj.122.1446606325072;
        Tue, 03 Nov 2015 19:05:25 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by smtp.gmail.com with ESMTPSA id c23sm292311iod.0.2015.11.03.19.05.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Nov 2015 19:05:24 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1446606308-1668-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280846>

Add a custom report_garbage handler to collect and remove garbage
.idx files from the pack directory.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 builtin/gc.c     | 20 ++++++++++++++++++++
 t/t5304-prune.sh |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index df3e454..668f975 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -45,6 +45,21 @@ static struct argv_array rerere = ARGV_ARRAY_INIT;
 
 static struct tempfile pidfile;
 static struct lock_file log_lock;
+static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
+
+static void clean_pack_garbage(void)
+{
+	int i;
+	for (i = 0; i < pack_garbage.nr; i++)
+		unlink_or_warn(pack_garbage.items[i].string);
+	string_list_clear(&pack_garbage, 0);
+}
+
+static void report_pack_garbage(unsigned seen_bits, const char *path)
+{
+	if (seen_bits == PACKDIR_FILE_IDX)
+		string_list_append(&pack_garbage, path);
+}
 
 static void git_config_date_string(const char *key, const char **output)
 {
@@ -416,6 +431,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, rerere.argv[0]);
 
+	report_garbage = report_pack_garbage;
+	reprepare_packed_git();
+	if (pack_garbage.nr > 0)
+		clean_pack_garbage();
+
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 0297515..def203c 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -245,7 +245,7 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_failure 'clean pack garbage with gc' '
+test_expect_success 'clean pack garbage with gc' '
 	test_when_finished "rm -f .git/objects/pack/fake*" &&
 	test_when_finished "rm -f .git/objects/pack/foo*" &&
 	: >.git/objects/pack/foo.keep &&
-- 
2.5.1
