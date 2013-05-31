From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 4/6] contrib: related: add option to parse from committish
Date: Fri, 31 May 2013 02:37:42 -0500
Message-ID: <1369985864-31922-5-git-send-email-felipe.contreras@gmail.com>
References: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:40:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJwN-0008Qh-4d
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab3EaHjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:39:41 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:38953 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3EaHjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:39:40 -0400
Received: by mail-yh0-f47.google.com with SMTP id f73so324387yha.34
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0xmrhRH7DiLZJotSTsNsVygBqLAWj9/kdwuyPupsftg=;
        b=vwWQ2lEPj1V/h/yM5bE3151vHtqZCcJFuB149Hj1Kz3qi8OHiptRuXbkSubRlV2iAy
         b+LCKKvOOIBSNxmdejCGSXaDVUkT3Q9YaAbTbVQ6dsp0qmspCAbxalTDcD3PM0KmI4Zj
         3cpALL9xBhxpdcH922xA6jFqe2TP4HbWy29ioQvTWrW35iC5qGbLmnOCseGp5z1OKN1T
         m9VXTpykgbvHruGKHxb3u2RIuaihcxLLCPwSDxR67mIn1uRUpu46wpIUDvoZRVhj1B02
         EkxqeSwIMF+mocCuBQ3Uzwt2q21mVo6J9Dhp4PpiD/CjrJY850tHbfoaahBcQ7tBXZW3
         YJ+Q==
X-Received: by 10.236.76.4 with SMTP id a4mr6148799yhe.44.1369985979921;
        Fri, 31 May 2013 00:39:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d24sm34681865yhi.17.2013.05.31.00.39.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:39:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226062>

For example master..feature-a.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 0de1c6c..3573237 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -7,10 +7,12 @@ require 'optparse'
 
 $since = '5-years-ago'
 $min_percent = 10
+$files = []
+$rev_args = []
 
 OptionParser.new do |opts|
   opts.program_name = 'git related'
-  opts.banner = 'usage: git related [options] <files>'
+  opts.banner = 'usage: git related [options] <files | rev-list options>'
 
   opts.on('-p', '--min-percent N', Integer,
           'Minium percentage of role participation') do |v|
@@ -118,10 +120,42 @@ class Commits
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
