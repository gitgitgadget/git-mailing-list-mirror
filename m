From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [IGNORE] Implement 'git rebase' in ruby
Date: Mon, 10 Jun 2013 00:22:02 -0500
Message-ID: <1370841722-8059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 07:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uluaa-0001fM-C1
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab3FJFX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:23:59 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:40969 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab3FJFX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:23:57 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so3350796oag.20
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZjRrAyCUfmJpD1iFzG03zCk3ebNeG10SpuZKeSfBIoc=;
        b=Ky5n+w9TYie9QxiRvWKVWSN2uZmwmqmlayLbOMqwptrujDfyUt8RXRSLcscHgXXVov
         fFNoP2Vo8tEjtEMsgpho+7mMK7OiAR+ULLI/OEfkcDPxqZFC3gloA0DuBFNxcQeQ+/B+
         /qAx+DNT806uXo/6zn9TH3Zosis5ahrunXPOh7l57Qz5r8x9ENvM5PeU+DJPDISgPgtL
         JT7j8NzlYTt5e/cetKnzm8RS0hRyXdcGOMxFM69Tz+3g+bJCCyT+rCFqHkFfYDGMf788
         8MtL3aSnAvshLiZGDhnrugyp9zLJXmCZixR7aVAbn8xuT2faC9f24LrTDHGVWodnMOiq
         2wmw==
X-Received: by 10.60.94.70 with SMTP id da6mr6676315oeb.63.1370841836644;
        Sun, 09 Jun 2013 22:23:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm19671769oby.12.2013.06.09.22.23.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 22:23:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227237>

Ignore this patch. I was using this to test and improve 'git rebase', and I was
using the lessons learned to improve 'git rebase' shell script.

I was planning it to clean it even more, and simplify it using tricks specific
to Ruby.

But no more.

There's no point in trying to improve 'git rebase'. It will remain forever as a
barely maintainable mesh of shell scripts, that aren't even consistent among
themselves.

Maybe somebody in the future will find this useful. So here it is.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase.rb | 2056 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2056 insertions(+)
 create mode 100755 git-rebase.rb

diff --git a/git-rebase.rb b/git-rebase.rb
new file mode 100755
index 0000000..3ec1ad6
--- /dev/null
+++ b/git-rebase.rb
@@ -0,0 +1,2056 @@
+#!/usr/bin/env ruby
+
+require 'optparse'
+require 'fileutils'
+
+def `(cmd)
+  IO.popen(cmd) { |pipe| pipe.read.chomp }
+end
+
+class Array
+  def to_f
+    File.join(self)
+  end
+end
+
+class CommandError < RuntimeError
+
+  attr_reader :command, :output
+
+  def initialize(command, output)
+    @command = command
+    @output = output
+  end
+
+  def to_s
+    Array(@command).join(' ').inspect
+  end
+
+end
+
+def run(*args)
+  out = nil
+  if args.first.kind_of?(Hash)
+    env = args.shift
+  else
+    env = ENV
+  end
+
+  cmd = args.shift
+  opts = args.shift || {}
+
+  to_read = opts.delete(:read)
+  to_write = opts.delete(:write)
+  silent = opts.delete(:silent)
+
+  verbose = silent ? $verbose : !to_read
+
+  if to_write
+    mode = 'r+'
+  elsif opts[:out]
+    mode = 'w'
+  else
+    mode = 'r'
+  end
+
+  opts[:err] = [:child, :out] unless verbose
+
+  IO.popen(env, cmd, mode, opts) do |pipe|
+    if to_write
+      pipe.write(to_write)
+      pipe.close_write
+    end
+    out = pipe.read.chomp if not opts[:out]
+  end
+  if out and not out.empty?
+    puts out if verbose or not $?.success?
+  end
+  raise CommandError.new(cmd, out) unless $?.success?
+  out
+end
+
+def die(*msg)
+  $stderr.puts(msg * "\n")
+  exit 1
+end
+
+def say(*msg)
+  puts msg * "\n" unless $GIT_QUIET
+end
+
+$GIT_DIR = File.absolute_path(`git rev-parse --git-dir`)
+$GIT_QUIET = nil
+
+$merge_dir = File.join($GIT_DIR, 'rebase-merge')
+$apply_dir = File.join($GIT_DIR, 'rebase-apply')
+$verbose = true
+
+ENV['GIT_REFLOG_ACTION'] ||= 'rebase'
+
+$opts = {}
+$opts[:diffstat] = true if `git config --bool rebase.stat` == 'true'
+$opts[:autosquash] = true if `git config --bool rebase.autosquash` == 'true'
+$opts[:autostash] = true if `git config --bool rebase.autostash` == 'true'
+$opts[:am] = []
+
+cmds = []
+strategy = nil
+strategy_opts = []
+rebase_root = nil
+force_rebase = false
+rerere_autoupdate = nil
+state_dir = nil
+preserve_merges = false
+keep_empty = false
+
+action = nil
+onto = nil
+revisions = nil
+head_name = nil
+orig_head = nil
+onto_name = nil
+switch_to = nil
+upstream = nil
+squash_onto = nil
+
+msgend = nil
+msgnum = nil
+last_count = nil
+
+rewritten = nil
+todo = nil
+done = nil
+dropped = nil
+msg = nil
+author_script = nil
+amend = nil
+rewritten_list = nil
+rewritten_pending = nil
+orig_reflog_action = nil
+comment_char = nil
+squash_msg = nil
+fixup_msg = nil
+
+pick_one_preserving_merges = nil
+interactive_rebase = nil
+
+optparser = OptionParser.new do |opts|
+  opts.program_name = 'git rebase'
+  opts.banner = 'usage: git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
+   or: git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
+   or: git-rebase --continue | --abort | --skip | --edit-todo'
+
+  opts.separator ''
+  opts.separator 'Available options are'
+
+  opts.on('--[no-]verify') do |v|
+    $opts[:ok_to_skip_pre_rebase] = !v
+  end
+
+  opts.on('--autostash') do |v|
+    $opts[:autostash] = v
+  end
+
+  opts.on('--onto BASE') do |v|
+    onto = v
+  end
+
+  opts.on('-x', '--exec CMD') do |v|
+    cmds << v
+  end
+
+  opts.on('-i', '--interactive') do
+    interactive_rebase = :explicit
+    $opts[:type] = :interactive
+  end
+
+  opts.on('-k', '--keep-empty') do
+    keep_empty = true
+  end
+
+  opts.on('-p', '--preserve-merges') do
+    preserve_merges = true
+    interactive_rebase = :implied if not interactive_rebase
+    $opts[:type] = :interactive
+  end
+
+  opts.on('--[no-]autosquash') do |v|
+    $opts[:autosquash] = v
+  end
+
+  opts.on('-M') do
+    # nothing
+  end
+
+  opts.on('-m', '--merge') do
+    # nothing
+  end
+
+  opts.on('-X', '--strategy-option STRAT') do |v|
+    strategy_opts << v
+    strategy = 'recursive' if not strategy
+  end
+
+  opts.on('-s', '--strategy STRAT') do |v|
+    strategy = v
+  end
+
+  opts.on('--[no-]stat') do |v|
+    $opts[:diffstat] = v
+  end
+
+  opts.on('-n') do
+    $opts[:diffstat] = false
+  end
+
+  opts.on('-v', '--verbose') do
+    $opts[:verbose] = true
+  end
+
+  opts.on('-q', '--quiet') do
+    $opts[:verbose] = false
+  end
+
+  opts.on('--whitespace KIND') do |v|
+    $opts[:am] << '--whitespace=%s' % v
+    case v
+    when 'fix', 'strip'
+      force_rebase = true
+    end
+  end
+
+  opts.on('--ignore-whitespace') do
+    $opts[:am] << '--ignore-whitespace'
+  end
+
+  opts.on('--committer-date-is-author-date') do
+    $opts[:am] << '--committer-date-is-author-date'
+    force_rebase = true
+  end
+
+  opts.on('--ignore-date') do
+    $opts[:am] << '--ignore-date'
+    force_rebase = true
+  end
+
+  opts.on('-C') do |v|
+    $opts[:am] << '-C%s' % v
+  end
+
+  opts.on('--root') do
+    rebase_root = true
+  end
+
+  opts.on('-f', '--force-rebase') do
+    force_rebase = true
+  end
+
+  opts.on('--no-ff') do
+    force_rebase = true
+  end
+
+  opts.on('--[no-]rerere-autoupdate') do |v|
+    rerere_autoupdate = v
+  end
+
+  opts.separator ''
+  opts.separator 'Actions:'
+
+  opts.on('--continue') do
+    action = :continue
+  end
+
+  opts.on('--skip') do
+    action = :skip
+  end
+
+  opts.on('--abort') do
+    action = :abort
+  end
+
+  opts.on('--edit-todo') do
+    action = :edit_todo
+  end
+
+  opts.separator ''
+
+  opts.on_tail('-h', '--help') do
+    puts opts
+    exit 1
+  end
+
+end
+
+class RebaseType
+
+  attr_reader :state_dir
+
+  def initialize
+    check
+  end
+
+  def bind(binding)
+    @binding = binding
+  end
+
+  def do(action)
+    @action = action
+    if action
+      die 'No rebase in progress?' unless $in_progress
+      send(action)
+    else
+      start
+    end
+  end
+
+  def check
+    if `git rev-parse --is-bare-repository` != 'false'
+      die "fatal: #{$0} cannot be used without a working tree."
+    end
+
+    begin
+      cdup = `git rev-parse --show-toplevel`
+      raise if not $?.success?
+      Dir.chdir(cdup)
+    rescue
+      die "Cannot chdir to #{cdup}, the toplevel of the working tree"
+    end
+
+    if test('e', [$apply_dir, 'applying'].to_f)
+      die 'It looks like git-am is in progress. Cannot rebase.'
+    end
+  end
+
+  def setup
+    # Make sure no rebase is in progress
+    if $in_progress
+      state_dir_base = File.basename(state_dir)
+      die "It seems that there is already a #{state_dir_base} directory, and",
+        "I wonder if you are in the middle of another rebase.  If that is the",
+        "case, please try",
+        "  git rebase (--continue | --abort | --skip)",
+        "If that is not the case, please",
+        "  rm -fr \"$state_dir\"",
+        "and run me again.  I am stopping in case you still have something",
+        "valuable there."
+    end
+
+    fields = %w[rebase_root onto interactive_rebase strategy strategy_opts keep_empty rerere_autoupdate]
+    fields.each do |e|
+      v = eval(e, @binding)
+      eval("@#{e} = #{v.inspect}")
+    end
+
+    @interactive_rebase ||= :implied if @rebase_root and not @onto
+
+    if not @rebase_root
+      case ARGV.size
+      when 0
+        upstream_name = `git rev-parse --symbolic-full-name --verify -q @{upstream} 2> /dev/null`
+        if upstream_name.empty?
+          error_on_missing_default_upstream('rebase', 'rebase', 'against', 'git rebase <branch>')
+        end
+      else
+        upstream_name = ARGV.shift
+      end
+      @upstream = `git rev-parse --verify "#{upstream_name}^0"`
+      die "invalid upstream #{upstream_name}" if @upstream.empty?
+      @upstream_arg = upstream_name
+    else
+      if not @onto
+        empty_tree = `git hash-object -t tree /dev/null`
+        @onto = `git commit-tree #{empty_tree} < /dev/null`
+        @squash_onto = @onto
+      end
+      upstream_name = nil
+      @upstream = nil
+      @upstream_arg = '--root'
+    end
+
+    # Make sure the branch to rebase onto is valid.
+    @onto_name = @onto ? @onto : upstream_name
+    case @onto_name
+    when /(.+)?\.\.\.(.+)?/
+      left = $1 ? $1 : 'HEAD'
+      right = $2 ? $2 : 'HEAD'
+      merge_bases = `git merge-base --all #{left} #{right}`.split("\n")
+      case merge_bases.size
+      when 1
+        @onto = merge_bases.first
+      when 0
+        die "#{@onto_name}: there is no merge base"
+      else
+        die "#{@onto_name}: there are more than one merge bases"
+      end
+    else
+      @onto = `git rev-parse --verify "#{@onto_name}^0"`
+      die "Does not point to a valid commit: #{@onto_name}" if @onto.empty?
+    end
+
+    # If the branch to rebase is given, that is the branch we will rebase
+    # $branch_name -- branch being rebased, or HEAD (already detached)
+    # $orig_head -- commit object name of tip of the branch before rebasing
+    # $head_name -- refs/heads/<that-branch> or "detached HEAD"
+
+    case ARGV.size
+    when 1
+      @switch_to = @branch_name = branch = ARGV[0]
+
+      system "git show-ref --verify --quiet -- refs/heads/#{branch}"
+      if $?.success?
+        @orig_head = `git rev-parse -q --verify refs/heads/#{branch}`
+        @head_name = 'refs/heads/%s' % branch if $?.success?
+      end
+
+      if not @head_name
+        @orig_head = `git rev-parse -q --verify #{branch}`
+        @head_name = 'detached HEAD' if $?.success?
+      end
+      die "fatal: no such branch: #{@branch_name}" unless @head_name
+    when 0
+      @branch_name = `git symbolic-ref -q HEAD`
+      if $?.success?
+        @head_name = @branch_name.clone()
+        @branch_name.gsub!('refs/heads/', '')
+      else
+        @head_name = 'detached HEAD'
+        @branch_name = 'HEAD'
+      end
+      @orig_head = `git rev-parse --verify HEAD`
+      exit unless $?.success?
+    else
+      die "BUG: unexpected number of arguments left to parse"
+    end
+
+    # update main
+    fields = %w[onto onto_name squash_onto interactive_rebase upstream]
+    fields += %w[orig_head head_name switch_to revisions]
+    fields.each do |e|
+      v = eval('@' + e)
+      next if v == nil
+      eval("#{e} = #{v.inspect}", @binding)
+    end
+  end
+
+  def start_common
+    # If a hook exists, give it a chance to interrupt
+    hook = [$GIT_DIR, 'hooks', 'pre-rebase'].to_f
+    if not $opts[:ok_to_skip_pre_rebase] and test('e', hook)
+      cmd = [ hook ]
+      if @upstream_arg
+        cmd << @upstream_arg
+        cmd += ARGV
+      end
+      begin
+        run cmd
+      rescue CommandError
+        die 'The pre-rebase hook refused to rebase.'
+      end
+    end
+
+    if $opts[:diffstat]
+      say "Changes from #{@mb} to #{@onto}:"
+      run({ 'GIT_PAGER' => '' }, %W[git diff --stat --summary #{@mb} #{@onto}])
+    end
+  end
+
+  def start
+    setup
+
+    dirty = !require_clean_work_tree(quiet: true)
+    if $opts[:autostash] and dirty
+      begin
+        stash_sha1 = run %w[git stash create autostash], read: true
+      rescue CommandError
+        die 'Cannot autostash'
+      end
+
+      begin
+        FileUtils.mkdir_p(@state_dir)
+        File.write([@state_dir, 'autostash'].to_f, stash_sha1)
+        stash_abbrev = run %W[git rev-parse --short #{stash_sha1}], read: true
+        puts "Created autostash: #{stash_abbrev}"
+        run %w[git reset --hard]
+      rescue CommandError
+      end
+    end
+
+    require_clean_work_tree('rebase', 'Please commit or stash them.')
+
+    @mb = `git merge-base '#{@onto}' '#{@orig_head}'`
+
+    if @upstream == @onto and @mb == @onto
+      # linear history?
+      begin
+        run "git rev-list --parents '#{@onto}'..'#{@orig_head}' | grep -q ' .* '", out: File::NULL
+      rescue
+        if not $opts[:force_rebase]
+          # Lazily switch to the target branch if needed...
+          run %W[git checkout #{@switch_to} --] if @switch_to
+          say "Current branch #{@branch_name} is up to date."
+          exit 0
+        else
+          say "Current branch #{@branch_name} is up to date, rebase forced."
+        end
+      end
+    end
+
+    start_common
+
+    # Detach HEAD and reset the tree
+    say 'First, rewinding head to replay your work on top of it...'
+
+    begin
+      run %W[git checkout -q #{@onto}^0]
+    rescue
+      die 'could not detach HEAD'
+    end
+    run %W[git update-ref ORIG_HEAD #{@orig_head}]
+
+    # If the $onto is a proper descendant of the tip of the branch, then
+    # we just fast-forwarded.
+    if @mb == @orig_head
+      say "Fast-forwarded #{@branch_name} to #{@onto_name}."
+      move_to_original_branch
+      exit 0
+    end
+
+    if @rebase_root
+      @revisions = "#{@onto}..#{@orig_head}"
+    else
+      @revisions = "#{@upstream}..#{@orig_head}"
+    end
+
+    # update main
+    fields = %w[revisions]
+    fields.each do |e|
+      v = eval('@' + e)
+      next if v == nil
+      eval("#{e} = #{v.inspect}", @binding)
+    end
+
+    run_specific
+  end
+
+  def load
+    def load_field(field)
+      begin
+        File.read([@state_dir, field].to_f).chomp
+      rescue
+        nil
+      end
+    end
+
+    @head_name = load_field('head-name')
+    @onto = load_field('onto')
+
+    # We always write to orig-head, but interactive rebase used to write to
+    # head. Fall back to reading from head to cover for the case that the
+    # user upgraded git with an ongoing interactive rebase.
+
+    @orig_head = load_field('orig-head') || load_field('orig')
+
+    $GIT_QUIET = load_field('quiet')
+    load_field('verbose') && $verbose = true
+
+    @strategy = load_field('strategy')
+    @strategy_opts = load_field('strategy_opts').split("\n").map { |e| e[2..-1] }
+
+    v = load_field('allow_rerere_autoupdate')
+    if v != nil
+      @rerere_autoupdate = (v == '--rerere-autoupdate')
+    end
+
+    # update main
+    fields = %w[head_name onto orig_head strategy strategy_opts rerere_autoupdate]
+    fields.each do |e|
+      v = eval('@' + e)
+      next if v == nil
+      eval("#{e} = #{v.inspect}", @binding)
+    end
+  end
+
+  def store
+    # update self
+    fields = %w[head_name onto orig_head strategy strategy_opts rerere_autoupdate]
+    fields.each do |e|
+      v = eval(e, @binding)
+      eval("@#{e} = #{v.inspect}")
+    end
+
+    def store_field(field, value)
+      File.write([@state_dir, field].to_f, value)
+    end
+
+    store_field('head-name', @head_name)
+    store_field('onto', @onto)
+    store_field('orig-head', @orig_head)
+    store_field('quiet', $GIT_QUIET)
+    store_field('verbose', 't') if $verbose
+    store_field('strategy', @strategy) if @strategy
+
+    store_field('strategy_opts', @strategy_opts.map { |e| '--%s' % e }.join(' '))
+
+    if @rerere_autoupdate != nil
+      store_field('allow_rerere_autoupdate',
+                  @rerere_autoupdate ? '--rerere-autoupdate' : '--no-rerere-autoupdate')
+    end
+  end
+
+  def finish_rebase
+    if test('f', [@state_dir, 'autostash'].to_f)
+      stash_sha1 = File.read([@state_dir, 'autostash'].to_f)
+      begin
+        run %W[git stash apply #{stash_sha1}], silent: true
+      rescue CommandError
+        ref_stash = 'refs/stash'
+        File.write([$GIT_DIR, 'logs', ref_stash].to_f, '', open_args: ['a'])
+        begin
+          run %W[git update-ref -m "autostash" #{ref_stash} #{stash_sha1}]
+        rescue CommandError
+          die "Cannot store #{stash_sha1}"
+        end
+
+        puts 'Applying autostash resulted in conflicts.
+  Your changes are safe in the stash.
+  You can run "git stash pop" or "git stash drop" it at any time.
+  '
+      else
+        puts 'Applied autostash.'
+      end
+    end
+
+    run %w[git gc --auto]
+    FileUtils.rm_rf(@state_dir)
+  end
+
+  def run_specific
+    if @interactive_rebase == :implied
+      ENV['GIT_EDITOR'] = ':'
+      $opts[:autosquash] = false
+    end
+    r = eval("run_rebase_#{@type.to_s}.call", @binding)
+    if r == 0
+      finish_rebase
+    end
+    return r
+  end
+
+  def continue
+    begin
+      run %w[git rev-parse --verify HEAD], out: File::NULL
+    rescue CommandError
+      die 'Cannot read HEAD'
+    end
+    begin
+      run %w[git update-index --ignore-submodules --refresh]
+      run %w[git diff-files --quiet --ignore-submodules]
+    rescue CommandError
+      die 'You must edit all merge conflicts and then',
+        'mark them as resolved using git add'
+    end
+    load
+    run_specific
+  end
+
+  def skip
+    begin
+      run %w[git reset --hard HEAD], silent: true
+    rescue CommandError
+      exit 1
+    end
+    load
+    run_specific
+  end
+
+  def abort
+    run %w[git rerere clear]
+    load
+    if @head_name.start_with?('refs/')
+      begin
+        run %w[git symbolic-ref -m 'rebase:\ aborting' HEAD] + [@head_name]
+      rescue CommandError
+        die "Could not move back to #{@head_name}"
+      end
+    end
+    run %w[git reset --hard] + [@orig_head], silent: true
+    finish_rebase
+    return 0
+  end
+
+  def edit_todo
+    die 'The --edit-todo action can only be used during interactive rebase.'
+  end
+
+  def move_to_original_branch
+    return unless @head_name.start_with?('refs/')
+    head = `git rev-parse HEAD`
+    begin
+      message = "rebase finished: #{@head_name} onto #{@onto}"
+      run %W[git update-ref -m #{message} #{@head_name} #{head} #{@orig_head}]
+      message = "rebase finished: returning to #{@head_name}"
+      run %W[git symbolic-ref -m #{message} HEAD #{@head_name}]
+    rescue CommandError
+      die "Could not move back to #{@head_name}"
+    end
+  end
+
+end
+
+class AmRebase < RebaseType
+
+  def initialize
+    super
+    @type = :am
+    @state_dir = $apply_dir
+  end
+
+  def helper(command)
+    begin
+      run %W[git am --#{command} --resolvemsg=#{$resolvemsg}]
+    rescue CommandError
+      return 1
+    end
+    move_to_original_branch
+    finish_rebase
+    return 0
+  end
+
+  def continue
+    super
+    helper('continue')
+  end
+
+  def skip
+    super
+    helper('skip')
+  end
+
+  def run_specific
+    return if @action
+
+    patches = [$GIT_DIR, 'rebased-patches'].to_f
+    FileUtils.rm_f(patches)
+
+    root_flag = '--root' if @rebase_root
+
+    begin
+      run "git format-patch -k --stdout --full-index --ignore-if-in-upstream " \
+        "--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter #{root_flag} " \
+        "'#{@revisions}' > '#{patches}'"
+    rescue CommandError
+      FileUtils.rm_f(patches)
+      case @head_name
+      when /refs\/heads\/.*/
+        run "git checkout -q #{@head_name}"
+      else
+        run "git checkout -q #{@orig_head}"
+      end
+
+      $stderr.puts "
+
+    git encountered an error while preparing the patches to replay
+    these revisions:
+
+        #{@revisions}
+
+    As a result, git cannot rebase them.
+        "
+
+      return 1
+    end
+
+    opts_am = $opts[:am]
+    opts_am << '-q' if $GIT_QUIET
+    opts = opts_am.join(' ')
+
+    begin
+      run "git am #{opts} --rebasing --resolvemsg='#{$resolvemsg}' < '#{patches}'"
+    rescue CommandError
+      $rebase.store if File.directory?(@state_dir)
+      return 1
+    ensure
+      FileUtils.rm_f(patches)
+    end
+
+    move_to_original_branch
+    finish_rebase
+    return 0
+  end
+
+end
+
+class CherryPickRebase < RebaseType
+
+  def initialize
+    super
+    @type = :cherrypick
+    @state_dir = $merge_dir
+  end
+
+  def run_specific
+    return if @action
+
+    ENV['GIT_CHERRY_PICK_HELP'] = $resolvemsg
+
+    begin
+      FileUtils.mkdir_p(@state_dir)
+    rescue
+      die "Could not create temporary #{@state_dir}"
+    end
+
+    begin
+      File.write([@state_dir, 'cherrypick'].to_f, 'true')
+    rescue
+      die "Could not mark as interactive"
+    end
+
+    if not @rebase_root
+      revisions = "#{@upstream}...#{@orig_head}"
+    else
+      revisions = "#{@onto}...#{@orig_head}"
+    end
+
+    begin
+      cmd = %W[git cherry-pick --no-merges --right-only --topo-order --do-walk]
+      if @keep_empty
+        cmd << '--keep-redundant-commits'
+      else
+        cmd << '--skip-empty'
+        cmd << '--cherry-pick'
+      end
+      cmd << '--strategy=%s' % @strategy if @strategy
+      cmd += @strategy_opts.map { |e| '-X%s' % e }
+      cmd << '-q' if not $verbose
+      cmd << '--ff' if not @force_rebase
+      cmd << (@rerere_autoupdate ? '--rerere-autoupdate' : '--no-rerere-autoupdate') if @rerere_autoupdate != nil
+      cmd << revisions
+      run cmd
+    rescue CommandError
+      $rebase.store
+      return 1
+    end
+
+    move_to_original_branch
+    finish_rebase
+    return 0
+  end
+
+  def helper(command)
+    begin
+      run %W[git cherry-pick --#{command}]
+    rescue CommandError
+      return 1
+    end
+    move_to_original_branch
+    finish_rebase
+    return 0
+  end
+
+  def continue
+    super
+    # do we have anything to commit?
+    system *%w[git diff-index --cached --quiet HEAD --]
+    if not $?.success?
+      begin
+        run %w[git commit --no-verify -e]
+      rescue CommandError
+      end
+    end
+    helper('continue')
+  end
+
+  def skip
+    super
+    helper('skip')
+  end
+
+  def abort
+    run %W[git cherry-pick --abort]
+    super
+    return 0
+  end
+
+end
+
+class InteractiveRebase < RebaseType
+
+  def initialize
+    super
+    @type = :interactive
+    @state_dir = $merge_dir
+  end
+
+  def do(action)
+    if action
+      # Only interactive rebase uses detailed reflog messages
+      if ENV['GIT_REFLOG_ACTION'] == 'rebase'
+        ENV['GIT_REFLOG_ACTION'] = 'rebase -i (%s)' % action
+      end
+    end
+    super
+  end
+
+  def start
+    setup
+
+    dirty = !require_clean_work_tree(quiet: true)
+    if $opts[:autostash] and dirty
+      begin
+        stash_sha1 = run %w[git stash create autostash], read: true
+      rescue CommandError
+        die 'Cannot autostash'
+      end
+
+      begin
+        FileUtils.mkdir_p(@state_dir)
+        File.write([@state_dir, 'autostash'].to_f, stash_sha1)
+        stash_abbrev = run %W[git rev-parse --short #{stash_sha1}], read: true
+        puts "Created autostash: #{stash_abbrev}"
+        run %w[git reset --hard]
+      rescue CommandError
+      end
+    end
+
+    require_clean_work_tree('rebase', 'Please commit or stash them.')
+    @mb = `git merge-base "#{@onto}" "#{@orig_head}"`
+    start_common
+    run_specific
+  end
+
+  def edit_todo
+    run_specific
+  end
+
+end
+
+comment_for_reflog = lambda do |v|
+  case orig_reflog_action
+  when '', /^rebase/
+    ENV['GIT_REFLOG_ACTION'] = "rebase -i (#{v})"
+  end
+end
+
+def is_empty_commit(commit)
+  tree = `git rev-parse -q --verify "#{commit}"^{tree} 2> /dev/null`
+  die "#{commit}: not a commit that can be picked" unless $?.success?
+  ptree = `git rev-parse -q --verify "#{commit}"^^{tree} 2>/dev/null`
+  ptree = '4b825dc642cb6eb9a060e54bf8d69288fbee4904' unless $?.success?
+  return tree == ptree
+end
+
+def is_merge_commit(commit)
+  `git rev-parse --verify --quiet "#{commit}"^2 > /dev/null 2>&1`
+  return $?.success?
+end
+
+def has_action(file)
+  ! `git stripspace --strip-comments < "#{file}"`.empty?
+end
+
+die_abort = lambda do |msg|
+  FileUtils.rm_rf state_dir
+  die msg
+end
+
+def git_sequence_editor(args)
+  editor = ENV['GIT_SEQUENCE_EDITOR']
+  if not editor
+    editor = `git config sequence.editor`
+    if editor.empty?
+      editor = `git var GIT_EDITOR`
+      return false unless $?.success?
+    end
+  end
+
+  ENV['GIT_SEQUENCE_EDITOR'] = editor
+  system("#{editor} '#{args}'")
+  return $?.success?
+end
+
+mark_action_done = lambda do
+  system "sed -e 1q < '#{todo}' >> '#{done}'"
+  system "sed -e 1d < '#{todo}' >> '#{todo}'.new"
+  FileUtils.mv("#{todo}.new", todo, :force => true)
+  new_count = `git stripspace --strip-comments < '#{done}' | wc -l`.to_i
+  File.write(msgnum, new_count)
+  total = new_count + `git stripspace --strip-comments < '#{todo}' | wc -l`.to_i
+  File.write(msgend, total)
+  if last_count != new_count
+    last_count = new_count
+    puts "Rebasing (%d/%d)\r" % [new_count, total]
+    puts if $verbose
+  end
+end
+
+def commit_message(commit)
+  `git cat-file commit "#{commit}" | sed "1,/^$/d"`
+end
+
+def get_author_ident_from_commit(commit)
+  encoding = `git config i18n.commitencoding || echo UTF-8`
+  str = `git show -s --date=raw --format="GIT_AUTHOR_NAME=%an%nGIT_AUTHOR_EMAIL=%ae%nGIT_AUTHOR_DATE=%ad" --encoding="#{encoding}" "#{commit}" -- `
+  return str
+end
+
+make_patch = lambda do |commit|
+  sha1_and_parents = `git rev-list --parents -1 #{commit}`
+  patch = nil
+  case sha1_and_parents
+  when /.+ .+ .+/
+    patch = `git diff --cc #{sha1_and_parents}`
+  when /.+ .+/
+    patch = `git diff-tree -p '#{commit}^!'`
+  else
+    patch = 'Root commit'
+  end
+  File.write(File.join(state_dir, 'patch'), patch + "\n")
+  File.exists?(msg) or File.write(msg, commit_message(commit))
+  File.exists?(author_script) or File.write(author_script, get_author_ident_from_commit(commit))
+end
+
+die_with_patch = lambda do |commit, msg|
+  File.write(File.join(state_dir, 'stopped-sha'), commit)
+  make_patch.call commit
+  system 'git rerere'
+  die msg
+end
+
+exit_with_patch = lambda do |commit, ret|
+  File.write(File.join(state_dir, 'stopped-sha'), commit)
+  make_patch.call commit
+  File.write(amend, `git rev-parse --verify HEAD`)
+  warn "You can amend the commit now, with"
+  warn
+  warn "	git commit --amend"
+  warn
+  warn "Once you are satisfied with your changes, run"
+  warn
+  warn "	git rebase --continue"
+  warn
+  exit ret
+end
+
+pick_one_preserving_merges = lambda do |a1, a2|
+  fast_forward = true
+  case a1
+  when '-n'
+    fast_forward = false
+    sha1 = a2
+  else
+    sha1 = a1
+  end
+  sha1 = `git rev-parse #{sha1}`
+
+  if File.exists?(File.join(state_dir, 'current-commit'))
+    if fast_forward
+      File.open(File.join(state_dir, 'current-commit')) do |f|
+        f.each_line do |current_commit|
+          current_commit.chomp!
+          File.write(File.join(rewritten, current_commit), `git rev-parse HEAD`)
+        end
+      end
+      begin
+        FileUtils.rm(File.join(state_dir, 'current-commit'))
+      rescue
+        die "Cannot write current commit's replacement sha1"
+      end
+    end
+  end
+
+  File.write(File.join(state_dir, 'current-commit'), sha1 + "\n", :open_args => ['a'])
+
+  # rewrite parents; if none were rewritten, we can fast-forward.
+  new_parents = ''
+  pend = `git rev-list --parents -1 #{sha1} | cut -d' ' -s -f2-`.chomp.split
+  if pend.empty?
+    pend = ['root']
+  end
+
+  while not pend.empty?
+    parent = pend.shift
+
+    if File.exists?(File.join(rewritten, parent))
+      new_p = File.read(File.join(rewritten, parent)).chomp
+
+      # If the todo reordered commits, and our parent is marked for
+      # rewriting, but hasn't been gotten to yet, assume the user meant to
+      # drop it on top of the current HEAD
+      if new_p.empty?
+        new_p = `git rev-parse HEAD`
+      end
+
+      parent != new_p and fast_forward = false
+
+      case new_parents
+      when /#{new_p}/
+        # do nothing; that parent is already there
+      else
+        new_parents += ' ' + new_p
+      end
+    else
+      if File.exists?(File.join(dropped, parent))
+        fast_forward = false
+        replacement = File.read(File.join(dropped, parent)).chomp
+        replacement = 'root' if replacement.empty?
+        pend.unshift(replacement)
+      else
+        new_parents += ' ' + parent
+      end
+    end
+  end
+
+  if fast_forward
+    warn "Fast-forward to #{sha1}" if $verbose
+    output "git reset --hard #{sha1}"
+    die "Cannot fast-forward to #{sha1}" unless $?.success?
+  else
+    first_parent = `expr "#{new_parents}" : ' \\([^ ]*\\)'`
+
+    if a1 != '-n'
+      # detach HEAD to current parent
+      output "git checkout #{first_parent} 2> /dev/null"
+      die "Cannot move HEAD to #{first_parent}" unless $?.success?
+    end
+
+    case new_parents
+    when / .+ .+/
+      a1 == '-n' and die "Refusing to squash a merge: #{sha1}"
+
+      # redo merge
+      author_script_content = get_author_ident_from_commit(sha1)
+      msg_content = commit_message(sha1)
+
+      # No point in merging the first parent, that's HEAD
+      new_parents.gsub!(/^ #{first_parent}/, '')
+      do_with_author(author_script_content, "git merge --no-ff #{strategy ? "-s #{strategy}" : ''} -m \"#{msg_content}\" #{new_parents}", :out => true)
+      if not $?.success?
+        File.write(File.join($GIT_DIR, 'MERGE_MSG'), msg_content)
+        die_with_patch.call sha1, "Error redoing merge #{sha1}"
+      end
+      File.write(rewritten_list, sha1 + ' ' + `git rev-parse HEAD^0` + "\n", :open_args => ['a'])
+    else
+      if a2
+        args = "#{a1} #{a2}"
+      else
+        args = a1
+      end
+
+      output "git -c notes.rewrite.cherry-pick=false cherry-pick #{args}"
+      die_with_patch.call sha1, "Could not pick #{sha1}" unless $?.success?
+    end
+  end
+
+  return true
+end
+
+pick_one = lambda do |v, v2 = nil|
+  ff = '--ff'
+
+  case v
+  when '-n'
+    sha1 = v2
+    ff = nil
+  else
+    sha1 = v
+  end
+
+  if force_rebase
+    ff = nil
+  end
+
+  output "git rev-parse --verify #{sha1}"
+  die "Invalid commit name: #{sha1}" unless $?.success?
+
+  if is_empty_commit(sha1)
+    empty_args = "--allow-empty"
+  end
+
+  if v2
+    args = "#{v} #{v2}"
+  else
+    args = v
+  end
+
+  File.directory?(rewritten) and return pick_one_preserving_merges.call(v, v2)
+  output "git -c notes.rewrite.cherry-pick=false cherry-pick #{empty_args} #{ff} #{args}"
+  return $?.success?
+end
+
+do_pick = lambda do |commit, rest|
+  if `git rev-parse HEAD` == squash_onto
+    # Set the correct commit message and author info on the
+    # sentinel root before cherry-picking the original changes
+    # without committing (-n).  Finally, update the sentinel again
+    # to include these changes.  If the cherry-pick results in a
+    # conflict, this means our behaviour is similar to a standard
+    # failed cherry-pick during rebase, with a dirty index to
+    # resolve before manually running git commit --amend then git
+    # rebase --continue.
+    system "git commit --allow-empty --allow-empty-message --amend --no-post-rewrite -n -q -C #{commit}" and
+    pick_one.call('-n', commit) and
+    system "git commit --allow-empty --allow-empty-message --amend --no-post-rewrite -n -q -C #{commit}" or
+    die_with_patch.call commit, "Could not apply #{commit}... #{rest}"
+  else
+    if not pick_one.call(commit)
+      die_with_patch.call commit, "Could not apply #{commit}... #{rest}"
+    end
+  end
+end
+
+flush_rewritten_pending = lambda do
+  return unless File.exists?(rewritten_pending) and File.size(rewritten_pending) > 0
+  newsha1 = `git rev-parse HEAD^0`
+  system "sed 's/$/ #{newsha1}/' < '#{rewritten_pending}' >> '#{rewritten_list}'"
+  FileUtils.rm_f rewritten_pending
+end
+
+peek_next_command = lambda do
+  `git stripspace --strip-comments < '#{todo}' | sed -n -e 's/ .*//p' -e q`
+end
+
+record_in_rewritten = lambda do |commit|
+  oldsha1 = `git rev-parse #{commit}`
+  File.write(rewritten_pending, oldsha1 + "\n", :open_args => ['a'])
+
+  case peek_next_command.call
+  when 'squash', 's', 'fixup', 'f'
+    # nothn
+  else
+    flush_rewritten_pending.call
+  end
+end
+
+def do_with_author(author_script_content, cmd, out = false)
+  env = ENV.to_h
+  author_script_content.each_line do |line|
+    key, value = line.chomp.split('=')
+    env[key] = value
+  end
+  if out
+    output(env, cmd)
+  else
+    system(env, cmd)
+  end
+end
+
+def nth_string(v)
+  case v.to_s
+  when /(1[0-9]|[04-9])$/
+    return "#{v}th"
+  when /1$/
+    return "#{v}st"
+  when /2$/
+    return "#{v}nd"
+  when /3$/
+    return "#{v}rd"
+  end
+end
+
+die_failed_squash = lambda do |commit, rest|
+  FileUtils.mv(squash_msg, msg)
+  FileUtils.rm_f(fixup_msg)
+  FileUtils.copy(msg, File.join($GIT_DIR, 'MERGE_MSG'))
+  warn
+  warn "Could not apply #{commit}... #{rest}"
+  die_with_patch.call commit, ''
+end
+
+update_squash_messages = lambda do |style, commit|
+  if File.exists?(squash_msg)
+    FileUtils.move squash_msg, "#{squash_msg}.bak"
+    count = `sed -n -e "1s/^. This is a combination of \\(.*\\) commits\./\\1/p" -e "q" < "#{squash_msg}".bak`.to_i + 1
+    File.open(squash_msg, 'w') do |f|
+      f.puts "#{comment_char} This is a combination of #{count} commits."
+      f.puts `sed -e 1d -e '2,/^./{ /^$/d }' < '#{squash_msg}.bak'`
+    end
+  else
+    begin
+      File.write(fixup_msg, commit_message('HEAD'))
+    rescue
+      die "Cannot write #{fixup_msg}"
+    end
+    count = 2
+    File.open(squash_msg, 'w') do |f|
+      f.puts "#{comment_char} This is a combination of #{count} commits."
+      f.puts "#{comment_char} The first commit's message is:"
+      f.puts
+      f.write File.read(fixup_msg)
+    end
+  end
+
+  case style
+  when 'squash'
+    FileUtils.rm_f fixup_msg
+    File.open(squash_msg, 'a') do |f|
+      f.puts
+      f.puts "#{comment_char} This is the #{nth_string count} commit message:"
+      f.puts
+      f.write commit_message(commit)
+    end
+  when 'fixup'
+    File.open(squash_msg, 'a') do |f|
+      f.puts
+      f.puts "#{comment_char} The #{nth_string count} commit message will be skipped:"
+      f.puts
+      # Change the space after the comment character to TAB:
+      f.write `git cat-file commit "#{commit}" | sed "1,/^$/d" | git stripspace --comment-lines | sed -e 's/ /	/'`
+    end
+  end
+end
+
+do_next = lambda do
+  begin
+    FileUtils.rm_f([msg, author_script, amend])
+  rescue
+    exit
+  end
+
+  command = sha1 = rest = nil
+
+  File.open(todo) do |f|
+    begin
+      line = f.readline.chomp
+      command, sha1, rest = line.split(' ', 3)
+    rescue EOFError
+      command = nil
+    end
+  end
+
+  case command
+  when /^#{Regexp.escape(comment_char)}/, '', nil, 'noop'
+    mark_action_done.call
+  when 'pick', 'p'
+    comment_for_reflog.call 'pick'
+    mark_action_done.call
+    do_pick.call sha1, rest
+    record_in_rewritten.call sha1
+  when 'x', 'exec'
+    File.open(todo) do |f|
+      command, rest = f.readline.chomp.split(' ', 2)
+    end
+    mark_action_done.call
+    puts "Executing: #{rest}"
+
+    # "exec" command doesn't take a sha1 in the todo-list.
+    # => can't just use $sha1 here.
+    system "git rev-parse --verify HEAD > '#{state_dir}'/stopped-sha"
+
+    cmd = []
+    shell = ENV['SHELL']
+    shell = '/bin/sh' if not shell or shell.empty?
+    cmd << shell
+    cmd << '-c'
+    cmd << rest
+    system(*cmd) # Actual execution
+
+    status = $?.exitstatus
+    # Run in subshell because require_clean_work_tree can die.
+
+    dirty = !require_clean_work_tree(quiet: true)
+
+    if status != 0
+      warn "Execution failed: #{rest}"
+      warn "and made changes to the index and/or the working tree" if dirty
+
+      warn "You can fix the problem, and then run"
+      warn
+      warn "	git rebase --continue"
+      warn
+      if status == 127 # command not found
+        status = 1
+      end
+      exit status
+    elsif dirty
+      warn "Execution succeeded: $rest"
+      warn "but left changes to the index and/or the working tree"
+      warn "Commit or stash your changes, and then run"
+      warn
+      warn "	git rebase --continue"
+      warn
+      exit 1
+    end
+  when 'squash', 's', 'fixup', 'f'
+    case command
+    when 'squash', 's'
+      squash_style = 'squash'
+    when 'fixup', 'f'
+      squash_style = 'fixup'
+    end
+
+    comment_for_reflog.call squash_style
+
+    File.exists?(done) and has_action(done) or
+      die "Cannot '#{squash_style}' without a previous commit"
+
+    mark_action_done.call
+
+    update_squash_messages.call squash_style, sha1
+
+    author_script_content = get_author_ident_from_commit('HEAD')
+    File.write(author_script, author_script_content)
+    if not pick_one.call '-n', sha1
+      system "git rev-parse --verify HEAD > '#{amend}'"
+      die_failed_squash.call sha1, rest
+    end
+
+    case peek_next_command.call
+    when 'squash', 's', 'fixup', 'f'
+      # This is an intermediate commit; its message will only be
+      # used in case of trouble.  So use the long version:
+      do_with_author(author_script_content, "git commit --amend --no-verify -F '#{squash_msg}'", :out => true)
+      die_failed_squash.call sha1, rest unless $?.success?
+    else
+      # This is the final command of this squash/fixup group
+      if File.exists?(fixup_msg)
+        do_with_author author_script_content, "git commit --amend --no-verify -F '#{fixup_msg}'"
+        die_failed_squash.call sha1, rest unless $?.success?
+      else
+        FileUtils.copy(squash_msg, File.join($GIT_DIR, 'SQUASH_MSG'))
+        FileUtils.rm_f(File.join($GIT_DIR, 'MERGE_MSG'))
+        do_with_author author_script_content, "git commit --amend --no-verify -F '#{$GIT_DIR}'/SQUASH_MSG -e"
+        die_failed_squash.call sha1, rest unless $?.success?
+      end
+      FileUtils.rm_f([squash_msg, fixup_msg])
+    end
+    record_in_rewritten.call sha1
+  when 'edit', 'e'
+    comment_for_reflog.call 'edit'
+
+    mark_action_done.call
+    do_pick.call sha1, rest
+    warn "Stopped at #{sha1}... #{rest}"
+    exit_with_patch.call sha1, 0
+  when 'reword', 'r'
+    comment_for_reflog.call 'reword'
+
+    mark_action_done.call
+    do_pick.call sha1, rest
+    if ! system "git commit --amend --no-post-rewrite"
+      warn "Could not amend commit after successfully picking #{sha1}... #{rest}"
+      warn "This is most likely due to an empty commit message, or the pre-commit hook"
+      warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
+      warn "you are able to reword the commit."
+      exit_with_patch.call sha1, 1
+    end
+    record_in_rewritten.call sha1
+  else
+    warn "Unknown command: #{command} #{sha1} #{rest}"
+    fixtodo = "Please fix this using 'git rebase --edit-todo'."
+    if system "git rev-parse --verify -q '#{sha1}' >/dev/null"
+      die_with_patch.call sha1, fixtodo
+    else
+      die fixtodo
+    end
+  end
+
+  if File.exists?(todo) and File.size(todo) > 0
+    return false
+  end
+
+  comment_for_reflog.call 'finish'
+
+  newhead = `git rev-parse HEAD`
+  case head_name
+  when /^refs\//
+    message = "#{ENV['GIT_REFLOG_ACTION']}: #{head_name} onto #{onto}"
+    system "git update-ref -m '#{message}' #{head_name} #{newhead} #{orig_head}" and
+    system "git symbolic-ref -m '#{ENV['GIT_REFLOG_ACTION']}: returning to #{head_name}' HEAD #{head_name}"
+  end
+
+  if File.exists?(File.join(state_dir, 'verbose'))
+    system "git diff-tree --stat #{orig_head}..HEAD"
+  end
+  if File.exists?(rewritten_list) and File.size(rewritten_list) > 0
+    system "git notes copy --for-rewrite=rebase < '#{rewritten_list}'"
+    if File.executable?(File.join($GIT_DIR, 'hooks', 'post-rewrite'))
+      system("'#{File.join($GIT_DIR, 'hooks', 'post-rewrite')}' rebase < '#{rewritten_list}'")
+    end
+  end
+
+  $stderr.puts "Successfully rebased and updated #{head_name}."
+
+  return true
+end
+
+do_rest = lambda do
+  while true
+    do_next.call && break
+  end
+end
+
+append_todo_help = lambda do
+  IO.popen('git stripspace --comment-lines', 'r+') do |p|
+    p.write <<EOF
+
+Commands:
+ p, pick = use commit
+ r, reword = use commit, but edit the commit message
+ e, edit = use commit, but stop for amending
+ s, squash = use commit, but meld into previous commit
+ f, fixup = like "squash", but discard this commit's log message
+ x, exec = run command (the rest of the line) using shell
+
+These lines can be re-ordered; they are executed from top to bottom.
+
+If you remove a line here THAT COMMIT WILL BE LOST.
+EOF
+    p.close_write
+    File.write(todo, p.read, :open_args => ['a'])
+  end
+end
+
+skip_unnecessary_picks = lambda do
+  fd = 3
+  new_file = File.open("#{todo}.new", 'w')
+  done_file = File.open(done, 'a')
+  file = done_file
+
+  File.open(todo) do |f|
+    f.each_line do |line|
+      command, rest = line.chomp.split(' ', 2)
+      case "#{fd},#{command}"
+      when '3,pick', '3,p'
+        # pick a commit whose parent is current $onto -> skip
+        commit = rest.gsub(/ .*$/, '')
+        case `git rev-parse --verify --quiet '#{commit}^'`
+        when /^#{onto}/
+          onto = commit
+        else
+          fd = 1
+          file = new_file
+        end
+      when /^3,#/, '3,'
+        # copy comments
+      else
+        fd = 1
+        file = new_file
+      end
+      file.puts "#{command}#{rest ? ' ' + rest : ''}"
+    end
+  end
+  new_file.close
+  done_file.close
+  FileUtils.mv("#{todo}.new", todo, :force => true)
+  case peek_next_command.call
+  when 'squash', 's', 'fixup', 'f'
+    record_in_rewritten.call onto
+  end
+  # TODO die "Could not skip unnecessary pick commands"
+end
+
+def add_exec_commands(todo, cmds)
+  cmd = cmds.map { |e| 'exec %s' % e }.join("\n")
+  new = File.open("#{todo}.new", 'w')
+  File.open(todo) do |f|
+    first = true
+    f.each_line do |line|
+      insn, rest = line.chomp.split(' ', 2)
+      case insn
+      when 'pick'
+        new.puts cmd unless first
+      end
+      new.puts "#{insn} #{rest}"
+      first = false
+    end
+    new.puts cmd
+  end
+  new.close
+  FileUtils.mv("#{todo}.new", todo)
+end
+
+rearrange_squash = lambda do |todo|
+
+  # extract fixup!/squash! lines and resolve any referenced sha1's
+  new = File.open("#{todo}.sq", 'w')
+  File.open(todo) do |f|
+    f.each_line do |line|
+      pick, sha1, message = line.chomp.split(' ', 3)
+      case message
+      when /^(squash)! (.*)$/, /^(fixup)! (.*)$/
+        action = $1
+        rest = $2
+        new.puts "#{sha1} #{action} #{rest}"
+        # if it's a single word, try to resolve to a full sha1 and
+        # emit a second copy. This allows us to match on both message
+        # and on sha1 prefix
+        if rest =~ /^\w+$/
+          fullsha = `git rev-parse -q --verify '#{rest}' 2>/dev/null`
+          if not fullsha.empty?
+            # prefix the action to uniquely identify this line as
+            # intended for full sha1 match
+            new.puts "#{sha1} +#{action} #{fullsha}"
+          end
+        end
+      end
+    end
+  end
+  new.close
+
+  return if not File.exists?("#{todo}.sq") or File.size("#{todo}.sq") == 0
+
+  used = ''
+
+  new = File.open("#{todo}.rearranged", 'w')
+  File.open(todo) do |f|
+    f.each_line do |line|
+      pick, sha1, message = line.chomp.split(' ', 3)
+      case used
+      when / #{sha1} /
+        next
+      end
+      new.puts "#{pick} #{sha1} #{message}"
+      used += sha1 + ' '
+      File.open("#{todo}.sq") do |f|
+        f.each_line do |line|
+          squash, action, msg_content = line.chomp.split(' ', 3)
+          case used
+          when / #{squash} /
+            next
+          end
+          emit = false
+          case action
+          when /^\+(.*)$/
+            action = $1
+            emit = true if msg_content =~ /^#{sha1}/
+          else
+            emit = true if message =~ /^#{Regexp.escape(msg_content)}/
+          end
+          if emit
+            new.puts "#{action} #{squash} #{action}! #{msg_content}"
+            used += squash + ' '
+          end
+        end
+      end
+    end
+  end
+  new.close
+
+  FileUtils.mv("#{todo}.rearranged", todo)
+  FileUtils.rm_f("#{todo}.sq")
+end
+
+run_rebase_interactive = lambda do
+  rewritten = File.join(state_dir, 'rewritten')
+  todo = File.join(state_dir, 'git-rebase-todo')
+  done = File.join(state_dir, 'done')
+  dropped = File.join(state_dir, 'dropped')
+
+  msg = File.join(state_dir, 'message')
+  author_script = File.join(state_dir, 'author-script')
+  amend = File.join(state_dir, 'amend')
+  rewritten_list = File.join(state_dir, 'rewritten-list')
+  rewritten_pending = File.join(state_dir, 'rewritten-pending')
+
+  squash_msg = File.join(state_dir, 'message-squash')
+  fixup_msg = File.join(state_dir, 'message-fixup')
+
+  msgnum = File.join(state_dir, 'msgnum')
+  msgend = File.join(state_dir, 'end')
+
+  ENV['GIT_CHERRY_PICK_HELP'] = $resolvemsg
+
+  orig_reflog_action = ENV['GIT_REFLOG_ACTION']
+  comment_char = `git config --get core.commentchar 2>/dev/null | cut -c1`
+  comment_char = '#' if comment_char.empty?
+
+  case action
+  when :continue
+    # do we have anything to commit?
+    if system 'git diff-index --cached --quiet HEAD --'
+      # Nothing to commit -- skip this
+    else
+      if not File.exists?(author_script)
+        die "You have staged changes in your working tree. If these changes are meant to be
+  squashed into the previous commit, run:
+
+    git commit --amend
+
+  If they are meant to go into a new commit, run:
+
+    git commit
+
+  In both case, once you're done, continue with:
+
+    git rebase --continue
+  "
+      end
+      begin
+        author_script_content = File.read(author_script)
+      rescue
+        die "Error trying to find the author identity to amend commit"
+      end
+      if File.exists?(amend)
+        current_head = `git rev-parse --verify HEAD`
+        if current_head != File.read(amend).chomp
+          die "\
+  You have uncommitted changes in your working tree. Please, commit them
+  first and then run 'git rebase --continue' again."
+        end
+        do_with_author author_script_content, "git commit --amend --no-verify -F '#{msg}' -e"
+        die "Could not commit staged changes." unless $?.success?
+      else
+        do_with_author author_script_content, "git commit --no-verify -F '#{msg}' -e"
+        die "Could not commit staged changes." unless $?.success?
+      end
+    end
+
+    record_in_rewritten.call File.read(File.join(state_dir, 'stopped-sha'))
+
+    require_clean_work_tree('rebase')
+    do_rest.call
+    return 0
+  when :edit_todo
+    system "git stripspace --strip-comments < '#{todo}' > '#{todo}.new'"
+    FileUtils.mv("#{todo}.new", todo, :force => true)
+    append_todo_help.call
+    IO.popen('git stripspace --comment-lines', 'r+') do |p|
+      p.write <<EOF
+
+You are editing the todo file of an ongoing interactive rebase.
+To continue rebase after editing, run:
+    git rebase --continue
+
+EOF
+      p.close_write
+      File.write(todo, p.read, :open_args => ['a'])
+    end
+
+    if not git_sequence_editor(todo)
+      die_abort.call "Could not execute editor"
+    end
+    exit
+  when :skip
+    system 'git rerere clear'
+    do_rest.call
+    return 0
+  end
+
+  system 'git var GIT_COMMITTER_IDENT > /dev/null'
+  die "You need to set your committer info first" unless $?.success?
+
+  comment_for_reflog.call 'start'
+
+  if switch_to
+    output "git checkout #{switch_to} --"
+    die "Could not checkout #{switch_to}" unless $?.success?
+  end
+
+  orig_head = `git rev-parse --verify HEAD`
+  die 'No HEAD?' unless $?.success?
+  begin
+    FileUtils.mkdir_p state_dir
+  rescue
+    die "Could not create temporary #{state_dir}"
+  end
+
+  begin
+    File.write(File.join(state_dir, 'interactive'), 'true')
+  rescue
+    die "Could not mark as interactive"
+  end
+
+  $rebase.store
+
+  if preserve_merges
+    if not rebase_root
+      FileUtils.mkdir rewritten
+      `git merge-base --all #{orig_head} #{upstream}`.each_line do |c|
+        c.chomp!
+        begin
+          File.write(File.join(rewritten, c), onto)
+        rescue
+          die "Could not init rewritten commits"
+        end
+      end
+    else
+      FileUtils.mkdir rewritten
+      begin
+        File.write(File.join(rewritten, 'root'), onto)
+      rescue
+        die "Could not init rewritten commits"
+      end
+    end
+    merges_option = nil
+  else
+    merges_option = '--no-merges --cherry-pick'
+  end
+
+  shorthead = `git rev-parse --short #{orig_head}`
+  shortonto = `git rev-parse --short #{onto}`
+  if not rebase_root
+    shortupstream = `git rev-parse --short #{upstream}`
+    revisions = "#{upstream}...#{orig_head}"
+    shortrevisions = "#{shortupstream}..#{shorthead}"
+  else
+    revisions = "#{onto}...#{orig_head}"
+    shortrevisions = shorthead
+  end
+
+  `git rev-list #{merges_option} --pretty=oneline --abbrev-commit --abbrev=7 --reverse --left-right --topo-order #{revisions} | sed -n "s/^>//p"`.each_line do |line|
+    shortsha1, rest = line.chomp.split(' ', 2)
+
+    if not keep_empty and is_empty_commit(shortsha1) and ! is_merge_commit(shortsha1)
+      comment_out = "#{comment_char} "
+    else
+      comment_out = nil
+    end
+
+    if not preserve_merges
+      File.open(todo, 'a') do |f|
+        f.puts "#{comment_out}pick #{shortsha1} #{rest}"
+      end
+    else
+      sha1 = `git rev-parse #{shortsha1}`
+      if not rebase_root
+        preserve = true
+        `git rev-list --parents -1 #{sha1} | cut -d' ' -s -f2-`.each_line do |line|
+          line.chomp.split.each do |p|
+            if File.exists?(File.join(rewritten, p))
+              preserve = false
+            end
+          end
+        end
+      else
+        preserve = false
+      end
+      if not preserve
+        File.write(File.join(rewritten, sha1), '') # touch
+        File.open(todo, 'a') do |f|
+          f.puts "#{comment_out}pick #{shortsha1} #{rest}"
+        end
+      end
+    end
+
+  end
+
+  # Watch for commits that been dropped by --cherry-pick
+  if preserve_merges
+    FileUtils.mkdir dropped
+    # Save all non-cherry-picked changes
+    system "git rev-list #{revisions} --left-right --cherry-pick | sed -n 's/^>//p' > '#{state_dir}'/not-cherry-picks"
+    # Now all commits and note which ones are missing in
+    # not-cherry-picks and hence being dropped
+    `git rev-list #{revisions}`.each_line do |rev|
+      rev.chomp!
+      if File.exists?(File.join(rewritten, rev)) and `grep #{rev} '#{state_dir}'/not-cherry-picks` == ''
+        # Use -f2 because if rev-list is telling us this commit is
+        # not worthwhile, we don't want to track its multiple heads,
+        # just the history of its first-parent for others that will
+        # be rebasing on top of it
+        system "git rev-list --parents -1 #{rev} | cut -d' ' -s -f2 > '#{dropped}'/#{rev}"
+        short = `git rev-list -1 --abbrev-commit --abbrev=7 #{rev}`
+        system "grep -v '^[a-z][a-z]* #{short}' < '#{todo}' > '#{todo}2'"
+        FileUtils.mv("#{todo}2", todo)
+        File.delete(File.join(rewritten, rev))
+      end
+    end
+  end
+
+  File.exists?(todo) and File.size(todo) > 0 or File.write(todo, 'noop')
+  $opts[:autosquash] and rearrange_squash.call(todo)
+  not cmds.empty? and add_exec_commands(todo, cmds)
+
+  File.write(todo, <<EOF, :open_args => ['a'])
+
+#{comment_char} Rebase #{shortrevisions} onto #{shortonto}
+EOF
+
+   append_todo_help.call
+   IO.popen('git stripspace --comment-lines', 'r+') do |p|
+     p.write <<EOF
+
+However, if you remove everything, the rebase will be aborted.
+
+EOF
+     p.close_write
+     File.write(todo, p.read, :open_args => ['a'])
+   end
+
+   if not keep_empty
+     File.open(todo, 'a') do |f|
+       f.puts "#{comment_char} Note that empty commits are commented out"
+     end
+   end
+
+  die_abort.call "Nothing to do" unless has_action(todo)
+
+  FileUtils.copy(todo, "#{todo}.backup")
+  if not git_sequence_editor(todo)
+    die_abort.call "Could not execute editor"
+  end
+
+  die_abort.call "Nothing to do" unless has_action(todo)
+
+  File.directory?(rewritten) or force_rebase or skip_unnecessary_picks.call
+
+  output "git checkout #{onto}"
+  die_abort.call "could not detach HEAD" unless $?.success?
+  system "git update-ref ORIG_HEAD #{orig_head}"
+  do_rest.call
+  return 0
+end
+
+def output(*args)
+  if args.first.kind_of?(Hash)
+    env = args.shift
+  else
+    env = ENV
+  end
+
+  if not $verbose
+    out = nil
+    IO.popen(env, *args, :err=>[:child, :out]) do |p|
+      out = p.read
+    end
+    print out unless $?.success?
+  else
+    system(env, *args)
+  end
+end
+
+def error_on_missing_default_upstream(cmd, op_type, op_prep, example)
+  branch_name = `git symbolic-ref -q HEAD`
+
+  # If there's only one remote, use that in the suggestion
+  remotes = `git remote`.split("\n")
+  remote = remotes.size == 1 ? remotes.first : '<remote>'
+
+  if branch_name.empty?
+    puts <<-EOF
+You are not currently on a branch. Please specify which
+branch you want to #{op_type} #{op_prep}. See git-#{cmd}(1) for details.
+
+    #{example}
+
+    EOF
+  else
+    puts <<-EOF
+There is no tracking information for the current branch.
+Please specify which branch you want to #{op_type} #{op_prep}.
+See git-#{cmd}(1) for details
+
+    #{example}
+
+If you wish to set tracking information for this branch you can do so with:
+
+    git branch --set-upstream-to=#{remote}/<branch> #{branch_name.gsub('^refs/heads/', '')}
+
+    EOF
+  end
+  exit 1
+end
+
+def require_clean_work_tree(action = nil, msg = nil, quiet: false)
+  begin
+    run %w[git rev-parse --verify HEAD], out: File::NULL
+  rescue
+    exit 1
+  end
+
+  run %w[git update-index -q --ignore-submodules --refresh]
+  errors = []
+
+  begin
+    run %w[git diff-files --quiet --ignore-submodules]
+  rescue
+    errors << "Cannot #{action}: You have unstaged changes."
+  end
+
+  begin
+    run %w[git diff-index --cached --quiet --ignore-submodules HEAD --]
+  rescue CommandError
+    if errors.empty?
+      errors << "Cannot #{action}: Your index contains uncommitted changes."
+    else
+      errors << "Additionally, your index contains uncommitted changes."
+    end
+  end
+
+  if not errors.empty? and not quiet
+    errors.each do |e|
+      $stderr.puts(e)
+    end
+    $stderr.puts(msg) if msg
+    exit 1
+  end
+
+  return errors.empty?
+end
+
+################################################################################
+
+action_args = [ '--skip', '--abort', '--continue', '--edit-todo' ]
+
+# these options are exclusive
+ARGV.each do |e|
+  if action_args.include?(e) and ARGV.size > 1
+    puts optparser
+    exit 1
+  end
+end
+
+begin
+  optparser.parse!
+rescue OptionParser::InvalidOption, OptionParser::MissingArgument
+  $stderr.puts $!.to_s
+  $stderr.puts optparser
+  exit 1
+end
+
+if $opts.has_key?(:verbose)
+  v = $opts[:verbose]
+  $verbose = v
+  $opts[:diffstat] = v
+  $GIT_QUIET = !v
+end
+
+$opts[:force_rebase] = force_rebase
+
+if (ARGV.size > 2) or (rebase_root and ARGV.size > 1)
+  puts optparser
+  exit 1
+end
+
+if not cmds.empty? and interactive_rebase != :explicit
+  die 'The --exec option must be used with the --interactive option'
+end
+
+$resolvemsg = <<EOF
+When you have resolved this problem, run "git rebase --continue".
+If you prefer to skip this patch, run "git rebase --skip" instead.
+To check out the original branch and stop rebasing, run "git rebase --abort".
+
+EOF
+
+if test('d', $apply_dir)
+  type = :am
+  state_dir = $apply_dir
+elsif test('d', $merge_dir)
+  if test('e', [$merge_dir, 'interactive'].to_f)
+    type = :interactive
+    interactive_rebase = :explicit
+  else
+    type = :cherrypick
+  end
+  state_dir = $merge_dir
+end
+
+$in_progress = !!type
+
+type ||= $opts[:type] || ($opts[:am].empty? ? :cherrypick : :am)
+# type ||= $opts[:type] || (keep_empty ? :cherrypick : :am)
+
+case type
+when :am
+  $rebase = AmRebase.new
+when :cherrypick
+  $rebase = CherryPickRebase.new
+when :interactive
+  $rebase = InteractiveRebase.new
+end
+
+state_dir = $rebase.state_dir
+$rebase.bind(binding)
+
+exit $rebase.do(action)
-- 
1.8.3.698.g079b096
