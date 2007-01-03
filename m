From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix "Use of uninitialized value" warning in git_tags_body
Date: Wed, 03 Jan 2007 23:11:53 +0100
Organization: At home
Message-ID: <enh9h8$7l0$2@sea.gmane.org>
References: <11678612691404-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jan 03 23:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2EIJ-0007LL-UN
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 23:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbXACWJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 17:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbXACWJI
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 17:09:08 -0500
Received: from main.gmane.org ([80.91.229.2]:48846 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbXACWJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 17:09:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H2EI0-0007h9-7G
	for git@vger.kernel.org; Wed, 03 Jan 2007 23:08:52 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 23:08:52 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 23:08:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35895>

Jakub Narebski wrote:

> Fix "Use of uninitialized value" warning in git_tags_body generated
> for lightweight tags of tree and blob object; those don't have age
> ($tag{'age'}) defined.

By the way, the latest "Fix warnings" patches for gitweb were result
of working on bare bones test suite for gitweb. For now I'm only
checking if there was anything written to STDERR.

BTW how in portable way to check that given file matches given patterns
in specified order, or matches given patterns in any order?

Below current version of script.

#!/bin/sh
#
# Copyright (c) 2007 Jakub Narebski
#

test_description='gitweb as standalone script (basic tests).

This test runs gitweb (git web interface) as CGI script from
commandline, and checks that it does not spew any errors
or warnings.'

gitweb_init () {
        cat >gitweb_config.perl <<EOF
#!/usr/bin/perl

# gitweb configuration for tests

our \$version = "current";
our \$GIT = "git";
our \$projectroot = "$(pwd)";
our \$home_link_str = "projects";
our \$site_name = "[localhost]";
our \$site_header = "";
our \$site_footer = "";
our \$home_text = "indextext.html";
our @stylesheets = ("file:///$(pwd)/../../gitweb/gitweb.css");
our \$logo = "file:///$(pwd)/../../gitweb/git-logo.png";
our \$favicon = "file:///$(pwd)/../../gitweb/git-favicon.png";
our \$projects_list = "";
our \$export_ok = "";
our \$strict_export = "";
EOF
}

gitweb_run () {
        export GATEWAY_INTERFACE="CGI/1.1"
        export HTTP_ACCEPT="*/*"
        export REQUEST_METHOD="GET"
        export QUERY_STRING=""$1""
        export PATH_INFO=""$2""

        export GITWEB_CONFIG=$(pwd)/gitweb_config.perl

        rm -f gitweb.log &&
        perl -- $(pwd)/../../gitweb/gitweb.perl \
                >/dev/null 2>gitweb.log &&
        test ! -s gitweb.log
}

. ./test-lib.sh

gitweb_init

#test_debug 'cat $(pwd)/gitweb_config.perl'

# ----------------------------------------------------------------------
# no commits

test_expect_success \
        'no commits: projects_list (implicit)' \
        'gitweb_run'
test_debug 'cat gitweb.log'

test_expect_success \
        'no commits: projects_index' \
        'gitweb_run "a=project_index"'
test_debug 'cat gitweb.log'

test_expect_success \
        'no commits: .git summary (implicit)' \
        'gitweb_run "p=.git"'
test_debug 'cat gitweb.log'

test_expect_success \
        'no commits: .git commit (implicit)' \
        'gitweb_run "p=.git;a=commit"'
test_debug 'cat gitweb.log'

test_expect_success \
        'no commits: .git tree (implicit)' \
        'gitweb_run "p=.git;a=tree"'
test_debug 'cat gitweb.log'

test_expect_success \
        'no commits: .git heads (implicit)' \
        'gitweb_run "p=.git;a=heads"'
test_debug 'cat gitweb.log'

test_expect_success \
        'no commits: .git tags (implicit)' \
        'gitweb_run "p=.git;a=tags"'
test_debug 'cat gitweb.log'


# ----------------------------------------------------------------------
# initial commit

test_expect_success \
        'make initial commit' \
        'echo "Not an empty file." > file &&
         git add file &&
         git commit -a -m "Initial commit."'

test_expect_success \
        'projects_list (implicit)' \
        'gitweb_run'
test_debug 'cat gitweb.log'

test_expect_success \
        'projects_index' \
        'gitweb_run "a=project_index"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git summary (implicit)' \
        'gitweb_run "p=.git"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git commit (implicit)' \
        'gitweb_run "p=.git;a=commit"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git commitdiff (implicit)' \
        'gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git commit (HEAD)' \
        'gitweb_run "p=.git;a=commit;h=HEAD"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git commit (..invalid^..)' \
        'gitweb_run "p=.git;a=commit;h=..invalid^.."'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git commit (non-existent)' \
        'gitweb_run "p=.git;a=commit;h=non-existent"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git tree (implicit)' \
        'gitweb_run "p=.git;a=tree"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git tree (0000000000000000000000000000000000000000)' \
        'gitweb_run "p=.git;a=tree;h=0000000000000000000000000000000000000000"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git blob (file)' \
        'gitweb_run "p=.git;a=blob;f=file"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git blob_plain (file)' \
        'gitweb_run "p=.git;a=blob_plain;f=file"'
test_debug 'cat gitweb.log'

test_expect_success \
        '.git blob (non-existent)' \
        'gitweb_run "p=.git;a=blob;f=non-existent"'
test_debug 'cat gitweb.log'

# ----------------------------------------------------------------------
# commitdiff testing

test_expect_success \
        'commitdiff: root' \
        'gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: file added' \
        'echo "New file" > new_file &&
         git add new_file &&
         git commit -a -m "File added." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: mode change' \
        'chmod a+x new_file &&
         git commit -a -m "Mode changed." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: file renamed' \
        'git mv new_file renamed_file &&
         git commit -a -m "File renamed." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: file to symlink' \
        'rm renamed_file &&
         ln -s file renamed_file &&
         git commit -a -m "File to symlink." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: file deleted' \
        'git rm renamed_file &&
         rm -f renamed_file &&
         git commit -a -m "File removed." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: file copied / new file' \
        'cp file file2 &&
         git add file2 &&
         git commit -a -m "File copied." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: mode change and modified' \
        'echo "New line" >> file2 &&
         chmod a+x file2 &&
         git commit -a -m "Mode change and modification." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: renamed and modified' \
        'cat >file2<<EOF &&
Dominus regit me,
et nihil mihi deerit.
In loco pascuae ibi me collocavit,
super aquam refectionis educavit me;
animam meam convertit,
deduxit me super semitas jusitiae,
propter nomen suum.
EOF
         git commit -a -m "File added." &&
         git mv file2 file3 &&
         echo "Propter nomen suum." >> file3 &&
         git commit -a -m "File rename and modification." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

test_expect_success \
        'commitdiff: renamed, mode change and modified' \
        'git mv file3 file2 &&
         echo "Propter nomen suum." >> file2 &&
         chmod a+x file2 &&
         git commit -a -m "File rename, mode change and modification." &&
         gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

# ----------------------------------------------------------------------
# tags testing

test_expect_success \
        'tags: different types of tags' \
        'git tag -a -m "Tag commit object" tag-commit HEAD &&
         git tag -a -m "Tag tag object" tag-tag tag-commit &&
         git tag -a -m "Tag tree object" tag-tree HEAD^{tree} &&
         git tag -a -m "Tag blob object" tag-blob HEAD:file &&
         git tag lightweight/tag-commit HEAD &&
         git tag lightweight/tag-tag tag-commit &&
         git tag lightweight/tag-tree HEAD^{tree} &&
         git tag lightweight/tag-blob HEAD:file &&
         gitweb_run "p=.git;a=tags"'
test_debug 'cat gitweb.log'

test_done
