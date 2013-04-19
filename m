From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/11] contrib: cc-cmd: support multiple roles
Date: Fri, 19 Apr 2013 14:30:29 -0500
Message-ID: <1366399831-5964-10-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2x-0005LP-TB
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab3DSTc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:29 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:48965 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3DSTcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:32:13 -0400
Received: by mail-qc0-f179.google.com with SMTP id v28so2263120qcm.10
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pjGmeEWpGsiZkydv6jS/FUk94N7OCb4Z/jbA8y3Bld4=;
        b=f7hnr2XM0m/G9zJGQulDEPVrIkA5LEarZyi/SSBDXeUlG0HI45sWOmnHZaTsFoK7J/
         8uFIt55nTb0/BKxgeD4OvpBfZtnaqaTFx8P7lLG051x9HhF6w/KITTOvxFuOONdqAyh8
         oICj0GnUddKAbhv7ZMnKdELePr5dqY3Xs2kcEK8m5UISy4cCPLmTgIWRflz1+t43z1hS
         7S+KcGkKerWcxFSUopPCpoLhtkV4s+hXyAJKfBkmgNugeOXU3nku8LT7oF6DYHAyCV2v
         uOqaU1CFTYSJlJl/a3ZuDcMPkb2hapgg7QPp/nYaQkj2yaj8pIMx9wQT7LIZ6NSqZrsC
         MdrQ==
X-Received: by 10.229.152.4 with SMTP id e4mr5720915qcw.63.1366399932987;
        Fri, 19 Apr 2013 12:32:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id z2sm19556241qad.4.2013.04.19.12.32.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:32:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221807>

Currently only the roles of 'author' and 'signer' and handler, but now
there's also 'reviewer' and 'acker'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 200da0d..67a276d 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -50,6 +50,12 @@ end
 
 get_aliases if $get_aliases
 
+KNOWN_ROLES = {
+  'Signed-off' => :signer,
+  'Reviewed' => :reviewer,
+  'Acked' => :acker,
+}
+
 class Commit
 
   attr_reader :id, :roles
@@ -61,27 +67,30 @@ class Commit
 
   def parse(data)
     author = msg = nil
-    roles = {}
+    # hash of arrays
+    roles = Hash.new { |hash, key| hash[key] = [] }
     data.each_line do |line|
       if not msg
         case line
         when /^author ([^<>]+) <(\S+)>$/
           author = $1, $2
-          roles[author] = :author
+          roles[author] << :author
         when /^$/
           msg = true
         end
       else
-        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
+        role_regex = KNOWN_ROLES.keys.join('|')
+        if line =~ /^(#{role_regex})-by: ([^<>]+) <(\S+?)>$/
           person = $2, $3
-          roles[person] = :signer if person != author
+          role = KNOWN_ROLES[$1]
+          roles[person] << role if person != author
         end
       end
     end
-    @roles = roles.map do |person, role|
+    @roles = roles.map do |person, roles|
       address = "%s <%s>" % person
       person = nil, $aliases[address] if $aliases.include?(address)
-      [person, role]
+      [person, roles]
     end
   end
 
@@ -220,9 +229,11 @@ end
 persons = Hash.new { |hash, key| hash[key] = {} }
 
 commits.items.values.each do |commit|
-  commit.roles.each do |person, role|
-    persons[person][role] ||= 0
-    persons[person][role] += 1
+  commit.roles.each do |person, roles|
+    roles.each do |role|
+      persons[person][role] ||= 0
+      persons[person][role] += 1
+    end
   end
 end
 
-- 
1.8.2.1.790.g4588561
