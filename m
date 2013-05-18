From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 12/15] contrib: related: add option to show commits
Date: Sat, 18 May 2013 06:46:52 -0500
Message-ID: <1368877615-9563-13-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdfdS-0007M9-HD
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab3ERLtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:49:09 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52267 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3ERLtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:49:07 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so6105784oag.19
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=lyDM1JKgoKQ7TiO+lqyHN7t4jswR4dJMgDRDc+3MLcQ=;
        b=wH3fUPT9Pe0DJxGkI2xImjOmG60wH4Xl/jx5dEjAZVOqmZ66Wi6kGKmUQnchxn4Lgk
         rrBeFnpwb+6b0smLNXhQSdGvuikbtcFdvujS22CUXizIeZckRx/Sm7CquSs+NyKacqwl
         AfkI3jgMXtYP8NypvIzicXLXpfE1SuEiOtBjMPHip6EqvsoYfAtOYRXDdJaMXax3SZVc
         710OR/dI34Rh/AXXhY9p+JsHPJK6tMhmrSKCWw42SoifU9zqCh+YaN82q7GEPMHjbgsq
         iZcpAps4tzL1uh5Na998htvA2Jvh5OJs05nH1Z2pY05M0prRGbZcJZG3mi7dsJ5SzijZ
         UuQQ==
X-Received: by 10.182.129.230 with SMTP id nz6mr23123802obb.49.1368877746628;
        Sat, 18 May 2013 04:49:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pm16sm11695447oeb.3.2013.05.18.04.49.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:49:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224785>

Instead of showing the authors and signers, show the commits themselves.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index a2f98d9..aec156e 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -7,6 +7,7 @@ require 'optparse'
 
 $since = '5-years-ago'
 $min_percent = 10
+$show_commits = false
 
 $mailmaps = {}
 $mailmaps_complex = {}
@@ -22,6 +23,9 @@ begin
     opts.on('-d', '--since DATE', 'How far back to search for relevant commits') do |v|
       $since = v
     end
+    opts.on('-c', '--commits[=FORMAT]', [:raw, :full], 'List commits instead of persons') do |v|
+      $show_commits = v || true
+    end
   end.parse!
 rescue OptionParser::InvalidOption
 end
@@ -167,6 +171,10 @@ class Commits
     @items.each(&block)
   end
 
+  def list
+    @items.keys
+  end
+
   def import
     return if @items.empty?
     File.popen(%w[git cat-file --batch], 'r+') do |p|
@@ -226,6 +234,20 @@ commits = Commits.new
 commits.from_patches(ARGV)
 commits.import
 
+if $show_commits
+  cmd = nil
+  case $show_commits
+  when :raw
+    puts commits.list
+  when :full
+    cmd = %w[git log --patch --no-walk]
+  else
+    cmd = %w[git log --oneline --no-walk]
+  end
+  system(*cmd + commits.list) if cmd
+  exit 0
+end
+
 persons = Persons.new
 
 persons.sort.reverse.each do |person|
-- 
1.8.3.rc2.542.g24820ba
