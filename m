From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 01/15] Add new git-related helper to contrib
Date: Sat, 12 Oct 2013 02:06:21 -0500
Message-ID: <1381561584-20529-13-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNs-0005LL-LX
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab3JLHNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59081 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab3JLHM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:56 -0400
Received: by mail-ob0-f174.google.com with SMTP id wm4so3402597obc.5
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RdHaAXiETlO6uSbFu4Ulg+R/8tgT4FPNwLcWSZaSH08=;
        b=rKcoNvnjL0GhZrbViScoOsK402ucP7I+Lse1vz4cgSG/xrTrD3mgvCReVgj/apQ6ny
         59z4Y4mWh1H3oawqCG9Wh30eV16HHNUzH66F4GbjLlr4X2Ym0WOtEtt2MAXLZ6TjXRsi
         WdPA+U7zlBw1POIIYlX+or9wsdsLkj5941APf84Vp2n6UbiUrAX+XBZ0kKywhs5oYLp0
         WrRtHZL44H+tH1/IjHvPe5woXdJlBbkyt4sN0RiWKnFComqVi2bVXBcBeGIoJlITN5m2
         vjjpbGg5CTUaTLOafdbTkGpWFAVdOW4gEjzwzznOoPLRklxNKdoCH6dOZqFFPAN012vN
         fz/A==
X-Received: by 10.60.42.234 with SMTP id r10mr984088oel.40.1381561976528;
        Sat, 12 Oct 2013 00:12:56 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm101380158oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236004>

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
index 0000000..66c1009
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
+    in_body = nil
+    data.each_line do |line|
+      if not in_body
+        case line
+        when /^author ([^<>]+) <(\S+)> (.+)$/
+          @persons << '%s <%s>' % [$1, $2]
+        when /^$/
+          in_body = true
+        end
+      else
+        if line =~ /^(Signed-off-by|Reviewed-by|Acked-by|Cc): ([^<>]+) <(\S+?)>$/
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
+          @items[id] ||= Commit.new(id)
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
1.8.4-fc
