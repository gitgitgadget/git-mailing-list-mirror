From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 4/6] refs: add safe_create_reflog function
Date: Thu, 25 Jun 2015 16:45:08 -0400
Message-ID: <1435265110-6414-4-git-send-email-dturner@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jun 25 22:45:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8E1k-00067M-38
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbbFYUpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:45:34 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38745 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbFYUp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:45:29 -0400
Received: by igin14 with SMTP id n14so528465igi.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ifs1ORTRDffCcGD9zqABDErswzrGlDei2ktUXVuZ4l0=;
        b=imM3pRIteL++M9Rs/6UoMjOhLPHBiPBrc/fyCuRWdFlhc9RrxtIvGBDyWiuZcaPr5y
         C2Y/tK4e9IN9zRU5ulTSFLDp+3ZAT3d6eLWl4OurgZCbRjjkaIwxSf0SzTpACXfm4i82
         rtpHkh4CStX8KXMCKHv85IO2sl1LZoOEtLvTBZJ7B8yMurBXkLQY7D/xE0P9XKoFrUBb
         y0LCH8yWbb3ByGtCmo+i24/zNH9Jg3L/tpPg/5n0SXXgsTDfR/I5zGtOq08rRn4bdPao
         3qAfUilt36D7ko3GYms171hyLLwkMf8UVxbjFr8Sq1jh1Z2zynH2faPFPomr4Tiq9TGD
         xs0Q==
X-Gm-Message-State: ALoCoQmwbWhy7fH+dD2pOWNHRgXEpU4M9EPbwOu7fiX3YDr71tP6UcrVnpBgvjfL7G2mPU4OpaNs
X-Received: by 10.107.137.42 with SMTP id l42mr60667125iod.60.1435265128612;
        Thu, 25 Jun 2015 13:45:28 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id fv2sm4042683igb.22.2015.06.25.13.45.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 13:45:27 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272726>

Make log_ref_setup private, and add public safe_create_reflog which
calls log_ref_setup.

In a moment, we will use safe_create_reflog to add reflog creation
commands to git-reflog.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/checkout.c |  4 +---
 refs.c             | 11 +++++++++++
 refs.h             |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 93f63d3..b793670 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -621,7 +621,6 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				int temp;
-				struct strbuf log_file = STRBUF_INIT;
 				int ret;
 				const char *ref_name;
 				struct strbuf err = STRBUF_INIT;
@@ -629,9 +628,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 				temp = log_all_ref_updates;
 				log_all_ref_updates = 1;
-				ret = log_ref_setup(ref_name, &log_file, &err);
+				ret = safe_create_reflog(ref_name, &err);
 				log_all_ref_updates = temp;
-				strbuf_release(&log_file);
 				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
 						opts->new_orphan_branch, err.buf);
diff --git a/refs.c b/refs.c
index de7b5ef..7b02c45 100644
--- a/refs.c
+++ b/refs.c
@@ -3171,6 +3171,17 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	return 0;
 }
 
+
+int safe_create_reflog(const char *refname, struct strbuf *err)
+{
+	int ret;
+	struct strbuf sb = STRBUF_INIT;
+
+	ret = log_ref_setup(refname, &sb, err);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 			    const unsigned char *new_sha1,
 			    const char *committer, const char *msg)
diff --git a/refs.h b/refs.h
index debdefc..2986aac 100644
--- a/refs.h
+++ b/refs.h
@@ -228,7 +228,7 @@ int pack_refs(unsigned int flags);
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
-int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err);
+int safe_create_reflog(const char *refname, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-- 
2.0.4.314.gdbf7a51-twtrsrc
