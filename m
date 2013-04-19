From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/11] contrib: cc-cmd: add option to fetch aliases
Date: Fri, 19 Apr 2013 14:30:28 -0500
Message-ID: <1366399831-5964-9-git-send-email-felipe.contreras@gmail.com>
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
	id 1UTH2h-00053j-0x
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab3DSTcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:11 -0400
Received: from mail-qe0-f54.google.com ([209.85.128.54]:48401 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3DSTcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:32:10 -0400
Received: by mail-qe0-f54.google.com with SMTP id s14so2953110qeb.13
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kinhYfiFhF+eVRLtMOajsz4RRfw5b0fJgZdp9SJURVc=;
        b=QkLDP7M8Ss17vNjS6VhIAdmtvNP94AOXU2BgKyg17rwwidJrk3HxwKwLrg4KI96p3K
         Xl3iyu3RMtZQnDaSZIG7/JOkUKRASkzQwQzFlM82BuS7TdH9UbKSGV3V2jjLs4NM2IyE
         vIPZEScky98w4TocoFfQC/NTIp4hTsxFHMAxyyPO24XgDhgusa3LQI8n229nm5l3v2+/
         ZQCBA9QU/qwLxuaBvCGhzoCnXVmK9S37rNiWoJORqO34YgjBp+dmw8AZipOKJJkIyS8i
         L3MdKl8muOU9dDGd1b7GcRUrfItVqbOxFm0zNYacqNNUwsRFUDgE2IUGuHaDGwXHEBGc
         X2OA==
X-Received: by 10.229.14.130 with SMTP id g2mr2695811qca.90.1366399930060;
        Fri, 19 Apr 2013 12:32:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id bt19sm19578517qab.0.2013.04.19.12.32.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:32:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221802>

Only the mutt format is supported for now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 4fad030..200da0d 100755
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
     opts.on('-c', '--commits[=FORMAT]', [:raw, :full], 'List commits instead of persons') do |v|
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
 
   attr_reader :id, :roles
@@ -56,6 +79,8 @@ class Commit
       end
     end
     @roles = roles.map do |person, role|
+      address = "%s <%s>" % person
+      person = nil, $aliases[address] if $aliases.include?(address)
       [person, role]
     end
   end
-- 
1.8.2.1.790.g4588561
