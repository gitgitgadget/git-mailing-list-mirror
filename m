Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFE3C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8E122203
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgJNOzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 10:55:22 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:56740 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbgJNOzL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 10:55:11 -0400
Received: from client3368.fritz.box (i5C745714.versanet.de [92.116.87.20])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 9BCA23C0A25;
        Wed, 14 Oct 2020 16:55:08 +0200 (CEST)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     paulus@ozlabs.org
Cc:     git@vger.kernel.org
Subject: [PATCH] gitk: Add options --select-file and --select-line
Date:   Wed, 14 Oct 2020 16:55:06 +0200
Message-Id: <20201014145506.45449-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.rc1.13.g3b7fca9674
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These can be used in combination with --select-commit to jump to a given
line in a patch on startup. (They don't have any effect when
--select-commit is not used.)

This is useful for the "Show History Context" command in Git Gui's blame
window, which currently only jumps to the right commit in gitk, but
doesn't select the line that the context menu was opened on.

Also, these options allow for powerful editor integration; they make it
possible to jump into gitk right from a text editor. For example, here's
a small ruby script that takes a file path and a line number and opens
gitk with the commit selected that last modified that line. This can
easily be mapped to a key in vim or other editors.

    #!/usr/bin/env ruby

    if ARGV.length != 2
        puts "Usage: #{$0} <file> <line>"
        exit 1
    end

    file, line = ARGV
    blame_output = `git blame -p -L#{line},+1 "#{file}"`
    exit 1 if $?.exitstatus != 0

    blame_output_lines = blame_output.split("\n")
    commit, line = blame_output_lines[0].split

    file = blame_output_lines.grep(/^filename /)[0][9..-1]
    date = blame_output_lines.grep(/^committer-time /)[0][15..-1]
    two_weeks_later = date.to_i + 60 * 60 * 24 * 7 * 2

    system "gitk --before='#{two_weeks_later}' \
                 --select-commit=#{commit} \
                 --select-file='#{file}' \
                 --select-line=#{line} &"
---
 gitk | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 23d9dd1..cf70313 100755
--- a/gitk
+++ b/gitk
@@ -475,12 +475,17 @@ proc stop_rev_list {view} {
 }
 
 proc reset_pending_select {selid} {
-    global pending_select mainheadid selectheadid
+    global pending_select pending_select_file pending_select_line
+    global mainheadid selectheadid select_file select_line
 
     if {$selid ne {}} {
         set pending_select $selid
     } elseif {$selectheadid ne {}} {
         set pending_select $selectheadid
+        if {$select_file ne {} && $select_line ne {}} {
+            set pending_select_file $select_file
+            set pending_select_line $select_line
+        }
     } else {
         set pending_select $mainheadid
     }
@@ -1612,6 +1617,16 @@ proc getcommitlines {fd inst view updating}  {
     return 2
 }
 
+proc select_pending_line {} {
+    global pending_select pending_select_file pending_select_line
+
+    set desired_loc [expr {[info exists pending_select_file]
+        ? [list $pending_select_file $pending_select_line]
+        : {}}]
+
+    selectline [rowofcommit $pending_select] 1 $desired_loc
+}
+
 proc chewcommits {} {
     global curview hlview viewcomplete
     global pending_select
@@ -1626,7 +1641,7 @@ proc chewcommits {} {
             reset_pending_select {}
 
             if {[commitinview $pending_select $curview]} {
-                selectline [rowofcommit $pending_select] 1
+                select_pending_line
             } else {
                 set row [first_real_row]
                 selectline $row 1
@@ -5244,7 +5259,7 @@ proc layoutmore {} {
     if {[info exists pending_select] &&
         [commitinview $pending_select $curview]} {
         update
-        selectline [rowofcommit $pending_select] 1
+        select_pending_line
     }
     drawvisible
 }
@@ -7325,6 +7340,8 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     global vinlinediff
 
     unset -nocomplain pending_select
+    unset -nocomplain pending_select_file
+    unset -nocomplain pending_select_line
     $canv delete hover
     normalline
     unsel_reflist
@@ -12507,6 +12524,8 @@ if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
 
 set selecthead {}
 set selectheadid {}
+set select_file {}
+set select_line {}
 
 set revtreeargs {}
 set cmdline_files {}
@@ -12522,6 +12541,12 @@ foreach arg $argv {
         "--select-commit=*" {
             set selecthead [string range $arg 16 end]
         }
+        "--select-file=*" {
+            set select_file [string range $arg 14 end]
+        }
+        "--select-line=*" {
+            set select_line [string range $arg 14 end]
+        }
         "--argscmd=*" {
             set revtreeargscmd [string range $arg 10 end]
         }
-- 
2.29.0.rc1.13.g3b7fca9674

