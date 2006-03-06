From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] annotate: Support annotation of files on other revisions.
Date: Sun, 5 Mar 2006 21:43:53 -0500
Message-ID: <20060306024353.GA23001@mythryan2.michonline.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se> <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 03:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG5ig-0005dU-Ub
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 03:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWCFCoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 21:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWCFCoz
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 21:44:55 -0500
Received: from mail.autoweb.net ([198.172.237.26]:19383 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750706AbWCFCoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 21:44:55 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FG5iM-0004Ik-83; Sun, 05 Mar 2006 21:44:51 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG5iF-0004vt-W7; Sun, 05 Mar 2006 21:44:44 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FG5hq-0004rN-7d; Sun, 05 Mar 2006 21:44:18 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17265>


This is a bug fix, and cleans up one or two other things spotted during the
course of tracking down the main bug here.

Also, the test-suite is updated to reflect this case.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 git-annotate.perl   |    7 +++++--
 t/t8001-annotate.sh |    6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

On Mon, Mar 06, 2006 at 01:29:32PM +1300, Martin Langhoff wrote:
> On 3/6/06, Ryan Anderson <ryan@michonline.com> wrote:
> > Along these lines, if anyone can pin down the complicated cases that
> > annotate and blame get differently, adding them as a test would be
> > *exceedingly* appreciated, even if it makes annotate (or blame) fail for
> > a bit, it gives us something to work against.
> 
> It would be great if they both worked properly with paths that existed
> in the past. Right now, I can't git-annotate or git-blame a file I
> know was there in a past revision. I think I had taught Johannes'
> annotate to deal with this, or at least intended to. As things stand,
> git-annotate/git-blame need a checkout, which is really silly.

annotate was *trying* to handle that cleanly, but failed due to a silly
bug.  This is the same bug that Junio pointed out:
	cd t
	./t8001-annotate.sh
	cd trash
	../../git-annotate file master

This is fixed by the patch at the end of this email.

> Tools like gitweb and cvsserver should be able to do:
> 
>   GIT_DIR=/somebarerepo/git.git git-(annotate|blame) -h headname Makefile
> 
> and not worry about creating a temporary index *and* checking out
> Makefile so that things work. That's what cvsserver does now, anyway.
> Ugly :-(

For annotate, the syntax I was using was:
	git annotate Makefile headname

I'm not married to it, so please, send a patch to change it if you want
(Please fix up the test case I'm sending in this patch, as well.)

cdd80fd28d300dd2400bf75ff64ae2bf1a8b92aa
diff --git a/git-annotate.perl b/git-annotate.perl
index d93ee19..5953ac6 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -10,6 +10,7 @@ use warnings;
 use strict;
 use Getopt::Long;
 use POSIX qw(strftime gmtime);
+use Data::Dumper;
 
 sub usage() {
 	print STDERR 'Usage: ${\basename $0} [-s] [-S revs-file] file [ revision ]
@@ -99,7 +100,7 @@ while (my $bound = pop @stack) {
 	}
 }
 push @revqueue, $head;
-init_claim( defined $starting_rev ? $starting_rev : 'dirty');
+init_claim( defined $starting_rev ? $head : 'dirty');
 unless (defined $starting_rev) {
 	my $diff = open_pipe("git","diff","-R", "HEAD", "--",$filename)
 		or die "Failed to call git diff to check for dirty state: $!";
@@ -345,6 +346,7 @@ sub git_cat_file {
 	return () unless defined $rev && defined $filename;
 
 	my $blob = git_ls_tree($rev, $filename);
+	die "Failed to find a blob for $filename in rev $rev\n" if !defined $blob;
 
 	my $catfile = open_pipe("git","cat-file", "blob", $blob)
 		or die "Failed to git-cat-file blob $blob (rev $rev, file $filename): " . $!;
@@ -367,12 +369,13 @@ sub git_ls_tree {
 
 	my ($mode, $type, $blob, $tfilename);
 	while(<$lstree>) {
+		chomp;
 		($mode, $type, $blob, $tfilename) = split(/\s+/, $_, 4);
 		last if ($tfilename eq $filename);
 	}
 	close($lstree);
 
-	return $blob if $filename eq $filename;
+	return $blob if ($tfilename eq $filename);
 	die "git-ls-tree failed to find blob for $filename";
 
 }
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index 172908a..761d0bc 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -87,4 +87,10 @@ test_expect_success \
     'One line blamed on B2' \
     '[ $(git annotate file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
 
+test_expect_success \
+    'Annotating an old revision works' \
+    '[ $(git annotate file master | awk "{print \$3}" | grep -c "^A$") == 2 ] && \
+     [ $(git annotate file master | awk "{print \$3}" | grep -c "^B$") == 2 ]'
+
+
 test_done
-- 
1.2.4.g9201-dirty



-- 

Ryan Anderson
  sometimes Pug Majere
