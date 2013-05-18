From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 11/15] contrib: related: add support for multiple patches
Date: Sat, 18 May 2013 06:46:51 -0500
Message-ID: <1368877615-9563-12-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdfdS-0007M9-0j
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836Ab3ERLtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:49:05 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:65276 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3ERLtD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:49:03 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so6202222oag.14
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nbbjTqTZ1p42iMqp0Pj35TdddP/5EqdVKJbeS1y5yXM=;
        b=LioFMp1/IcWbIgT5tCWqSPUNXCDOsX4cKh2ic2D9QTZ2HZ5uJB6WhOMK4FLhTIZX96
         wYONd99K1jV4EVo0tnNcKowS5vjPjPRKSH+YAPXpy9XIW64xgGKxM1v7v/++yQyEHXQc
         lvSh42ailKkkr5smFAksKXM62qzKEdhz2IuO5wbdz9wUilgWu9eypKQRS1btOAhuIrcY
         unc3gGVVbKOGeDn7T0ZDVIKoqvBSVbwU1huypENY6nbH+OmfZ6GP/J55/bXiXwZQFGls
         sFOuhjZZDT74weQC1JaNF7Iss4TyPaKrq+GJCNgqdlSlkj9riHTXr42soGEYLX23Js4e
         3kgw==
X-Received: by 10.182.45.197 with SMTP id p5mr22617673obm.92.1368877743449;
        Sat, 18 May 2013 04:49:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z5sm5132047obw.4.2013.05.18.04.49.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:49:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224784>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index def2af5..a2f98d9 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -14,7 +14,7 @@ $mailmaps_complex = {}
 begin
   OptionParser.new do |opts|
     opts.program_name = 'git related'
-    opts.banner = 'usage: git related [options] <file>'
+    opts.banner = 'usage: git related [options] <files>'
 
     opts.on('-p', '--min-percent N', Integer, 'Minium percentage of role participation') do |v|
       $min_percent = v
@@ -156,6 +156,7 @@ class Commits
 
   def initialize
     @items = {}
+    @main_commits = {}
   end
 
   def size
@@ -192,24 +193,28 @@ class Commits
       p.each do |line|
         if line =~ /^(\h{40})/
           id = $1
-          @items[id] = Commit.new(id)
+          @items[id] = Commit.new(id) if not @main_commits.include?(id)
         end
       end
     end
     Dir.chdir($cur_dir)
   end
 
-  def from_patch(file)
-    from = source = nil
-    File.open(file) do |f|
-      f.each do |line|
-        case line
-        when /^From (\h+) (.+)$/
-          from = $1
-        when /^---\s+(\S+)/
-          source = $1 != '/dev/null' ? $1[2..-1] : nil
-        when /^@@ -(\d+)(?:,(\d+))?/
-          get_blame(source, $1, $2, from)
+  def from_patches(files)
+    source = nil
+    files.each do |file|
+      from = nil
+      File.open(file) do |f|
+        f.each do |line|
+          case line
+          when /^From (\h+) (.+)$/
+            from = $1
+            @main_commits[from] = true
+          when /^---\s+(\S+)/
+            source = $1 != '/dev/null' ? $1[2..-1] : nil
+          when /^@@ -(\d+)(?:,(\d+))?/
+            get_blame(source, $1, $2, from)
+          end
         end
       end
     end
@@ -217,10 +222,8 @@ class Commits
 
 end
 
-exit 1 if ARGV.size != 1
-
 commits = Commits.new
-commits.from_patch(ARGV[0])
+commits.from_patches(ARGV)
 commits.import
 
 persons = Persons.new
-- 
1.8.3.rc2.542.g24820ba
