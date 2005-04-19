From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] Add help details to git help command. (This time with
 Perl)
Date: Tue, 19 Apr 2005 11:35:15 -0600
Message-ID: <42654153.8080307@mesatop.com>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 19:32:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwZW-0005Qo-3x
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVDSRfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVDSRfl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:35:41 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:46432 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261393AbVDSRfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 13:35:20 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher-b.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3JHZIME003752
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 11:35:19 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3JHZFXV013390;
	Tue, 19 Apr 2005 11:35:16 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418102412.GJ1461@pasky.ji.cz>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Mon, Apr 18, 2005 at 06:42:26AM CEST, I got a letter
> where Steven Cole <elenstev@mesatop.com> told me that...

[snippage]

> 
>>This patch will provide the comment lines in the shell script associated
>>with the command, cleaned up a bit for presentation.
>>
>>BUGS: This will also print any comments in the entire file, which may
>>not be desired.  If a command name and shell script filename
>>do not follow the usual convention, this won't work, e.g. ci for commit.
> 
> 
> Hey, those BUGS are the only slightly non-trivial thing on the whole
> thing! I could do this patch myself... ;-) Also, you don't want to print
> the first newline and the Copyright notices.
> 

OK, here is a patch which _may_ do what you want.

This one no longer prints comments embedded later in the file,
and doesn't print the first newline and disposes of the (c) notices
as requested.  And does the right thing for git help ci.

Example:

[steven@spc0 git-pasky-testing]$ ./git help diff
Make a diff between two GIT trees.

By default compares the current working tree to the state at the
last commit. You can specify -r rev1:rev2 or -r rev1 -r rev2 to
tell it to make a diff between the specified revisions. If you
do not specify a revision, the current working tree is implied
(note that no revision is different from empty revision - -r rev:
compares between rev and HEAD, while -r rev compares between rev
and working tree).

-p instead of one ID denotes a parent commit to the specified ID
(which must not be a tree, obviously).

Outputs a diff converting the first tree to the second one.

---------
Speaking of 'git diff', I ran that before applying the following patch,
and got a diff starting thusly:

  --- /dev/null
  +++ b/gitmerge-file.sh

I had earlier done a 'git pull pasky', which was 'Up to date'.

So, the following patch is a conventional diff.

If the Perl filename or code  is too hideous, you're more than
welcome to change it.

Steven
---------
This patch will provide the comment lines in the shell script associated
with the command, cleaned up a bit for presentation.

Thanks to Bob Newell for some Perl help.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

diff -urN git-pasky-orig/git git-pasky-testing/git
--- git-pasky-orig/git	2005-04-19 10:27:54.000000000 -0600
+++ git-pasky-testing/git	2005-04-19 10:19:08.000000000 -0600
@@ -19,6 +19,11 @@


  help () {
+
+command=$1
+scriptfile=git$command.sh
+
+if [ ! $command ]; then
  	cat <<__END__
  The GIT scripted toolkit  $(gitversion.sh)

@@ -48,6 +53,8 @@
  	track		[RNAME]
  	version

+Additional help is available with: git help COMMAND
+
  Note that these expressions can be used interchangably as "ID"s:
  	empty string (current HEAD)
  	remote name (as registered with git addremote)
@@ -56,6 +63,13 @@
  	commit object hash (as returned by commit-id)
  	tree object hash (accepted only by some commands)
  __END__
+fi
+if [ $scriptfile = "gitci.sh" ]; then
+	scriptfile="gitcommit.sh"
+fi
+if [ ! $scriptfile = "git.sh" ]; then
+	print_help_header.pl <$scriptfile  | grep -v "(c)" | cut -c 3-
+fi
  }


diff -urN git-pasky-orig/Makefile git-pasky-testing/Makefile
--- git-pasky-orig/Makefile	2005-04-19 10:27:54.000000000 -0600
+++ git-pasky-testing/Makefile	2005-04-19 10:32:50.000000000 -0600
@@ -21,7 +21,7 @@
  	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
  	gitmerge.sh gitpull.sh gitrm.sh gittag.sh gittrack.sh gitexport.sh \
  	gitapply.sh gitcancel.sh gitXlntree.sh commit-id gitlsremote.sh \
-	gitfork.sh gitinit.sh gitseek.sh gitstatus.sh
+	gitfork.sh gitinit.sh gitseek.sh gitstatus.sh print_help_header.pl

  COMMON=	read-cache.o

diff -urN git-pasky-orig/print_help_header.pl git-pasky-testing/print_help_header.pl
--- git-pasky-orig/print_help_header.pl	1969-12-31 17:00:00.000000000 -0700
+++ git-pasky-testing/print_help_header.pl	2005-04-19 10:24:34.000000000 -0600
@@ -0,0 +1,10 @@
+#!/usr/bin/perl
+#
+# Prints the block of text preceded by #
+# Copyright (c) Steven Cole, 2005
+#
+# reads from stdin   writes to stdout  no error checking
+<STDIN>;<STDIN>;
+while (substr( $line=<STDIN>, 0, 1) eq "#") {
+                 print $line;
+}
