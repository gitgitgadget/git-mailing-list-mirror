From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/3] make commit --verbose work with --no-status
Date: Sat, 22 Feb 2014 03:09:22 +0800
Message-ID: <1393009762-31133-4-git-send-email-rctay89@gmail.com>
References: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
 <1393009762-31133-2-git-send-email-rctay89@gmail.com>
 <1393009762-31133-3-git-send-email-rctay89@gmail.com>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 20:10:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGvUB-0000l3-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 20:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbaBUTKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 14:10:01 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34353 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbaBUTKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 14:10:00 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so3665323pde.35
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pia+OZy94FOMAfFQhuha4bG2hvECamjY9jP19wmHXuc=;
        b=wJKHeZ10rYbMN7QiH0wt+EAk4dszy9aFgSdoPnqDbMK02Wc+ELiikDHIgi8Zl89Jm0
         ubs7CCcDKEo90i8qbhFylCFlCayZB8HcGPgY+ZYrCHjJs7uGudhC+7RoCqCvkd/rzOKd
         jUfA+nJWXWtpePO8/GQ2vttp7CYTcu3Bo5PYpvwngaZ0kyrmF4/tyidiRYluawyKCQyJ
         cvCxDpo7GdmI0YAroajCJACKD3IjYOTkslbjREHrY3h49W2kra95/a2rx3TfMW1O2uXn
         JsWamWGKtxFR6pvtkW2RIFvPFoFLoJGe0dfydS5yVJoTdG0DZJ1oxQXl63/kfuKADJ30
         +wXA==
X-Received: by 10.66.162.74 with SMTP id xy10mr11158860pab.4.1393009799882;
        Fri, 21 Feb 2014 11:09:59 -0800 (PST)
Received: from chiliad.localdomain (cm245.gamma242.maxonline.com.sg. [202.156.242.245])
        by mx.google.com with ESMTPSA id vf7sm23887999pbc.5.2014.02.21.11.09.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 11:09:58 -0800 (PST)
X-Mailer: git-send-email 1.9.0.291.g027825b
In-Reply-To: <1393009762-31133-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242490>

One would expect 'git commit --verbose --no-status' to give a commit
message with a diff of the commit, sans the output of git-status.
However, this does not work currently; the commit message body is
entirely empty (diff is absent as well). This is because internally the
status machinery is used to provide both the diff and status output, but
it is skipped due to --no-status.

We introduce a new status_format, STATUS_FORMAT_NONE. Thus, we still
call run_status(), but produce nothing in place of the usual git-status
output. status_format is set only when git-commit is passed i)
--verbose, and ii) --no-status.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/commit.c | 14 +++++++++++++-
 wt-status.c      |  2 +-
 wt-status.h      |  3 +++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2e86b76..fca6a6b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -126,6 +126,7 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum status_format {
 	STATUS_FORMAT_DEFAULT = 0,
+	STATUS_FORMAT_NONE,
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
@@ -478,6 +479,10 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	wt_status_collect(s);
 
 	switch (status_format) {
+	case STATUS_FORMAT_NONE:
+		wt_status_mark_commitable(s);
+		wt_status_print_verbose(s);
+		break;
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(s);
 		break;
@@ -1141,7 +1146,12 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
 
-	if (status_format != STATUS_FORMAT_DEFAULT)
+	if (verbose && !include_status) {
+		include_status = 1;
+		status_format = STATUS_FORMAT_NONE;
+	}
+
+	if (status_format != STATUS_FORMAT_DEFAULT && !verbose)
 		dry_run = 1;
 
 	return argc;
@@ -1305,6 +1315,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		s.prefix = prefix;
 
 	switch (status_format) {
+	case STATUS_FORMAT_NONE:
+		break;
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(&s);
 		break;
diff --git a/wt-status.c b/wt-status.c
index 9b0189c..e90fd0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -822,7 +822,7 @@ void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
 	strbuf_release(&pattern);
 }
 
-static void wt_status_print_verbose(struct wt_status *s)
+void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
diff --git a/wt-status.h b/wt-status.h
index 30a4812..5c89f23 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -95,8 +95,11 @@ void wt_status_truncate_message_at_cut_line(struct strbuf *);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+void wt_status_mark_commitable(struct wt_status *state);
 void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
 
+void wt_status_print_verbose(struct wt_status *s);
+
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
 
-- 
1.9.0.291.g027825b
