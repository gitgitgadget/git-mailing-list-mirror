From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add test t9500 for gitweb (as standalone script)
Date: Sat, 19 May 2007 02:19:20 +0200
Message-ID: <11795339604115-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 02:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCfR-0003M3-HE
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbXESATY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbXESATY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:19:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:32687 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbXESATX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:19:23 -0400
Received: by mu-out-0910.google.com with SMTP id w1so692246mue
        for <git@vger.kernel.org>; Fri, 18 May 2007 17:19:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=N0DVV1pmlUHagpESTyCKzWzwzfm+o5ClQ6QqZGOlmczPuOyJSxyKT9YBW+8eLa1OA1k4Glc6350n7beCPJNA3iZHPAlHaS9QihzNzrJ2uO+/foz+5MjJyAwMWvQIdYlQqto582qYQEcvlmhY4EbdX1VIlc+jB2jdrhQ0UUslpNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=IT5HqY8NW1RuWEHVSrWyxULd0xuxO5b5G66ITokpgKJfSFdZ7JYfaB7WKODnPOCEiWpZfKiP1tuROsrNV6hS6ekSN857DH7aFw+dN5P+mffOZISTe+h7sCNWs7qdDd9H2g+cZ6OlLqbL3Hq/nOthSZ+7Wt22nQlTnwSrPqWLbv8=
Received: by 10.82.189.6 with SMTP id m6mr3931502buf.1179533961130;
        Fri, 18 May 2007 17:19:21 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id u9sm7994298muf.2007.05.18.17.19.17;
        Fri, 18 May 2007 17:19:19 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4J0JKim008098;
	Sat, 19 May 2007 02:19:21 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4J0JKMm008097;
	Sat, 19 May 2007 02:19:20 +0200
X-Mailer: git-send-email 1.5.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47695>

This test runs gitweb (git web interface) as CGI script from
commandline, and checks that it would not write any errors
or warnings to log.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is test I have used to find errors and warnings fixed in the
late 'Fix "Use of uninitialized value" warning ...' series.

It is not perfect, it does not offer full coverage, and tests
only if there are no errors or warning not checking the output,
not even HTTP code, but it helps.

 t/t9500-gitweb-standalone-no-errors.sh |  490 ++++++++++++++++++++++++++++++++
 1 files changed, 490 insertions(+), 0 deletions(-)
 create mode 100755 t/t9500-gitweb-standalone-no-errors.sh

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
new file mode 100755
index 0000000..b92ab63
--- /dev/null
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -0,0 +1,490 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Jakub Narebski
+#
+
+test_description='gitweb as standalone script (basic tests).
+
+This test runs gitweb (git web interface) as CGI script from
+commandline, and checks that it would not write any errors
+or warnings to log.'
+
+gitweb_init () {
+	cat >gitweb_config.perl <<EOF
+#!/usr/bin/perl
+
+# gitweb configuration for tests
+
+our \$version = "current";
+our \$GIT = "git";
+our \$projectroot = "$(pwd)";
+our \$home_link_str = "projects";
+our \$site_name = "[localhost]";
+our \$site_header = "";
+our \$site_footer = "";
+our \$home_text = "indextext.html";
+our @stylesheets = ("file:///$(pwd)/../../gitweb/gitweb.css");
+our \$logo = "file:///$(pwd)/../../gitweb/git-logo.png";
+our \$favicon = "file:///$(pwd)/../../gitweb/git-favicon.png";
+our \$projects_list = "";
+our \$export_ok = "";
+our \$strict_export = "";
+
+CGI::Carp::set_programname("gitweb/gitweb.cgi");
+EOF
+
+	cat >.git/description <<EOF
+$0 test repository
+EOF
+}
+
+gitweb_run () {
+	export GATEWAY_INTERFACE="CGI/1.1"
+	export HTTP_ACCEPT="*/*"
+	export REQUEST_METHOD="GET"
+	export QUERY_STRING=""$1""
+	export PATH_INFO=""$2""
+
+	export GITWEB_CONFIG=$(pwd)/gitweb_config.perl
+
+	# some of git commands write to STDERR on error, but this is not
+	# written to web server logs, so we are not interested in that:
+	# we are interested only in properly formatted errors/warnings
+	rm -f gitweb.log &&
+	perl -- $(pwd)/../../gitweb/gitweb.perl \
+		>/dev/null 2>gitweb.log &&
+	if grep -q -s "^[[]" gitweb.log >/dev/null; then false; else true; fi
+
+	# gitweb.log is left for debugging
+}
+
+. ./test-lib.sh
+
+gitweb_init
+
+# ----------------------------------------------------------------------
+# no commits (empty, just initialized repository)
+
+test_expect_success \
+	'no commits: projects_list (implicit)' \
+	'gitweb_run'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'no commits: projects_index' \
+	'gitweb_run "a=project_index"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'no commits: .git summary (implicit)' \
+	'gitweb_run "p=.git"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'no commits: .git commit (implicit HEAD)' \
+	'gitweb_run "p=.git;a=commit"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'no commits: .git commitdiff (implicit HEAD)' \
+	'gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'no commits: .git tree (implicit HEAD)' \
+	'gitweb_run "p=.git;a=tree"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'no commits: .git heads' \
+	'gitweb_run "p=.git;a=heads"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'no commits: .git tags' \
+	'gitweb_run "p=.git;a=tags"'
+test_debug 'cat gitweb.log'
+
+
+# ----------------------------------------------------------------------
+# initial commit
+
+test_expect_success \
+	'Make initial commit' \
+	'echo "Not an empty file." > file &&
+	 git add file &&
+	 git commit -a -m "Initial commit." &&
+	 git branch b'
+
+test_expect_success \
+	'projects_list (implicit)' \
+	'gitweb_run'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'projects_index' \
+	'gitweb_run "a=project_index"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git summary (implicit)' \
+	'gitweb_run "p=.git"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git commit (implicit HEAD)' \
+	'gitweb_run "p=.git;a=commit"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git commitdiff (implicit HEAD, root commit)' \
+	'gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git commitdiff_plain (implicit HEAD, root commit)' \
+	'gitweb_run "p=.git;a=commitdiff_plain"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git commit (HEAD)' \
+	'gitweb_run "p=.git;a=commit;h=HEAD"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git tree (implicit HEAD)' \
+	'gitweb_run "p=.git;a=tree"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git blob (file)' \
+	'gitweb_run "p=.git;a=blob;f=file"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git blob_plain (file)' \
+	'gitweb_run "p=.git;a=blob_plain;f=file"'
+test_debug 'cat gitweb.log'
+
+# ----------------------------------------------------------------------
+# nonexistent objects
+
+test_expect_success \
+	'.git commit (non-existent)' \
+	'gitweb_run "p=.git;a=commit;h=non-existent"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git commitdiff (non-existent)' \
+	'gitweb_run "p=.git;a=commitdiff;h=non-existent"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git commitdiff (non-existent vs HEAD)' \
+	'gitweb_run "p=.git;a=commitdiff;hp=non-existent;h=HEAD"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git tree (0000000000000000000000000000000000000000)' \
+	'gitweb_run "p=.git;a=tree;h=0000000000000000000000000000000000000000"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git tag (0000000000000000000000000000000000000000)' \
+	'gitweb_run "p=.git;a=tag;h=0000000000000000000000000000000000000000"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git blob (non-existent)' \
+	'gitweb_run "p=.git;a=blob;f=non-existent"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'.git blob_plain (non-existent)' \
+	'gitweb_run "p=.git;a=blob_plain;f=non-existent"'
+test_debug 'cat gitweb.log'
+
+
+# ----------------------------------------------------------------------
+# commitdiff testing (implicit, one implicit tree-ish)
+
+test_expect_success \
+	'commitdiff(0): root' \
+	'gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): file added' \
+	'echo "New file" > new_file &&
+	 git add new_file &&
+	 git commit -a -m "File added." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): mode change' \
+	'chmod a+x new_file &&
+	 git commit -a -m "Mode changed." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): file renamed' \
+	'git mv new_file renamed_file &&
+	 git commit -a -m "File renamed." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): file to symlink' \
+	'rm renamed_file &&
+	 ln -s file renamed_file &&
+	 git commit -a -m "File to symlink." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): file deleted' \
+	'git rm renamed_file &&
+	 rm -f renamed_file &&
+	 git commit -a -m "File removed." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): file copied / new file' \
+	'cp file file2 &&
+	 git add file2 &&
+	 git commit -a -m "File copied." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): mode change and modified' \
+	'echo "New line" >> file2 &&
+	 chmod a+x file2 &&
+	 git commit -a -m "Mode change and modification." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): renamed and modified' \
+	'cat >file2<<EOF &&
+Dominus regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+EOF
+	 git commit -a -m "File added." &&
+	 git mv file2 file3 &&
+	 echo "Propter nomen suum." >> file3 &&
+	 git commit -a -m "File rename and modification." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): renamed, mode change and modified' \
+	'git mv file3 file2 &&
+	 echo "Propter nomen suum." >> file2 &&
+	 chmod a+x file2 &&
+	 git commit -a -m "File rename, mode change and modification." &&
+	 gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+# ----------------------------------------------------------------------
+# commitdiff testing (taken from t4114-apply-typechange.sh)
+
+test_expect_success 'setup typechange commits' '
+	echo "hello world" > foo &&
+	echo "hi planet" > bar &&
+	git update-index --add foo bar &&
+	git commit -m initial &&
+	git branch initial &&
+	rm -f foo &&
+	ln -s bar foo &&
+	git update-index foo &&
+	git commit -m "foo symlinked to bar" &&
+	git branch foo-symlinked-to-bar &&
+	rm -f foo &&
+	echo "how far is the sun?" > foo &&
+	git update-index foo &&
+	git commit -m "foo back to file" &&
+	git branch foo-back-to-file &&
+	rm -f foo &&
+	git update-index --remove foo &&
+	mkdir foo &&
+	echo "if only I knew" > foo/baz &&
+	git update-index --add foo/baz &&
+	git commit -m "foo becomes a directory" &&
+	git branch "foo-becomes-a-directory" &&
+	echo "hello world" > foo/baz &&
+	git update-index foo/baz &&
+	git commit -m "foo/baz is the original foo" &&
+	git branch foo-baz-renamed-from-foo
+	'
+
+test_expect_success \
+	'commitdiff(2): file renamed from foo to foo/baz' \
+	'gitweb_run "p=.git;a=commitdiff;hp=initial;h=foo-baz-renamed-from-foo"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(2): file renamed from foo/baz to foo' \
+	'gitweb_run "p=.git;a=commitdiff;hp=foo-baz-renamed-from-foo;h=initial"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(2): directory becomes file' \
+	'gitweb_run "p=.git;a=commitdiff;hp=foo-becomes-a-directory;h=initial"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(2): file becomes directory' \
+	'gitweb_run "p=.git;a=commitdiff;hp=initial;h=foo-becomes-a-directory"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(2): file becomes symlink' \
+	'gitweb_run "p=.git;a=commitdiff;hp=initial;h=foo-symlinked-to-bar"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(2): symlink becomes file' \
+	'gitweb_run "p=.git;a=commitdiff;hp=foo-symlinked-to-bar;h=foo-back-to-file"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(2): symlink becomes directory' \
+	'gitweb_run "p=.git;a=commitdiff;hp=foo-symlinked-to-bar;h=foo-becomes-a-directory"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(2): directory becomes symlink' \
+	'gitweb_run "p=.git;a=commitdiff;hp=foo-becomes-a-directory;h=foo-symlinked-to-bar"'
+test_debug 'cat gitweb.log'
+
+# ----------------------------------------------------------------------
+# commit, commitdiff: merge, large
+test_expect_success \
+	'Create a merge' \
+	'git checkout b &&
+	 echo "Branch" >> b &&
+	 git add b &&
+	 git commit -a -m "On branch" &&
+	 git checkout master &&
+	 git pull . b'
+
+test_expect_success \
+	'commit(0): merge commit' \
+	'gitweb_run "p=.git;a=commit"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(0): merge commit' \
+	'gitweb_run "p=.git;a=commitdiff"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'Prepare large commit' \
+	'git checkout b &&
+	 echo "To be changed" > 01-change &&
+	 echo "To be renamed" > 02-pure-rename-from &&
+	 echo "To be deleted" > 03-delete &&
+	 echo "To be renamed and changed" > 04-rename-from &&
+	 echo "To have mode changed" > 05-mode-change &&
+	 echo "File to symlink" > 06-file-or-symlink &&
+	 echo "To be changed and have mode changed" > 07-change-mode-change	&&
+	 git add 0* &&
+	 git commit -a -m "Prepare large commit" &&
+	 echo "Changed" > 01-change &&
+	 git mv 02-pure-rename-from 02-pure-rename-to &&
+	 git rm 03-delete && rm -f 03-delete &&
+	 echo "A new file" > 03-new &&
+	 git add 03-new &&
+	 git mv 04-rename-from 04-rename-to &&
+	 echo "Changed" >> 04-rename-to &&
+	 chmod a+x 05-mode-change &&
+	 rm -f 06-file-or-symlink && ln -s 01-change 06-file-or-symlink &&
+	 echo "Changed and have mode changed" > 07-change-mode-change	&&
+	 chmod a+x 07-change-mode-change &&
+	 git commit -a -m "Large commit" &&
+	 git checkout master'
+
+test_expect_success \
+	'commit(1): large commit' \
+	'gitweb_run "p=.git;a=commit;h=b"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'commitdiff(1): large commit' \
+	'gitweb_run "p=.git;a=commitdiff;h=b"'
+test_debug 'cat gitweb.log'
+
+# ----------------------------------------------------------------------
+# tags testing
+
+test_expect_success \
+	'tags: list of different types of tags' \
+	'git checkout master &&
+	 git tag -a -m "Tag commit object" tag-commit HEAD &&
+	 git tag -a -m "" tag-commit-nomessage HEAD &&
+	 git tag -a -m "Tag tag object" tag-tag tag-commit &&
+	 git tag -a -m "Tag tree object" tag-tree HEAD^{tree} &&
+	 git tag -a -m "Tag blob object" tag-blob HEAD:file &&
+	 git tag lightweight/tag-commit HEAD &&
+	 git tag lightweight/tag-tag tag-commit &&
+	 git tag lightweight/tag-tree HEAD^{tree} &&
+	 git tag lightweight/tag-blob HEAD:file &&
+	 gitweb_run "p=.git;a=tags"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'tag: Tag to commit object' \
+	'gitweb_run "p=.git;a=tag;h=tag-commit"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'tag: on lightweight tag (invalid)' \
+	'gitweb_run "p=.git;a=tag;h=lightweight/tag-commit"'
+test_debug 'cat gitweb.log'
+
+# ----------------------------------------------------------------------
+# logs
+
+test_expect_success \
+	'logs: log (implicit HEAD)' \
+	'gitweb_run "p=.git;a=log"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'logs: shortlog (implicit HEAD)' \
+	'gitweb_run "p=.git;a=shortlog"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'logs: history (implicit HEAD, file)' \
+	'gitweb_run "p=.git;a=history;f=file"'
+test_debug 'cat gitweb.log'
+
+# ----------------------------------------------------------------------
+# feed generation
+
+test_expect_success \
+	'feeds: OPML' \
+	'gitweb_run "a=opml"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'feed: RSS' \
+	'gitweb_run "p=.git;a=rss"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'feed: Atom' \
+	'gitweb_run "p=.git;a=atom"'
+test_debug 'cat gitweb.log'
+
+test_done
-- 
1.5.1.4
