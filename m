From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Maintaince script for l10n files and commits
Date: Thu,  8 Mar 2012 02:47:14 +0800
Message-ID: <1331146034-85804-1-git-send-email-worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 19:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Lu3-0000h8-AH
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 19:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759627Ab2CGSry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 13:47:54 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:50189 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759001Ab2CGSrx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 13:47:53 -0500
Received: by obbuo6 with SMTP id uo6so7246065obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 10:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=lLEWbGifBMBjRSFXKkxnaxCcAVa9Ki1bRPuKNNJ1Ph0=;
        b=rt6uBTSFD8iF3V3sQdWyTi/V5Z9wc/h6QuIubhgibw6PkmtW+Yq/mzcOBHZG+DKknx
         B+KU5BnMkdalakyfmLzNGdExyG5ZrBZ0DIehFKn8H3SnYHcPiAel/IbeQK1lpkXxVXzT
         pytK1mVjgsr0cLpmSavtaGDKwzT+meCv9/jE8KezBNOQb5TuwoEZuC7wsw7EOWSSuSBQ
         Zd3u+HvWv/OU0kj+ZkmLYYKe7uTCtI1+G91ikbAQbswMQ79ocD8O+IlGJukPJ6DL2WR+
         i8qhQ5EjTJlPRP6UFCqEr3+woLCfB5S0HSFz9dW0uX9wkK4PUM2oxF3F9q340DdaMtGg
         ZHMg==
Received: by 10.60.12.131 with SMTP id y3mr1460824oeb.26.1331146072899;
        Wed, 07 Mar 2012 10:47:52 -0800 (PST)
Received: from localhost.foo.bar ([123.116.247.153])
        by mx.google.com with ESMTPS id b3sm23131478obp.6.2012.03.07.10.47.40
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 10:47:51 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.330.gaa956.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192471>

Usage of this script:

 * rake commits      : Check commit logs written with non-ascii chars,
                       but without the correct encoding settings.
                       Always report Non-ascii in subject line as error.

 * rake pot          : Print the summary of the update of git.pot file

 * rake XX.po        : Create or update XX.po from the git.po tempolate file

 * rake check[XX.po] : Syntax check on XX.po

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/Rakefile |  157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 po/Rakefile

diff --git a/po/Rakefile b/po/Rakefile
new file mode 100644
index 00000..e581b
--- /dev/null
+++ b/po/Rakefile
@@ -0,0 +1,157 @@
+require 'tempfile'
+
+POTFILE="git.pot"
+
+class NonAsciiInSubjectError < Exception
+end
+
+class BadEncodingError < Exception
+end
+
+def shellout(cmd)
+    pipe = IO.popen(cmd)
+    pipe.readlines
+end
+
+desc "Syntax check on XX.po, or all .po files if nothing provided."
+task :check, :po_file do |t, args|
+    if args[:po_file]
+        if File.exists? args[:po_file]
+            system("msgfmt -o /dev/null --check --statistics #{args[:po_file]}")
+        else
+            $stderr.puts "File #{args[:po_file]} does not exist."
+        end
+    else
+        FileList["*.po"].each do |po_file|
+            puts "=" * 72
+            puts "Check #{po_file}..."
+            system("msgfmt -o /dev/null --check --statistics #{po_file}")
+        end
+    end
+end
+
+desc "Show summary of updates of git.pot"
+task :pot do
+    status = shellout("git status --porcelain -- #{POTFILE}")
+    new = []
+    dropped = []
+    tmpfile = Tempfile.new('git.pot')
+    if status.empty?
+        puts "Nothing changed."
+    else
+        ENV["LANGUAGE"] = "C"
+        system("git show HEAD:./git.pot > #{tmpfile.path}")
+        msgcmp = shellout("msgcmp -N --use-untranslated #{tmpfile.path} #{POTFILE} 2>&1")
+        msgcmp.each do |line|
+            if m = /^.*:([0-9]+): this message is used but not defined in/.match(line)
+                new << m[1]
+            elsif m = /^.*:([0-9]+): warning: this message is not used/.match(line)
+                dropped << m[1]
+            end
+        end
+        puts "Update of #{POTFILE}:"
+        puts
+        if not new.empty?
+            puts " * Add #{new.count} new l10n string#{new.count>1 ? "s":""}" +
+                 " in the new generated \"git.pot\" file at" +
+                 " line#{new.count>1? "s":""}:"
+            puts "   " + new.join(", ")
+            puts
+        end
+        if not dropped.empty?
+            puts " * Remove #{dropped.count} l10n string#{dropped.count>1 ?
+                 "s":""} from the old \"git.pot\" file at line" +
+                 "#{dropped.count>1 ? "s":""}:"
+            puts "   " + dropped.join(", ")
+        end
+    end
+end
+
+# raise Exception if commit has bad encoding setting
+def verify_commit_encoding(commit, log)
+    subject = 0
+    non_ascii = nil
+    encoding = nil
+    log.each do |line|
+        if line.chomp!.empty?
+            # next line would be the commit log subject line,
+            # if no previous empty line found.
+            subject += 1
+            next
+        end
+        if subject == 0 and line =~ /^encoding /
+            encoding = line.chomp.sub(/^encoding /, '')
+        end
+        # non-ascii found in commit log
+        if match = /([^[:alnum:][:punct:][:space:]]+)/.match(line)
+            non_ascii = "#{line} << #{match[1][0..9]}"
+            # subject must be written in english
+            raise NonAsciiInSubjectError.new(non_ascii) if subject == 1
+        end
+        # subject has only one line
+        subject += 1 if subject == 1
+        # break if there are non-asciis and has already checked subject line
+        break if non_ascii && subject > 0
+    end
+
+    return if not non_ascii
+
+    encoding = 'UTF-8' if not encoding
+    cmd = "python -c \"s='''#{
+              log.collect!{
+                |x| x.chomp.gsub(/['"]/, "")
+              }.join(' - ')}'''; s.decode('#{encoding}')\" 2>/dev/null"
+    raise BadEncodingError.new(non_ascii) if not system(cmd)
+end
+
+desc "Check commits for bad encoding settings."
+task :commits, :from, :to do |t, args|
+    from = args[:from] || 'origin/master'
+    to = args[:to] || 'HEAD'
+    commits = shellout("git rev-list #{from}..#{to}")
+    commits.each do |c|
+        c.chomp!
+        log = shellout("git cat-file commit #{c}")
+        begin
+            verify_commit_encoding(c, log)
+        rescue BadEncodingError => e
+            $stderr.puts "=" * 78
+            $stderr.puts "Error: Bad encoding setting found in commit #{c[0,7]}:"
+            $stderr.puts "       >> #{e.message}"
+            $stderr.puts
+            log.each {|line| puts "\t" + line.chomp}
+        rescue NonAsciiInSubjectError => e
+            $stderr.puts "=" * 78
+            $stderr.puts "Error: Non-AscII found in subject in commit #{c[0,7]}:"
+            $stderr.puts "       >> #{e.message}"
+            $stderr.puts
+            log.each {|line| puts "\t" + line.chomp}
+        end
+    end
+end
+
+
+desc "Create or update XX.po file from git.pot"
+task "XX.po" do
+    $stderr.puts "Use your real locale file, such as zh_CN.po"
+end
+
+# Update XX.po even if timestamp of XX.po is newer
+FileList["*.po"].each do |t|
+    task t => POTFILE
+end
+
+rule '.po' => POTFILE do |t|
+    if File.exist?(t.name)
+        system("msgmerge --add-location --backup=off -U #{t.name} #{t.source}")
+    else
+        system("msginit -i #{t.source} --locale=#{t.name.sub(/.po$/, '')}")
+    end
+    mofile="build/locale/#{t.name.sub(/.po$/, '')}/LC_MESSAGES/git.mo"
+    FileUtils.mkdir_p File.dirname(mofile)
+    system("msgfmt -o #{mofile} --check --statistics #{t.name}")
+end
+
+task :default do
+    system("rake -T")
+end
-- 
1.7.9.2.330.gaa956.dirty
