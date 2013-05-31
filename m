From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 1/4] Add new git-related helper to contrib
Date: Fri, 31 May 2013 02:46:17 -0500
Message-ID: <1369986380-412-2-git-send-email-felipe.contreras@gmail.com>
References: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:48:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiK4R-0004GS-7s
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695Ab3EaHsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:48:11 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:53168 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab3EaHsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:48:08 -0400
Received: by mail-yh0-f41.google.com with SMTP id z12so328991yhz.28
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ewSLfNtT8vgCLxIGdDuMta5pAA3XctADoFpH2yQrdjk=;
        b=CcX+Xm4Y/AWHx7nTQONecArrlpOgNdp15WHOa7WaPlpSXR7FtY9PJ3C4hzEJWkAuOY
         IOyrASWjEuqSexhuse55hr25rjci0RMc1aoDJnhc0i2URaXc7zy+QcNF4jrOyQCDxbEU
         MgjiE5JNnAc4XWeWfj6Ks1PKV2lLVr/Q69bSEPsI3hhOTD9NCmYj7r0vHqACdHPtW664
         fiVuU2sap7TixRELvw69cIiz6HBLo4UOsliVAE/QhEz31FhGV00AVcgK2vVbAsEJovZy
         Yyy5AZZ2qKaUUI5GBZj4u0/UcNVaDFBp1p5WEXQXxYxsoTjdztGZOYE5x7YcJ183GLSl
         1oIw==
X-Received: by 10.236.17.103 with SMTP id i67mr6056410yhi.180.1369986487722;
        Fri, 31 May 2013 00:48:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d91sm66066685yhq.16.2013.05.31.00.48.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:48:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226066>

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
1.8.3.358.g5a91d05
