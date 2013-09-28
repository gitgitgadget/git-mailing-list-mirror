From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/44] ruby: rewrite 'request-pull'
Date: Sat, 28 Sep 2013 17:03:35 -0500
Message-ID: <1380405849-13000-11-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2ie-00030Z-ED
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab3I1WK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:29 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:52739 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab3I1WK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:26 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so4183969obc.32
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oZxIcgqcGar5WkVHX5xnFA1HntfJ1eifnVhbcJSL9+U=;
        b=jpimu7x/GDOzvPP6Gupla3tnEC7PqkQSzHRgDqVa64RWkOfcl40pLjPjVcfB0Hw4IZ
         SfD6oJO9jlsDtCU3lC+OCZsvdhjRBiYeIxLeMGBvuudJc5cMbi8fOKoRzbM1hlct0TcU
         uRaJCtU0GxAV+wCfxdxtFl25Jei+GKE9AxuRFq0OXyFXPF4Ixy4HKXeM5XcZrpfMr2l6
         Dj+Nhttt3W6Qg11tvBmh7/p/ci6itqA4jF4GXM0aojUmruIAiBiAzsnSsyyducfv0pTe
         jkr1+npkKYYnMaHS9XktW8bJ2+fajF7QJwa4e99AT01tuPLEcw/LHlx6lpNS4eEs6SDU
         t1kw==
X-Received: by 10.182.99.231 with SMTP id et7mr12483636obb.10.1380406225742;
        Sat, 28 Sep 2013 15:10:25 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm19517445obb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235528>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    The objective is to be as close to the original as possible, to minimize
    regressions, even if the style is not very Ruby-ish.

 Makefile            |   3 +-
 git-rb-setup.rb     |  17 ++++++
 git-request-pull.rb | 146 +++++++++++++++++++++++++++++++++++++++++++++++
 git-request-pull.sh | 160 ----------------------------------------------------
 4 files changed, 165 insertions(+), 161 deletions(-)
 create mode 100755 git-request-pull.rb
 delete mode 100755 git-request-pull.sh

diff --git a/Makefile b/Makefile
index 27e61c0..44b4cd5 100644
--- a/Makefile
+++ b/Makefile
@@ -466,7 +466,6 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-repack.sh
-SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
@@ -493,7 +492,9 @@ SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
 SCRIPT_RUBY += git-rb-setup.rb
+SCRIPT_RUBY += git-request-pull.rb
 
+RUBY_PROGRAMS += git-request-pull$X
 PROGRAMS += $(RUBY_PROGRAMS)
 
 NO_INSTALL += git-remote-testgit
diff --git a/git-rb-setup.rb b/git-rb-setup.rb
index 969278a..92998a2 100644
--- a/git-rb-setup.rb
+++ b/git-rb-setup.rb
@@ -9,3 +9,20 @@ end
 def sha1_to_hex(sha1)
   sha1.unpack('H*').first
 end
+
+class CommandError < RuntimeError
+
+  def initialize(command)
+     @command = command
+  end
+
+  def to_s
+    Array(@command).join(' ').inspect
+  end
+
+end
+
+def run(cmd, *args)
+  system(*cmd, *args)
+  raise CommandError.new(cmd) unless $?.success?
+end
diff --git a/git-request-pull.rb b/git-request-pull.rb
new file mode 100755
index 0000000..60cf6ce
--- /dev/null
+++ b/git-request-pull.rb
@@ -0,0 +1,146 @@
+#!git ruby
+
+ENV['GIT_PAGER'] =
+
+patch = ''
+
+def usage
+  puts <<EOF
+usage: git request-pull [options] start url [end]
+
+    -p                    show patch text as well
+
+EOF
+  exit 1
+end
+
+until ARGV.empty?
+  case ARGV.first
+  when '-p'
+    patch = '-p'
+  when '--'
+    ARGV.shift
+    break
+  when /^-/
+    usage
+  else
+    break
+  end
+  ARGV.shift
+end
+
+base = ARGV[0]
+url = ARGV[1]
+head = ARGV[2] || 'HEAD'
+status = 0
+branch_name = nil
+
+headref = `git rev-parse -q --verify --symbolic-full-name "#{head}"`.chomp
+headref = "" if headref == "HEAD"
+
+branch_name = headref.gsub(%r{^refs/heads/}, '')
+if branch_name == headref ||
+  ! system(%[git config "branch.#{branch_name}.description" >/dev/null])
+  branch_name = nil
+end
+
+tag_name = `git describe --exact "#{head}^0" 2>/dev/null`.chomp
+
+usage unless base or url
+
+baserev = `git rev-parse --verify --quiet "#{base}"^0`.chomp
+die "Not a valid revision: #{base}" if baserev.empty?
+
+headrev = `git rev-parse --verify --quiet "#{head}"^0`.chomp
+die "Not a valid revision: #{head}" if headrev.empty?
+
+merge_base = `git merge-base #{baserev} #{headrev}`.chomp
+die "No commits in common between #{base} and #{head}" unless $?.success?
+
+# $head is the token given from the command line, and $tag_name, if
+# exists, is the tag we are going to show the commit information for.
+# If that tag exists at the remote and it points at the commit, use it.
+# Otherwise, if a branch with the same name as $head exists at the remote
+# and their values match, use that instead.
+#
+# Otherwise find a random ref that matches $headrev.
+find_matching_ref='
+	sub abbr {
+		my $ref = shift;
+		if ($ref =~ s|^refs/heads/|| || $ref =~ s|^refs/tags/|tags/|) {
+			return $ref;
+		} else {
+			return $ref;
+		}
+	}
+
+	my ($found);
+	while (<STDIN>) {
+		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
+		next unless ($sha1 eq $ARGV[1]);
+		$found = abbr($ref);
+		if ($deref && $ref eq "refs/tags/$ARGV[2]") {
+			last;
+		}
+		if ($ref eq $ARGV[0]) {
+			last;
+		}
+	}
+	if ($found) {
+		print "$found\n";
+	}
+'
+
+ref = `git ls-remote "#{url}" | perl -e '#{find_matching_ref}' "#{headref}" "#{headrev}" "#{tag_name}"`.chomp
+url = `git ls-remote --get-url "#{url}"`.chomp
+
+begin
+  run(%[git show -s --format='The following changes since commit %H:
+
+  %s (%ci)
+
+are available in the git repository at:
+' #{merge_base}])
+  puts "  #{url}" + (ref.empty? ? "" : " #{ref}")
+  run(%[git show -s --format='
+for you to fetch changes up to %H:
+
+  %s (%ci)
+
+----------------------------------------------------------------' #{headrev}])
+
+  if branch_name
+    puts "(from the branch description for #{branch_name} local branch)"
+    puts
+    run(%[git config "branch.#{branch_name}.description"])
+  end
+
+  if not tag_name.empty?
+    if ref.empty? || ref != "tags/#{tag_name}"
+      $stderr.puts "warn: You locally have #{tag_name} but it does not (yet)"
+      $stderr.puts "warn: appear to be at #{url}"
+      $stderr.puts "warn: Do you want to push it there, perhaps?"
+    end
+    run(%[git cat-file tag "#{tag_name}" | sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p])
+    puts
+  end
+
+  if branch_name || ! tag_name.empty?
+    puts "----------------------------------------------------------------"
+  end
+
+  run(%[git shortlog ^#{baserev} #{headrev}])
+  run(%[git diff -M --stat --summary #{patch} #{merge_base}..#{headrev}])
+
+  if ref.empty?
+    short_headref = `git rev-parse -q --verify --symbolic-full-name --abbrev-ref "#{head}"`.chomp
+    $stderr.puts "warn: No branch of #{url} is at:"
+    run("git show -s --format='warn:   %h: %s' #{headrev} >&2")
+    $stderr.puts "warn: Are you sure you pushed '#{short_headref}' there?"
+    status = 1
+  end
+rescue CommandError
+  status = 1
+end
+
+exit status
diff --git a/git-request-pull.sh b/git-request-pull.sh
deleted file mode 100755
index d8b4c3c..0000000
--- a/git-request-pull.sh
+++ /dev/null
@@ -1,160 +0,0 @@
-#!/bin/sh
-# Copyright 2005, Ryan Anderson <ryan@michonline.com>
-#
-# This file is licensed under the GPL v2, or a later version
-# at the discretion of Linus Torvalds.
-
-USAGE='<start> <url> [<end>]'
-LONG_USAGE='Summarizes the changes between two commits to the standard output,
-and includes the given URL in the generated summary.'
-SUBDIRECTORY_OK='Yes'
-OPTIONS_KEEPDASHDASH=
-OPTIONS_SPEC='git request-pull [options] start url [end]
---
-p    show patch text as well
-'
-
-. git-sh-setup
-
-GIT_PAGER=
-export GIT_PAGER
-
-patch=
-while	case "$#" in 0) break ;; esac
-do
-	case "$1" in
-	-p)
-		patch=-p ;;
-	--)
-		shift; break ;;
-	-*)
-		usage ;;
-	*)
-		break ;;
-	esac
-	shift
-done
-
-base=$1 url=$2 head=${3-HEAD} status=0 branch_name=
-
-headref=$(git rev-parse -q --verify --symbolic-full-name "$head")
-if test "$headref" = "HEAD"
-then
-	headref=
-fi
-
-branch_name=${headref#refs/heads/}
-if test "z$branch_name" = "z$headref" ||
-	! git config "branch.$branch_name.description" >/dev/null
-then
-	branch_name=
-fi
-
-tag_name=$(git describe --exact "$head^0" 2>/dev/null)
-
-test -n "$base" && test -n "$url" || usage
-
-baserev=$(git rev-parse --verify --quiet "$base"^0)
-if test -z "$baserev"
-then
-    die "fatal: Not a valid revision: $base"
-fi
-
-headrev=$(git rev-parse --verify --quiet "$head"^0)
-if test -z "$headrev"
-then
-    die "fatal: Not a valid revision: $head"
-fi
-
-merge_base=$(git merge-base $baserev $headrev) ||
-die "fatal: No commits in common between $base and $head"
-
-# $head is the token given from the command line, and $tag_name, if
-# exists, is the tag we are going to show the commit information for.
-# If that tag exists at the remote and it points at the commit, use it.
-# Otherwise, if a branch with the same name as $head exists at the remote
-# and their values match, use that instead.
-#
-# Otherwise find a random ref that matches $headrev.
-find_matching_ref='
-	sub abbr {
-		my $ref = shift;
-		if ($ref =~ s|^refs/heads/|| || $ref =~ s|^refs/tags/|tags/|) {
-			return $ref;
-		} else {
-			return $ref;
-		}
-	}
-
-	my ($found);
-	while (<STDIN>) {
-		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
-		next unless ($sha1 eq $ARGV[1]);
-		$found = abbr($ref);
-		if ($deref && $ref eq "refs/tags/$ARGV[2]") {
-			last;
-		}
-		if ($ref eq $ARGV[0]) {
-			last;
-		}
-	}
-	if ($found) {
-		print "$found\n";
-	}
-'
-
-ref=$(git ls-remote "$url" | perl -e "$find_matching_ref" "$headref" "$headrev" "$tag_name")
-
-url=$(git ls-remote --get-url "$url")
-
-git show -s --format='The following changes since commit %H:
-
-  %s (%ci)
-
-are available in the git repository at:
-' $merge_base &&
-echo "  $url${ref+ $ref}" &&
-git show -s --format='
-for you to fetch changes up to %H:
-
-  %s (%ci)
-
-----------------------------------------------------------------' $headrev &&
-
-if test -n "$branch_name"
-then
-	echo "(from the branch description for $branch_name local branch)"
-	echo
-	git config "branch.$branch_name.description"
-fi &&
-
-if test -n "$tag_name"
-then
-	if test -z "$ref" || test "$ref" != "tags/$tag_name"
-	then
-		echo >&2 "warn: You locally have $tag_name but it does not (yet)"
-		echo >&2 "warn: appear to be at $url"
-		echo >&2 "warn: Do you want to push it there, perhaps?"
-	fi
-	git cat-file tag "$tag_name" |
-	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
-	echo
-fi &&
-
-if test -n "$branch_name" || test -n "$tag_name"
-then
-	echo "----------------------------------------------------------------"
-fi &&
-
-git shortlog ^$baserev $headrev &&
-git diff -M --stat --summary $patch $merge_base..$headrev || status=1
-
-if test -z "$ref"
-then
-	short_headref=$(git rev-parse -q --verify --symbolic-full-name --abbrev-ref "$head")
-	echo "warn: No branch of $url is at:" >&2
-	git show -s --format='warn:   %h: %s' $headrev >&2
-	echo "warn: Are you sure you pushed '$short_headref' there?" >&2
-	status=1
-fi
-exit $status
-- 
1.8.4-fc
