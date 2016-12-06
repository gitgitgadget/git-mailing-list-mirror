Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CAEE1FBB0
	for <e@80x24.org>; Tue,  6 Dec 2016 02:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbcLFCU4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 21:20:56 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:46240
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751223AbcLFCUu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Dec 2016 21:20:50 -0500
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Dec 2016 21:20:50 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1480989740;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=TNWBrTwUMO6VaVMmWH5IazDUIzY0E8GEbfOmrg2Pivo=;
        b=Xv0Q2ipk+2tsfFm7kq36YzrkflkauiwUXHP4MMQstkKxOcmqiYIRqelMy+qgcr+I
        eT7j9pttHEDOLkAd6fRTdx0j4DONVMr9L6pKr3mwPo/wObGpCqgxFES75foF9EDsTiV
        OrgLW7v0+BuGo2yRO4cEW0XmI1T1QKyVRjusKuZg=
From:   Nuno Subtil <subtil@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020158d1de0e71-ac079bb9-bc7d-4fb7-9ff7-60fd6955116b-000000@eu-west-1.amazonses.com>
Subject: [PATCH] git-p4: add p4 shelf support
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 6 Dec 2016 02:02:20 +0000
X-SES-Outgoing: 2016.12.06-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extends the submit command to support shelving a commit instead of
submitting it to p4 (similar to --prepare-p4-only).

Signed-off-by: Nuno Subtil <subtil@gmail.com>
---
 git-p4.py | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52..3c4be22 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1286,6 +1286,8 @@ def __init__(self):
                 optparse.make_option("--export-labels", dest="exportLabels", action="store_true"),
                 optparse.make_option("--dry-run", "-n", dest="dry_run", action="store_true"),
                 optparse.make_option("--prepare-p4-only", dest="prepare_p4_only", action="store_true"),
+                optparse.make_option("--shelve-only", dest="shelve_only", action="store_true", help="Create P4 shelf for first change that would be submitted (using a new CL)"),
+                optparse.make_option("--shelve-cl", dest="shelve_cl", help="Replace shelf under existing CL number (previously shelved files will be deleted)"),
                 optparse.make_option("--conflict", dest="conflict_behavior",
                                      choices=self.conflict_behavior_choices),
                 optparse.make_option("--branch", dest="branch"),
@@ -1297,6 +1299,8 @@ def __init__(self):
         self.preserveUser = gitConfigBool("git-p4.preserveUser")
         self.dry_run = False
         self.prepare_p4_only = False
+        self.shelve_only = False
+        self.shelve_cl = None
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
@@ -1496,6 +1500,12 @@ def prepareSubmitTemplate(self):
                 else:
                     inFilesSection = False
             else:
+                if self.shelve_only and self.shelve_cl:
+                    if line.startswith("Change:"):
+                        line = "Change: %s\n" % self.shelve_cl
+                    if line.startswith("Status:"):
+                        line = "Status: pending\n"
+
                 if line.startswith("Files:"):
                     inFilesSection = True
 
@@ -1785,7 +1795,11 @@ def applyCommit(self, id):
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
                 submitTemplate = message[:message.index(separatorLine)]
-                p4_write_pipe(['submit', '-i'], submitTemplate)
+
+                if self.shelve_only:
+                    p4_write_pipe(['shelve', '-i', '-r'], submitTemplate)
+                else:
+                    p4_write_pipe(['submit', '-i'], submitTemplate)
 
                 if self.preserveUser:
                     if p4User:
@@ -1799,12 +1813,17 @@ def applyCommit(self, id):
                 # new file.  This leaves it writable, which confuses p4.
                 for f in pureRenameCopy:
                     p4_sync(f, "-f")
-                submitted = True
+
+                if not self.shelve_only:
+                    submitted = True
 
         finally:
             # skip this patch
             if not submitted:
-                print "Submission cancelled, undoing p4 changes."
+                if not self.shelve_only:
+                    print "Submission cancelled, undoing p4 changes."
+                else:
+                    print "Change shelved, undoing p4 changes."
                 for f in editedFiles:
                     p4_revert(f)
                 for f in filesToAdd:
@@ -2034,9 +2053,13 @@ def run(self, args):
             if ok:
                 applied.append(commit)
             else:
-                if self.prepare_p4_only and i < last:
-                    print "Processing only the first commit due to option" \
-                          " --prepare-p4-only"
+                if (self.prepare_p4_only or self.shelve_only) and i < last:
+                    if self.prepare_p4_only:
+                        print "Processing only the first commit due to option" \
+                              " --prepare-p4-only"
+                    else:
+                        print "Processing only the first commit due to option" \
+                              " --shelve-only"
                     break
                 if i < last:
                     quit = False
@@ -3638,6 +3661,7 @@ def printUsage(commands):
     "debug" : P4Debug,
     "submit" : P4Submit,
     "commit" : P4Submit,
+    "shelve" : P4Submit,
     "sync" : P4Sync,
     "rebase" : P4Rebase,
     "clone" : P4Clone,

--
https://github.com/git/git/pull/309
