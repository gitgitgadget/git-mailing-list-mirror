From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 00/15] New git-related helper
Date: Sat, 12 Oct 2013 02:06:10 -0500
Message-ID: <1381561584-20529-2-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNL-0004uk-AL
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab3JLHMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:31 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:41114 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab3JLHM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:28 -0400
Received: by mail-ob0-f181.google.com with SMTP id va2so3438032obc.40
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V11d9a6AZaNlv4IdbWuHwIKbm4uZkw9Pm8W+fj94YrQ=;
        b=NWcBuEyUyPeZoW+qGWEtZ0pCjejIvtJyF+rRlGjfLQ5dY/dP1e5IWuaN8pflssLPje
         ZIMxoUFEOhx0T8m0Pmo4YUiSABP7gQdtQ8MHezHom2d51SCvo02LLQBj5bQvviAYryWX
         /2mT2CDHEnoiKMWX7nCsMhyn+6l4KQGYgj5qwjbMwZaQ1k416xkiyu4EqDq8RsrKTAea
         YwAf79fu0GsG1eC7paLi7ofpYxCt/aCMbHDkfBxOWZ/2FsU2M7dpNoj9HaaT4YwPW6Eu
         KoiDQM5PPBEywzg9HrPM941xcNHPkZsHr7NeaymX3ALQf02N7MSXAEJn6s3mKTYB83Y5
         mQxg==
X-Received: by 10.60.131.197 with SMTP id oo5mr971674oeb.39.1381561948241;
        Sat, 12 Oct 2013 00:12:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d8sm101381882oeu.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235990>

This tool finds people that might be interested in a patch, by going
back through the history for each single hunk modified, and finding
people that reviewed, acknowledged, signed, or authored the code the
patch is modifying.

It does this by running `git blame` incrementally on each hunk, and
then parsing the commit message. After gathering all the relevant
people, it groups them to show what exactly was their role when the
participated in the development of the relevant commit, and on how
many relevant commits they participated. They are only displayed if
they pass a minimum threshold of participation.

For example:

  % git related master..fc/transport/improv
  Junio C Hamano <gitster@pobox.com> (signer: 90%, author: 5%)
  Felipe Contreras <felipe.contreras@gmail.com> (author: 25%, reviewer: 2%)
  Sverre Rabbelier <srabbelier@gmail.com> (author: 17%, acker: 2%, signer: 7%)
  Jeff King <peff@peff.net> (acker: 17%, author: 10%)
  Shawn O. Pearce <spearce@spearce.org> (author: 5%, signer: 2%, cced: 2%)
  Elijah Newren <newren@gmail.com> (author: 10%)

In addition, it has an option to output the list of commits, instead
of the contributors, which allows you to easily find out the previous
changes to the lines your patches modify.

  % git related -c master..fc/transport/improv
  99d9ec0 Merge branch 'fc/transport-helper-no-refspec'
  67c9c78 transport-helper: barf when user tries old:new
  0460ed2 documentation: trivial style cleanups
  126aac5 transport-helper: fix remote helper namespace regression
  21610d8 transport-helper: clarify pushing without refspecs
  a93b4a0 transport-helper: warn when refspec is not used
  664059f transport-helper: update remote helper namespace
  c4458ec fast-export: Allow pruned-references in mark file
  ...

Moreover, when sending patches for review, you can configure `git
send-email` to use `git related` to find relevant people that should
be Cc'ed:

  % git send-email --cc-cmd='git related' *.patch

It has way many more features than git-contacts which is a rewrite in
Perl of this script, but only the initial bare minimum stage.

I've also added tests, and this is how git-contacts fares in comparison:

--- expected 2013-10-10 21:13:45.938291298 +0000
+++ actual 2013-10-10 21:13:45.937291298 +0000
@@ -1,2 +1,2 @@
-Jon Stewart <jon@stewart.com> (author: 50%)
-Pablo Escobar <pablo@escobar.com> (author: 50%)
+Jon Stewart <jon@stewart.com>
+Pablo Escobar <pablo@escobar.com>
not ok 1 - basic

git-contacts doesn't show the amount of involvement, but that's easy to fix.

--- expected 2013-10-10 21:13:45.975291299 +0000
+++ actual 2013-10-10 21:13:45.974291299 +0000
@@ -1,2 +1,3 @@
-John Poppins <john@doe.com> (author: 66%)
-Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
+John Doe <john@doe.com>
+John Poppins <john@doe.com>
+Jon Stewart <jon@stewart.com>
not ok 2 - others

git-contacts doesn't show the kind of involvement (reviewer, author)
nor does it group people by their email address.

(skip other failures)

expecting success:
git related -craw -1 master | git log --format='%s' --no-walk --stdin
> actual &&
cat > expected <<-EOF &&
four
three
one
EOF
test_cmp expected actual

not ok 7 - commits

Also, it doesn't have the option to show the commits themselves, which
is useful to investigate the diffs. This feature alone is what makes
the make "git-contacts" not appropriate, because if this feature is
implemented, 'git contacts --commits' wouldn't have anything to do
with "contacts".

For that matter it doesn't support any options at all (e.g.
--min-percent, --since), and doesn't have a usage helper (--help).

Changes since v9:

diff --git a/contrib/related/Makefile b/contrib/related/Makefile
new file mode 100644
index 0000000..1224fce
--- /dev/null
+++ b/contrib/related/Makefile
@@ -0,0 +1,17 @@
+TESTS := $(wildcard test-*.t)
+
+export T := $(addprefix $(CURDIR)/,$(TESTS))
+export MAKE := $(MAKE) -e
+export PATH := $(CURDIR):$(PATH)
+export TEST_LINT := test-lint-executable test-lint-shell-syntax
+export TEST_DIRECTORY := $(CURDIR)/../../t
+
+all:
+
+test:
+	$(MAKE) -C ../../t $@
+
+$(TESTS): all
+	$(MAKE) -C ../../t $(CURDIR)/$@
+
+.PHONY: all test $(TESTS)
diff --git a/contrib/related/README b/contrib/related/README
new file mode 100644
index 0000000..26188ca
--- /dev/null
+++ b/contrib/related/README
@@ -0,0 +1,65 @@
+= git-related =
+
+This tool finds people that might be interested in a patch, by going
+back through the history for each single hunk modified, and finding
+people that reviewed, acknowledged, signed, or authored the code the
+patch is modifying.
+
+It does this by running `git blame` incrementally on each hunk, and then
+parsing the commit message. After gathering all the relevant people, it
+groups them to show what exactly was their role when the participated in
+the development of the relevant commit, and on how many relevant commits
+they participated. They are only displayed if they pass a minimum
+threshold of participation.
+
+For example:
+
+------------
+% git related master..fc/transport/improv
+Junio C Hamano <gitster@pobox.com> (signer: 90%, author: 5%)
+Felipe Contreras <felipe.contreras@gmail.com> (author: 25%, reviewer: 2%)
+Sverre Rabbelier <srabbelier@gmail.com> (author: 17%, acker: 2%, signer: 7%)
+Jeff King <peff@peff.net> (acker: 17%, author: 10%)
+Shawn O. Pearce <spearce@spearce.org> (author: 5%, signer: 2%, cced: 2%)
+Elijah Newren <newren@gmail.com> (author: 10%)
+------------
+
+In addition, it has an option to output the list of commits, instead of the
+contributors, which allows you to easily find out the previous changes to the
+lines your patches modify.
+
+------------
+% git related -c master..fc/transport/improv
+99d9ec0 Merge branch 'fc/transport-helper-no-refspec'
+67c9c78 transport-helper: barf when user tries old:new
+0460ed2 documentation: trivial style cleanups
+126aac5 transport-helper: fix remote helper namespace regression
+21610d8 transport-helper: clarify pushing without refspecs
+a93b4a0 transport-helper: warn when refspec is not used
+664059f transport-helper: update remote helper namespace
+c4458ec fast-export: Allow pruned-references in mark file
+...
+------------
+
+Moreover, when sending patches for review, you can configure `git send-email`
+to use `git related` to find relevant people that should be Cc'ed:
+
+------------
+% git send-email --cc-cmd='git related' *.patch
+------------
+
+== Installation ==
+
+To use this script, simply put `git-related` in your `$PATH` and make sure it
+has executable permissions:
+
+------------
+wget https://raw.github.com/felipec/git-related/master/git-related -O ~/bin/git-related
+chmod +x ~/bin/git-related
+------------
+
+And make sure `~/bin` is in your `$PATH`:
+
+------------
+export PATH="$HOME/bin:$PATH"
+------------
diff --git a/contrib/related/git-related b/contrib/related/git-related
index 7248f0f..b9c8619 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -17,9 +17,10 @@ $base_dir = File.dirname(git_dir)
 $cur_dir = Dir.pwd
 
 KNOWN_ROLES = {
-  'Signed-off' => :signer,
-  'Reviewed' => :reviewer,
-  'Acked' => :acker,
+  'Signed-off-by' => :signer,
+  'Reviewed-by' => :reviewer,
+  'Acked-by' => :acker,
+  'Cc' => :cced,
 }
 
 def get_mailmap(filename)
@@ -45,17 +46,16 @@ get_mailmap(File.join($base_dir, '.mailmap'))
 mailmap_file = %x[git config mailmap.file].chomp
 get_mailmap(mailmap_file)
 
-class SimpleParser
+class ParseOpt
   attr_writer :usage
 
   class Option
-    attr_reader :short, :long, :values, :help
+    attr_reader :short, :long, :help
 
-    def initialize(short, long, values, help, &block)
+    def initialize(short, long, help, &block)
       @block = block
       @short = short
       @long = long
-      @values = values
       @help = help
     end
 
@@ -68,49 +68,49 @@ class SimpleParser
     @list = {}
   end
 
-  def on(*args, &block)
-    short = args.shift if args.first.is_a?(String)
-    long = args.shift if args.first.is_a?(String)
-    values = args.shift if args.first.is_a?(Array)
-    help = args.shift if args.first.is_a?(String)
-    opt = Option.new(short, long, values, help, &block)
+  def on(short = nil, long = nil, help = nil, &block)
+    opt = Option.new(short, long, help, &block)
     @list[short] = opt if short
     @list[long] = opt if long
   end
 
   def parse
-    i = 0
     if ARGV.member?('-h') or ARGV.member?('--help')
       usage
-      exit 1
+      exit 0
     end
-    while cur = ARGV[i] do
-      if cur =~ /^(-.+?)(?:=(.*))?$/
+    seen_dash = false
+    ARGV.delete_if do |cur|
+      opt = val = nil
+      next false if cur[0] != '-' or seen_dash
+      case cur
+      when '--'
+        seen_dash = true
+        next true
+      when /^--no-(.+)$/
         opt = @list[$1]
-        if opt
-          v = $2
-          if not v
-            if not opt.values
-              extra = true
-            else
-              extra = !!opt.values.map(&:to_s).member?(ARGV[i + 1])
-            end
-            v = extra ? ARGV.delete_at(i + 1) : true
-          end
-          opt.call(v)
-          ARGV.delete_at(i)
-          next
-        end
+        val = false
+      when /^-([^-])(.+)?$/, /^--(.+?)(?:=(.+))?$/
+        opt = @list[$1]
+        val = $2 || true
+      end
+      if opt
+        opt.call(val)
+        true
       end
-      i += 1
     end
   end
 
   def usage
+    def fmt(prefix, str)
+      return str ? prefix + str : nil
+    end
     puts 'usage: %s' % @usage
     @list.values.uniq.each do |opt|
       s = '    '
-      s << [opt.short, opt.long].compact.join(', ')
+      s << ''
+      s << [fmt('-', opt.short), fmt('--', opt.long)].compact.join(', ')
+      s << ''
       s << '%*s%s' % [26 - s.size, '', opt.help] if opt.help
       puts s
     end
@@ -118,21 +118,18 @@ class SimpleParser
 
 end
 
-opts = SimpleParser.new
-opts.usage = 'usage: git related [options] <files | rev-list options>'
+opts = ParseOpt.new
+opts.usage = 'git related [options] <files | rev-list options>'
 
-opts.on('-p', '--min-percent',
-        'Minium percentage of role participation') do |v|
+opts.on('p', 'min-percent', 'Minium percentage of role participation') do |v|
   $min_percent = v.to_i
 end
 
-opts.on('-d', '--since',
-        'How far back to search for relevant commits') do |v|
+opts.on('d', 'since', 'How far back to search for relevant commits') do |v|
   $since = v
 end
 
-opts.on('-c', '--commits', [:raw, :full],
-        'List commits instead of persons') do |v|
+opts.on('c', 'commits', 'List commits instead of persons') do |v|
   $show_commits = v
 end
 
@@ -207,19 +204,19 @@ class Commit
   end
 
   def parse(data)
-    msg = author = nil
+    in_body = author = nil
     data.each_line do |line|
-      if not msg
+      if not in_body
         case line
         when /^author ([^<>]+) <(\S+)> (.+)$/
           author = Persons.get($1, $2)
           author.add_role(@id, :author)
         when /^$/
-          msg = true
+          in_body = true
         end
       else
         role_regex = KNOWN_ROLES.keys.join('|')
-        if line =~ /^(#{role_regex})-by: ([^<>]+) <(\S+?)>$/
+        if line =~ /^(#{role_regex}): ([^<>]+) <(\S+?)>$/
           person = Persons.get($2, $3)
           role = KNOWN_ROLES[$1]
           next if role == :signer and person == author
@@ -276,29 +273,32 @@ class Commits
       p.each do |line|
         if line =~ /^\h{40}/
           id = $&
-          @items[id] = Commit.new(id) if not @main_commits.include?(id)
+          @items[id] ||= Commit.new(id) if not @main_commits.include?(id)
         end
       end
     end
     Dir.chdir($cur_dir)
   end
 
-  def from_patches(files)
+  def scan_patch(f, id = nil)
     source = nil
+    f.each do |line|
+      case line
+      when /^From (\h+) (.+)$/
+        id = $1
+        @main_commits[id] = true
+      when /^---\s+(\S+)/
+        source = $1 != '/dev/null' ? $1[2..-1] : nil
+      when /^@@ -(\d+)(?:,(\d+))?/
+        get_blame(source, $1, $2, id) if source and id
+      end
+    end
+  end
+
+  def from_patches(files)
     files.each do |file|
-      from = nil
       File.open(file) do |f|
-        f.each do |line|
-          case line
-          when /^From (\h+) (.+)$/
-            from = $1
-            @main_commits[from] = true
-          when /^---\s+(\S+)/
-            source = $1 != '/dev/null' ? $1[2..-1] : nil
-          when /^@@ -(\d+)(?:,(\d+))?/
-            get_blame(source, $1, $2, from) if source and from
-          end
-        end
+        scan_patch(f)
       end
     end
   end
@@ -319,20 +319,12 @@ class Commits
       args = revs
     end
 
-    source = nil
     File.popen(%w[git rev-list --reverse] + args) do |p|
       p.each do |e|
         id = e.chomp
         @main_commits[id] = true
         File.popen(%w[git show -C --oneline] + [id]) do |p|
-          p.each do |e|
-            case e
-            when /^---\s+(\S+)/
-              source = $1 != '/dev/null' ? $1[2..-1] : nil
-            when /^@@ -(\d+)(?:,(\d+))?/
-              get_blame(source, $1, $2, id) if source
-            end
-          end
+          scan_patch(p, id)
         end
       end
     end
@@ -359,9 +351,9 @@ commits.import
 if $show_commits
   cmd = nil
   case $show_commits
-  when :raw
+  when 'raw'
     puts commits.list
-  when :full
+  when 'full'
     cmd = %w[git log --patch --no-walk]
   else
     cmd = %w[git log --oneline --no-walk]
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
new file mode 100755
index 0000000..f357e30
--- /dev/null
+++ b/contrib/related/test-related.t
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description="Test git related"
+
+test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$PWD/../../t"
+. "$TEST_DIRECTORY"/test-lib.sh
+
+setup() {
+	git init &&
+	echo one > content &&
+	git add content &&
+	git commit -q -m one --author='Pablo Escobar <pablo@escobar.com>' &&
+	echo two >> content &&
+	git commit -q -a -m one --author='Jon Stewart <jon@stewart.com>' &&
+	echo three >> content &&
+	git commit -q -a -m three --author='John Doe <john@doe.com>' &&
+	echo four >> content &&
+	git branch basic &&
+	git commit -q -a -F - --author='John Poppins <john@doe.com>' <<-EOF &&
+	four
+
+	Reviewed-by: Jon Stewart <jon@stewart.com>
+	EOF
+	echo five >> content &&
+	git commit -q -a -m five --author='Mary Poppins <mary@yahoo.com.uk>'
+	git checkout -b next &&
+	echo six >> content &&
+	git commit -q -a -m six --author='Ocatio Paz <octavio.paz@gmail.com>'
+}
+
+setup
+
+test_expect_success "basic" "
+	git format-patch --stdout -1 basic > patch &&
+	git related patch | sort > actual &&
+	cat > expected <<-EOF &&
+	Jon Stewart <jon@stewart.com> (author: 50%)
+	Pablo Escobar <pablo@escobar.com> (author: 50%)
+	EOF
+	test_cmp expected actual
+"
+
+test_expect_success "others" "
+	git format-patch --stdout -1 master > patch &&
+	git related patch | sort > actual &&
+	cat > expected <<-EOF &&
+	John Poppins <john@doe.com> (author: 66%)
+	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
+	EOF
+	test_cmp expected actual
+"
+
+test_expect_success "multiple patches" "
+	git format-patch --stdout -1 master > patch1 &&
+	git format-patch --stdout -1 master^ > patch2 &&
+	git related patch1 patch2 | sort > actual &&
+	cat > expected <<-EOF &&
+	John Poppins <john@doe.com> (author: 50%)
+	Jon Stewart <jon@stewart.com> (reviewer: 25%, author: 25%)
+	Pablo Escobar <pablo@escobar.com> (author: 25%)
+	EOF
+	test_cmp expected actual
+"
+
+test_expect_success "from committish" "
+	git related -1 master | sort > actual &&
+	cat > expected <<-EOF &&
+	John Poppins <john@doe.com> (author: 66%)
+	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
+	EOF
+	test_cmp expected actual
+"
+
+test_expect_success "from single rev committish" "
+	git related -1 master | sort > actual &&
+	cat > expected <<-EOF &&
+	John Poppins <john@doe.com> (author: 66%)
+	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
+	EOF
+	test_cmp expected actual
+"
+
+test_expect_success "mailmap" "
+	test_when_finished 'rm -rf .mailmap' &&
+	cat > .mailmap <<-EOF &&
+	Jon McAvoy <jon@stewart.com>
+	John Poppins <john@poppins.com> <john@doe.com>
+	EOF
+	git related -1 master | sort > actual &&
+	cat > expected <<-EOF &&
+	John Poppins <john@poppins.com> (author: 66%)
+	Jon McAvoy <jon@stewart.com> (reviewer: 33%, author: 33%)
+	EOF
+	test_cmp expected actual
+"
+
+test_expect_success "commits" "
+	git related -craw -1 master | git log --format='%s' --no-walk --stdin > actual &&
+	cat > expected <<-EOF &&
+	four
+	three
+	one
+	EOF
+	test_cmp expected actual
+"
+
+test_done

Felipe Contreras (15):
  Add new git-related helper to contrib
  contrib: related: add tests
  contrib: related: add support for multiple patches
  contrib: related: add option to parse from committish
  contrib: related: parse committish like format-patch
  contrib: related: print the amount of involvement
  contrib: related: add helper Person classes
  contrib: related: show role count
  contrib: related: add support for more roles
  contrib: related: group persons with same email
  contrib: related: allow usage on other directories
  contrib: related: add mailmap support
  contrib: related: add option parsing
  contrib: related: add option to show commits
  contrib: related: add README

 contrib/related/Makefile       |  17 ++
 contrib/related/README         |  65 +++++++
 contrib/related/git-related    | 377 +++++++++++++++++++++++++++++++++++++++++
 contrib/related/test-related.t | 107 ++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 contrib/related/Makefile
 create mode 100644 contrib/related/README
 create mode 100755 contrib/related/git-related
 create mode 100755 contrib/related/test-related.t

-- 
1.8.4-fc
