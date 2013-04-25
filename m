From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 05/11] contrib: related: add option to parse from committish
Date: Thu, 25 Apr 2013 14:59:37 -0500
Message-ID: <1366919983-27521-6-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMB-0003yE-HB
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758393Ab3DYUBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:21 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:42259 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab3DYUBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:19 -0400
Received: by mail-ob0-f177.google.com with SMTP id ef5so2917507obb.36
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4ZXf9Dbp7PUTk7JtuG1IqVHMHiLBJpuStF0sezRhO6Y=;
        b=PIx7VSGuvHGcfVYAeBJ1GHuUGlYsCBRW/mmpDeLilAEniEourSDSEiLDtpDSYlzAQ6
         Eio/Jwx7af5TNVwTjRR/6vAkk2FijaGPs8ttJhIKDmSJQQ2qLJSig3gQCE63O7gbKp/1
         zxAZ2QAVe22CnPqFU9nXwtVB7vzOaO296KBXiIlaxLymnFwbssK/E7JwsjpjjeTByL68
         smCUyy1P0zK62YTfwakoSFQbSBXY7gIdkCCXEjmWa0CgSGjtQLAxqoERGhXf6pcEmHVC
         lPGU4p8VQEWJkKNHcGpprpugpPev70E2MOuDsfSHwXQMREiUI7tuVckiqcG+hFz0p8VT
         7pMw==
X-Received: by 10.60.131.98 with SMTP id ol2mr16244918oeb.37.1366920079247;
        Thu, 25 Apr 2013 13:01:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pq6sm1858657obc.11.2013.04.25.13.01.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222432>

For example master..feature-a.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 6eed4bc..0015b3c 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -5,11 +5,13 @@ require 'optparse'
 $since = '3-years-ago'
 $min_percent = 5
 $show_commits = false
+$files = []
+$rev_args = []
 
 begin
   OptionParser.new do |opts|
     opts.program_name = 'git cc-cmd'
-    opts.banner = 'usage: git cc-cmd [options] <files>'
+    opts.banner = 'usage: git cc-cmd [options] <files | rev-list options>'
 
     opts.on('-p', '--min-percent N', Integer, 'Minium percentage of role participation') do |v|
       $min_percent = v
@@ -122,10 +124,40 @@ class Commits
     end
   end
 
+  def from_rev_args(args)
+    return if args.empty?
+    source = nil
+    File.popen(%w[git rev-list --reverse] + args) do |p|
+      p.each do |e|
+        id = e.chomp
+        @main_commits[id] = true
+        File.popen(%w[git show -C --oneline] + [id]) do |p|
+          p.each do |e|
+            case e
+            when /^---\s+(\S+)/
+              source = $1 != '/dev/null' ? $1[2..-1] : nil
+            when /^@@\s-(\d+),(\d+)/
+              get_blame(source, $1, $2, id)
+            end
+          end
+        end
+      end
+    end
+  end
+
+end
+
+ARGV.each do |e|
+  if File.exists?(e)
+    $files << e
+  else
+    $rev_args << e
+  end
 end
 
 commits = Commits.new
-commits.from_patches(ARGV)
+commits.from_patches($files)
+commits.from_rev_args($rev_args)
 commits.import
 
 if $show_commits
-- 
1.8.2.1
