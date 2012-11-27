From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 07:29:05 +0100
Message-ID: <CAMP44s3=VpMv-S2eV9rXRaH9U3SvaR8B6Dto=vAmVQ_XB1uBXg@mail.gmail.com>
References: <20121115212818.GA21558@thyrsus.com>
	<CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
	<20121126220108.GB1713@thyrsus.com>
	<CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
	<20121126234359.GA8042@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Nov 27 07:29:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdEfb-0003bA-Bw
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 07:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab2K0G3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 01:29:08 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42652 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab2K0G3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 01:29:06 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so10651851obb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 22:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uBX4q7doZ8RVo436ji/JFrjI3WvBAqeamadnd+qP7jI=;
        b=Hd8xfE+K9016D5kF15ectLTPnerH3RbEew6B3VfxO1gIjCyKEbbN5CzRufdQt7LT1K
         gGYfD22R88jo8pnOJamIUIBvEWG4qt55kqt+xKjZBb9yqujEAPCH+yH9fGKqUr/fiUQY
         Rmn5dwyGh4JRLTqpumSkRUDNr/CkDlceRMoRucl7dJXDgpQ8D0FtHYxCaDn+YpG00Tze
         s0wmg7CNk8Ux3KBns6kIqWYcirNb9fy2l2nembXMU05dPv++NRNw0Eymlfmh1teFipO+
         5CDgjV18yR3vry08DGftX7almGzG9dfqSrY03C8RMN5JVxx5zbJNzIZFGTaUjILLmVtD
         ayVQ==
Received: by 10.60.31.6 with SMTP id w6mr11437552oeh.65.1353997745649; Mon, 26
 Nov 2012 22:29:05 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 22:29:05 -0800 (PST)
In-Reply-To: <20121126234359.GA8042@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210535>

On Tue, Nov 27, 2012 at 12:43 AM, Eric S. Raymond <esr@thyrsus.com> wrote:

> -----------------------------------
> commit 1
> directory foo-1.1
>
> Release 1.1 of project foo
> .
> commit 2
> directory foo-1.2
>
> ..This is an example of a byte-stuffed line.
>
> Release 1.2 of project foo
> .
> commit 3
> directory foo-1.3
>
> Release 1.3 of project foo
> .
> -----------------------------------
>
> The main objective of the logfile design is to make hand-crafting
> these easy.

Here's another version with YAML:
---
-
  author: &me Felipe Contreras <felipe.contreras@gmail.com>
  date: 2011-1-1
  msg: one
- tag v0.1
-
  author: *me
  date: 2011-1-2
  msg: extra
-
  author: *me
  date: 2011-1-3
  msg: |
    with

    spaces
-
  author: *me
  date: 2011-1-4
  msg: |
    dot
    .
-
  author: *me
  date: 2011-1-5
  msg: remove
  ref: remove
- checkout devel
-
  author: *me
  date: 2011-1-6
  msg: dev
- checkout master
-
  author: *me
  date: 2011-1-7
  msg: bump
- tag v0.2
- checkout test remove
---

I believe that log file is much more human readable. Yet I still fail
to see why would anybody want so much detail only to import tarballs.

diff --git a/contrib/weave/git-weave b/contrib/weave/git-weave
new file mode 100755
index 0000000..646aeaa
--- /dev/null
+++ b/contrib/weave/git-weave
@@ -0,0 +1,234 @@
+#!/usr/bin/env ruby
+
+require 'optparse'
+require 'find'
+require 'fileutils'
+require 'yaml'
+
+$last = nil
+$branches = {}
+$branch = 'master'
+$refs = {}
+
+class Commit
+
+  attr_reader :id, :parents, :author, :committer, :date, :msg, :ref
+
+  @@num = 0
+
+  def initialize(args)
+    @id = @@num += 1
+    @parents = []
+    args.each do |key, value|
+      instance_variable_set("@#{key}", value)
+    end
+    if @author =~ /(.+ <.+>) (.+)/
+      @author = $1
+    end
+    if @committer =~ /(.+ <.+>) (.+)/
+      @committer = $1
+      @date = DateTime.strptime($2, '%s %z')
+    end
+    $refs[@ref] = @id if @ref
+  end
+
+end
+
+def export_commit(cmd, indir, out)
+
+  c = Commit.new(cmd)
+  $last = c.id
+
+  # commit
+  out.puts 'commit refs/heads/%s' % $branch
+  out.puts 'mark :%u' % c.id
+  if c.author and c.committer
+    out.puts 'author %s %s' % [c.author, c.date.strftime('%s %z')]
+    out.puts 'committer %s %s' % [c.committer, c.date.strftime('%s %z')]
+  else
+    out.puts 'committer %s %s' % [c.author, c.date.strftime('%s %z')]
+  end
+  out.puts 'data %u' % c.msg.bytesize
+  out.puts c.msg
+
+  # parents
+  c.parents.each_with_index do |p, i|
+    ref = $refs[p]
+    if i == 0
+      out.puts 'from :%u' % ref
+    else
+      out.puts 'merge :%u' % ref
+    end
+  end
+
+  # files
+  out.puts 'deleteall'
+  FileUtils.cd(File.join(indir, c.id.to_s)) do
+    Find.find('.') do |e|
+      next unless File.file?(e)
+      content = File.read(e)
+      filename = e.split(File::SEPARATOR).slice(1..-1).join(File::SEPARATOR)
+      if File.symlink?(e)
+        mode = '120000'
+        content = File.readlink(e)
+      else
+        mode = File.executable?(e) ? '100755' : '100644'
+      end
+      out.puts 'M %s inline %s' % [mode, filename]
+      out.puts 'data %u' % content.bytesize
+      out.puts content
+    end
+  end
+  out.puts
+
+end
+
+def do_reset(out, ref, from)
+  out.puts "reset %s" % ref
+  out.puts "from :%u" % from
+  out.puts
+end
+
+def export_reset(cmd, indir, out)
+  _, ref, from = cmd.split
+  do_reset(out, ref, from)
+end
+
+def export_checkout(cmd, indir, out)
+  _, $branch, from = cmd.split
+  from = ':%u' % $last if not $branches[$branch]
+  do_reset(out, 'refs/heads/%s' % $branch, from) if from
+  $branches[$branch] = true
+end
+
+def export_tag(cmd, indir, out)
+  _, tag = cmd.split
+  do_reset(out, 'refs/tags/%s' % tag, $last)
+end
+
+def export(indir = '.', out = STDOUT)
+
+  $branches['master'] = true
+
+  YAML.load_file(File.join(indir, 'log')).each do |e|
+    case e
+    when Hash
+      export_commit(e, indir, out)
+    when /^checkout /
+      export_checkout(e, indir, out)
+    when /^tag /
+      export_tag(e, indir, out)
+    when /^reset /
+      export_reset(e, indir, out)
+    end
+  end
+
+end
+
+def import(outdir, out)
+  format = 'format:commit %H%nauthor %an <%ae> %ad%ncommitter %cn
<%ce> %cd%nparents %P%n%n%B'
+  cmd = ['git', 'log', '-z', '-s', '--date=raw', '--format=%s' %
format, '--reverse', '--all']
+  commits = {}
+
+  cmds = []
+
+  IO.popen(cmd).each_with_index("\0") do |data, i|
+    @msg = nil
+    @parents = []
+    data.chomp("\0").each_line do |l|
+      if not @msg
+        case l
+        when /^commit (.+)$/
+          @id = $1
+        when /^author (.+)$/
+          @author = $1
+        when /^committer (.+)$/
+          @committer = $1
+        when /^parents (.+)$/
+          @parents = $1.split(" ")
+        when /^$/
+          @msg = ""
+        end
+      else
+        @msg << l
+      end
+    end
+
+    num = i + 1
+    commits[@id] = num
+
+    cmds << {
+      :author => @author,
+      :committer => @committer,
+      :msg => @msg,
+      :ref => num,
+      :parents => @parents.map { |e| commits[e] },
+    }
+
+    wd = File.join(outdir, num.to_s)
+    FileUtils.mkdir_p(wd)
+    system('git', '--work-tree', wd, 'checkout', '-f', '-q', @id)
+  end
+
+  IO.popen(['git', 'show-ref', '--tags', '--heads']).each do |e|
+    id, ref = e.chomp.split
+    cmds << 'reset %s %s' % [ref, commits[id]]
+  end
+
+  out.write(cmds.to_yaml)
+end
+
+def git_pack(indir, outdir)
+  indir = File.absolute_path(indir)
+  system('git', 'init', '--quiet', outdir)
+  FileUtils.cd(outdir) do
+    IO.popen(['git', 'fast-import', '--quiet'], 'w') do |io|
+      export(indir, io)
+    end
+    system('git', 'reset', '--quiet', '--hard')
+  end
+end
+
+def git_unpack(indir, outdir)
+  begin
+    FileUtils.mkdir_p(outdir)
+    log = File.open(File.join(outdir, 'log'), 'w')
+    ENV['GIT_DIR'] = File.join(indir, '.git')
+    oldref = %x[git symbolic-ref HEAD]
+    import(outdir, log)
+  ensure
+    system('git', 'symbolic-ref', 'HEAD', oldref) if oldref
+    ENV.delete('GIT_DIR')
+    log.close if log
+  end
+end
+
+$indir = '.'
+
+begin
+  OptionParser.new do |opts|
+    opts.on('-x') do
+      $mode = 'unpack'
+    end
+    opts.on('-c') do
+      $mode = 'pack'
+    end
+    opts.on('-o', '--outdir DIR') do |v|
+      $outdir = v
+    end
+    opts.on('-i', '--indir DIR') do |v|
+      $indir = v
+    end
+  end.parse!
+rescue OptionParser::InvalidOption
+end
+
+$mode = File.exists?(File.join($indir, '.git')) ? 'unpack' : 'pack'
unless $mode
+$outdir = File.join($indir, $mode == 'pack' ? 'packed' : 'unpacked2')
unless $outdir
+
+case $mode
+when 'pack'
+  git_pack($indir, $outdir)
+when 'unpack'
+  git_unpack($indir, $outdir)
+end

-- 
Felipe Contreras
