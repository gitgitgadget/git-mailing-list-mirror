From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: gitpacker progress report and a question
Date: Mon, 26 Nov 2012 21:07:07 +0100
Message-ID: <CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
References: <20121115212818.GA21558@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Nov 26 21:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td4xj-00010H-5V
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791Ab2KZUHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:07:10 -0500
Received: from mail-gg0-f174.google.com ([209.85.161.174]:44842 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab2KZUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:07:08 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so2067236ggd.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y6RJ3PcIybdpu6HUf2jec6xs+U1IeLorZwcBh1TQM94=;
        b=Xas32czrILyt+Qfet3RCB+az+0YUQ8Z2oCnF9bF0STj6XNttLeemGVnHbxWuwGn4Rg
         oyU3zopzuaJTqBmYq2EI+OW8t/IpTvSG9NqSsxMAfzyIXx73lHXGkUjATfY68mDLHiIe
         k6d8MnW2nQuLg60kfs8H2BxwU5YsjevE1/Ofib9errz8FDhW1wa9yVPP8QT9D9mMBpyC
         BDsikVc4AXTzFtDEj+TGkv4iCoppju6JH6r7yAI7gkufCON3QwK78zkYgjAG9tIXV3jm
         DPIv0p5ziCXlDc7e8wEZeAAeF1LW+F2YwbsMTeTz2/AWu1ES+P+XZHE9cErEN9SJnVe3
         5XCg==
Received: by 10.58.180.7 with SMTP id dk7mr21672517vec.30.1353960428172; Mon,
 26 Nov 2012 12:07:08 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Mon, 26 Nov 2012 12:07:07 -0800 (PST)
In-Reply-To: <20121115212818.GA21558@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210477>

On Thu, Nov 15, 2012 at 10:28 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Some days ago I reported that I was attempting to write a tool that could
> (a) take a git repo and unpack it into a tarball sequence plus a metadata log,
> (b) reverse that operation, packing a tarball and log sequence into a repo.
>
> Thanks in part to advice by Andreas Schwab and in part to looking at the
> text of the p4 import script, this effort has succeeded.  A proof of
> concept is enclosed.  It isn't documented yet, and has not been tested
> on a repository with branches or merges in the history, but I am confident
> that the distance from here to a finished and tested tool is short.
>
> The immediate intended use is for importing older projects that are
> available only as sequences of release tarballs, but there are other
> sorts of repository surgery that would become easier using it.
>
> I'm still looking for a better name for it and would welcome suggestions.
>
> Before I do much further work, I need to determine how this will be shipped.
> I see two possibilities: either I ship it as a small standalone project,
> or it becomes a git subcommand shipped with the git suite. How I document
> it and set up its tests would differ between these two cases.

Please look at Documentation/SubmittingPatches, you should send
patches in inline format, preferably with 'git format-patch -M', and
preferably with 'git send-email' (in which case you don't need
format-patch), otherwise people will have trouble reviewing, or miss
it completely (as it was the case for me).

I have many comments, but I'll wait until you send the patch inlined,
I'll just address these:

1) I tried it, and it doesn't seem to import (pack?) are repository
with sub-directories in it

2) Using 'git fast-import' is probably simpler, and more efficient

Here is a proof of concept I wrote in ruby that is half the size, and
seems to implement the same functionality. The format is exactly the
same, but I think it should be modified to be more efficient.

Cheers.

>From eb3c34699d7f5d4eec4f088344659b8d9b6a07ea Mon Sep 17 00:00:00 2001
From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Mon, 26 Nov 2012 20:48:38 +0100
Subject: [PATCH] Add new git-weave tool

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/weave/git-weave | 166 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100755 contrib/weave/git-weave

diff --git a/contrib/weave/git-weave b/contrib/weave/git-weave
new file mode 100755
index 0000000..3106121
--- /dev/null
+++ b/contrib/weave/git-weave
@@ -0,0 +1,166 @@
+#!/usr/bin/env ruby
+
+require 'optparse'
+require 'find'
+require 'fileutils'
+
+def export(indir = '.', out = STDOUT)
+  open(File.join(indir, 'log')).each("\n.\n") do |data|
+
+    @msg = nil
+    @parents = []
+
+    data.chomp(".\n").each_line do |l|
+      if not @msg
+        case l
+        when /^commit (.+)$/
+          @id = $1
+        when /^author (.+)$/
+          @author = $1
+        when /^committer (.+)$/
+          @committer = $1
+        when /^parent (.+)$/
+          @parents << $1
+        when /^$/
+          @msg = ""
+        end
+      else
+        @msg << l
+      end
+    end
+
+    out.puts "commit refs/heads/master"
+    out.puts "mark :#{@id}"
+    out.puts "author #{@author}"
+    out.puts "committer #{@committer}"
+    out.puts "data #{@msg.bytesize}"
+    out.puts @msg
+
+    @parents.each_with_index do |p, i|
+      if i == 0
+        out.puts "from :%u" % p
+      else
+        out.puts "merge :%u" % p
+      end
+    end
+
+    # files
+    out.puts 'deleteall'
+    FileUtils.cd(File.join(indir, @id)) do
+      Find.find('.') do |e|
+        next unless File.file?(e)
+        content = File.read(e)
+        filename = e.split(File::SEPARATOR).slice(1..-1).join(File::SEPARATOR)
+        mode = File.executable?(e) ? '100755' : '100644'
+        if File.symlink?(e)
+          mode = '120000'
+          content = File.readlink(e)
+        end
+        out.puts 'M %s inline %s' % [mode, filename]
+        out.puts "data #{content.bytesize}"
+        out.puts content
+      end
+    end
+
+  end
+end
+
+def import(outdir, out)
+  format = 'format:commit %H%nauthor %an <%ae> %ad%ncommitter %cn
<%ce> %cd%nparents %P%n%n%B'
+  cmd = ['git', 'log', '-z', '-s', '--date=raw', '--format=%s' %
format, '--all', '--reverse']
+  commits = {}
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
+    out.puts "commit #{num}"
+    @parents.each do |p|
+      out.puts "parent #{commits[p]}"
+    end
+    out.puts "author #{@author}"
+    out.puts "committer #{@committer}"
+    out.puts
+    out.puts @msg.gsub(/\n\n+/, "\n") # why?
+    out.puts "."
+
+    wd = File.join(outdir, num.to_s)
+    FileUtils.mkdir_p(wd)
+    system('git', '--work-tree', wd, 'checkout', '-f', '-q', @id)
+  end
+end
+
+def git_pack(indir, outdir)
+  indir = File.absolute_path(indir)
+  system('git', 'init', outdir)
+  FileUtils.cd(outdir) do
+    IO.popen(['git', 'fast-import'], 'w') do |io|
+      export(indir, io)
+    end
+    system('git', 'reset', '--hard')
+  end
+end
+
+def git_unpack(indir, outdir)
+  begin
+    FileUtils.mkdir_p(outdir)
+    log = File.open(File.join(outdir, 'log'), 'w')
+    ENV['GIT_DIR'] = File.join(indir, '.git')
+    import(outdir, log)
+  ensure
+    system('git', 'symbolic-ref', 'HEAD', 'refs/heads/master')
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
1.8.0

-- 
Felipe Contreras
