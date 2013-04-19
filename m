From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 8/8] contrib: cc-cmd: add option  to fetch aliases
Date: Fri, 19 Apr 2013 00:14:18 -0500
Message-ID: <1366348458-7706-9-git-send-email-felipe.contreras@gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:16:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3g1-00087I-GP
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab3DSFPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:15:55 -0400
Received: from mail-gg0-f177.google.com ([209.85.161.177]:61653 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab3DSFPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:53 -0400
Received: by mail-gg0-f177.google.com with SMTP id v1so465167ggn.8
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HqnQanvFPHK9jHJ/FfsWgbgiy0mvMw3/wzJJWGbOilk=;
        b=HdrHsC9FdnNmcFbdDNZhzak8u35YOW2dqTgOmgKtArm4dhXBIHNMtSSMEEnbMAao/5
         EDkbj5BfPNHf5EShTMtEqLD/BgUhKwbvlWejvAcm1icOV+kW/iJLlIVxBtfMDgyv/dq7
         YV0okLyNgfcWtj0ILhul/gMeGwf0BWitK5WnILDbOrGMjDTfz2wqdYZ2o7OF+lgsGPxU
         huQQcpNe0e11tmACfADFxkXztX0W4sH+IJjE3GhY0TkuQOlUZ+tsMD4dvEGyMnJKIh/L
         65gA6TVWEwqsQBMpNFeFGe6yfADGHWmt3uelEyzznrYL8vb7obC5H4Ak8gRHZt8y/j7j
         Xu/Q==
X-Received: by 10.236.118.203 with SMTP id l51mr10375145yhh.59.1366348552692;
        Thu, 18 Apr 2013 22:15:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 28sm22362177yhd.5.2013.04.18.22.15.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221733>

Only the mutt format is supported for now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 6911259..02548c6 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -7,6 +7,8 @@ $min_percent = 5
 $show_commits = false
 $files = []
 $rev_args = []
+$get_aliases = false
+$aliases = {}
 
 begin
   OptionParser.new do |opts|
@@ -22,11 +24,32 @@ begin
     opts.on('-c', '--commits[=FORMAT]', [:raw], 'List commits instead of persons') do |v|
       $show_commits = v || true
     end
+    opts.on('-a', '--aliases', 'Use aliases') do |v|
+      $get_aliases = v
+    end
   end.parse!
 rescue OptionParser::InvalidOption => e
   $rev_args += e.args
 end
 
+def get_aliases
+  type = %x[git config sendemail.aliasfiletype].chomp
+  return if type != 'mutt'
+  file = %x[git config sendemail.aliasesfile].chomp
+  File.open(File.expand_path(file)) do |f|
+    f.each do |line|
+      if line =~ /^\s*alias\s+(?:-group\s+\S+\s+)*(\S+)\s+(.*)$/
+        key, addresses = $1, $2.split(', ')
+        addresses.each do |address|
+          $aliases[address] = key
+        end
+      end
+    end
+  end
+end
+
+get_aliases if $get_aliases
+
 class Commit
 
   attr_reader :id
@@ -60,6 +83,7 @@ class Commit
     end
     roles = roles.map do |person, role|
       address = "%s <%s>" % person
+      person = nil, $aliases[address] if $aliases.include?(address)
       [person, role]
     end
     [id, roles]
-- 
1.8.2.1.790.g4588561
