From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 05/15] contrib: related: add helper Person classes
Date: Sat, 18 May 2013 06:46:45 -0500
Message-ID: <1368877615-9563-6-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfd3-00070f-ME
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3ERLsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:48:45 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:60291 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab3ERLsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:43 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so6074542oag.28
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5IMvay58m2dtGRtFJxVwzYCPC7yhLeGU3z5HML6ezxQ=;
        b=FHSvVWSzdDnB8K1er1mVSCI+XMnyu9edbUAM9wKnUCg/zOnO6NSAfQnPPU2qnMiZlk
         rPw4KKRJmm8WghvAtotAcrll9TvyIw7TvLyOv4j9K9n2BL2+r0dsE5Gin4Zs/fHRMSyb
         UrVs6PwGfsZSdXfwG/GYAQZTPXNElBhpdW+2P2+k5F+ChsGljoevOGNVpBEEcJeDlZyK
         2siYHVK5JE2WempzEM4owLlgc86yAyZsY2FM8do8QB2AsSFvBEOZnBeztAkLTARBi6rF
         FhWHX+SPUmyc5FEjsqBPY618cL4j27fLa9IKyL6MOFDzVCnQ/4GCtyZHvjke07OS/w7B
         hG0A==
X-Received: by 10.60.62.237 with SMTP id b13mr5029462oes.40.1368877723398;
        Sat, 18 May 2013 04:48:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm2913549oel.2.2013.05.18.04.48.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224778>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 80 +++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 7be2829..df13148 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -8,10 +8,6 @@ require 'optparse'
 $since = '5-years-ago'
 $min_percent = 10
 
-def fmt_person(name, email)
-  name ? '%s <%s>' % [name, email] : email
-end
-
 begin
   OptionParser.new do |opts|
     opts.program_name = 'git related'
@@ -27,13 +23,59 @@ begin
 rescue OptionParser::InvalidOption
 end
 
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
+    @name ? '%s <%s>' % [@name, @email] : @email
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
@@ -42,17 +84,18 @@ class Commit
       if not msg
         case line
         when /^author ([^<>]+) <(\S+)> (.+)$/
-          @persons << fmt_person($1, $2)
+          author = Persons.get($1, $2)
+          author.add_role(@id)
         when /^$/
           msg = true
         end
       else
         if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
-          @persons << fmt_person($2, $3)
+          person = Persons.get($2, $3)
+          person.add_role(@id)
         end
       end
     end
-    @persons.uniq!
   end
 
 end
@@ -126,21 +169,10 @@ commits = Commits.new
 commits.from_patch(ARGV[0])
 commits.import
 
-count_per_person = Hash.new(0)
-
-commits.each do |id, commit|
-  commit.persons.each do |person|
-    count_per_person[person] += 1
-  end
-end
-
-# sort by number of participations
-count_sort = lambda do |a, b|
-  b[1] <=> a[1]
-end
+persons = Persons.new
 
-count_per_person.sort(&count_sort).each do |person, count|
-  percent = count.to_f * 100 / commits.size
+persons.sort.reverse.each do |person|
+  percent = person.size.to_f * 100 / commits.size
   next if percent < $min_percent
   puts '%s (involved: %u%%)' % [person, percent]
 end
-- 
1.8.3.rc2.542.g24820ba
