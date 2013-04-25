From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 01/11] Add new git-related  helper to contrib
Date: Thu, 25 Apr 2013 14:59:33 -0500
Message-ID: <1366919983-27521-2-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSM1-0003mg-SF
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260Ab3DYUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:09 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:39455 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab3DYUBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:07 -0400
Received: by mail-ob0-f180.google.com with SMTP id uk5so2819864obc.25
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HxVrqu1IRQI9/BB4kVRB9J1tFaIIAMrqfTo3MJXFY4E=;
        b=I6aApJL2DIHfzRJUtaoSDOQKBh+1VP2kHQspr/xM/8uHb18FfWOuYVnctWH1abHSJW
         ITcs9A47hL8AQIFA5Q1M5THYgH30gZHgpd7w+Mr53poxm4OzX3jSPeidyeI0+PrUKokZ
         Z5lqrJBMd1Yfd6ujSEOcjE08xGK2TLUGIFK+meSXrHGEskiNLSxuL957ojpjsli9wb4Q
         3y4NDBfizTGeynzsv7BlOMcSlxhoBiilTES4cCvDCYNTWcuPiIPLzWaDqQXsXneDdGs0
         6phlo1Ne6ISh6X1sst0Sv2cs/XOa9o/eGgKXmrf1ykV8nlGoD6ft0PuKQMg4hZXfpmr0
         bKSg==
X-Received: by 10.60.149.129 with SMTP id ua1mr6118899oeb.56.1366920067180;
        Thu, 25 Apr 2013 13:01:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jv10sm4949953oeb.3.2013.04.25.13.01.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222429>

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
  Felipe Contreras <felipe.contreras@gmail.com> (author: 100%)
  Jeff King <peff@peff.net> (signer: 83%)
  Max Horn <max@quendi.de> (signer: 16%)
  Junio C Hamano <gitster@pobox.com> (signer: 16%)

Thus it can be used for 'git send-email' as a cc-cmd.

There might be some other related functions to this script, not just to
be used as a cc-cmd.

Comments-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 131 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100755 contrib/related/git-related

diff --git a/contrib/related/git-related b/contrib/related/git-related
new file mode 100755
index 0000000..2d47efa
--- /dev/null
+++ b/contrib/related/git-related
@@ -0,0 +1,131 @@
+#!/usr/bin/env ruby
+
+$since = '3-years-ago'
+$min_percent = 5
+
+class Commit
+
+  attr_reader :id, :roles
+
+  def initialize(id)
+    @id = id
+    @roles = []
+  end
+
+  def parse(data)
+    author = msg = nil
+    roles = {}
+    data.each_line do |line|
+      if not msg
+        case line
+        when /^author ([^<>]+) <(\S+)> (.+)$/
+          author = $1, $2
+          roles[author] = :author
+        when /^$/
+          msg = true
+        end
+      else
+        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
+          person = $2, $3
+          roles[person] = :signer if person != author
+        end
+      end
+    end
+    @roles = roles.map do |person, role|
+      [person, role]
+    end
+  end
+
+end
+
+class Commits
+
+  attr_reader :items
+
+  def initialize()
+    @items = {}
+  end
+
+  def size
+    @items.size
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
+  def get_blame(source, start, offset, from)
+    return unless source and offset
+    File.popen(['git', 'blame', '--incremental', '-C',
+               '-L', '%u,+%u' % [start, offset],
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
+    source = nil
+    from = nil
+    File.open(file) do |f|
+      f.each do |line|
+        case line
+        when /^From (\h+) (.+)$/
+          from = $1
+        when /^---\s+(\S+)/
+          source = $1 != '/dev/null' ? $1[2..-1] : nil
+        when /^@@\s-(\d+),(\d+)/
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
+# hash of hashes
+persons = Hash.new { |hash, key| hash[key] = {} }
+
+commits.items.values.each do |commit|
+  commit.roles.each do |person, role|
+    persons[person][role] ||= 0
+    persons[person][role] += 1
+  end
+end
+
+persons.each do |person, roles|
+  roles = roles.map do |role, count|
+    percent = count.to_f * 100 / commits.size
+    next if percent < $min_percent
+    '%s: %u%%' % [role, percent]
+  end.compact
+  next if roles.empty?
+
+  name, email = person
+  # must quote chars?
+  name = '"%s"' % name if name =~ /[^\w \-]/i
+  person = name ? '%s <%s>' % [name, email] : email
+  puts '%s (%s)' % [person, roles.join(', ')]
+end
-- 
1.8.2.1
