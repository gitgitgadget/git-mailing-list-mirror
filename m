From: Mark Lodato <lodatom@gmail.com>
Subject: [BUG] bugs in clean, status, bisect, and send-email
Date: Wed, 24 Feb 2010 22:28:41 -0500
Message-ID: <ca433831002241928hef29dadu39f93bc1a8460331@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 04:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkUPW-0006Vl-Vp
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 04:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758835Ab0BYD3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 22:29:05 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:47064 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab0BYD3C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 22:29:02 -0500
Received: by ywh35 with SMTP id 35so2979983ywh.4
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 19:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=eySh0oAfQQQzESyZWWCxZyz4A+LXRHc3v07vep66Bek=;
        b=UNjwzKWv80xy6KPTZGx3WkpgpPKePnrbsSa/oVLJ1iujr+RK+4x5QJCrySB4yaFTaP
         CVLqdsVYSj/19GMz63YCRRbgUnZAvXvRCRQeiGeaPZro4yKTuvvPkqP/dpLO230rcWTa
         wcopZQG3CacTQCpcNjndKkIB4CN1McBeYwzeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Yu6Mw+WW014T5ejgHznQo6hH35dg+0fuzPo5Uj2M+3wt3SmD3Od4kmLaRyRP2yszGI
         sLGvR5QxLQ5WJCwX3myuMAGNtVwn/rTZam9GpkciOBR6olynefGCGn7H1HikfGmeUbt6
         stWaQNrlhp4s9oZpRrc/nZFFi/JpZHhdzKb4M=
Received: by 10.90.245.1 with SMTP id s1mr686694agh.72.1267068541111; Wed, 24 
	Feb 2010 19:29:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141023>

I noticed the following four bugs but don't have time to investigate
further, let alone make test cases or fix them.  If someone else wants
to tackle these, great.  If not, I'll try to research them more when I
get free time, which won't be for a while.

All of the following have been tested with git 1.7.0, and the first
three examples use a new, empty repository.

$ mkdir test_dir
$ cd test_dir
$ git init


1. git-clean removes directories when a glob partially matches

If the pathspec given to 'git clean' has the potential to match a file
in a subdirectory (even if no matching file exists in that directory),
the entire directory is removed.  In the following example, none of
the commands should try to remove dir/.

$ mkdir dir
$ touch dir/file
$ git clean -nd 'x*'
$ git clean -nd '*.c'
Would remove dir/
$ git clean -nd 'd*j'
Would remove dir/


2. git-status globs only match untracked files, not staged or unmodified

The last command should show that b.c is staged and modified, but
instead it shows absolutely nothing.  If this is intended behavior,
it's certainly not what I would expect.

$ touch a.txt b.c
$ git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       a.txt
#       b.c
nothing added to commit but untracked files present (use "git add" to track)
$ git status -- '*.c'
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       b.c
nothing added to commit but untracked files present (use "git add" to track)
$ git add b.c
$ echo foo >> b.c
$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file:   b.c
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   b.c
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       a.txt
$ git status -- '*.c'
# On branch master
#
# Initial commit
#
nothing to commit (create/copy files and use "git add" to track)


3. git-send-email does not accept -h option

All other git sub-commands accept -h, so it would probably be a good
idea to implement it for 'git send-email' as well.

$ git send-email -h
usage: git format-patch [options] [<since> | <revision range>]

    -n, --numbered        use [PATCH n/m] even with a single patch
    -N, --no-numbered     use [PATCH] even with multiple patches
    -s, --signoff         add Signed-off-by:
    --stdout              print patches to standard out
    --cover-letter        generate a cover letter
    --numbered-files      use simple number sequence for output file names
    --suffix <sfx>        use <sfx> instead of '.patch'
    --start-number <n>    start numbering patches at <n> instead of 1
    --subject-prefix <prefix>
                          Use [<prefix>] instead of [PATCH]
    -o, --output-directory <dir>
                          store resulting files in <dir>
    -k, --keep-subject    don't strip/add [PATCH]
    --no-binary           don't output binary diffs
    --ignore-if-in-upstream
                          don't include a patch matching a commit upstream
    -p, --no-stat         show patch format instead of default (patch + stat)

Messaging
    --add-header <header>
                          add email header
    --cc <email>          add Cc: header
    --in-reply-to <message-id>
                          make first mail a reply to <message-id>
    --attach[=<boundary>]
                          attach the patch
    --inline[=<boundary>]
                          inline the patch
    --thread[=<style>]    enable message threading, styles: shallow, deep

format-patch -o /tmp/ipOBB8AaCU -h: command returned error: 129


4. git-bisect fails if a pathspec is given that matches no commits

It says there are -1 revisions left.  I have no idea what it does
after that.  The following example uses git.git.

$ git bisect start v1.7.0 v1.6.6 -- 'foobar'
Bisecting: -1 revisions left to test after this (roughly 0 steps)
[f2a37151d4624906e34a9bcafb2ad79d0e8cb7ec] Fix memory leak in helper
method for disconnect
