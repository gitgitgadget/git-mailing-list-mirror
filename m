From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix "Use of uninitialized value" warning in git_tags_body
Date: Sun, 7 Jan 2007 03:40:00 +0100
Message-ID: <200701070340.01182.jnareb@gmail.com>
References: <11678612691404-git-send-email-jnareb@gmail.com> <enh9h8$7l0$2@sea.gmane.org> <7vsleqjz1u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B2FoFmqOCbyDQtQ"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 03:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NxD-0003rW-OH
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 03:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbXAGCkH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 21:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbXAGCkH
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 21:40:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:8297 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351AbXAGCkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 21:40:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5981839uga
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 18:40:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:message-id;
        b=tU9yoyQiZ2TSCFcITP24QhO9QQOzYKcZLeeK094qTCOPg+jb7JzYF0StXVkqBJCPoOe/JIWFYlozS5jR/lVRB2WD5YpBBSRRWZ7Akuk6b3icoT5fuKAz4Vps0VywXkYGdv0ulAW1gZB6Zj3L7hMnNQWHHyw+x9WWr/WETvsCjR4=
Received: by 10.66.232.10 with SMTP id e10mr31706373ugh.1168137602800;
        Sat, 06 Jan 2007 18:40:02 -0800 (PST)
Received: from host-81-190-18-145.torun.mm.pl ( [81.190.18.145])
        by mx.google.com with ESMTP id y7sm37545933ugc.2007.01.06.18.39.58;
        Sat, 06 Jan 2007 18:40:02 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vsleqjz1u.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36122>

--Boundary-00=_B2FoFmqOCbyDQtQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> Fix "Use of uninitialized value" warning in git_tags_body generated
>>> for lightweight tags of tree and blob object; those don't have age
>>> ($tag{'age'}) defined.
>>
>> By the way, the latest "Fix warnings" patches for gitweb were result
>> of working on bare bones test suite for gitweb. For now I'm only
>> checking if there was anything written to STDERR.
> 
> I think this is a useful thing to have in-tree at this point,
> with perhaps minor tweaks I'd suggest later.  That way other
> people can write more tests to catch regressions.

I plan to submit it soonish... should I submit it early, incomplete,
or first fix it up a bit?

>> BTW how in portable way to check that given file matches given patterns
>> in specified order, or matches given patterns in any order?
> 
> This depends on how different the same page is rendered at
> different times; I suspect the outputs for the same request from
> two runs of the test are expected to be different in age, commit
> and tag object ID and nothing else?

The problem with test for gitweb is that is fairly easy to test
for things that should not change independent of the changes in
output, namely:
 * gitweb should not write warnings and errors to web server log,
   if they result from incorrect parameters (e.g. object not found);
   simple check if anything is written to STDERR
 * the output should be well-formed XHTML (or XML in the case
   of OPML, RSS and Atom fields), but this needs externel tools
   like HTMLtidy
 * HTTP status is well defined, too
 
What is harder to check is that:
 * all the information which should be is there

The goal is to have test which does not change from pass to fail
if we replace ' ' by '&nbsp;', make some fragment hyperlink,
add something, etc...

> If so, I think using test_tick() to force the stable commit
> object ID while your test is building a test repository would be
> a useful thing to do.  Also I think replacing call to "time"
> (you seem to call it from multiple places, all to compute "age")
> with a call to a subroutine "git_time" and then defining:
> 
> 	sub git_time {
>         	if (exists $::ENV{GIT_TEST_TIME}) {
>                 	return $::ENV{GIT_TEST_TIME};
>                 }
>                 return time;
>         }
> 
> to help testing would be sensible.  Set and export GIT_TEST_TIME
> to a fixed time (say, midnight GMT December 28th, 2006) in
> gitweb_init and you will get stable agestring if you have
> already made the commit and author timestamps stable with
> test_tick().

Good idea, nice to know. Even nicer would be to have it described
in t/README...

-- 
Jakub Narebski
Poland

--Boundary-00=_B2FoFmqOCbyDQtQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="t9300-gitweb-standalone-basic.sh"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="t9300-gitweb-standalone-basic.sh"

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
	 git commit -a -m "Initial commit." &&
	 git branch b'

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
	'.git tree (implicit)' \
	'gitweb_run "p=.git;a=tree"'
test_debug 'cat gitweb.log'

test_expect_success \
	'.git blob (file)' \
	'gitweb_run "p=.git;a=blob;f=file"'
test_debug 'cat gitweb.log'

test_expect_success \
	'.git blob_plain (file)' \
	'gitweb_run "p=.git;a=blob_plain;f=file"'
test_debug 'cat gitweb.log'

# ----------------------------------------------------------------------
# nonexistent objects

test_expect_success \
	'.git commit (non-existent)' \
	'gitweb_run "p=.git;a=commit;h=non-existent"'
test_debug 'cat gitweb.log'

test_expect_success \
	'.git commitdiff (non-existent)' \
	'gitweb_run "p=.git;a=commitdiff;h=non-existent"'
test_debug 'cat gitweb.log'

test_expect_success \
	'.git tree (0000000000000000000000000000000000000000)' \
	'gitweb_run "p=.git;a=tree;h=0000000000000000000000000000000000000000"'
test_debug 'cat gitweb.log'

test_expect_success \
	'.git blob (non-existent)' \
	'gitweb_run "p=.git;a=blob;f=non-existent"'
test_debug 'cat gitweb.log'

test_expect_success \
	'.git blob_plain (non-existent)' \
	'gitweb_run "p=.git;a=blob_plain;f=non-existent"'
test_debug 'cat gitweb.log'

# ----------------------------------------------------------------------
# commitdiff testing (implicit, one implicit tree-ish)

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
# commitdiff testing (taken from t4114-apply-typechange.sh)

test_expect_success 'setup typechange commits' '
	echo "hello world" > foo &&
	echo "hi planet" > bar &&
	git update-index --add foo bar &&
	git commit -m initial &&
	git branch initial &&
	rm -f foo &&
	ln -s bar foo &&
	git update-index foo &&
	git commit -m "foo symlinked to bar" &&
	git branch foo-symlinked-to-bar &&
	rm -f foo &&
	echo "how far is the sun?" > foo &&
	git update-index foo &&
	git commit -m "foo back to file" &&
	git branch foo-back-to-file &&
	rm -f foo &&
	git update-index --remove foo &&
	mkdir foo &&
	echo "if only I knew" > foo/baz &&
	git update-index --add foo/baz &&
	git commit -m "foo becomes a directory" &&
	git branch "foo-becomes-a-directory" &&
	echo "hello world" > foo/baz &&
	git update-index foo/baz &&
	git commit -m "foo/baz is the original foo" &&
	git branch foo-baz-renamed-from-foo
	'

test_expect_success \
	'commitdiff(2): file renamed from foo to foo/baz' \
	'gitweb_run "p=.git;a=commitdiff;hp=initial;h=foo-baz-renamed-from-foo"'
test_debug 'cat gitweb.log'

test_expect_success \
	'commitdiff(2): file renamed from foo/baz to foo' \
	'gitweb_run "p=.git;a=commitdiff;hp=foo-baz-renamed-from-foo;h=initial"'
test_debug 'cat gitweb.log'

test_expect_success \
	'commitdiff(2): directory becomes file' \
	'gitweb_run "p=.git;a=commitdiff;hp=foo-becomes-a-directory;h=initial"'
test_debug 'cat gitweb.log'

test_expect_success \
	'commitdiff(2): file becomes directory' \
	'gitweb_run "p=.git;a=commitdiff;hp=initial;h=foo-becomes-a-directory"'
test_debug 'cat gitweb.log'

test_expect_success \
	'commitdiff(2): file becomes symlink' \
	'gitweb_run "p=.git;a=commitdiff;hp=initial;h=foo-symlinked-to-bar"'
test_debug 'cat gitweb.log'

test_expect_success \
	'commitdiff(2): symlink becomes file' \
	'gitweb_run "p=.git;a=commitdiff;hp=foo-symlinked-to-bar;h=foo-back-to-file"'
test_debug 'cat gitweb.log'

test_expect_success \
	'commitdiff(2): symlink becomes directory' \
	'gitweb_run "p=.git;a=commitdiff;hp=foo-symlinked-to-bar;h=foo-becomes-a-directory"'
test_debug 'cat gitweb.log'

test_expect_success \
	'commitdiff(2): directory becomes symlink' \
	'gitweb_run "p=.git;a=commitdiff;hp=foo-becomes-a-directory;h=foo-symlinked-to-bar"'
test_debug 'cat gitweb.log'

# ----------------------------------------------------------------------
# commitdiff large
test_expect_success \
	'create a merge' \
	'git checkout b &&
	 echo "Branch" >> b &&
	 git add b &&
	 git commit -a -m "On branch" &&
	 git checkout master &&
	 git pull . b'

test_expect_success \
	'commitdiff: merge commit' \
	'gitweb_run "p=.git;a=commitdiff"'
test_debug 'cat gitweb.log'

# ----------------------------------------------------------------------
# tags testing

test_expect_success \
	'tags: different types of tags' \
	'git tag -a -m "Tag commit object" tag-commit HEAD &&
	 git tag -a -m "" tag-commit-nomessage HEAD &&
	 git tag -a -m "Tag tag object" tag-tag tag-commit &&
	 git tag -a -m "Tag tree object" tag-tree HEAD^{tree} &&
	 git tag -a -m "Tag blob object" tag-blob HEAD:file &&
	 git tag lightweight/tag-commit HEAD &&
	 git tag lightweight/tag-tag tag-commit &&
	 git tag lightweight/tag-tree HEAD^{tree} &&
	 git tag lightweight/tag-blob HEAD:file &&
	 gitweb_run "p=.git;a=tags"'
test_debug 'cat gitweb.log'

test_expect_success \
	'tag: Tag to commit object' \
	'gitweb_run "p=.git;a=tag;h=tag-commit"'
test_debug 'cat gitweb.log'

test_expect_success \
	'tag: on lightweight tag (invalid)' \
	'gitweb_run "p=.git;a=tag;h=lightweight/tag-commit"'
test_debug 'cat gitweb.log'

test_done

--Boundary-00=_B2FoFmqOCbyDQtQ--
