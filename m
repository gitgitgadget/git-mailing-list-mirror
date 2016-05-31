From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule--helper: offer a consistent API
Date: Tue, 31 May 2016 16:59:33 -0700
Message-ID: <20160531235933.3854-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 01 01:59:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7tZZ-0008S6-RP
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 01:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbcEaX7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 19:59:41 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36654 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbcEaX7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 19:59:41 -0400
Received: by mail-pf0-f180.google.com with SMTP id f144so2276516pfa.3
        for <git@vger.kernel.org>; Tue, 31 May 2016 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sTnoWrudiCio5M7qqQZ7mFp8cI0g7hnvaTvsFDcvhKk=;
        b=NnrJzrlgYnJkkViW2dqWANxNDqABohusvctheVD+4KcJpXVrw3zsp0m2KrYCjX8Z1U
         x7gpa9dEZTR1SeIcQOrhEwA3QTHIr++4S8UgjwWZ7jD+jezULqCzK5in5FjLoWuOijq3
         vp5HEaZMcmKcAe7zjIXjcFOreRDSX4zV544uITlsrfuI8Cra49pdJLnQo0AXL/40d+qv
         RVwH4Q6e399nvvll8WWde6zFWpE9hRFXcANF9lb1Qk7eNmdRMaEhoOzaqNZGE3GVmk8n
         SO/O72ATbNudt+MZ0sCjrgpgy5LuF/qXXnSS4g2kmR4Qy5Y1vZjR3wiLgcfPjgiEn3M8
         cFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sTnoWrudiCio5M7qqQZ7mFp8cI0g7hnvaTvsFDcvhKk=;
        b=Y2xTTIoATvi0q82oRVntSY1aLxEvBEZiQh3zCRSi7VysCqU9yewyvlcwZgDeUzK8uk
         CIuPuoQfuMy9IBYOKz+TS6qQGPLFPynlUZUMljj/bLoMu5opPlZl/9pRqvQtyyNj5wYx
         2xfOkkQb33toOxYsgCAWXoGce3e4Hm43aK9pb3/wzRxYC4NuqpnSdoCBpICLo4sgBalM
         rJ1+ad14TsLXe2h2hVIzd+l+m6fNeIh/vYAI70ZSXqINkLapXESVz6rcjnfK17HvUOnQ
         6h62JzWXY1TfBTUqILblI/rREeBbk5gVRbYl9uqO6TqJ0J1QF7cQJ3uYipsvjKG7RERU
         Cgag==
X-Gm-Message-State: ALyK8tKgRXMqzIMgSfOPJ89jtE/YMIIPHs2ioc6W40z29Xx7FQINLRbuK0U7OPQkJRtssXX2
X-Received: by 10.98.193.197 with SMTP id i188mr1639009pfg.151.1464739179963;
        Tue, 31 May 2016 16:59:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9063:1a72:5a8e:8f65])
        by smtp.gmail.com with ESMTPSA id l73sm20548697pfa.36.2016.05.31.16.59.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 May 2016 16:59:38 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.1.g2cd07c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296037>

In 48308681 (2016-02-29, git submodule update: have a dedicated helper
for cloning), the helper communicated errors back only via exit code,
and dance with printing '#unmatched' in case of error was left to
git-submodule.sh as it uses the output of the helper and pipes it into
shell commands. This change makes the helper consistent by never
printing '#unmatched' in the helper but always handling these piping
issues in the actual shell script.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I think this applies on any of the recent submodule branches;
certainly on master (Git 2.9-rc1).

Thanks,
Stefan

 builtin/submodule--helper.c |  4 +---
 git-submodule.sh            | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ca33408..b1ebee2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -287,10 +287,8 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_list_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
-		printf("#unmatched\n");
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
-	}
 
 	for (i = 0; i < list.nr; i++) {
 		const struct cache_entry *ce = list.entries[i];
diff --git a/git-submodule.sh b/git-submodule.sh
index 42e0e9f..0515019 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -345,7 +345,10 @@ cmd_foreach()
 	# command in the subshell (and a recursive call to this function)
 	exec 3<&0
 
-	git submodule--helper list --prefix "$wt_prefix"|
+	{
+		git submodule--helper list --prefix "$wt_prefix" ||
+		echo "#unmatched"
+	} |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -453,7 +456,10 @@ cmd_deinit()
 		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
 	fi
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	{
+		git submodule--helper list --prefix "$wt_prefix" "$@" ||
+		echo "#unmatched"
+	} |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -1020,7 +1026,10 @@ cmd_status()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	{
+		git submodule--helper list --prefix "$wt_prefix" "$@" ||
+		echo "#unmatched"
+	} |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -1098,7 +1107,10 @@ cmd_sync()
 		esac
 	done
 	cd_to_toplevel
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	{
+		git submodule--helper list --prefix "$wt_prefix" "$@" ||
+		echo "#unmatched"
+	} |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-- 
2.9.0.rc0.2.g145fc64
