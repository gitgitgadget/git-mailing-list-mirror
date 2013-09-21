From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH/RFC 4/7] ruby: rewrite 'request-pull'
Date: Sat, 21 Sep 2013 13:48:12 -0500
Message-ID: <1379789295-18519-5-git-send-email-felipe.contreras@gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 20:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSJj-0000bM-EG
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab3IUSyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:54:00 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42226 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab3IUSx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:53:59 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so2083518obc.24
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//5CosY2Y5Yt0sGCVheW0Efyqrhjq2ekizep7e7Ul44=;
        b=QlCDmECsUT9wZTZqZ8ckRon73aigRxq9zzdC9AnC+2kqzP+qmYfVbXnPSa7AQun+so
         FQD/TlEvTOxaWzboUaliCM5AgsyKosYhkgDc3IFH65WA5aTM3jSzWx4oNzBrsc3LAvEq
         ZgaIgP5Otj1XPBtH5GD7ZrdOarm8CljokfG8Gm+20y9aMGcg8uDh5c72NLN/6+C9iorZ
         YLcK1W9oaeB6y0trtTDFzi6FuDQRsfXs9BHEiGf739pUKmQk0MD+nsVH8Sfr+en6r83u
         6eSClQp8mcH2N9ZOsU12a/JDJ2kFF/lg+MSGNKaL2YRN4nXWwhjZiGOeS0UQhPG/NOts
         ebOA==
X-Received: by 10.182.71.82 with SMTP id s18mr11761085obu.9.1379789639478;
        Sat, 21 Sep 2013 11:53:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm8642337obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 11:53:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235138>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile            |   2 +-
 git-rb-setup.rb     |  25 ++++++++
 git-request-pull.rb | 153 +++++++++++++++++++++++++++++++++++++++++++++++++
 git-request-pull.sh | 162 ----------------------------------------------------
 ruby.c              |   1 +
 5 files changed, 180 insertions(+), 163 deletions(-)
 create mode 100644 git-request-pull.rb
 delete mode 100755 git-request-pull.sh

diff --git a/Makefile b/Makefile
index 8a4e48f..cb6bb4e 100644
--- a/Makefile
+++ b/Makefile
@@ -465,7 +465,6 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-repack.sh
-SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
@@ -493,6 +492,7 @@ SCRIPT_PYTHON += git-p4.py
 
 SCRIPT_RUBY += git-rb-setup.rb
 SCRIPT_RUBY += git-refs.rb
+SCRIPT_RUBY += git-request-pull.rb
 
 NO_INSTALL += git-remote-testgit
 NO_INSTALL += git-remote-testpy
diff --git a/git-rb-setup.rb b/git-rb-setup.rb
index 969278a..f3a2c99 100644
--- a/git-rb-setup.rb
+++ b/git-rb-setup.rb
@@ -9,3 +9,28 @@ end
 def sha1_to_hex(sha1)
   sha1.unpack('H*').first
 end
+
+def pager(msg)
+  pager = ENV['GIT_PAGER'] || `git var GIT_PAGER`.chomp
+  system("echo -n '#{msg}' | #{pager}")
+end
+
+class CommandError < RuntimeError
+
+  attr_reader :command, :output
+
+  def initialize(command, output)
+     @command = command
+     @output = output
+  end
+
+  def to_s
+    Array(@command).join(' ').inspect
+  end
+
+end
+
+def run(cmd)
+  system(cmd)
+  raise CommandError.new(cmd, nil) unless $?.success?
+end
diff --git a/git-request-pull.rb b/git-request-pull.rb
new file mode 100644
index 0000000..b6d0156
--- /dev/null
+++ b/git-request-pull.rb
@@ -0,0 +1,153 @@
+#!/usr/bin/env ruby
+
+require_relative 'git-rb-setup'
+
+patch = ''
+
+ARGV.shift
+
+def usage
+  pager <<EOF
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
+headref = `git symbolic-ref -q "#{head}"`.chomp
+
+if system(%[git show-ref -q --verify "#{headref}"])
+  branch_name = headref.gsub(/^refs\/heads\//, '')
+  if branch_name == headref ||
+    ! system(%[git config "branch.#{branch_name}.description" >/dev/null])
+    branch_name = nil
+  end
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
+  sub abbr {
+    my $ref = shift;
+    if ($ref =~ s|^refs/heads/|| || $ref =~ s|^refs/tags/|tags/|) {
+      return $ref;
+    } else {
+      return $ref;
+    }
+  }
+
+  my ($tagged, $branch, $found);
+  while (<STDIN>) {
+    my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
+    next unless ($sha1 eq $ARGV[1]);
+    $found = abbr($ref);
+    if ($deref && $ref eq "tags/$ARGV[2]") {
+      $tagged = $found;
+      last;
+    }
+    if ($ref =~ m|/\Q$ARGV[0]\E$|) {
+      $exact = $found;
+    }
+  }
+  if ($tagged) {
+    print "$tagged\n";
+  } elsif ($exact) {
+    print "$exact\n";
+  } elsif ($found) {
+    print "$found\n";
+  }
+'
+
+ref = `git ls-remote "#{url}" | perl -e '#{find_matching_ref}' "#{head}" "#{headrev}" "#{tag_name}"`.chomp
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
+  if branch_name or not tag_name.empty?
+    puts "----------------------------------------------------------------"
+  end
+
+  run(%[git shortlog ^#{baserev} #{headrev}])
+  run(%[git diff -M --stat --summary #{patch} #{merge_base}..#{headrev}])
+
+  if ref.empty?
+    $stderr.puts "warn: No branch of #{url} is at:"
+    run("git show -s --format='warn:   %h: %s' #{headrev} >&2")
+    $stderr.puts "warn: Are you sure you pushed '#{head}' there?"
+    status = 1
+  end
+rescue CommandError
+  status = 1
+end
+
+exit status
diff --git a/git-request-pull.sh b/git-request-pull.sh
deleted file mode 100755
index ebf1269..0000000
--- a/git-request-pull.sh
+++ /dev/null
@@ -1,162 +0,0 @@
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
-headref=$(git symbolic-ref -q "$head")
-if git show-ref -q --verify "$headref"
-then
-	branch_name=${headref#refs/heads/}
-	if test "z$branch_name" = "z$headref" ||
-		! git config "branch.$branch_name.description" >/dev/null
-	then
-		branch_name=
-	fi
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
-	my ($tagged, $branch, $found);
-	while (<STDIN>) {
-		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
-		next unless ($sha1 eq $ARGV[1]);
-		$found = abbr($ref);
-		if ($deref && $ref eq "tags/$ARGV[2]") {
-			$tagged = $found;
-			last;
-		}
-		if ($ref =~ m|/\Q$ARGV[0]\E$|) {
-			$exact = $found;
-		}
-	}
-	if ($tagged) {
-		print "$tagged\n";
-	} elsif ($exact) {
-		print "$exact\n";
-	} elsif ($found) {
-		print "$found\n";
-	}
-'
-
-ref=$(git ls-remote "$url" | perl -e "$find_matching_ref" "$head" "$headrev" "$tag_name")
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
-	echo "warn: No branch of $url is at:" >&2
-	git show -s --format='warn:   %h: %s' $headrev >&2
-	echo "warn: Are you sure you pushed '$head' there?" >&2
-	status=1
-fi
-exit $status
diff --git a/ruby.c b/ruby.c
index 7f0cc9d..733215a 100644
--- a/ruby.c
+++ b/ruby.c
@@ -33,6 +33,7 @@ static void git_init(void)
 
 static const char *commands[] = {
 	"refs",
+	"request-pull",
 };
 
 static void run_ruby_command(int argc, const char **argv)
-- 
1.8.4-fc
