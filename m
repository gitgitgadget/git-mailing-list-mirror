From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 00:14:11 -0500
Message-ID: <1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:15:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3fl-0007yE-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734Ab3DSFPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:15:35 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:59078 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab3DSFPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:34 -0400
Received: by mail-ye0-f170.google.com with SMTP id q9so577511yen.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WNxxht/aKYGYAJTMmZY+Zyz4RHkuDvcmEyiZMpbhtb0=;
        b=fnkiIj8/aQdISPdRJ1jxMb+G1Y3hCA6r1FATc13AS8tmBVUC0laeolboVwZHYRneds
         yzCsMPJ0DqSHrqjgYrlh1mDbUvW4baLq1PHoBdGUK86ELQk9h8KASQAhU0eJxlP1awg2
         hWgF6lu2DRJRjFvVXmG9cukKdne+4L58yyN9fs8yF5xm4D9+AmEEVFZYTNUQ3rozDpw/
         PxwGYIHzWQgopXgXj1hnmHaninhRgvwHmEn5E6+qX4y2RMHbvNqGe4Ws5GUxnRLRkN84
         dGkFwz8pfKzwjg0lEMmvPg5WSG5k3EgiLON29rC+7lPD54XnpminA+Fbsz61eJc4meiU
         s2BQ==
X-Received: by 10.236.156.195 with SMTP id m43mr4312822yhk.142.1366348533398;
        Thu, 18 Apr 2013 22:15:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 30sm22355706yhb.6.2013.04.18.22.15.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221729>

The code finds the changes of a commit, runs 'git blame' for each chunk
to see which other commits are relevant, and then reports the author and
signers.

Finally, it calculates what percentage of the total relevant commits
each person was involved in, and show only the ones that pass the
threshold.

For example:

  % git cc-cmd 0001-remote-hg-trivial-cleanups.patch
  Felipe Contreras <felipe.contreras@gmail.com> (author: 100%)
  Jeff King <peff@peff.net> (signer: 83%)
  Max Horn <max@quendi.de> (signer: 16%)
  Junio C Hamano <gitster@pobox.com> (signer: 16%)

Thus it can be used for 'git send-email' as a cc-cmd.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100755 contrib/cc-cmd/git-cc-cmd

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
new file mode 100755
index 0000000..c7ecf79
--- /dev/null
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -0,0 +1,140 @@
+#!/usr/bin/env ruby
+
+$since = '3-years-ago'
+$min_percent = 5
+
+class Commit
+
+  attr_reader :id
+  attr_accessor :roles
+
+  def initialize(id)
+    @id = id
+    @roles = []
+  end
+
+  def self.parse(data)
+    id = author = msg = nil
+    roles = {}
+    data.each_line do |line|
+      if not msg
+        case line
+        when /^commit (.+)$/
+          id = $1
+        when /^author ([^<>]+) <(\S+)>$/
+          author = $1, $2
+          roles[author] = 'author'
+        when /^$/
+          msg = true
+        end
+      else
+        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
+          person = $2, $3
+          roles[person] = 'signer' if person != author
+        end
+      end
+    end
+    roles = roles.map do |person, role|
+      address = "%s <%s>" % person
+      [person, role]
+    end
+    [id, roles]
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
+    format = [ 'commit %H', 'author %an <%ae>', '', '%B' ].join('%n')
+    File.popen(['git', 'show', '-z', '-s', '--format=format:' + format] + @items.keys) do |p|
+      p.each("\0") do |data|
+        next if data == "\0" # bug in git show?
+        id, roles = Commit.parse(data)
+        commit = @items[id]
+        commit.roles = roles
+      end
+    end
+  end
+
+  def each_person_role
+    commit_roles = @items.values.map { |commit| commit.roles }.flatten(1)
+    commit_roles.group_by { |person, role| person }.each do |person, commit_roles|
+      commit_roles.group_by { |person, role| role }.each do |role, commit_roles|
+        yield person, role, commit_roles.size
+      end
+    end
+  end
+
+  def get_blame(source, start, offset, from)
+    return unless source
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
+    import
+  end
+
+end
+
+exit 1 if ARGV.size != 1
+
+commits = Commits.new()
+commits.from_patch(ARGV[0])
+
+# hash of hashes
+persons = Hash.new { |hash, key| hash[key] = {} }
+
+commits.each_person_role do |person, role, count|
+  persons[person][role] = count
+end
+
+persons.each do |person, roles|
+  roles = roles.map do |role, count|
+    percent = count.to_f * 100 / commits.size
+    next if percent < $min_percent
+    "%s: %u%%" % [role, percent]
+  end.compact
+  next if roles.empty?
+
+  name, email = person
+  # must quote chars?
+  name = '"%s"' % name if name =~ /[^\w \-]/i
+  person = name ? "%s <%s>" % [name, email] : email
+  puts "%s (%s)" % [person, roles.join(', ')]
+end
-- 
1.8.2.1.790.g4588561
