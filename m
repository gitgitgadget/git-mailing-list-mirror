From: Lea Wiemann <lewiemann@gmail.com>
Subject: [RFC/PATCH] test suite for Git.pm
Date: Sun,  1 Jun 2008 05:51:09 +0200
Message-ID: <1212292269-21534-1-git-send-email-LeWiemann@gmail.com>
Cc: pasky@suse.cz, Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 05:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ecA-0003gx-Mg
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 05:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbYFADux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 23:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbYFADux
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 23:50:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:26659 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbYFADuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 23:50:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so430991fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 20:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=F7vhcl2ohSEvMJEeoNccHt4Jt5AA4pwSpcgIhtqKYLA=;
        b=Zs228fD94rR+spnprt76qE4qEJ9aRVE5QB8Ui4FYERkGmmR15XizVRsqMqwL/RI47SxJOlY5xHy5/8NMCDWs31Z0o6pJ1Sk6jLRj9tJlt/jrKWlIe4JVAxadXPJmgkRmELp2Yi6brHmEp/+x6EvTiURjX+r/tgcQGdI2QIO2SSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=ezUIGepH1chFELPDt9vpU5aO99NBMVBjfwlnEBBq02upFMi0IRuFSYUaF1YSJZGId0ZOf0YYYzeoK39lKyrOjUQOPeBXIwdtfJQZowa12OtA296T3IZNmZWfb1FVydX55ycGnysYvuTp+pANAB5FHa1yPC0O1MtRxV7zmYjcxBo=
Received: by 10.86.73.17 with SMTP id v17mr4699667fga.24.1212292250856;
        Sat, 31 May 2008 20:50:50 -0700 (PDT)
Received: from fly ( [91.33.240.119])
        by mx.google.com with ESMTPS id d4sm1888450fga.8.2008.05.31.20.50.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 20:50:49 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2eb7-0005cZ-Hq; Sun, 01 Jun 2008 05:51:09 +0200
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83425>

Added a shell script (t/t9700-perl-git.sh) that sets up a git
repository and a perl script (t/t9700/test.pl) that runs the actual
tests.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Hi everyone!

Here's my first draft for a test suite for Git.pm.  It doesn't test
all of Git.pm yet, but I'll add more tests later.  Comments are
appreciated!

My test-fu didn't suffice for testing the command methods (which are
responsible for calling git), and I'm not currently planning to.  I'm
hoping to add more coverage to the constructor (Git->repository)
though.

Something I'm not sure about yet is how to test failure cases -- for
instance, there are a couple of methods in Git.pm that return undef
for $E->value (i.e. exit code) == 1, but die for $E->value > 1.  The
latter case I can't currently test.  Ideas how to test those cases
cleanly (i.e. how to simulate/mock an exit code > 1) are very welcome.

(Petr:) There's some serious strangeness going on where calling
wc_chdir causes all subsequent commands to fail (marked as TODO at the
end).  I've spent half an hour unsuccessfully trying to track down the
error.  It would be great if you (or anyone else with more Git
experience than me) could have a look at this.

-- Lea


 t/t9700-perl-git.sh |   40 +++++++++++++++++++++++++++++
 t/t9700/test.pl     |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100755 t/t9700-perl-git.sh
 create mode 100755 t/t9700/test.pl

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
new file mode 100755
index 0000000..735ada1
--- /dev/null
+++ b/t/t9700-perl-git.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Lea Wiemann
+#
+
+test_description='perl interface (Git.pm)'
+. ./test-lib.sh
+
+# set up test repository
+
+test_expect_success \
+    'set up test repository' \
+    'echo "*.test" > .gitignore &&
+
+     echo "test file 1" > file1 &&
+     echo "test file 2" > file2 &&
+     mkdir directory1 &&
+     echo "in directory1" >> directory1/file &&
+     mkdir directory2 &&
+     echo "in directory2" >> directory2/file &&
+     git add . &&
+     git commit -m "first commit" &&
+     git rev-parse HEAD > revisions.test &&
+
+     git tag -- --silly-name &&
+
+     echo "changed file 1" > file1 &&
+     git add . &&
+     git commit -m "second commit" &&
+     git rev-parse HEAD >> revisions.test &&
+
+     git-config --add color.test.slot1 green &&
+     (git-config --get-color color.test.slot1 red; echo foo) > x
+     '
+
+test_external_without_stderr \
+    'Perl API' \
+    perl ../t9700/test.pl
+
+test_done
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
new file mode 100755
index 0000000..c8d5c64
--- /dev/null
+++ b/t/t9700/test.pl
@@ -0,0 +1,70 @@
+#!/usr/bin/perl
+
+use warnings;
+use strict;
+
+use Test::More qw(no_plan);
+use Cwd;
+use File::Basename;
+
+BEGIN { use_ok('Git') }
+require_ok('Git');
+
+# set up
+#our $repo_dir = "trash directory";
+our $abs_repo_dir = Cwd->cwd;
+ok(our $r = Git->repository(Directory => "."), "open repository");
+ok((open REVISIONS, 'revisions.test' and chomp(our @revisions = <REVISIONS>)),
+   "(read revisions)");
+
+# ident
+like($r->ident("aUthor"), qr/^A U Thor <author\@example.com> [0-9]+ \+0000$/,
+     "ident scalar: author (type)");
+like($r->ident("cOmmitter"), qr/^C O Mitter <committer\@example.com> [0-9]+ \+0000$/,
+     "ident scalar: committer (type)");
+is($r->ident("invalid"), "invalid", "ident scalar: invalid ident string (no parsing)");
+my ($name, $email, $time_tz) = $r->ident('author');
+is_deeply([$name, $email], ["A U Thor", "author\@example.com"],
+	 "ident array: author");
+like($time_tz, qr/[0-9]+ \+0000/, "ident array: author");
+is_deeply([$r->ident("Name <email> 123 +0000")], ["Name", "email", "123 +0000"],
+	  "ident array: ident string");
+is_deeply([$r->ident("invalid")], [], "ident array: invalid ident string");
+# ident_person
+is($r->ident_person("aUthor"), "A U Thor <author\@example.com>",
+   "ident_person: author (type)");
+is($r->ident_person("Name <email> 123 +0000"), "Name <email>",
+   "ident_person: ident string");
+is($r->ident_person("Name", "email", "123 +0000"), "Name <email>",
+   "ident_person: array");
+
+# parse_rev
+is($r->parse_rev("HEAD"), $revisions[-1], "parse_rev: 'HEAD'");
+is($r->parse_rev("HEAD^"), $revisions[-2], "parse_rev: 'HEAD^'");
+is($r->parse_rev($revisions[0]), $revisions[0], "parse_rev: SHA1");
+is($r->parse_rev("--silly-name"), $revisions[0], "parse_rev: tag");
+is($r->parse_rev("nonexistent"), undef, "parse_rev: nonexistent name");
+is($r->parse_rev("0" x 40), "0" x 40, "parse_rev: nonexistent SHA1");
+
+# colors
+our $ansi_green = "\x1b[32m";
+# Cannot test $r->get_colorbool("color.foo")) since our stdout is not
+# a terminal.
+
+# paths
+is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
+is($r->repo_path, "./.git", "repo_path");
+is($r->wc_path, $abs_repo_dir . "/", "wc_path");
+is($r->wc_subdir, "", "wc_subdir initial");
+$r->wc_chdir("directory1");
+is($r->wc_subdir, "directory1", "wc_subdir after wc_chdir");
+TODO: {
+	local $TODO = "commands do not work after wc_chdir";
+	# Failure output is active even when in non-verbose mode and
+	# thus annoying, and the ANSI codes mess up the output on top
+	# of that.  Thus we simply skip these tests while they fail.
+	todo_skip 'get_color after wc_chdir', 2;
+	is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color after wc_chdir");
+	is($r->parse_rev("HEAD"), $revisions[-1], "parse_rev after wc_chdir");
+}
+
-- 
1.5.5.GIT
