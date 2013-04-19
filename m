From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/11] contrib: cc-cmd: add option to parse from committish
Date: Fri, 19 Apr 2013 14:30:25 -0500
Message-ID: <1366399831-5964-6-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2W-0004xK-Jb
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab3DSTcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:03 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:43632 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab3DSTcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:32:01 -0400
Received: by mail-qa0-f54.google.com with SMTP id j8so75387qah.6
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UZ2Cc96axlDUY8qb0jVnoSlUCRW5Odik1kKsEezsXfM=;
        b=NPux+79/oRlacB2FzgfuzdrGJk5ASCXWOdox9udqYuWnHfm7L2TPBWAxTFwcfgmspe
         JS1UsbwKq/JKzoGKX7QscKrCjND9r2XEfQDG9w4oWk3D79+Oswxs8QvIPIE9Lc6dr9tC
         F4XQfv8wvWrXWANKfvcW22oOti4iBcxuj5JGYm/khbjW0cy5XFo+3BBCEDngLx0ykJJH
         ZaEZ+tk5rkTwGko9FPF6/9qouDdFkv4wqpe55f5HE9RVfGJkqrED5gjkJxhRQo+Vas+E
         SZdMTDtZ1RrgXQNtGDECxJ5HEOlm5SChm6/tsIqtgZRXk6TWaknJg6fudTjPeusE93Ri
         QKjA==
X-Received: by 10.49.38.39 with SMTP id d7mr16793344qek.57.1366399920290;
        Fri, 19 Apr 2013 12:32:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ds5sm19534216qab.11.2013.04.19.12.31.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:31:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221799>

For example master..feature-a.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index c49225f..aecfa45 100755
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
1.8.2.1.790.g4588561
