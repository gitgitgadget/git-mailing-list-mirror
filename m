From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 29/44] ruby: request-pull: use native commit info
Date: Sat, 28 Sep 2013 17:03:54 -0500
Message-ID: <1380405849-13000-30-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2je-0003o7-AX
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab3I1WL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:28 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:37060 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab3I1WLY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:24 -0400
Received: by mail-oa0-f49.google.com with SMTP id i4so3013118oah.36
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tLXb7il6dzOjeDpEeTkgGkZgmcyEgasZnfKRizulTwo=;
        b=uHVyfWtrtR6g8XwwWRFFCN/X0RcHL/519A3nHFTB9w8h09cIOsVKUnPHEOMZBc8/D/
         xkWheYC1fidfiUX73HNwQNMWux7bW69v50WFvZUpNKPDO7MNL/hwtccjZ7IFsrrosRLA
         eaTp/s16HZ2QbuEUw+ghqUWVDm01+uLseAXNJm2If1DHdkzh7VjdJ4HnWg/UK2I6CZmP
         mnze2bjGyH96L8zNSQSSqX/upBg/9cYC6vc+zU9RqZi8yO+/FwBC+4SAvybmH+PVmxUf
         SsCdVEBxbvXQw3+eQklRZTuBvFmQHYOuCESIqdeMtMxYf11ofh/6Yz9J6KF/2W4Xn1Fu
         rD3g==
X-Received: by 10.182.44.134 with SMTP id e6mr12493290obm.14.1380406284315;
        Sat, 28 Sep 2013 15:11:24 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm19491602obc.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235549>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    We could use a bit more of the internal parsing in C, or we could export more,
    but there's no need to, parse_buffer() is relatively simple in Ruby.

 git-request-pull.rb | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 869f160..5f40901 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -1,5 +1,7 @@
 #!git ruby
 
+require 'date'
+
 ENV['GIT_PAGER'] =
 
 patch = ''
@@ -58,6 +60,25 @@ def get_ref(transport, head_ref, head_id, tag_name)
   return found
 end
 
+def parse_buffer(buffer)
+  summary = []
+  date = msg = nil
+  header, body = buffer.split("\n\n", 2)
+  header.each_line do |line|
+    case line
+    when /^committer ([^<>]+) <(\S+)> (.+)$/
+      date = DateTime.strptime($3, '%s %z')
+    end
+  end
+  body.each_line do |l|
+    break if (l.strip.empty?)
+    summary << l.chomp
+  end
+  summary = summary.join(' ')
+  date = date.strftime('%F %T %z')
+  return [summary, date]
+end
+
 until ARGV.empty?
   case ARGV.first
   when '-p'
@@ -103,7 +124,8 @@ head_commit = Git::Commit.get(head_id)
 merge_bases = get_merge_bases([base_commit, head_commit], 0);
 die "No commits in common between #{base} and #{head}" unless merge_bases
 
-merge_base = sha1_to_hex(merge_bases.first.sha1)
+merge_base_id = merge_bases.first.sha1
+merge_base_commit = Git::Commit.get(merge_base_id)
 
 remote = remote_get(url)
 transport = transport_get(remote, nil)
@@ -111,20 +133,25 @@ transport = transport_get(remote, nil)
 ref = get_ref(transport, head_ref != "HEAD" ? head_ref : nil, head_id, tag_name)
 url = remote.url.first
 
+merge_base_summary, merge_base_date = parse_buffer(merge_base_commit.buffer)
+head_summary, head_date = parse_buffer(head_commit.buffer)
+
 begin
-  run(%[git show -s --format='The following changes since commit %H:
+  puts "The following changes since commit %s:
 
-  %s (%ci)
+  %s (%s)
 
 are available in the git repository at:
-' #{merge_base}])
+
+" % [merge_base_commit, merge_base_summary, merge_base_date]
   puts "  #{url}" + (ref ? " #{ref}" : "")
-  run(%[git show -s --format='
-for you to fetch changes up to %H:
+  puts "
+for you to fetch changes up to %s:
 
-  %s (%ci)
+  %s (%s)
 
-----------------------------------------------------------------' #{head_commit}])
+----------------------------------------------------------------
+" % [head_commit, head_summary, head_date]
 
   if branch_name
     puts "(from the branch description for #{branch_name} local branch)"
@@ -147,11 +174,11 @@ for you to fetch changes up to %H:
   end
 
   run(%[git shortlog ^#{base} #{head}])
-  run(%[git diff -M --stat --summary #{patch} ^#{merge_base} #{head}])
+  run(%[git diff -M --stat --summary #{patch} ^#{merge_base_commit} #{head}])
 
   if ! ref
     $stderr.puts "warn: No branch of #{url} is at:"
-    run("git show -s --format='warn:   %h: %s' #{head} >&2")
+    $stderr.puts "warn:   %s: %s'" % [find_unique_abbrev(head_id, DEFAULT_ABBREV), head_summary]
     $stderr.puts "warn: Are you sure you pushed '#{abbr(head_ref)}' there?"
     status = 1
   end
-- 
1.8.4-fc
