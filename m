From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Fix git-svn to handle svn not reporting the md5sum of a file, and test.
Date: Sun, 27 May 2007 16:04:02 -0700
Message-ID: <20070527230402.GB27309@muzzle>
References: <1179981426176-git-send-email-foom@fuhm.net> <4659703B.8070101@gmail.com> <20070527172351.GA27309@muzzle> <4659DBC8.2000105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Y Knight <foom@fuhm.net>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 01:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsRmU-0000e5-28
	for gcvg-git@gmane.org; Mon, 28 May 2007 01:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXE0XEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 19:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbXE0XEG
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 19:04:06 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44610 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbXE0XEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 19:04:05 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5894A2DC032;
	Sun, 27 May 2007 16:04:02 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 27 May 2007 16:04:02 -0700
Content-Disposition: inline
In-Reply-To: <4659DBC8.2000105@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48591>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> Eric Wong wrote:
> > A Large Angry SCM <gitzilla@gmail.com> wrote:
> >> James Y Knight wrote:
> >>> ---
> >>> git-svn.perl                    |    2 +-
> >>> t/t9112-git-svn-md5less-file.sh |   45
> >>> +++++++++++++++++++++++++++++++++++++++
> >>> 2 files changed, 46 insertions(+), 1 deletions(-)
> >>> create mode 100755 t/t9112-git-svn-md5less-file.sh
> >> [...]
> >>
> >> The new test fails here (Suse 9.3 fully patched) w/ the following:
> >>
> >> *** t9112-git-svn-md5less-file.sh ***
> >> *   ok 1: load svn dumpfile
> >> *   ok 2: initialize git-svn
> >> * FAIL 3: fetch revisions from svn
> >>         git-svn fetch
> >> * failed 1 among 3 test(s)
> >> make[1]: *** [t9112-git-svn-md5less-file.sh] Error 1
> >
> > I can't reproduce it here (on Debian Etch, SVN 1.4.2).  Can you run with
> > the test with the -v switch?  Thanks.
> >
> 
> 
> ~/GIT/git/t> sh ./t9112-git-svn-md5less-file.sh -v
> * expecting success: svnadmin load /home/test/GIT/git/t/trash/svnrepo < 
> dumpfile.svn
> <<< Started new transaction, based on original revision 1
>      * adding path : md5less-file ... done.
> 
> ------- Committed revision 1 >>>
> 
> *   ok 1: load svn dumpfile
> 
> * expecting success: git-svn init file:///home/test/GIT/git/t/trash/svnrepo
> *   ok 2: initialize git-svn
> 
> * expecting success: git-svn fetch
> ./test-lib.sh: line 141:  8163 Segmentation fault      git-svn fetch
> * FAIL 3: fetch revisions from svn
>         git-svn fetch
> 
> * failed 1 among 3 test(s)
> ~/GIT/git/t>
> 
> 
> And here is the failing part of the test using sh -x:
> 
> + test_expect_success 'fetch revisions from svn' 'git-svn fetch'
> + test 2 = 2
> + test_skip 'fetch revisions from svn' 'git-svn fetch'
> ++ expr ././t9112-git-svn-md5less-file.sh : '.*/\(t[0-9]*\)-[^/]*$'
> + this_test=t9112
> ++ expr 2 + 1
> + this_test=t9112.3
> + to_skip=
> + case "$to_skip" in
> + false
> + say 'expecting success: git-svn fetch'
> + echo '* expecting success: git-svn fetch'
> * expecting success: git-svn fetch
> + test_run_ 'git-svn fetch'
> + eval 'git-svn fetch'
> ++ git-svn fetch
> ./test-lib.sh: line 141:  8276 Segmentation fault      git-svn fetch
> + eval_ret=139
> + return 0
> + '[' 0 = 0 -a 139 = 0 ']'
> + test_failure_ 'fetch revisions from svn' 'git-svn fetch'
> ++ expr 2 + 1
> + test_count=3
> ++ expr 0 + 1
> + test_failure=1
> + say 'FAIL 3: fetch revisions from svn'
> + echo '* FAIL 3: fetch revisions from svn'
> * FAIL 3: fetch revisions from svn
> + shift
> + echo 'git-svn fetch'
> + sed -e 's/^/  /'
>         git-svn fetch
> + test '' = ''
> + echo ''
> 
> This began after the 18bece4..99b5a79 update to master. Prior to that 
> the svn tests were passing.

Thanks.

I'm definitely not able to reproduce this here, and I'm sure Junio
wouldn't have pushed out if he could, either...  Which versions of SVN
and Perl (MD5) do you have?

A backtrace with debugging symbols could be helpful if the below
stab in the dark doesn't work out:

Maybe there's an off chance that the MD5 implementation you're using
can't handle zero-sized files?

Junio: can you apply the following patch regardless of whether or not it
fixes this issue?  It just makes more sense, thanks.

>From 3229470be27589a0428994475b0a597cc549cf78 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sun, 27 May 2007 15:59:01 -0700
Subject: [PATCH] git-svn: avoid md5 calculation entirely if SVN doesn't provide one

There's no point in calculating an MD5 if we're not going to use
it.  We'll also avoid the possibility of there being a bug in the
Perl MD5 library not being able to handle zero-sized files.

This is a followup to 20b3d206acbbb042c7ad5f42d36ff8d036a538c5,
which allows us to track repositories that do not provide MD5
checksums.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eeaeb2d..58f7dd0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2472,12 +2472,16 @@ sub close_file {
 	my $hash;
 	my $path = $self->git_path($fb->{path});
 	if (my $fh = $fb->{fh}) {
-		seek($fh, 0, 0) or croak $!;
-		my $md5 = Digest::MD5->new;
-		$md5->addfile($fh);
-		my $got = $md5->hexdigest;
-		die "Checksum mismatch: $path\n",
-		    "expected: $exp\n    got: $got\n" if (defined $exp && $got ne $exp);
+		if (defined $exp) {
+			seek($fh, 0, 0) or croak $!;
+			my $md5 = Digest::MD5->new;
+			$md5->addfile($fh);
+			my $got = $md5->hexdigest;
+			if ($got ne $exp) {
+				die "Checksum mismatch: $path\n",
+				    "expected: $exp\n    got: $got\n";
+			}
+		}
 		sysseek($fh, 0, 0) or croak $!;
 		if ($fb->{mode_b} == 120000) {
 			sysread($fh, my $buf, 5) == 5 or croak $!;
-- 
Eric Wong
