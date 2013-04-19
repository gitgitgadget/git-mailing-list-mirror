From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/11] contrib: cc-cmd: add option to show commits
Date: Fri, 19 Apr 2013 14:30:24 -0500
Message-ID: <1366399831-5964-5-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2g-00053j-H6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab3DSTcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:08 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:42796 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3DSTb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:31:58 -0400
Received: by mail-qc0-f182.google.com with SMTP id k19so879977qcs.41
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fI3I8p6wMXe4IYbw/bfYP9M6Yo5bn7VOZI3BZ9zqfy4=;
        b=SB0jNZd76Zq70hFP4tlUqU9CgxOmTu3QjG60+U9bb96p0cZEKCVU5WTTnE/PVxDN/R
         9dqBO+8wJwvWaqOjcGTlID5jyHAhBBnnXBDzJwem9dA4juLuXtMmSzwkLbUEJ2c46Jdn
         /bVuzijJkuCXqRbZ/R3BlU5wOTeyKxCIEghLD354HY4FvcBz0BhtexQSDbSZKfcX5OPS
         3ZO1P80QZ4U62uRcqesyQQ1IS8w++kyJjEUlDGD1zdBt6Tfb3b6RwvV4yu+t+m6b0FOE
         uuOmPssDg1eNLlOZDHPfHXYDjvsRi+1OiIdUsUUeVLjgH+pITghRTqKgP58Mx9tNZf1Y
         Dfiw==
X-Received: by 10.224.180.206 with SMTP id bv14mr14275486qab.56.1366399917340;
        Fri, 19 Apr 2013 12:31:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id hm4sm19574145qab.2.2013.04.19.12.31.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:31:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221801>

Instead of showing the authors and signers, show the commits themselves.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 3a9c70e..c49225f 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -4,6 +4,7 @@ require 'optparse'
 
 $since = '3-years-ago'
 $min_percent = 5
+$show_commits = false
 
 begin
   OptionParser.new do |opts|
@@ -16,6 +17,9 @@ begin
     opts.on('-d', '--since DATE', 'How far back to search for relevant commits') do |v|
       $since = v
     end
+    opts.on('-c', '--commits[=FORMAT]', [:raw, :full], 'List commits instead of persons') do |v|
+      $show_commits = v || true
+    end
   end.parse!
 rescue OptionParser::InvalidOption
 end
@@ -124,6 +128,20 @@ commits = Commits.new
 commits.from_patches(ARGV)
 commits.import
 
+if $show_commits
+  cmd = nil
+  case $show_commits
+  when :raw
+    puts commits.items.keys
+  when :full
+    cmd = %w[git log --patch --no-walk]
+  else
+    cmd = %w[git log --oneline --no-walk]
+  end
+  system(*cmd + commits.items.keys) if cmd
+  exit 0
+end
+
 # hash of hashes
 persons = Hash.new { |hash, key| hash[key] = {} }
 
-- 
1.8.2.1.790.g4588561
