From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH/RFC 7/7] ruby: rewrite 'reset'
Date: Sat, 21 Sep 2013 13:48:15 -0500
Message-ID: <1379789295-18519-8-git-send-email-felipe.contreras@gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 20:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSJq-0000ez-V5
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3IUSyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:54:10 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:43794 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab3IUSyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:54:07 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so2062052obc.25
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0jve3ZLwBFgNRNquego+Dn4lHdyx4N8lznPzormISc=;
        b=TD6DtvRmgry3hqpehwyzJlRhqASJOpOSk5eib6q+VM8dOnpnnHRaxGNiWDYf4MxXP/
         uWAdYb1Qp8mLRj011xbAJ+qj8E49jmdU1w32H+1OXwM+XW0X6VqAHftvdMqcrX++t6m8
         mzpIdm51dmnd2KtN3qa2WvWLGPNaPOSNrgr5hYoNZsPwyVVC4roDX0mT2vPGNRTr6BfK
         mL/L7FZIintaFdX+LMXw+8wX/yZ74Uq9jrO0Du5BImWyey1l6XaFdBSC15CE4tg37FL4
         wDre/rLPh81cmwc09rkKQVPOTuBy8SIHTlhGmaRM0DQb1YZF71xI5kDu1tuLBPe6zZW/
         xDpg==
X-Received: by 10.182.129.201 with SMTP id ny9mr11814826obb.0.1379789646686;
        Sat, 21 Sep 2013 11:54:06 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm8625165obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 11:54:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235141>

Purely for demonstration purposes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile        |   1 +
 git-rb-setup.rb |  89 ++++++++++++
 git-reset.rb    | 223 ++++++++++++++++++++++++++++++
 git.c           |   1 -
 ruby.c          | 414 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 727 insertions(+), 1 deletion(-)
 create mode 100644 git-reset.rb

diff --git a/Makefile b/Makefile
index cb6bb4e..087b33d 100644
--- a/Makefile
+++ b/Makefile
@@ -493,6 +493,7 @@ SCRIPT_PYTHON += git-p4.py
 SCRIPT_RUBY += git-rb-setup.rb
 SCRIPT_RUBY += git-refs.rb
 SCRIPT_RUBY += git-request-pull.rb
+SCRIPT_RUBY += git-reset.rb
 
 NO_INSTALL += git-remote-testgit
 NO_INSTALL += git-remote-testpy
diff --git a/git-rb-setup.rb b/git-rb-setup.rb
index f3a2c99..a789946 100644
--- a/git-rb-setup.rb
+++ b/git-rb-setup.rb
@@ -6,10 +6,25 @@ def die(*args)
   exit 128
 end
 
+def warning(*args)
+  fmt = args.shift
+  $stderr.printf("warning: %s\n" % fmt, *args)
+end
+
+def error(*args)
+  fmt = args.shift
+  $stderr.printf("fatal: %s\n" % fmt, *args)
+  return -1
+end
+
 def sha1_to_hex(sha1)
   sha1.unpack('H*').first
 end
 
+def git_path(*path)
+  File.join(get_git_dir, *path)
+end
+
 def pager(msg)
   pager = ENV['GIT_PAGER'] || `git var GIT_PAGER`.chomp
   system("echo -n '#{msg}' | #{pager}")
@@ -34,3 +49,77 @@ def run(cmd)
   system(cmd)
   raise CommandError.new(cmd, nil) unless $?.success?
 end
+
+class SimpleParser
+  attr_writer :usage
+
+  class Option
+    attr_reader :short, :long, :values, :help
+
+    def initialize(short, long, values, help, &block)
+      @block = block
+      @short = short
+      @long = long
+      @values = values
+      @help = help
+    end
+
+    def call(v)
+      @block.call(v)
+    end
+  end
+
+  def initialize
+    @list = {}
+  end
+
+  def on(*args, &block)
+    short = args.shift if args.first.is_a?(String) or args.first == nil
+    long = args.shift if args.first.is_a?(String)
+    values = args.shift if args.first.is_a?(Array)
+    help = args.shift if args.first.is_a?(String)
+    opt = Option.new(short, long, values, help, &block)
+    @list[short] = opt if short
+    @list[long] = opt if long
+  end
+
+  def parse(args = ARGV)
+    i = 0
+    if args.member?('-h') or args.member?('--help')
+      usage
+      exit! 1
+    end
+    while cur = args[i] do
+      if cur =~ /^(-.+?)(?:=(.*))?$/
+        opt = @list[$1]
+        if opt
+          v = $2
+          if not v
+            if not opt.values
+              extra = true
+            else
+              extra = !!opt.values.map(&:to_s).member?(args[i + 1])
+            end
+            extra = false
+            v = extra ? args.delete_at(i + 1) : true
+          end
+          opt.call(v)
+          args.delete_at(i)
+          next
+        end
+      end
+      i += 1
+    end
+  end
+
+  def usage
+    puts 'usage: %s' % @usage
+    @list.values.uniq.each do |opt|
+      s = '    '
+      s << [opt.short, opt.long].compact.join(', ')
+      s << '%*s%s' % [26 - s.size, '', opt.help] if opt.help
+      puts s
+    end
+  end
+
+end
diff --git a/git-reset.rb b/git-reset.rb
new file mode 100644
index 0000000..88697c8
--- /dev/null
+++ b/git-reset.rb
@@ -0,0 +1,223 @@
+#!/usr/bin/env ruby
+
+require_relative 'git-rb-setup'
+
+$quiet = false
+$patch_mode = false
+
+def reflog_message(action, rev=nil)
+  rla = ENV['GIT_REFLOG_ACTION']
+  if rla
+    '%s: %s' % [rla, action]
+  elsif rev
+    'reset: moving to %s' % rev
+  else
+    'reset: %s' % action
+  end
+end
+
+def update_refs(rev, sha1)
+  sha1_old_orig = get_sha1('ORIG_HEAD')
+  old_orig = sha1_old_orig if sha1_old_orig
+  sha1_orig = get_sha1('HEAD')
+  if sha1_orig
+    orig = sha1_orig
+    msg = reflog_message('updating ORIG_HEAD')
+    update_ref(msg, 'ORIG_HEAD', orig, old_orig, 0, MSG_ON_ERR)
+  elsif old_orig
+    delete_ref('ORIG_HEAD', old_orig, 0)
+  end
+  msg = reflog_message('updating HEAD', rev)
+  return update_ref(msg, 'HEAD', sha1, orig, 0, MSG_ON_ERR)
+end
+
+def is_merge
+  return test('e', git_path('MERGE_HEAD'))
+end
+
+def parse_args(args)
+  rev = 'HEAD'
+  if args[0]
+    if args[0] == '--'
+      args.shift
+    elsif args[1] == '--'
+      rev = args.shift
+      args.shift
+    elsif (!args[1] && get_sha1_committish(args[0])) || (args[1] && get_sha1_treeish(args[0]))
+      verify_non_filename($prefix, args[0])
+      rev = args.shift
+    else
+      verify_filename($prefix, args[0], 1)
+    end
+  end
+  pathspec = args[0] ? get_pathspec($prefix, args) : []
+  return [rev, pathspec]
+end
+
+def reset_index(sha1, reset_type)
+  read_cache_unmerged
+  opts = {}
+
+  case reset_type
+  when :merge, :keep
+    opts[:update] = true
+  when :hard
+    opts[:update] = true
+    opts[:reset] = true
+  else
+    opts[:reset] = true
+  end
+
+  opts[:verobse] = true unless $quiet
+
+  if reset_type == :keep
+    head_sha1 = get_sha1('HEAD')
+    return error('You do not have a valid HEAD.') unless head_sha1
+    opts[:head] = head_sha1
+  end
+
+  if unpack_trees(sha1, opts) != 0
+    return -1
+  end
+
+  if reset_type == :hard || reset_type == :mixed
+    tree = parse_tree_indirect(sha1);
+    prime_cache_tree(nil, tree);
+  end
+
+  return 0
+end
+
+def print_new_head_line(commit)
+  hex = find_unique_abbrev(commit.sha1, DEFAULT_ABBREV)
+  print('HEAD is now at %s' % hex)
+	msg = logmsg_reencode(commit, get_log_output_encoding());
+  _, body = msg.split("\n\n", 2)
+  if body
+    puts [' ', body.lines.first].join
+  else
+    puts
+  end
+end
+
+def cmd(*args)
+  args.shift
+
+  reset_type = :none
+
+  opts = SimpleParser.new
+  opts.usage = 'git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]'
+
+  opts.on('-q', '--quiet', '') do |v|
+    $quiet = true
+  end
+
+  opts.on(nil, '--hard', 'reset HEAD, index and working tree') do |v|
+    reset_type = :hard
+  end
+
+  opts.on(nil, '--soft', 'reset only HEAD') do |v|
+    reset_type = :soft
+  end
+
+  opts.on(nil, '--mixed', 'reset HEAD and index') do |v|
+    reset_type = :mixed
+  end
+
+  opts.on(nil, '--merge', '') do |v|
+    reset_type = :merge
+  end
+
+  opts.on(nil, '--keep', '') do |v|
+    reset_type = :keep
+  end
+
+  opts.on('-p', '--patch', '') do |v|
+    $patch_mode = true
+  end
+
+  $prefix = setup_git_directory
+  git_config
+
+  opts.parse(args)
+  rev, pathspec = parse_args(args)
+
+  unborn = rev == 'HEAD' && !get_sha1('HEAD')
+  if unborn
+    sha1 = EMPTY_TREE_SHA1_BIN
+  elsif pathspec.empty?
+    sha1 = get_sha1_committish(rev)
+    die("Failed to resolve '%s' as a valid revision." % rev) unless sha1
+    commit = lookup_commit_reference(sha1)
+    die("Could not parse object '%s'." % rev) unless commit
+    sha1 = commit.sha1
+  else
+    sha1 = get_sha1_treeish(rev)
+    die("Failed to resolve '%s' as a valid tree." % rev) unless sha1
+    tree = parse_tree_indirect(sha1)
+    die("Could not parse object '%s'.", rev) unless tree
+    sha1 = tree.sha1
+  end
+
+  if $patch_mode
+    args = []
+    args << 'add--interactive'
+    args << '--patch=reset'
+    args << sha1_to_hex(sha1)
+    args << '--'
+    args += pathspec
+    return run_command(args, RUN_GIT_CMD);
+  end
+
+  if not pathspec.empty?
+    if reset_type == :mixed
+      warning("--mixed with paths is deprecated; use 'git reset -- <paths>' instead.")
+    elsif reset_type != :none
+      die('Cannot do %s reset with paths.' % reset_type.to_s)
+    end
+  end
+
+  reset_type = :mixed if reset_type == :none
+
+  if reset_type != :soft && reset_type != :mixed
+    setup_work_tree
+  end
+
+  if reset_type == :mixed && is_bare_repository
+    die('%s reset is not allowed in a bare repository' % reset_type.to_s);
+  end
+
+  if reset_type == :soft || reset_type == :keep
+    if is_merge || read_cache < 0 || unmerged_cache != 0
+      die('Cannot do a %s reset in the middle of a merge.' % reset_type.to_s)
+    end
+  end
+
+  if reset_type != :soft
+    do_locked_index(1) do |f|
+      if reset_type == :mixed
+        r = read_from_tree(pathspec, sha1)
+        return 1 if not r
+        flags = $quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN
+        refresh_index(flags, nil, 'Unstaged changes after reset:')
+      else
+        err = reset_index(sha1, reset_type)
+        err = reset_index(sha1, :mixed) if reset_type == :keep && err == 0
+        die("Could not reset index file to revision '%s'." % rev) if err != 0
+      end
+      write_cache(f)
+    end || die('Could not write new index file.')
+  end
+
+  status = 0
+  if pathspec.empty? && !unborn
+    status = update_refs(rev, sha1)
+    if reset_type == :hard && status == 0 && !$quiet
+      print_new_head_line(lookup_commit_reference(sha1))
+    end
+  end
+  remove_branch_state if pathspec.empty?
+  return status
+end
+
+exit cmd(*ARGV)
diff --git a/git.c b/git.c
index 0e1d97d..777a34a 100644
--- a/git.c
+++ b/git.c
@@ -399,7 +399,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
-		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
diff --git a/ruby.c b/ruby.c
index b4e874d..b3be386 100644
--- a/ruby.c
+++ b/ruby.c
@@ -1,17 +1,40 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "refs.h"
+#include "commit.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "branch.h"
+#include "run-command.h"
+#include "cache-tree.h"
 
 #undef NORETURN
 #undef PATH_SEP
 
 #include <ruby.h>
 
+static VALUE git_rb_commit;
+static VALUE git_rb_tree;
+
 static inline VALUE sha1_to_str(const unsigned char *sha1)
 {
 	return rb_str_new((const char *)sha1, 20);
 }
 
+static inline char *str_to_cstr(VALUE str)
+{
+	if (str == Qnil)
+		return NULL;
+	return RSTRING_PTR(str);
+}
+
+static inline unsigned char *str_to_sha1(VALUE str)
+{
+	return (unsigned char *)str_to_cstr(str);
+}
+
 static int for_each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	VALUE r;
@@ -42,19 +65,410 @@ static VALUE git_rb_resolve_ref_unsafe(VALUE self, VALUE refname, VALUE reading)
 	return a;
 }
 
+static VALUE git_rb_get_sha1(VALUE self, VALUE name)
+{
+	unsigned char buf[20];
+	int r;
+	r = get_sha1(RSTRING_PTR(name), buf);
+	if (r)
+		return Qnil;
+	return sha1_to_str(buf);
+}
+
+static VALUE git_rb_setup_git_directory(VALUE self)
+{
+	const char *prefix;
+	prefix = setup_git_directory();
+	if (!prefix)
+		return Qnil;
+	return rb_str_new2(prefix);
+}
+
+static VALUE git_rb_setup_work_tree(VALUE self)
+{
+	setup_work_tree();
+	return Qnil;
+}
+
+static VALUE git_rb_is_bare_repository(VALUE self)
+{
+	return is_bare_repository() ? Qtrue : Qfalse;
+}
+
+static VALUE git_rb_get_sha1_committish(VALUE self, VALUE str)
+{
+	unsigned char buf[20];
+	if (get_sha1_committish(RSTRING_PTR(str), buf))
+		return Qnil;
+	return sha1_to_str(buf);
+}
+
+static VALUE git_rb_get_sha1_treeish(VALUE self, VALUE str)
+{
+	unsigned char buf[20];
+	if (get_sha1_treeish(RSTRING_PTR(str), buf))
+		return Qnil;
+	return sha1_to_str(buf);
+}
+
+static VALUE git_rb_lookup_commit_reference(VALUE self, VALUE id)
+{
+	struct commit *commit;
+	commit = lookup_commit_reference(str_to_sha1(id));
+	if (!commit)
+		return Qnil;
+	return Data_Wrap_Struct(git_rb_commit, NULL, NULL, commit);
+}
+
+static VALUE git_rb_commit_sha1(VALUE self)
+{
+	struct commit *commit;
+	Data_Get_Struct(self, struct commit, commit);
+	return sha1_to_str(commit->object.sha1);
+}
+
+static VALUE git_rb_commit_buffer(VALUE self)
+{
+	struct commit *commit;
+	Data_Get_Struct(self, struct commit, commit);
+	return rb_str_new2(commit->buffer);
+}
+
+static VALUE git_rb_parse_tree_indirect(VALUE self, VALUE id)
+{
+	struct tree *tree;
+	tree = parse_tree_indirect(str_to_sha1(id));
+	if (!tree)
+		return Qnil;
+	return Data_Wrap_Struct(git_rb_tree, NULL, NULL, tree);
+}
+
+static VALUE git_rb_tree_sha1(VALUE self)
+{
+	struct tree *tree;
+	Data_Get_Struct(self, struct tree, tree);
+	return sha1_to_str(tree->object.sha1);
+}
+
+static VALUE git_rb_unpack_trees(VALUE self, VALUE sha1, VALUE uopts)
+{
+	struct tree_desc desc[2];
+	struct unpack_trees_options opts;
+	int r;
+	int nr = 1;
+	VALUE head;
+
+	memset(&opts, 0, sizeof(opts));
+
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.fn = oneway_merge;
+	opts.merge = 1;
+
+	if (rb_hash_lookup(uopts, ID2SYM(rb_intern("update"))) == Qtrue)
+		opts.update = 1;
+	if (rb_hash_lookup(uopts, ID2SYM(rb_intern("reset"))) == Qtrue)
+		opts.reset = 1;
+	if (rb_hash_lookup(uopts, ID2SYM(rb_intern("verbose"))) == Qtrue)
+		opts.verbose_update = 1;
+
+	head = rb_hash_lookup(uopts, ID2SYM(rb_intern("head")));
+	if (head != Qnil) {
+		fill_tree_descriptor(desc, str_to_sha1(head));
+		opts.fn = twoway_merge;
+		nr++;
+	}
+
+	fill_tree_descriptor(desc + nr - 1, str_to_sha1(sha1));
+	r = unpack_trees(nr, desc, &opts);
+	return INT2NUM(r);
+}
+
+static VALUE git_rb_read_cache_unmerged(VALUE self)
+{
+	read_cache_unmerged();
+	return Qnil;
+}
+
+static VALUE git_rb_read_cache(VALUE self)
+{
+	int r;
+	r = read_cache();
+	return INT2NUM(r);
+}
+
+static VALUE git_rb_unmerged_cache(VALUE self)
+{
+	int r;
+	r = unmerged_cache();
+	return INT2NUM(r);
+}
+
+static void update_index_from_diff(struct diff_queue_struct *q,
+		struct diff_options *opt, void *data)
+{
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filespec *one = q->queue[i]->one;
+		if (one->mode && !is_null_sha1(one->sha1)) {
+			struct cache_entry *ce;
+			ce = make_cache_entry(one->mode, one->sha1, one->path,
+				0, 0);
+			if (!ce)
+				die(_("make_cache_entry failed for path '%s'"),
+				    one->path);
+			add_cache_entry(ce, ADD_CACHE_OK_TO_ADD |
+				ADD_CACHE_OK_TO_REPLACE);
+		} else
+			remove_file_from_cache(one->path);
+	}
+}
+
+static VALUE git_rb_read_from_tree(VALUE self, VALUE paths, VALUE tree_sha1)
+{
+	struct diff_options opt;
+	const char **pathspec = NULL;
+
+	if (paths != Qnil && RARRAY_LEN(paths) > 0) {
+		int i;
+		VALUE *cpaths = RARRAY_PTR(paths);
+		pathspec = xcalloc(RARRAY_LEN(paths) + 1, sizeof(*pathspec));
+		for (i = 0; i < RARRAY_LEN(paths); i++)
+			pathspec[i] = RSTRING_PTR(cpaths[i]);
+		pathspec[i] = NULL;
+	}
+
+	memset(&opt, 0, sizeof(opt));
+	diff_tree_setup_paths(pathspec, &opt);
+	opt.output_format = DIFF_FORMAT_CALLBACK;
+	opt.format_callback = update_index_from_diff;
+
+	read_cache();
+	if (do_diff_cache(str_to_sha1(tree_sha1), &opt))
+		return Qfalse;
+	diffcore_std(&opt);
+	diff_flush(&opt);
+	diff_tree_release_paths(&opt);
+
+	return Qtrue;
+}
+
+static VALUE git_rb_refresh_index(VALUE self, VALUE flags, VALUE seen, VALUE header_msg)
+{
+	int r;
+	r = refresh_index(&the_index, FIX2INT(flags), NULL, NULL, str_to_cstr(header_msg));
+	return INT2NUM(r);
+}
+
+static VALUE git_rb_update_ref(VALUE self, VALUE action, VALUE refname, VALUE sha1, VALUE oldval, VALUE flags, VALUE onerr)
+{
+	int r;
+	r = update_ref(RSTRING_PTR(action), RSTRING_PTR(refname), str_to_sha1(sha1), str_to_sha1(oldval),
+			NUM2INT(flags), FIX2INT(onerr));
+	return INT2NUM(r);
+}
+
+static VALUE git_rb_delete_ref(VALUE self, VALUE refname, VALUE sha1, VALUE delopt)
+{
+	int r;
+	r = delete_ref(RSTRING_PTR(refname), str_to_sha1(sha1), NUM2INT(delopt));
+	return INT2NUM(r);
+}
+
+static VALUE git_rb_remove_branch_state(VALUE self)
+{
+	remove_branch_state();
+	return Qnil;
+}
+
+static VALUE git_rb_write_cache(VALUE self, VALUE fd)
+{
+	int r;
+	r = write_index(&the_index, NUM2INT(fd));
+	return INT2NUM(r);
+}
+
+static VALUE git_rb_get_index_file(VALUE self)
+{
+	char *file;
+	file = get_index_file();
+	return rb_str_new2(file);
+}
+
+static VALUE git_rb_do_locked_index(VALUE self, VALUE die_on_error)
+{
+	struct lock_file *lock = xcalloc(1, sizeof(*lock));
+	int fd, cr;
+	VALUE r;
+
+	fd = hold_locked_index(lock, NUM2INT(die_on_error));
+	r = rb_yield(INT2NUM(fd));
+	cr = NUM2INT(r);
+	if (cr == 0)
+		cr = commit_locked_index(lock);
+	return cr == 0 ? Qtrue : Qfalse;
+}
+
+static VALUE git_rb_verify_filename(VALUE self, VALUE prefix, VALUE arg, VALUE diagnose_misspelt_rev)
+{
+	verify_filename(str_to_cstr(prefix), str_to_cstr(arg), NUM2INT(diagnose_misspelt_rev));
+	return Qnil;
+}
+
+static VALUE git_rb_verify_non_filename(VALUE self, VALUE prefix, VALUE arg)
+{
+	verify_non_filename(str_to_cstr(prefix), str_to_cstr(arg));
+	return Qnil;
+}
+
+static VALUE git_rb_git_config(VALUE self)
+{
+	git_config(git_default_config, NULL);
+	return Qnil;
+}
+
+static VALUE git_rb_run_command(VALUE self, VALUE args, VALUE opt)
+{
+	const char **argv;
+	int i, r;
+	VALUE *cargs;
+
+	cargs = RARRAY_PTR(args);
+	argv = xcalloc(RARRAY_LEN(args) + 1, sizeof(*argv));
+	for (i = 0; i < RARRAY_LEN(args); i++)
+		argv[i] = RSTRING_PTR(cargs[i]);
+	argv[i] = NULL;
+
+	r = run_command_v_opt(argv, FIX2INT(opt));
+	return INT2NUM(r);
+}
+
+static VALUE git_rb_prime_cache_tree(VALUE self, VALUE cache, VALUE rtree)
+{
+	struct tree *tree;
+	Data_Get_Struct(rtree, struct tree, tree);
+	prime_cache_tree(&active_cache_tree, tree);
+	return Qnil;
+}
+
+static VALUE git_rb_get_pathspec(VALUE self, VALUE prefix, VALUE pathspec)
+{
+	const char **dst, **src;
+	VALUE *rsrc, *rdst;
+	int i, c;
+
+	c = RARRAY_LEN(pathspec);
+	rsrc = RARRAY_PTR(pathspec);
+
+	src = xcalloc(c + 1, sizeof(*src));
+	for (i = 0; i < c; i++)
+		src[i] = RSTRING_PTR(rsrc[i]);
+	src[i] = NULL;
+
+	dst = get_pathspec(str_to_cstr(prefix), src);
+
+	rdst = xcalloc(c, sizeof(*rdst));
+	for (i = 0; i < c; i++)
+		rdst[i] = rb_str_new2(dst[i]);
+
+	return rb_ary_new4(c, rdst);
+}
+
+static VALUE git_rb_get_git_dir(VALUE self)
+{
+	return rb_str_new2(get_git_dir());
+}
+
+static VALUE git_rb_find_unique_abbrev(VALUE self, VALUE sha1, VALUE len)
+{
+	const char *abbrev;
+	abbrev = find_unique_abbrev(str_to_sha1(sha1), NUM2INT(len));
+	return rb_str_new2(abbrev);
+}
+
+static VALUE git_rb_get_log_output_encoding(VALUE self)
+{
+	return rb_str_new2(get_log_output_encoding());
+}
+
+static VALUE git_rb_logmsg_reencode(VALUE self, VALUE commit, VALUE output_encoding)
+{
+	struct commit *g_commit;
+	char *str;
+
+	Data_Get_Struct(commit, struct commit, g_commit);
+	str = logmsg_reencode(g_commit, NULL, RSTRING_PTR(output_encoding));
+	return rb_str_new2(str);
+}
+
 static void git_init(void)
 {
+	VALUE mod, tmp;
+
+	mod = rb_define_module("Git");
+
 	rb_define_global_const("REF_ISSYMREF", INT2FIX(REF_ISSYMREF));
 	rb_define_global_const("REF_ISPACKED", INT2FIX(REF_ISPACKED));
 	rb_define_global_const("REF_ISBROKEN", INT2FIX(REF_ISBROKEN));
 
+	rb_define_global_const("MSG_ON_ERR", INT2FIX(MSG_ON_ERR));
+	rb_define_global_const("REFRESH_QUIET", INT2FIX(REFRESH_QUIET));
+	rb_define_global_const("REFRESH_IN_PORCELAIN", INT2FIX(REFRESH_IN_PORCELAIN));
+	rb_define_global_const("RUN_GIT_CMD", INT2FIX(RUN_GIT_CMD));
+	rb_define_global_const("DEFAULT_ABBREV", INT2FIX(DEFAULT_ABBREV));
+
+	tmp = rb_obj_freeze(rb_str_new((const char *)EMPTY_TREE_SHA1_BIN, 20));
+	rb_define_global_const("EMPTY_TREE_SHA1_BIN", tmp);
+
+	git_rb_commit = rb_define_class_under(mod, "Commit", rb_cData);
+	rb_define_method(git_rb_commit, "sha1", git_rb_commit_sha1, 0);
+	rb_define_method(git_rb_commit, "buffer", git_rb_commit_buffer, 0);
+
+	git_rb_tree = rb_define_class_under(mod, "Tree", rb_cData);
+	rb_define_method(git_rb_tree, "sha1", git_rb_tree_sha1, 0);
+
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
 	rb_define_global_function("resolve_ref_unsafe", git_rb_resolve_ref_unsafe, 2);
+
+	rb_define_global_function("get_sha1", git_rb_get_sha1, 1);
+	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
+	rb_define_global_function("setup_work_tree", git_rb_setup_work_tree, 0);
+	rb_define_global_function("is_bare_repository", git_rb_is_bare_repository, 0);
+	rb_define_global_function("get_sha1_committish", git_rb_get_sha1_committish, 1);
+	rb_define_global_function("get_sha1_treeish", git_rb_get_sha1_treeish, 1);
+	rb_define_global_function("lookup_commit_reference", git_rb_lookup_commit_reference, 1);
+	rb_define_global_function("parse_tree_indirect", git_rb_parse_tree_indirect, 1);
+
+	rb_define_global_function("read_cache_unmerged", git_rb_read_cache_unmerged, 0);
+	rb_define_global_function("unpack_trees", git_rb_unpack_trees, 2);
+	rb_define_global_function("read_cache", git_rb_read_cache, 0);
+	rb_define_global_function("unmerged_cache", git_rb_unmerged_cache, 0);
+	rb_define_global_function("read_from_tree", git_rb_read_from_tree, 2);
+	rb_define_global_function("update_ref", git_rb_update_ref, 6);
+	rb_define_global_function("delete_ref", git_rb_delete_ref, 3);
+	rb_define_global_function("remove_branch_state", git_rb_remove_branch_state, 0);
+	rb_define_global_function("write_cache", git_rb_write_cache, 1);
+	rb_define_global_function("get_index_file", git_rb_get_index_file, 0);
+	rb_define_global_function("do_locked_index", git_rb_do_locked_index, 1);
+	rb_define_global_function("refresh_index", git_rb_refresh_index, 3);
+	rb_define_global_function("verify_filename", git_rb_verify_filename, 3);
+	rb_define_global_function("verify_non_filename", git_rb_verify_non_filename, 2);
+	rb_define_global_function("git_config", git_rb_git_config, 0);
+	rb_define_global_function("run_command", git_rb_run_command, 2);
+	rb_define_global_function("prime_cache_tree", git_rb_prime_cache_tree, 2);
+	rb_define_global_function("get_pathspec", git_rb_get_pathspec, 2);
+	rb_define_global_function("get_git_dir", git_rb_get_git_dir, 0);
+	rb_define_global_function("find_unique_abbrev", git_rb_find_unique_abbrev, 2);
+	rb_define_global_function("get_log_output_encoding", git_rb_get_log_output_encoding, 0);
+	rb_define_global_function("logmsg_reencode", git_rb_logmsg_reencode, 2);
 }
 
 static const char *commands[] = {
 	"refs",
 	"request-pull",
+	"reset",
 };
 
 static void run_ruby_command(int argc, const char **argv)
-- 
1.8.4-fc
