From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 07/15] contrib: related: add helper Person classes
Date: Sat, 12 Oct 2013 02:06:11 -0500
Message-ID: <1381561584-20529-3-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNV-00052U-IN
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab3JLHMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:34 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33971 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab3JLHMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:31 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so3483388obc.9
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4YURkA/TxIbirzAfQ/RQT51dyTAG8VvFxopGQTB3YYk=;
        b=HkIn/Amc2K5s6+vqHvfDH+eVbXqXdCk7CHLr5rP4ko0ivgJUQgBFGud6C6AXqMsNZB
         oGNGkEDhPz9sTV2ETmz7hPqOMJO2ZUfWbKDbeAOA4TFx11zRsRnYuSPD8BmEEKCF49+4
         Zw/qiyj5XcVs3XUy4msk79wNFXyZMI6Lh4pq6ASwxFUUAvPhxeIGDBFKM6NXUnZwjpVt
         4t47oDwnSBOTOruwNVbpLaT0HthQiJtImFANfS1ikRgg+eSmS7R98Wm4XEGmDJzSIc+3
         5+2WCtXYqMmf0S3enPXSJBSNFbTmDy6UkOMHKpkFk+9s89yjIIOTzyYxAYrECLwrV+jk
         Dm0Q==
X-Received: by 10.182.45.195 with SMTP id p3mr17736977obm.29.1381561950954;
        Sat, 12 Oct 2013 00:12:30 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm101368264oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235997>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 71 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index ffce839..3cac925 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -8,13 +8,59 @@ $min_percent = 10
 $files = []
 $rev_args = []
 
-class Commit
+class Person
+
+  attr_reader :roles
+
+  def initialize(name, email)
+    @name = name
+    @email = email
+    @commits = {}
+  end
+
+  def add_role(commit)
+    @commits[commit] = true
+  end
+
+  def <=>(b)
+    self.size <=> b.size
+  end
+
+  def size
+    @commits.size
+  end
+
+  def to_s
+    '%s <%s>' % [@name, @email]
+  end
+
+end
 
-  attr_reader :persons
+class Persons
+
+  @@index = {}
+
+  include Enumerable
+
+  def each(&block)
+    @@index.values.each(&block)
+  end
+
+  def self.get(name, email)
+    id = [name, email]
+    person = @@index[id]
+    if not person
+      person = @@index[id] = Person.new(name, email)
+    end
+    person
+  end
+
+end
+
+class Commit
 
   def initialize(id)
     @id = id
-    @persons = []
   end
 
   def parse(data)
@@ -23,17 +69,18 @@ class Commit
       if not in_body
         case line
         when /^author ([^<>]+) <(\S+)> (.+)$/
-          @persons << '%s <%s>' % [$1, $2]
+          author = Persons.get($1, $2)
+          author.add_role(@id)
         when /^$/
           in_body = true
         end
       else
         if line =~ /^(Signed-off-by|Reviewed-by|Acked-by|Cc): ([^<>]+) <(\S+?)>$/
-          @persons << '%s <%s>' % [$2, $3]
+          person = Persons.get($2, $3)
+          person.add_role(@id)
         end
       end
     end
-    @persons.uniq!
   end
 
 end
@@ -152,16 +199,10 @@ else
 end
 commits.import
 
-count_per_person = Hash.new(0)
-
-commits.each do |id, commit|
-  commit.persons.each do |person|
-    count_per_person[person] += 1
-  end
-end
+persons = Persons.new
 
-count_per_person.each do |person, count|
-  percent = count.to_f * 100 / commits.size
+persons.sort.reverse.each do |person|
+  percent = person.size.to_f * 100 / commits.size
   next if percent < $min_percent
   puts '%s (involved: %u%%)' % [person, percent]
 end
-- 
1.8.4-fc
