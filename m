From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 28/29] Added guilt.reusebranch configuration option.
Date: Tue, 13 May 2014 22:31:04 +0200
Message-ID: <1400013065-27919-29-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSo-0000O3-I6
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbaEMUiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:38:09 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:64581 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbaEMUiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:38:06 -0400
Received: by mail-la0-f41.google.com with SMTP id e16so713944lan.14
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ajgni739eXRzc+wPWKCYv7yZ0mV9Aby5khLunH5Hpjc=;
        b=MxzB+6cErBTX2q7vYTf0XC+iNjiJ9btEP9PJZmCrEIQZiTZ8Ds4U5CmhRDoIDXdTtl
         Q2M3vmSI2PN1RguUmpr0ydpagjrWcLvLd1GuRfcueoa1Y8C8ODzOI77Wsva8Jm0hyLxz
         zppRAIPVBYwhZDzuMEShknZJHMr/wSv1ADxmlCEncZeoVWO9acghv33z39/RXQDEnpgf
         Bl3OVI0x1ome4cK9RJtISUejPU4QjujsQS0Pu86TUSAENa38t0AOD1Fg+wD2gVYnrW0k
         TQ8Oxqj4ZFgRHzlGVV+owt3W44zNs2wPnZB22fT2ywqemLDqqB8mz5cj4+XqYvHYE0Jf
         q8yw==
X-Gm-Message-State: ALoCoQmfeP9QsjcBvIFuYogRFN07iFiUyPrq9XFhTuoxpI8sV7tMw2wJySeWfVLhH9y56GL3kksa
X-Received: by 10.112.85.167 with SMTP id i7mr14134549lbz.32.1400013485227;
        Tue, 13 May 2014 13:38:05 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.38.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:38:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248845>

When the option is true (the default), Guilt does not create a new Git
branch when patches are applied.  This way, you can switch between
Guilt 0.35 and the current version of Guilt with no issues.

At a future time, maybe a year after Guilt with guilt.reusebranch
support is released, the default should be changed to "false" to take
advantage of the ability to use a separate Git branch when patches are
applied.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt                |  28 +++-
 regression/scaffold  |   1 +
 regression/t-062.out | 441 +++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-062.sh  | 137 ++++++++++++++++
 4 files changed, 601 insertions(+), 6 deletions(-)
 create mode 100644 regression/t-062.out
 create mode 100755 regression/t-062.sh

diff --git a/guilt b/guilt
index 9947acc..7c830eb 100755
--- a/guilt
+++ b/guilt
@@ -853,6 +853,9 @@ guilt_push_diff_context=1
 # default diffstat value: true or false
 DIFFSTAT_DEFAULT="false"
 
+# default old_style_prefix value: true or false
+REUSE_BRANCH_DEFAULT="true"
+
 # Prefix for guilt branches.
 GUILT_PREFIX=guilt/
 
@@ -864,6 +867,10 @@ GUILT_PREFIX=guilt/
 diffstat=`git config --bool guilt.diffstat`
 [ -z "$diffstat" ] && diffstat=$DIFFSTAT_DEFAULT
 
+# reuse Git branch?
+reuse_branch=`git config --bool guilt.reusebranch`
+[ -z "$reuse_branch" ] && reuse_branch=$REUSE_BRANCH_DEFAULT
+
 #
 # The following gets run every time this file is source'd
 #
@@ -928,13 +935,22 @@ else
 	die "Unsupported operating system: $UNAME_S"
 fi
 
-if [ "$branch" = "$raw_git_branch" ] && [ -n "`get_top 2>/dev/null`" ]
-then
-    # This is for compat with old repositories that still have a
-    # pushed patch without the new-style branch prefix.
-    old_style_prefix=true
+if [ -n "`get_top 2>/dev/null`" ]; then
+	# If there is at least one pushed patch, we set
+	# old_style_prefix according to how it was pushed.  It is only
+	# possible to change the prefix style while no patches are
+	# applied.
+	if [ "$branch" = "$raw_git_branch" ]; then
+		old_style_prefix=true
+	else
+		old_style_prefix=false
+	fi
 else
-    old_style_prefix=false
+	if $reuse_branch; then
+		old_style_prefix=true
+	else
+		old_style_prefix=false
+	fi
 fi
 
 _main "$@"
diff --git a/regression/scaffold b/regression/scaffold
index e4d7487..e4d2f35 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -93,6 +93,7 @@ function setup_git_repo
 	git config log.date default
 	git config log.decorate no
 	git config guilt.diffstat false
+	git config guilt.reusebranch false
 }
 
 function setup_guilt_repo
diff --git a/regression/t-062.out b/regression/t-062.out
new file mode 100644
index 0000000..727b436
--- /dev/null
+++ b/regression/t-062.out
@@ -0,0 +1,441 @@
+% setup_repo
+% git config guilt.reusebranch true
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/mode
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/mode
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
+% guilt pop
+Now at remove.
+% git for-each-ref
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt push
+Applying patch..mode
+Patch applied.
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop
+Now at remove.
+% git for-each-ref
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop
+Now at add.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt push
+Applying patch..remove
+Patch applied.
+% git for-each-ref
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop
+Now at add.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+Now at modify.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt push
+Applying patch..add
+Patch applied.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+Now at modify.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+All patches popped.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt push
+Applying patch..modify
+Patch applied.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+All patches popped.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt pop
+No patches applied.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt push
+Applying patch..modify
+Patch applied.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+All patches popped.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop -a
+All patches popped.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt push add
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt branch topic
+Switched to branch "topic"
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/topic/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/topic/modify
+% guilt pop -a
+All patches popped.
+% guilt push
+Applying patch..modify
+Patch applied.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/topic/modify
+% guilt pop -a
+All patches popped.
+% git checkout master
+Switched to branch "master"
+% guilt pop -a
+All patches popped.
+% git branch -d topic
+Deleted branch topic (was d485041).
+% rm -r .git/patches/topic
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% guilt branch topic
+Switched to branch "topic"
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/topic/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/topic/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/topic/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/topic/remove
+% guilt pop -a
+All patches popped.
+% git checkout master
+Switched to branch "master"
+% guilt pop -a
+All patches popped.
+% git branch -d topic
+Deleted branch topic (was d485041).
+% rm -r .git/patches/topic
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt branch topic
+Switched to branch "topic"
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/topic
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/topic
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/topic/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/topic/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/topic/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/topic/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/topic/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/topic/status
+% guilt pop -a
+No patches applied.
+% git checkout master
+Switched to branch "master"
+% guilt pop -a
+No patches applied.
+% git branch -d topic
+Deleted branch topic (was d485041).
+% rm -r .git/patches/topic
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% guilt branch topic
+Switched to branch "topic"
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/topic/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/topic/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/topic/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/topic/remove
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/topic
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/topic/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/topic/remove
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/master/status
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/topic/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/topic/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/topic/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/topic/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/topic/modify
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/topic/add
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/mode
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/topic/mode
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/topic/remove
+% guilt pop -a
+All patches popped.
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop -a
+No patches applied.
+% git checkout master
+Switched to branch "master"
+% guilt pop -a
+All patches popped.
+% git branch -d topic
+Deleted branch topic (was d485041).
+% rm -r .git/patches/topic
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt new newpatch
+% git for-each-ref --format=%(refname)
+refs/heads/master
+refs/patches/master/newpatch
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..newpatch
+Patch applied.
+% git for-each-ref
+25465dc1687f3833ecbd4e8bca437e522d7026db commit	refs/heads/master
+25465dc1687f3833ecbd4e8bca437e522d7026db commit	refs/patches/master/newpatch
+% git branch
+* master
+% guilt applied
+newpatch
+% guilt commit -a
+% git for-each-ref
+25465dc1687f3833ecbd4e8bca437e522d7026db commit	refs/heads/master
+% git branch
+* master
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% guilt applied
+modify
+add
+remove
+mode
+% git branch
+* master
+% git for-each-ref
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/heads/master
+5effcbeb303e8433935151d8c69f3bf63db1e8ef commit	refs/patches/master/add
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/patches/master/mode
+9509f22e2e627756d87b42432931c45955b74234 commit	refs/patches/master/modify
+9cbe2fc643b1a9e2179a8738f80424a1c2aa202d commit	refs/patches/master/remove
+% guilt commit -n 2
+% git for-each-ref
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/heads/master
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/patches/master/mode
+9cbe2fc643b1a9e2179a8738f80424a1c2aa202d commit	refs/patches/master/remove
+% git branch
+* master
+% guilt commit -n 2
+% git for-each-ref
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/heads/master
+% git branch
+* master
+% guilt series
diff --git a/regression/t-062.sh b/regression/t-062.sh
new file mode 100755
index 0000000..85596ca
--- /dev/null
+++ b/regression/t-062.sh
@@ -0,0 +1,137 @@
+#!/bin/bash
+#
+# Test the branch-switching upgrade code
+#
+
+source $REG_DIR/scaffold
+
+remove_topic() {
+	cmd guilt pop -a
+	if git rev-parse --verify --quiet guilt/master >/dev/null; then
+		cmd git checkout guilt/master
+	else
+		cmd git checkout master
+	fi
+	cmd guilt pop -a
+	cmd git branch -d $1
+	cmd rm -r .git/patches/$1
+	cmd git for-each-ref
+	cmd list_files
+}
+
+function fixup_time_info
+{
+	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
+}
+
+cmd setup_repo
+
+cmd git config guilt.reusebranch true
+
+cmd guilt push -a
+cmd list_files
+cmd git for-each-ref
+
+cmd git for-each-ref
+
+cmd list_files
+
+for i in `seq 5`; do
+	if [ $i -ge 5 ]; then
+		shouldfail guilt pop
+	else
+		cmd guilt pop
+	fi
+	cmd git for-each-ref
+	cmd guilt push
+	cmd git for-each-ref
+	cmd guilt pop
+	cmd git for-each-ref
+done
+
+# Check that "pop -a" does the right thing.
+cmd guilt push -a
+
+cmd git for-each-ref
+
+cmd guilt pop -a
+
+cmd git for-each-ref
+
+# Check that pushing two patches converts the repo to now-style (since
+# it currently has no patches applied).
+cmd guilt push add
+cmd git for-each-ref
+
+# Check guilt branch with a few patches applied.
+cmd guilt branch topic
+cmd git for-each-ref
+
+# Check that the topic branch is converted to new-style.
+cmd guilt pop -a
+cmd guilt push
+cmd git for-each-ref
+
+remove_topic topic
+
+# Check guilt branch with the full patch series applied.
+cmd guilt push -a
+cmd guilt branch topic
+cmd git for-each-ref
+
+remove_topic topic
+
+# Check guilt branch with no patches applied.
+# This gives us a new-style checkout.
+cmd guilt branch topic
+cmd git for-each-ref
+cmd list_files
+
+remove_topic topic
+
+# Check guilt branch in a new-style directory with all patches
+# applied.  (Strictly speaking, this test should probably move to a
+# file devoted to testing "guilt branch".)
+cmd guilt push -a
+cmd guilt branch topic
+cmd git for-each-ref
+cmd list_files
+cmd guilt pop -a
+cmd git for-each-ref
+
+remove_topic topic
+
+# Check that "guilt new" does the right thing when no patches are
+# applied.  (Strictly speaking, this test should maybe move to
+# t-025.sh).
+
+cmd guilt new newpatch
+cmd git for-each-ref '--format=%(refname)'
+cmd guilt pop
+fixup_time_info newpatch
+cmd guilt push
+cmd git for-each-ref
+
+# Check that "guilt commit" does the right thing when committing all
+# applied patches.  (Strictly speaking, this test should maybe move to
+# t-030.sh).
+cmd git branch
+cmd guilt applied
+cmd guilt commit -a
+cmd git for-each-ref
+cmd git branch
+
+# Check that "guilt commit" does the right thing when committing only
+# a few of the applied patches.  (Strictly speaking, this test should
+# maybe move to t-030.sh).
+cmd guilt push -a
+cmd guilt applied
+cmd git branch
+cmd git for-each-ref
+cmd guilt commit -n 2
+cmd git for-each-ref
+cmd git branch
+cmd guilt commit -n 2
+cmd git for-each-ref
+cmd git branch
+cmd guilt series
-- 
1.8.3.1
