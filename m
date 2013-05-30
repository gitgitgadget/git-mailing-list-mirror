From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7] Add new git-related helper to contrib
Date: Wed, 29 May 2013 22:32:57 -0500
Message-ID: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 05:34:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhtdV-0001KV-9c
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 05:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967369Ab3E3Dem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 23:34:42 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:44063 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966739Ab3E3Dek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 23:34:40 -0400
Received: by mail-yh0-f46.google.com with SMTP id v1so1411338yhn.33
        for <git@vger.kernel.org>; Wed, 29 May 2013 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=l+27qUULDQ5S9zohVTdWOgKelQ+0lBkFIIqykW90ndA=;
        b=dmmok4s6aA93lcoTA4wNGjJE4H9QsMbD6BnLkJNm9e/YP+zI2l93cEIc1peI4wmliY
         WDQi/7O/1meTrSBBmtJVQ6e63zUT3hvRAjNLYfVHqXyW26rBcQkSZqGMCEIGWni82qf6
         4G6P1RLZgbIP0KPA7BTn+OFL/uOeZlaHLQt2Cp+nHy6wrIirc5VF+2Wd/ZHkcNBYxElS
         sD5wMnCaq4HOyoSWj9BCysxJbSFvAU6zGteWPvUj0mGYzODzb8EVwmGh3Gw9JWlYgFbh
         FscM5HzIzNDGTx6vEalYwUe8eVECWJKrHehZCnpzqPMsjd+FwgXucYelCc/Q829W44NO
         ynuQ==
X-Received: by 10.236.68.2 with SMTP id k2mr2522105yhd.90.1369884879256;
        Wed, 29 May 2013 20:34:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id m74sm57107458yhm.0.2013.05.29.20.34.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 20:34:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225920>

This script find people that might be interested in a patch, by going
back through the history for each single hunk modified, and finding
people that reviewed, acknowledge, signed, or authored the code the
patch is modifying.

It does this by running 'git blame' incrementally on each hunk, and then
parsing the commit message. After gathering all the relevant people, it
groups them to show what exactly was their role when the participated in
the development of the relevant commit, and on how many relevant commits
they participated. They are only displayed if they pass a minimum
threshold of participation.

For example:

  % git related 0001-remote-hg-trivial-cleanups.patch
  Felipe Contreras <felipe.contreras@gmail.com>
  Jeff King <peff@peff.net>
  Max Horn <max@quendi.de>
  Junio C Hamano <gitster@pobox.com>

Thus it can be used for 'git send-email' as a cc-cmd.

There might be some other related functions to this script, not just to
be used as a cc-cmd.

Comments-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Small changes since v6:

--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -6,10 +6,6 @@
 $since = '5-years-ago'
 $min_percent = 10
 
-def fmt_person(name, email)
-  '%s <%s>' % [name, email]
-end
-
 class Commit
 
   attr_reader :persons
@@ -25,13 +21,13 @@ class Commit
       if not msg
         case line
         when /^author ([^<>]+) <(\S+)> (.+)$/
-          @persons << fmt_person($1, $2)
+          @persons << '%s <%s>' % [$1, $2]
         when /^$/
           msg = true
         end
       else
         if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
-          @persons << fmt_person($2, $3)
+          @persons << '%s <%s>' % [$2, $3]
         end
       end
     end
@@ -72,12 +68,12 @@ class Commits
   def get_blame(source, start, len, from)
     return if len == 0
     len ||= 1
-    File.popen(['git', 'blame', '--incremental', '-CCC',
+    File.popen(['git', 'blame', '--incremental', '-C', '-C',
                '-L', '%u,+%u' % [start, len],
                '--since', $since, from + '^',
                '--', source]) do |p|
       p.each do |line|
-        if line =~ /^(\h{40})/
+        if line =~ /^\h{40}/
           id = $&
           @items[id] = Commit.new(id)
         end
@@ -95,7 +91,7 @@ class Commits
         when /^---\s+(\S+)/
           source = $1 != '/dev/null' ? $1[2..-1] : nil
         when /^@@ -(\d+)(?:,(\d+))?/
-          get_blame(source, $1, $2, from)
+          get_blame(source, $1, $2, from) if source and from
         end
       end
     end

 contrib/related/git-related | 120 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100755 contrib/related/git-related

diff --git a/contrib/related/git-related b/contrib/related/git-related
new file mode 100755
index 0000000..1b9b1e7
--- /dev/null
+++ b/contrib/related/git-related
@@ -0,0 +1,120 @@
+#!/usr/bin/env ruby
+
+# This script finds people that might be interested in a patch
+# usage: git related <file>
+
+$since = '5-years-ago'
+$min_percent = 10
+
+class Commit
+
+  attr_reader :persons
+
+  def initialize(id)
+    @id = id
+    @persons = []
+  end
+
+  def parse(data)
+    msg = nil
+    data.each_line do |line|
+      if not msg
+        case line
+        when /^author ([^<>]+) <(\S+)> (.+)$/
+          @persons << '%s <%s>' % [$1, $2]
+        when /^$/
+          msg = true
+        end
+      else
+        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
+          @persons << '%s <%s>' % [$2, $3]
+        end
+      end
+    end
+    @persons.uniq!
+  end
+
+end
+
+class Commits
+
+  def initialize
+    @items = {}
+  end
+
+  def size
+    @items.size
+  end
+
+  def each(&block)
+    @items.each(&block)
+  end
+
+  def import
+    return if @items.empty?
+    File.popen(%w[git cat-file --batch], 'r+') do |p|
+      p.write(@items.keys.join("\n"))
+      p.close_write
+      p.each do |line|
+        if line =~ /^(\h{40}) commit (\d+)/
+          id, len = $1, $2
+          data = p.read($2.to_i)
+          @items[id].parse(data)
+        end
+      end
+    end
+  end
+
+  def get_blame(source, start, len, from)
+    return if len == 0
+    len ||= 1
+    File.popen(['git', 'blame', '--incremental', '-C', '-C',
+               '-L', '%u,+%u' % [start, len],
+               '--since', $since, from + '^',
+               '--', source]) do |p|
+      p.each do |line|
+        if line =~ /^\h{40}/
+          id = $&
+          @items[id] = Commit.new(id)
+        end
+      end
+    end
+  end
+
+  def from_patch(file)
+    from = source = nil
+    File.open(file) do |f|
+      f.each do |line|
+        case line
+        when /^From (\h+) (.+)$/
+          from = $1
+        when /^---\s+(\S+)/
+          source = $1 != '/dev/null' ? $1[2..-1] : nil
+        when /^@@ -(\d+)(?:,(\d+))?/
+          get_blame(source, $1, $2, from) if source and from
+        end
+      end
+    end
+  end
+
+end
+
+exit 1 if ARGV.size != 1
+
+commits = Commits.new
+commits.from_patch(ARGV[0])
+commits.import
+
+count_per_person = Hash.new(0)
+
+commits.each do |id, commit|
+  commit.persons.each do |person|
+    count_per_person[person] += 1
+  end
+end
+
+count_per_person.each do |person, count|
+  percent = count.to_f * 100 / commits.size
+  next if percent < $min_percent
+  puts person
+end
-- 
1.8.3.rc3.312.g47657de
