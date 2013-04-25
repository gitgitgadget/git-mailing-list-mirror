From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 08/11] contrib: related: support multiple roles
Date: Thu, 25 Apr 2013 14:59:40 -0500
Message-ID: <1366919983-27521-9-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMQ-0004FC-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab3DYUBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:31 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:44481 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245Ab3DYUB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:29 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so3205819oag.22
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EfXWs5HbeocyGmbt/ol5nkeD/sajzuTE0/OW+juDf+U=;
        b=IwgRESb69HPPk9hB+YS2ubcHT+VGrRY+R9zRQI3FqGg1Ow7HvMvYddfUCeVgkupc8U
         ZunH5Pq+p3XF7du5AHgT5dXv2q0nhcNjI0/oRo/RL4UGpHDUYutvAXN1Bb3CJCQlsPub
         olEWzx1f1g8HgiuMgLJzLRNTrwcK96Y1n0Jxrd79G/ozjZztK2iDtgO3a674DUbHi5tL
         Y4XQDTWYqbsgOfpnb0pF26FzpihokgF4taTfm0Q+ApPHTYb8L71PgJ3ofQ/Wbvz+RU8k
         CNQOeVk1VWRiQD0zRK1rvd4FSm0teI4yYqwYAHN0C1JXdQ41j3+fbr5YzhSgiGTzhrO9
         0NkA==
X-Received: by 10.182.126.162 with SMTP id mz2mr20516739obb.30.1366920088563;
        Thu, 25 Apr 2013 13:01:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rn6sm1413022oeb.0.2013.04.25.13.01.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222436>

Currently only the roles of 'author' and 'signer' and handler, but now
there's also 'reviewer' and 'acker'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index e8603be..cf6818e 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -27,6 +27,12 @@ rescue OptionParser::InvalidOption => e
   $rev_args += e.args
 end
 
+KNOWN_ROLES = {
+  'Signed-off' => :signer,
+  'Reviewed' => :reviewer,
+  'Acked' => :acker,
+}
+
 class Commit
 
   attr_reader :id, :roles
@@ -38,25 +44,28 @@ class Commit
 
   def parse(data)
     author = msg = nil
-    roles = {}
+    # hash of arrays
+    roles = Hash.new { |hash, key| hash[key] = [] }
     data.each_line do |line|
       if not msg
         case line
         when /^author ([^<>]+) <(\S+)> (.+)$/
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
-      [person, role]
+    @roles = roles.map do |person, roles|
+      [person, roles]
     end
   end
 
@@ -195,9 +204,11 @@ end
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
1.8.2.1
