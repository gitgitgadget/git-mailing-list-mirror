From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 00/10] transport-helper: updates
Date: Mon, 11 Nov 2013 16:54:58 -0600
Message-ID: <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0Uj-00064Q-J4
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab3KKXCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:05 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:40464 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab3KKXCB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:01 -0500
Received: by mail-ob0-f170.google.com with SMTP id gq1so5151795obb.29
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdleKP5rqDU8O5doIW7g7M6uCM0D7rk1QzEwbq50Hsw=;
        b=B4lAFPdCNi2GQjcFl+7qK1JX7kaKX745804aR6hxgDoUajfXlVEmtLGWaUIO85SYNa
         kNeFEyql3keEeJeTeiTDZnXi3oq/4QLt+jakl7Pseija0M6pHVZgpcwihqV7gCdUHYw2
         tIb4MYZC8uoGlv5m95QOY/tlBEAqvbsepggzqd8963vtYIjgqP5WFNVi4T77l6RGasja
         Q+xPlUbsUWS+oxD+GoNTG3ekhF8wLFGgkviXrbIoruDkEmPwWZnkRiBWjMrTzMzw3A20
         QCDzJoFPqGwT66bCIgcHH3Cwak4UxZ2dbrRVBZmRBOMKpqm0EaOnmenbHh4SMVRFk588
         yj/w==
X-Received: by 10.182.221.134 with SMTP id qe6mr3582163obc.66.1384210920856;
        Mon, 11 Nov 2013 15:02:00 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm29248437obg.13.2013.11.11.15.01.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:01:59 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237664>

Hi,

Here are the patches that allow transport helpers to be completely transparent;
renaming branches, deleting them, custom refspecs, --force, --dry-run,
reporting forced update, everything works.

Small changes since v5:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8ed41b4..4b76222 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -736,9 +736,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);
 
 	if (refspecs_list.nr) {
-		const char *refspecs_str[refspecs_list.nr];
+		const char **refspecs_str;
 		int i;
 
+		refspecs_str = xmalloc(sizeof(*refspecs_str) * refspecs_list.nr);
 		for (i = 0; i < refspecs_list.nr; i++)
 			refspecs_str[i] = refspecs_list.items[i].string;
 
@@ -746,6 +747,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
 
 		string_list_clear(&refspecs_list, 1);
+		free(refspecs_str);
 	}
 
 	if (use_done_feature)
diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 716aa4c..1c006a0 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -15,6 +15,8 @@ test -z "$refspec" && prefix="refs"
 
 export GIT_DIR="$url/.git"
 
+force=
+
 mkdir -p "$dir"
 
 if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"

Felipe Contreras (10):
  transport-helper: fix extra lines
  transport-helper: don't update refs in dry-run
  transport-helper: add 'force' to 'export' helpers
  transport-helper: check for 'forced update' message
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec
  fast-import: add support to delete refs
  fast-export: add support to delete refs
  transport-helper: add support to delete branches

 Documentation/git-fast-export.txt   |  4 +++
 Documentation/git-fast-import.txt   |  3 +++
 Documentation/gitremote-helpers.txt |  4 +++
 builtin/fast-export.c               | 49 ++++++++++++++++++++++++++++++++++++-
 fast-import.c                       | 13 +++++++---
 git-remote-testgit.sh               | 18 ++++++++++++++
 t/t5801-remote-helpers.sh           | 23 ++++++++++++++++-
 t/t9300-fast-import.sh              | 18 ++++++++++++++
 t/t9350-fast-export.sh              | 18 ++++++++++++++
 transport-helper.c                  | 47 +++++++++++++++++++++++------------
 10 files changed, 177 insertions(+), 20 deletions(-)

-- 
1.8.4.2+fc1
