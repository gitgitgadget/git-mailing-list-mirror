From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/11] contrib: related: add option to show commits
Date: Thu, 25 Apr 2013 14:59:36 -0500
Message-ID: <1366919983-27521-5-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMB-0003yE-W6
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122Ab3DYUBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:20 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:57485 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758367Ab3DYUBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:18 -0400
Received: by mail-ob0-f179.google.com with SMTP id oi10so2811807obb.38
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=rhiqqbJlExOfk6tmGkohOsjWkhyZ2eqQc86X+rUBnY8=;
        b=ezCXzfZnGo2fzrNp2AZ3ZNaflYkhzflbI9+Q175nhGwiD23u/H2hqBd3RkYYLimNTZ
         f/vVqFNaS5BqysPYPu+g/4LY/9TcY/YRrRm3J2pWStL4GrcqTNQfmRFqPihlLYfph198
         /CTGDseXGKHADbSUmN4F0UwxaT+VBz+WHkFv4Ia9vmJYukH5pj5+9Ye6fEBoae5bf6ZT
         mjR1XyFxJvVhx9/fW4qsWiamIy87t9rx7jKgzkP7cOnVMq3gg1N0jJTkso9D7xZH/Xbr
         OZhS4JuV+MK41FRKQAVphnKLCluXVNHD6Td6vtyMeMDhTzZo/EtXaWQhIMlxPDPM7Ua6
         uvng==
X-Received: by 10.182.96.135 with SMTP id ds7mr19580414obb.45.1366920076188;
        Thu, 25 Apr 2013 13:01:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zc8sm4724925obc.8.2013.04.25.13.01.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222433>

Instead of showing the authors and signers, show the commits themselves.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 90ec3aa..6eed4bc 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
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
1.8.2.1
