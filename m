From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/8] contrib: cc-cmd: add option to parse from committish
Date: Fri, 19 Apr 2013 00:14:15 -0500
Message-ID: <1366348458-7706-6-git-send-email-felipe.contreras@gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:16:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3gO-0008Vo-G6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab3DSFQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:16:04 -0400
Received: from mail-gh0-f179.google.com ([209.85.160.179]:35150 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab3DSFPp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:45 -0400
Received: by mail-gh0-f179.google.com with SMTP id z12so450013ghb.10
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=7vzyQT3VTBpJCX7Vd6ONPde0aUZ33XTdugn7QoICSqw=;
        b=EoZf2Z7HZ1or+OTEyVfKCr+SB3odfLLXumvrBET4zLu2xOD/3sNc5ssT44E07KBPg+
         PPwVApFkMCcfTJH+4KcP6gsfKj33LBn3txYjwpKGTQMvDXJyzFwvbku9jFoKcsBp3PVb
         mpKK7eoMPDb2UrzCGMUkd0WbM7sbB0dokBpZH11cyIzxnjv0KsjvvgcGqjlnDIbF5gEj
         ML+V7Ehjs/VVg/weQ8Z+Ko48AUQqEGJEeOYrA1XSV6g7h4NaLX9QqPEGfTLonBDkk5tC
         6t+FOQgTKo3oRg3o/y0IrBNysijXWeR+2rKGqDybyv/mISw6vjaf/FDApJQsowzh/dgT
         ALXQ==
X-Received: by 10.236.140.45 with SMTP id d33mr10043502yhj.19.1366348544000;
        Thu, 18 Apr 2013 22:15:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 30sm22356748yhb.6.2013.04.18.22.15.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221736>

For example master..feature-a.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index f13ed8f..462f22c 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
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
@@ -134,10 +136,40 @@ class Commits
     end
   end
 
+  def from_rev_args(args)
+    return if args.empty?
+    source = nil
+    File.popen(%w[git rev-list --reverse] + args) do |p|
+      p.each do |e|
+        id = e.chomp
+        @main_commits[id] = true
+        File.popen(%w[git --no-pager show -C --oneline] + [id]) do |p|
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
1.8.2.1.790.g4588561
