From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 13/15] contrib: related: add option to parse from committish
Date: Sat, 18 May 2013 06:46:53 -0500
Message-ID: <1368877615-9563-14-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:49:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdfdZ-0007Sn-JF
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006Ab3ERLtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:49:12 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:32926 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3ERLtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:49:10 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so5993113oag.39
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=PvwRhG4VDDWGJrmcfpP+O33gIMq8OUodOpYXvyyY0iE=;
        b=zUlZAw/1m62b2rOX2RKHAlme21MdV+6iMlLlRNRtQcXR3M2EVUpJToNIc+Ane0KCR+
         ThevlVvQqUf5AVupda5kUpssXNnDGkQblyHkUiBR2fPnzgF0Mpv0i25cUsjeU+Kl16rg
         lnQFjXrxW8Iq07yhGs1qPzBUDMf05+Uppb0ib3iXGXRg+EZ1JWm3GbZCIap5YE8UnSp6
         n03OfM/X5RkDi3BnvB20ZhNNjcOvl/asKu1NxPLznZ1X/0dQaEhlO+V6V8Dm+gz3FB0b
         25kBVzzuuBKJJHck4Ku2ukozVyWz9tnY16KgXIRSFlEGcZi+2rHSHt9PaYfIKAgfhsrL
         72lQ==
X-Received: by 10.182.129.4 with SMTP id ns4mr13261330obb.22.1368877749874;
        Sat, 18 May 2013 04:49:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm11221863obx.9.2013.05.18.04.49.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:49:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224786>

For example master..feature-a.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index aec156e..8394cdc 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -8,6 +8,8 @@ require 'optparse'
 $since = '5-years-ago'
 $min_percent = 10
 $show_commits = false
+$files = []
+$rev_args = []
 
 $mailmaps = {}
 $mailmaps_complex = {}
@@ -15,7 +17,7 @@ $mailmaps_complex = {}
 begin
   OptionParser.new do |opts|
     opts.program_name = 'git related'
-    opts.banner = 'usage: git related [options] <files>'
+    opts.banner = 'usage: git related [options] <files | rev-list options>'
 
     opts.on('-p', '--min-percent N', Integer, 'Minium percentage of role participation') do |v|
       $min_percent = v
@@ -228,10 +230,40 @@ class Commits
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
+            when /^@@ -(\d+)(?:,(\d+))?/
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
1.8.3.rc2.542.g24820ba
