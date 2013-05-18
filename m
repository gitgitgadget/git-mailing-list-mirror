From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sat, 18 May 2013 06:46:41 -0500
Message-ID: <1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfcu-0006ti-Pn
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab3ERLsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:48:32 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:46830 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab3ERLsb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:31 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so5478223obc.7
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=w+OPIUjJHO64SoBvs8fCRzEmuuybgxbOzoZW59MBA5M=;
        b=UMe8wEC9jlaFiOzF1GClXH26DS9EmPZxwWTG9Ph+Duez09MS6Dbyh896rR4Cnqrw+E
         U52BBRX50RN1ibJShzrjNWTciQXWtsGXqpF6fLMpxQqqlHFeZGNgOAZr0blkw+hUQqnX
         AD/Qn8NqDJUxHXpVg50j3jxAyRva75BFNxlMpk16xVfRhXrmTVPGldmH4DgfTHdKsQNZ
         RzEfGoIHqE2hoH9GhYlnHgeQ/Y18EyUYcwcF7S0/hsE9A3QqSV/dB/r6FNiHbp67ANSb
         JT/tGnkXbBm3L3dLBlAkwuLHLQWQIwQnUrShhj6qiqIu1VCZCF2t21fi8zlnWvN1oE/t
         guFg==
X-Received: by 10.182.125.4 with SMTP id mm4mr22261609obb.63.1368877710275;
        Sat, 18 May 2013 04:48:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm11220914obx.9.2013.05.18.04.48.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224774>

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
 contrib/related/git-related | 124 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100755 contrib/related/git-related

diff --git a/contrib/related/git-related b/contrib/related/git-related
new file mode 100755
index 0000000..4f31482
--- /dev/null
+++ b/contrib/related/git-related
@@ -0,0 +1,124 @@
+#!/usr/bin/env ruby
+
+# This script finds people that might be interested in a patch
+# usage: git related <file>
+
+$since = '5-years-ago'
+$min_percent = 10
+
+def fmt_person(name, email)
+  name ? '%s <%s>' % [name, email] : email
+end
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
+          @persons << fmt_person($1, $2)
+        when /^$/
+          msg = true
+        end
+      else
+        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
+          @persons << fmt_person($2, $3)
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
+      p.each do |l|
+        if l =~ /^(\h{40}) commit (\d+)/
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
+    File.popen(['git', 'blame', '--incremental', '-C',
+               '-L', '%u,+%u' % [start, len],
+               '--since', $since, from + '^',
+               '--', source]) do |p|
+      p.each do |line|
+        if line =~ /^(\h{40})/
+          id = $1
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
+          get_blame(source, $1, $2, from)
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
1.8.3.rc2.542.g24820ba
