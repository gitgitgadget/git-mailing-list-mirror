From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [PATCH] Added --exit-code option to git-status
Date: Sat, 05 Mar 2011 16:20:43 +0100
Message-ID: <4D7254CB.5040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 16:21:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvtHw-0000I2-7v
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 16:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab1CEPUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 10:20:54 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35059 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab1CEPUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 10:20:53 -0500
Received: by bwz15 with SMTP id 15so2814131bwz.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=GcJUzKQLLqNgJVnaC/pk4NgC7V0GmhHLhRFFgB2rpEc=;
        b=Q9IJfe2ohphZOMh800QSDCWHXGcLvVanmJ7qBt26dUQiVG1AuMKxLzmBd9rY5BywOQ
         ++TkKnjJZY+pOZmqALvIDY+ngJzbM52fEgRoXkWeHzYL+ut1Y3LQRyW3SvnG3Gm1sOKW
         rKxNrM5EkoH/XtRRRJKs+s3QPPy5MlQ8eIXaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=MdPWZYrfOffxYvNMj4Ny+1Qc+pWa3aSQFF786zsujBDjWIvboWnc9oL6JelgSia/4E
         IP3Lu7tz5K8cg47sxoQQQU59oubbfrmxOY8UespJlc7Hwzr1bjW6Ma2XXIUJUXL5OSFA
         kt7dgrzJDNBUbVyu+vBGfvUlb6qlbaCkqJTUY=
Received: by 10.204.45.164 with SMTP id e36mr1678629bkf.29.1299338451576;
        Sat, 05 Mar 2011 07:20:51 -0800 (PST)
Received: from [192.168.1.101] (alb163.neoplus.adsl.tpnet.pl [83.26.31.163])
        by mx.google.com with ESMTPS id b6sm405341bkb.22.2011.03.05.07.20.49
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 07:20:50 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168500>

When this option is specified git-status returns non-zero
exit code when there are untracked, modifed or staged files.
The exit code is a combination of following:
2 - untracked files
4 - modified files
8 - staged files
---

Recently there was a question on irc how to check if there are
any changes in working tree reliably, to be used in scripts.
So I've added the --exit-code to git-status.

Some items I'm not sure of:
- does die() return 1 everywhere? I've skipped this value in codes
- are there more possible states of working tree?

I also have a test written, what's left is documentation.

Comments?

 builtin/commit.c |    8 +++++++-
 wt-status.c      |   23 +++++++++++++++++++++++
 wt-status.h      |   11 +++++++++++
 3 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 355b2cb..283e32a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -100,6 +100,7 @@ static enum {
 	STATUS_FORMAT_PORCELAIN
 } status_format = STATUS_FORMAT_LONG;
 static int status_show_branch;
+static int status_use_exit_code;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -1085,6 +1086,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	struct wt_status s;
 	int fd;
 	unsigned char sha1[20];
+	int exit_code = 0;
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT_SET_INT('s', "short", &status_format,
@@ -1105,6 +1107,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, "when",
 		  "ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)",
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_BOOLEAN(0, "exit-code", &status_use_exit_code,
+			    "use exit code to specify status"),
 		OPT_END(),
 	};
 
@@ -1164,7 +1168,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		wt_status_print(&s);
 		break;
 	}
-	return 0;
+	if (status_use_exit_code)
+		exit_code = wt_status_exit_code(&s);
+	return exit_code;
 }
 
 static void print_summary(const char *prefix, const unsigned char *sha1)
diff --git a/wt-status.c b/wt-status.c
index a82b11d..b55f997 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -882,3 +882,26 @@ void wt_porcelain_print(struct wt_status *s, int null_termination)
 	s->prefix = NULL;
 	wt_shortstatus_print(s, null_termination, 0);
 }
+
+int wt_status_exit_code(struct wt_status *s)
+{
+	int ec = 0;
+	int dirty_submodules = 0;
+
+	if (!s)
+		return ec;
+
+	if (s->untracked.nr)
+		ec += STATUS_EC_UNTRACKED;
+
+	if (wt_status_check_worktree_changes(s, &dirty_submodules))
+		ec += STATUS_EC_MODIFIED;
+
+	if (s->commitable)
+		ec += STATUS_EC_STAGED;
+
+	/* TODO: what about dirty_submodules ? */
+
+	return ec;
+}
+
diff --git a/wt-status.h b/wt-status.h
index 7d16c51..845c5b1 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -68,4 +68,15 @@ void wt_status_collect(struct wt_status *s);
 void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_branch);
 void wt_porcelain_print(struct wt_status *s, int null_termination);
 
+/* Status of the working tree/index. Can be combined, for example 6 means
+ * there are some untracked and some modified files.
+ * 1 not used explicitly - used by die() ? */
+#define STATUS_EC_NO_CHANGES 0
+#define STATUS_EC_UNTRACKED  2 /* There are untracked files */ 
+#define STATUS_EC_MODIFIED   4 /* There are modified files (not staged) */
+#define STATUS_EC_STAGED     8 /* There are staged files (added) */
+
+/* Returns status exit code - see description of STATUS_EC_* defines */
+int wt_status_exit_code(struct wt_status *s);
+
 #endif /* STATUS_H */
-- 
1.7.4.1.179.gb9a20
