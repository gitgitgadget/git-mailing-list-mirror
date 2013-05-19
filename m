From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6] Add new git-related helper to contrib
Date: Sun, 19 May 2013 10:53:43 -0500
Message-ID: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 17:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue5xE-0008QM-Ku
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 17:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab3ESPzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 11:55:17 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:45635 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab3ESPzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 11:55:16 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so6277104obb.30
        for <git@vger.kernel.org>; Sun, 19 May 2013 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=rLaGFVvvfiJ4HYu96hsoMDspCAP+DGGHNm3BTEz1rxk=;
        b=WwWH4DcjfvD1vqyCS2RCcYxO2WxPDpsNtIOK5MtuSSRAqr4LQyix48KP3N2nQIfyK4
         kuW7BgNqgPZL85AJdLcShwaG87WeNQIQEQsCtWlk4Pt6HTt5Diw0399gm9itPKuO1WX0
         LxxLbVizJ/Ap9vPsvsHsYAXuZXjJkEGNOWTwP47Murm/aqX3mXB+n8CCMPdLx4ymKRXK
         OCZu46xbNhW9laaLeFX79gGlKa7+dhnZV5dLhKVrVrkCB/rE2RKMuwBcFtZp4rEWo5RU
         vYvymaSUIEKC7NJLP0BoxAUIhvmMtKZiWwWx/3txKJZ7vmSXb2tUuKV02AzpHhBW+mjr
         jzVw==
X-Received: by 10.60.35.100 with SMTP id g4mr15982626oej.53.1368978915467;
        Sun, 19 May 2013 08:55:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm16297958obc.2.2013.05.19.08.55.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 08:55:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.286.g3d43083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224896>

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

Sames as v5, with a few tiny modifications. I'm tired of sending the whole
series multiple times over the years, only to get stuck at the first patch, so
I'll send only the first one.

 contrib/related/git-related | 124 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100755 contrib/related/git-related

diff --git a/contrib/related/git-related b/contrib/related/git-related
new file mode 100755
index 0000000..b96dcdd
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
+  '%s <%s>' % [name, email]
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
+    File.popen(['git', 'blame', '--incremental', '-CCC',
+               '-L', '%u,+%u' % [start, len],
+               '--since', $since, from + '^',
+               '--', source]) do |p|
+      p.each do |line|
+        if line =~ /^(\h{40})/
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
1.8.3.rc3.286.g3d43083
