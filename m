From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Add new git-cc-cmd helper to contrib
Date: Sun, 11 Nov 2012 18:10:04 +0100
Message-ID: <1352653804-2203-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 18:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXb3I-0001I8-Ma
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab2KKRKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:10:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52517 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2KKRKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:10:18 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2085669bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Kf3r2grJncbQ+Or3QXcpiuzPtYlTZUKx500Fv3V1lEw=;
        b=iUExnHs3wkvcw/8wv/G5Ae6Q1uaPkUU+6SmG2ltsCQkBrH/SuVqS8Va4Zyl2Jt6HN0
         Ozl7HjPiDKqaH6nZcmvWwxe5xZDSdCpYMsLIegvIiq5X0mIFbsxLyQguzwpIvx+KCCe+
         GTPquNgMk1tZFQoca8srr9yPWX9QI3Wpxf8PYXbTzpPxtf7yDuq1SS9oqefv5aZ0ozbr
         Lg6sKIeSVFHsYHYZP3accdiKbKAYzW+9afAlvaohWkAOU7jwbeuFbRkrkAZ6O41T0ukh
         FtwvdfMjf8Do6N65uPREzZxdYq4+LN1kBMWdsep4UbI7QnHW1DEqfwFoiTnDi6g/2X6P
         AY9Q==
Received: by 10.204.9.138 with SMTP id l10mr6028021bkl.80.1352653816901;
        Sun, 11 Nov 2012 09:10:16 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id ia2sm1644972bkc.11.2012.11.11.09.10.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 09:10:15 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209419>

You can run it like format-patch:

 % git cc-cmd master..my-branch

And you'll get relevant people to Cc.

The code finds the changes in each commit in the list, runs 'git blame'
to see which other commits are relevant to those lines, and then adds
the author and signer to the list.

Finally, it calculates what percentage of the total relevant commits
each person was involved in, and if it passes the threshold, it goes in.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This cannot be used as cc-cmd option for 'git send-email' but it can as
series-cc-cmd for which I just send some patches.

An example output:

% git cc-cmd --role-stat v1.8.0^^1..v1.8.0^^2
Vietor Liu <vietor@vxwo.org> (author: 12%)
"Shawn O. Pearce" <spearce@spearce.org> (signer: 37%)
Alexandre Erwin Ittner <alexandre@ittner.com.br> (author: 12%)
Peter Krefting <peter@softwolves.pp.se> (author: 12%)
Pat Thoyts <patthoyts@users.sourceforge.net> (signer: 37%, author: 12%)
Christian Stimming <stimming@tuhh.de> (author: 12%)
Heiko Voigt <hvoigt@hvoigt.net> (author: 25%)
Heiko Voigt <heiko.voigt@mahr.de> (signer: 12%)
Bert Wesarg <bert.wesarg@googlemail.com> (author: 12%)

Cheers.

 contrib/cc-cmd/git-cc-cmd | 186 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100755 contrib/cc-cmd/git-cc-cmd

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
new file mode 100755
index 0000000..17b14d4
--- /dev/null
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -0,0 +1,186 @@
+#!/usr/bin/env ruby
+
+require 'optparse'
+
+$since = '3-years-ago'
+$min_percent = 5
+$role_stats = false
+
+begin
+  OptionParser.new do |opts|
+    opts.on('--role-stats') do |v|
+      $role_stats = v
+    end
+    opts.on('--min-percent N', Integer) do |v|
+      $min_percent = v
+    end
+    opts.on('--since DATE') do |v|
+      $since = v
+    end
+  end.parse!
+rescue OptionParser::InvalidOption
+end
+
+revs = []
+File.popen(%w[git rev-parse --revs-only --default=HEAD --symbolic] + ARGV).each do |rev|
+  revs << rev.chomp
+end
+
+case revs.size
+when 0
+  committish = '%s..HEAD' % '@{upstream}'
+when 1
+  committish = '%s..HEAD' % revs[0]
+else
+  committish = revs.join(' ')
+end
+
+$alias_file = "~/.mutt/aliases"
+$aliases = {}
+
+if $alias_file
+  open(File.expand_path($alias_file)).each do |line|
+    if line =~ /^\s*alias\s+(?:-group\s+\S+\s+)*(\S+)\s+(.*)$/
+      key, addresses = $1, $2.split(', ')
+      addresses.each do |address|
+        $aliases[address] = key
+      end
+    end
+  end
+end
+
+class Commit
+
+  attr_reader :id
+  attr_accessor :author, :roles
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
+      if $aliases.include?(address)
+        person = nil, $aliases[address]
+      end
+      [person, role]
+    end
+    [id, author, roles]
+  end
+
+end
+
+class Commits
+
+  attr_reader :items
+
+  def initialize(items = {})
+    @items = items
+    import
+  end
+
+  def size
+    @items.size
+  end
+
+  def import
+    return if @items.empty?
+    ids = @items.keys.join(' ')
+    format = [
+      'commit %H',
+      'author %an <%ae>',
+      '', '%B' ].join('%n')
+    open("|git show -z -s --format='format:#{format}' #{ids}").each("\0") do |data|
+      next if data == "\0" # bug in git show?
+      id, author, roles = Commit.parse(data)
+      commit = @items[id]
+      commit.author = author
+      commit.roles = roles
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
+  def self.from_blame(committish)
+    main_commits = {}
+    items = {}
+    open("|git rev-list --reverse #{committish}").each do |e|
+      id = e.chomp
+      main_commits[id] = true
+      open("|git --no-pager show -C --oneline #{id}").each do |e|
+        case e
+        when /^---\s+(\S+)/
+          @source = $1 != '/dev/null' ? $1[2..-1] : nil
+        when /^@@\s-(\d+),(\d+)/
+          next unless @source
+          open("|git blame --incremental -C -L #{$1},+#{$2} --since=#{$since} #{id}^ -- #{@source}").each do |e|
+            if e =~ /^(\h{40})/
+              items[$1] = Commit.new($1) if not main_commits.include?($1)
+            end
+          end
+        end
+      end
+    end
+    self.new(items)
+  end
+
+end
+
+commits = Commits.from_blame(committish)
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
+  name, email = person
+
+  # has must quote chars?
+  name = '"%s"' % name if name =~ /[^\w \-]/i
+
+  person = name ? "%s <%s>" % [name, email] : email
+
+  if $role_stats
+    puts "%s (%s)" % [person, roles.join(', ')]
+  else
+    puts person
+  end
+end
-- 
1.8.0
