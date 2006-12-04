X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: Re: Set permissions of each new file before "cvs add"ing it.
Date: Mon, 04 Dec 2006 08:55:38 +0100
Message-ID: <87y7poxfgl.fsf@rho.meyering.net>
References: <87ac24zrk0.fsf@rho.meyering.net>
	<7vbqmktmb7.fsf@assigned-by-dhcp.cox.net>
	<7v64cstm0x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 07:55:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v64cstm0x.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 03 Dec 2006 18:47:26 -0800")
Original-Lines: 115
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33170>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr8fw-0001fh-BD for gcvg-git@gmane.org; Mon, 04 Dec
 2006 08:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759029AbWLDHzl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 02:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759027AbWLDHzl
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 02:55:41 -0500
Received: from mx.meyering.net ([82.230.74.64]:1954 "EHLO mx.meyering.net")
 by vger.kernel.org with ESMTP id S1758522AbWLDHzk (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 02:55:40 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 0C83815FF; Mon,  4 Dec 2006 08:55:39 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
>> Jim Meyering <jim@meyering.net> writes:
>>
>>> Without the following patch, git-cvsexportcommit would fail to propagate
>>> permissions of files added in git to the CVS repository...
>> ...
>> Why sed in a Perl script ;-)?

Yeah, yeah, I was rushed.
There are existing uses of `git-ls-tree ... | cut ...` :-)

Ahh.  Your approach is better.

Your patch works fine (once I changed $amodes[] to $amodes{}).
> +my (%amodes);
...
> +	$amodes[$path] = $fields[1];
...
> +    set_new_file_permissions($f, $amodes[$f]);

I tested it with the following script.
New patch below.

Thank you!

--------------------------------------------
#!/bin/sh
rm -rf g c m
mkdir g c
top=`pwd`
cvs_repo=$top/c
(
  cd g
  git-init-db
  touch a
  git-add a
  git-commit -m.
  echo foo > f
  chmod a+x f
  git-add f
  git-commit -m.
)
cvs -Q -d $cvs_repo init
mkdir $cvs_repo/m
cvs -Q -f -q -d $cvs_repo co m
cd m
fail=0
export GIT_DIR=$top/g/.git
git-cvsexportcommit -c -p -v HEAD
test -x f || fail=1
rm -f f a
cvs -Q up
test -x f || fail=1
test -x a && fail=1
exit $fail
--------------------------------
Here's the patch I tested:

From: Jim Meyering <jim@meyering.net>
Date: Mon, 4 Dec 2006 08:44:08 +0100
Subject: Set permissions of each new file before "cvs add"ing it.
Otherwise, an executable script in git would end up being
checked into the CVS repository without the execute bit.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git-cvsexportcommit.perl |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 7bac16e..c9d1d88 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -116,6 +116,7 @@ if ($opt_a) {
 close MSG;

 my (@afiles, @dfiles, @mfiles, @dirs);
+my %amodes;
 my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
 #print @files;
 $? && die "Error in git-diff-tree";
@@ -124,6 +125,7 @@ foreach my $f (@files) {
     my @fields = split(m!\s+!, $f);
     if ($fields[4] eq 'A') {
         my $path = $fields[5];
+	$amodes{$path} = $fields[1];
 	push @afiles, $path;
         # add any needed parent directories
 	$path = dirname $path;
@@ -268,6 +270,7 @@ if (($? >> 8) == 2) {
 }

 foreach my $f (@afiles) {
+    set_new_file_permissions($f, $amodes{$f});
     if (grep { $_ eq $f } @bfiles) {
       system('cvs', 'add','-kb',$f);
     } else {
@@ -342,3 +345,13 @@ sub safe_pipe_capture {
     }
     return wantarray ? @output : join('',@output);
 }
+
+# For any file we want to add to cvs, we must first set its permissions
+# properly, *before* the "cvs add ..." command.  Otherwise, it is impossible
+# to change the permission of the file in the CVS repository using only cvs
+# commands.  This should be fixed in cvs-1.12.14.
+sub set_new_file_permissions {
+    my ($file, $perm) = @_;
+    chmod oct($perm), $file
+      or die "failed to set permissions of \"$file\": $!\n";
+}
--
