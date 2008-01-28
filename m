From: Gerrit Pape <pape@smarden.org>
Subject: git-rebase doesn't work when trying to squash changes into commits
	created with --no-verify
Date: Mon, 28 Jan 2008 15:42:32 +0000
Message-ID: <20080128154232.900.qmail@c07ab49f5b12dd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 16:43:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJW8d-0003MU-AV
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 16:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759511AbYA1PmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 10:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759382AbYA1PmP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 10:42:15 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:58594 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759244AbYA1PmO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 10:42:14 -0500
Received: (qmail 901 invoked by uid 1000); 28 Jan 2008 15:42:32 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71893>

Hi, IIRC I managed to reproduce the problem below, but currently don't
have the time to track it down.  Hopefully someone else can work on it,
there's even a patch suggested.

Thanks, Gerrit.


http://bugs.debian.org/458782:

----- Forwarded message from Raphael Hertzog <hertzog@debian.org> -----

Subject: Bug#458782: git-core: git-rebase doesn't work when trying to squash
	changes into commits created with --no-verify
Reply-To: Raphael Hertzog <hertzog@debian.org>, 458782@bugs.debian.org
From: Raphael Hertzog <hertzog@debian.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Date: Wed, 02 Jan 2008 21:27:35 +0100

I recently worked on a branch where I had to commit some test files that
had trailing whitespaces (those files were used in a non-regression test
and the trailing spaces were required and deliberate). Since I have the
standard pre-commit hook enabled, this required me to add --no-verify to
the "git commit" invocation.

Later I discovered a bug in that commit and wanted to merge another change
into it using "git rebase -i" and something like that:
pick 1a5c8d6 The commit created with git commit --no-verify
squash 57e9f03 A bugfix on top of the previous commit
pick 120ecd5 Next commit

The result is that the rebase process failed badly:
Rebasing (14/21)
* You have some suspicious patch lines:
*
* In scripts/t/700_Dpkg_Control.t
* trailing whitespace (line 27)
scripts/t/700_Dpkg_Control.t:27:Empty-Field: 
* trailing whitespace (line 44)
scripts/t/700_Dpkg_Control.t:44:is($src->{'long-field'}, 
* In scripts/t/700_Dpkg_Control/control-1
* trailing whitespace (line 8)
scripts/t/700_Dpkg_Control/control-1:8:empty-field: 
* trailing whitespace (line 9)
scripts/t/700_Dpkg_Control/control-1:9:     
fatal: Entry 'ChangeLog' would be overwritten by merge. Cannot merge.
Automatic cherry-pick failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' and commit the result.
When commiting, use the option '-c 120ecd5' to retain authorship and message.
Could not apply 120ecd5... Next commit

The situation is the following :
- the index contained the result of the pick + squash
- the error message indicated to commit with -c 4c01fe, that is with the
  information coming from the next commit of the rebase process... it
  looks like the rebase process marked the previous step as done when in
  fact the commit wasn't created due to lack of --no-verify.

The (quick) fix is the following :
--- /tmp/git-rebase--interactive	2008-01-02 21:24:00.000000000 +0100
+++ /usr/bin/git-rebase--interactive	2008-01-02 21:24:04.000000000 +0100
@@ -272,7 +272,7 @@
 			# This is like --amend, but with a different message
 			eval "$author_script"
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
-			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
+			$USE_OUTPUT git commit --no-verify -F "$MSG" $EDIT_COMMIT
 			;;
 		t)
 			cp "$MSG" "$GIT_DIR"/MERGE_MSG


-- System Information:
Debian Release: lenny/sid
  APT prefers unstable
  APT policy: (500, 'unstable'), (500, 'testing'), (500, 'stable'), (1, 'experimental')
Architecture: i386 (i686)

Kernel: Linux 2.6.23-1-686 (SMP w/1 CPU core)
Locale: LANG=fr_FR.UTF-8, LC_CTYPE=fr_FR.UTF-8 (charmap=UTF-8)
Shell: /bin/sh linked to /bin/bash

Versions of packages git-core depends on:
ii  cpio                    2.9-9            GNU cpio -- a program to manage ar
ii  libc6                   2.7-5            GNU C Library: Shared libraries
ii  libcurl3-gnutls         7.17.1-1         Multi-protocol file transfer libra
ii  libdigest-sha1-perl     2.11-2           NIST SHA-1 message digest algorith
ii  liberror-perl           0.17-1           Perl module for error/exception ha
ii  libexpat1               1.95.8-4         XML parsing C library - runtime li
ii  perl-modules            5.8.8-12         Core Perl modules
ii  zlib1g                  1:1.2.3.3.dfsg-8 compression library - runtime

Versions of packages git-core recommends:
ii  curl                         7.17.1-1    Get a file from an HTTP, HTTPS or 
ii  git-doc                      1:1.5.3.7-1 fast, scalable, distributed revisi
ii  less                         409-1       Pager program similar to more
ii  openssh-client [ssh-client]  1:4.7p1-1   secure shell client, an rlogin/rsh
ii  patch                        2.5.9-4     Apply a diff file to an original
ii  rsync                        2.6.9-6     fast remote file copy program (lik

-- no debconf information



----- End forwarded message -----
