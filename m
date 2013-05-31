From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 3/4] contrib: related: add option to parse from committish
Date: Fri, 31 May 2013 02:46:19 -0500
Message-ID: <1369986380-412-4-git-send-email-felipe.contreras@gmail.com>
References: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:48:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiK4S-0004GS-A1
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab3EaHsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:48:18 -0400
Received: from mail-gg0-f178.google.com ([209.85.161.178]:60543 "EHLO
	mail-gg0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab3EaHsO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:48:14 -0400
Received: by mail-gg0-f178.google.com with SMTP id a5so292897ggn.37
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jRlUP3jB0hP+79c8jU8Ha+sgGhL4iIJElymb3Wq2GHg=;
        b=iD6mJ/SV4dfg+5PbrVv6MH9W+G+O0ePbWSTkz7rcjAZnXMqQFgv3gO759oumJWrVhR
         Jm/PYVzuKq05kC9Pswo/YvZ8SZfQ/PGJoJ/aPZZd6DUpoCgG6uJLq+lGHR9cB1cNf8aX
         SJymxJS5QrgX0Q/kcwn6rMjWb7mQciaNgjo1n+abs2JiHgKNo46zrqVCi5zPRaKrWqp6
         Knby8u+ZsuuI2/nhyNx+nmSxVYamOGGG1+A2tDi0F+Dkj60gf+F9+DHQq+pmmXw8m8pX
         uQ+Qg4Em8CPkzZSY0ypsaCJ3pxKTfiKD0/a/zLr7Pp3ctVqIx45qM/htD0QI3A2gmsih
         8IBQ==
X-Received: by 10.236.19.48 with SMTP id m36mr6174074yhm.30.1369986493371;
        Fri, 31 May 2013 00:48:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id f19sm65204330yhj.3.2013.05.31.00.48.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:48:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226067>

For example master..feature-a.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 3379982..20eb456 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -1,10 +1,12 @@
 #!/usr/bin/env ruby
 
 # This script finds people that might be interested in a patch
-# usage: git related <files>
+# usage: git related <files | rev-list options>
 
 $since = '5-years-ago'
 $min_percent = 10
+$files = []
+$rev_args = []
 
 class Commit
 
@@ -102,10 +104,42 @@ class Commits
     end
   end
 
+  def from_rev_args(args)
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
+              get_blame(source, $1, $2, id) if source
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
+if $files.empty?
+  commits.from_rev_args($rev_args)
+else
+  commits.from_patches($files)
+end
 commits.import
 
 count_per_person = Hash.new(0)
-- 
1.8.3.358.g5a91d05
