From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/44] ruby: request-pull: trivial simplifications
Date: Sat, 28 Sep 2013 17:03:37 -0500
Message-ID: <1380405849-13000-13-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2io-0003AQ-Qb
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab3I1WKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:39 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:50191 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab3I1WKh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:37 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3021268oag.13
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yQxduJdpN5iTfwyzeWNwwYexQJyM2f/gdx1aSpR/rjc=;
        b=u4OeoeXZU/Qcc+OrxhHyCqE2hfuwXUpX+dB40iqi7uyHDTdTZVsmfPlMbHo19pP3ri
         c2kiFUcKg7uxnb/AZ/gTXsvy6d7dyGGn5Uo5IxpSqAAmjS6wDuZ18N4ELXw3L6Cv+Q0N
         19Lu3PtEZgOawU+pVYuaDNhKWKc28eXI90w5tIaKrGWByZM87qLXD74d+CfqlfJtpJny
         pcOcu23PrDqFqlQHdoxk5KrsyOX39WcLGG1iVV9Vvy2qhH5E2WnlC2/oM/++1bdvdMyn
         e+oXNUJy87bbxYzRZEfslCPlOUzXeS8V9bA3cur0qd/IJ0lhyj40dYMmiWHc08z/Fp1X
         PTog==
X-Received: by 10.60.103.146 with SMTP id fw18mr12434638oeb.32.1380406236601;
        Sat, 28 Sep 2013 15:10:36 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xx9sm19511004obc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235532>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    Let's start deviating from the original script.
    
    There are no functional changes though.

 git-request-pull.rb | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index eee2e28..9d3e9ab 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -62,21 +62,20 @@ base = ARGV[0]
 url = ARGV[1]
 head = ARGV[2] || 'HEAD'
 status = 0
-branch_name = nil
+branch_name = branch_desc = nil
+
+usage unless base or url
 
 headref = `git rev-parse -q --verify --symbolic-full-name "#{head}"`.chomp
-headref = "" if headref == "HEAD"
 
-branch_name = headref.gsub(%r{^refs/heads/}, '')
-if branch_name == headref ||
-  ! system(%[git config "branch.#{branch_name}.description" >/dev/null])
-  branch_name = nil
+if headref.start_with?('refs/heads')
+  branch_name = headref[11..-1]
+  branch_desc = `git config "branch.#{branch_name}.description"`.chomp
+  branch_name = nil if branch_desc.empty?
 end
 
 tag_name = `git describe --exact "#{head}^0" 2>/dev/null`.chomp
 
-usage unless base or url
-
 baserev = `git rev-parse --verify --quiet "#{base}"^0`.chomp
 die "Not a valid revision: #{base}" if baserev.empty?
 
@@ -86,7 +85,7 @@ die "Not a valid revision: #{head}" if headrev.empty?
 merge_base = `git merge-base #{baserev} #{headrev}`.chomp
 die "No commits in common between #{base} and #{head}" unless $?.success?
 
-ref = get_ref(url, headref, headrev, tag_name) || ''
+ref = get_ref(url, headref != "HEAD" ? headref : nil, headrev, tag_name)
 url = `git ls-remote --get-url "#{url}"`.chomp
 
 begin
@@ -96,7 +95,7 @@ begin
 
 are available in the git repository at:
 ' #{merge_base}])
-  puts "  #{url}" + (ref.empty? ? "" : " #{ref}")
+  puts "  #{url}" + (ref ? " #{ref}" : "")
   run(%[git show -s --format='
 for you to fetch changes up to %H:
 
@@ -107,11 +106,11 @@ for you to fetch changes up to %H:
   if branch_name
     puts "(from the branch description for #{branch_name} local branch)"
     puts
-    run(%[git config "branch.#{branch_name}.description"])
+    puts branch_desc
   end
 
   if not tag_name.empty?
-    if ref.empty? || ref != "tags/#{tag_name}"
+    if ref != "tags/#{tag_name}"
       $stderr.puts "warn: You locally have #{tag_name} but it does not (yet)"
       $stderr.puts "warn: appear to be at #{url}"
       $stderr.puts "warn: Do you want to push it there, perhaps?"
@@ -124,14 +123,13 @@ for you to fetch changes up to %H:
     puts "----------------------------------------------------------------"
   end
 
-  run(%[git shortlog ^#{baserev} #{headrev}])
-  run(%[git diff -M --stat --summary #{patch} #{merge_base}..#{headrev}])
+  run(%[git shortlog ^#{base} #{head}])
+  run(%[git diff -M --stat --summary #{patch} ^#{merge_base} #{head}])
 
-  if ref.empty?
-    short_headref = `git rev-parse -q --verify --symbolic-full-name --abbrev-ref "#{head}"`.chomp
+  if ! ref
     $stderr.puts "warn: No branch of #{url} is at:"
-    run("git show -s --format='warn:   %h: %s' #{headrev} >&2")
-    $stderr.puts "warn: Are you sure you pushed '#{short_headref}' there?"
+    run("git show -s --format='warn:   %h: %s' #{head} >&2")
+    $stderr.puts "warn: Are you sure you pushed '#{abbr(headref)}' there?"
     status = 1
   end
 rescue CommandError
-- 
1.8.4-fc
