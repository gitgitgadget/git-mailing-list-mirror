From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 2/2] gc: Remove garbage .idx files from pack dir
Date: Thu, 13 Aug 2015 13:02:53 -0500
Message-ID: <1439488973-11522-2-git-send-email-dougk.ff7@gmail.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
 <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
Cc: peff@peff.net, Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 20:04:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPwr6-0001fI-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 20:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbbHMSDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 14:03:53 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36121 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbbHMSDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 14:03:48 -0400
Received: by iodv127 with SMTP id v127so44629492iod.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D8Buiqn7NLKuEC3Q3utlRMUwN8vzZtdI/kssTYgGZMs=;
        b=03rNA9FHSiJGZzr3wULS4tqu1WduAlNm778jbf6XVtU1DzkXQmTc35VLbUre/PiOmu
         Az8mLorBbZk2xG1vztHzLP1dV+s4VUpoh1JqxakRQrUujkNlUU0E92Cd+aGTxAJbxdLe
         XXoYrK/ButtzgM/AeD6a+Y5dKH8c4k7uzhXIBhOIQQK1Xpbgm7AcVbDvoXW+4wd7urZV
         h3fQOo6R8VgyDU4hpvUT0bvON8HTrecqS4Am4+nZVsv8F6UpELWGki7QXOLKCSVWQ4/v
         JA+L55qncDDOytYdRPBcWdaXSJQXvPDvAvE5S37/XUZb7qRKFLU6dTWbNjVxN15o2EQy
         D+fg==
X-Received: by 10.107.161.197 with SMTP id k188mr35375427ioe.190.1439489028164;
        Thu, 13 Aug 2015 11:03:48 -0700 (PDT)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by smtp.gmail.com with ESMTPSA id b78sm2006376ioe.2.2015.08.13.11.03.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 11:03:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275868>

Add a custom report_garbage handler to collect and remove garbage
.idx files from the pack directory.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 builtin/gc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcc75d9..8352616 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -42,8 +42,18 @@ static struct argv_array prune = ARGV_ARRAY_INIT;
 static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
 static struct argv_array rerere = ARGV_ARRAY_INIT;
 
+static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
+
 static char *pidfile;
 
+static void clean_pack_garbage(void)
+{
+	int i;
+	for (i = 0; i < pack_garbage.nr; i++)
+		unlink_or_warn(pack_garbage.items[i].string);
+	string_list_clear(&pack_garbage, 0);
+}
+
 static void remove_pidfile(void)
 {
 	if (pidfile)
@@ -57,6 +67,12 @@ static void remove_pidfile_on_signal(int signo)
 	raise(signo);
 }
 
+static void report_pack_garbage(unsigned seen_bits, const char *path)
+{
+	if (seen_bits == PACKDIR_FILE_IDX)
+		string_list_append(&pack_garbage, path);
+}
+
 static void git_config_date_string(const char *key, const char **output)
 {
 	if (git_config_get_string_const(key, output))
@@ -372,6 +388,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
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
-- 
2.0.5
