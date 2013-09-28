From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 25/44] ruby: request-pull: trivial cleanups
Date: Sat, 28 Sep 2013 17:03:50 -0500
Message-ID: <1380405849-13000-26-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jR-0003dv-LW
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab3I1WLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:16 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:51755 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab3I1WLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:13 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so4157430obc.35
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Q2WpgTl7edEroAzPgiQ5JP1PxrGtQPt+YfkBGvZGtA=;
        b=DGOI6HjzLtc5O/wV+agNJH1+D/HB1WpVlGVOGYue2LLi08tuCDB7iAjBOiwXzWWo3Z
         zTAN1D6jlxrQ99rtdLvLxWkBPklRpkh/AeBMfGxzzjl2Pqo+CVfM/tDrt3Jv6neBOcU0
         8Y9h0usyaCQOSGZ/721OzpVwO4eSfJMUrxKnJ9chny8zBLKB6wIRRXCgDUOH4D++wkAZ
         uP3YqXH8+skMOWBrRHvWAaWmq6OHIxR8SFPt0zVXBVeiaIU4AnOWniUulSOuS1PqPhbE
         R7CZUB/nV+o8fourMNwa+Fzq+Zle74PpxxFCwrcKpdGkygnhx4BsBYPMGXjoMH9nRuIG
         iiaw==
X-Received: by 10.182.60.194 with SMTP id j2mr12226472obr.2.1380406272540;
        Sat, 28 Sep 2013 15:11:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm25472406oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235544>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    The fist override of a native class, which is one of the strong points of Ruby.
    
    We could use skip_prefix(str, prefix) like in C, but str.skip_prefix(prefix) is
    more natrual in Ruby.

 git-rb-setup.rb     |  6 ++++++
 git-request-pull.rb | 36 ++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/git-rb-setup.rb b/git-rb-setup.rb
index 92998a2..6f283da 100644
--- a/git-rb-setup.rb
+++ b/git-rb-setup.rb
@@ -26,3 +26,9 @@ def run(cmd, *args)
   system(*cmd, *args)
   raise CommandError.new(cmd) unless $?.success?
 end
+
+class String
+  def skip_prefix(prefix)
+    return self[prefix.length..-1]
+  end
+end
diff --git a/git-request-pull.rb b/git-request-pull.rb
index be4947d..79a26dc 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -25,7 +25,7 @@ def describe(rev)
   for_each_ref() do |name, sha1, flags|
     next unless name.start_with?('refs/tags/')
     next unless peel_ref(name) == get_sha1(rev)
-    return name[10..-1]
+    return name.skip_prefix('refs/tags/')
   end
   return nil
 end
@@ -43,17 +43,17 @@ end
 # Otherwise, if a branch with the same name as $head exists at the remote
 # and their values match, use that instead.
 #
-# Otherwise find a random ref that matches $headrev.
+# Otherwise find a random ref that matches $head_id.
 
-def get_ref(url, headref, headrev, tag_name)
+def get_ref(url, head_ref, head_id, tag_name)
   found = nil
   IO.popen(%[git ls-remote "#{url}"]) do |out|
     out.each do |l|
       sha1, ref, deref = l.scan(/^(\S+)\s+(\S+?)(\^\{\})?$/).first
-      next unless sha1 == headrev
+      next unless sha1 == head_id
       found = abbr(ref)
       break if (deref && ref == "refs/tags/#{tag_name}")
-      break if ref == headref
+      break if ref == head_ref
     end
   end
   return found
@@ -82,31 +82,31 @@ branch_name = branch_desc = nil
 
 usage unless base or url
 
-_, _, headref = dwim_ref(head)
+_, _, head_ref = dwim_ref(head)
 
-if headref.start_with?('refs/heads')
-  branch_name = headref[11..-1]
+if head_ref.start_with?('refs/heads')
+  branch_name = head_ref[11..-1]
   branch_desc = read_branch_desc(branch_name)
   branch_name = nil if not branch_desc
 end
 
 tag_name = describe(head)
 
-baserev = get_sha1("#{base}^0")
-die "Not a valid revision: #{base}" unless baserev
+base_id = get_sha1("#{base}^0")
+die "Not a valid revision: #{base}" unless base_id
 
-headrev = get_sha1("#{head}^0")
-die "Not a valid revision: #{head}" unless headrev
+head_id = get_sha1("#{head}^0")
+die "Not a valid revision: #{head}" unless head_id
 
-baserev = Git::Commit.get(baserev)
-headrev = Git::Commit.get(headrev)
+base_commit = Git::Commit.get(base_id)
+head_commit = Git::Commit.get(head_id)
 
-merge_bases = get_merge_bases([baserev, headrev], 0);
+merge_bases = get_merge_bases([base_commit, head_commit], 0);
 die "No commits in common between #{base} and #{head}" unless merge_bases
 
 merge_base = sha1_to_hex(merge_bases.first.sha1)
 
-ref = get_ref(url, headref != "HEAD" ? headref : nil, headrev.to_s, tag_name)
+ref = get_ref(url, head_ref != "HEAD" ? head_ref : nil, head_commit.to_s, tag_name)
 url = `git ls-remote --get-url "#{url}"`.chomp
 
 begin
@@ -122,7 +122,7 @@ for you to fetch changes up to %H:
 
   %s (%ci)
 
-----------------------------------------------------------------' #{headrev}])
+----------------------------------------------------------------' #{head_commit}])
 
   if branch_name
     puts "(from the branch description for #{branch_name} local branch)"
@@ -150,7 +150,7 @@ for you to fetch changes up to %H:
   if ! ref
     $stderr.puts "warn: No branch of #{url} is at:"
     run("git show -s --format='warn:   %h: %s' #{head} >&2")
-    $stderr.puts "warn: Are you sure you pushed '#{abbr(headref)}' there?"
+    $stderr.puts "warn: Are you sure you pushed '#{abbr(head_ref)}' there?"
     status = 1
   end
 rescue CommandError
-- 
1.8.4-fc
