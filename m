From: Alexander Klink <ak-git@cynops.de>
Subject: Re: git-svn failure when symlink added in svn
Date: Sat, 28 Apr 2007 13:02:01 +0000 (UTC)
Message-ID: <loom.20070428T144858-521@post.gmane.org>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle> <m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org> <alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 15:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhmZC-0001xD-Dr
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 15:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbXD1NCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 09:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965805AbXD1NCS
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 09:02:18 -0400
Received: from main.gmane.org ([80.91.229.2]:33112 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965292AbXD1NCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 09:02:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HhmYy-0007um-JK
	for git@vger.kernel.org; Sat, 28 Apr 2007 15:02:08 +0200
Received: from IP-213188106106.dialin.heagmedianet.de ([213.188.106.106])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Apr 2007 15:02:08 +0200
Received: from ak-git by IP-213188106106.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Apr 2007 15:02:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.188.106.106 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.0.11) Gecko/20070312 Firefox/1.5.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45778>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

> > trying to read the wrong SHA1 file. If one outputs ce->sha1 before
> >         void *new = read_sha1_file(ce->sha1, &type, size);
> > is called, one gets different output on Linux and Mac OS X.
> > For Seth's example, I get 5f34b0af07646aa529b5b005cde3a9559e606210 on Linux
> > and e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 on Mac OS X ...
> 
> Well, 5f34b0af0 is the "bar.txt" blob, while e69de29b is the empty blob
> 
> So yeah, the printout matches the SHA1's, and the SHA1's are clearly not 
> corrupted: they are just a sign of the fact that the data that was fed to 
> whoever generated the SHA1's was simply different.

The SHA1 hashes are generated in the close_file() function in
git-svn.perl by forking git-hash-object -w --stdin and redirecting
STDIN to the passed filehandle. This is what goes wrong (for some
perl-internal reason?) on Mac OS X. Here is a patch that works
around that by putting the data to be hashed in a temporary file
and calling git-hash-object with a filename.

Best regards,
    Alex

>From 504892b882d05bdf1fbf2325e7544f52115555d1 Mon Sep 17 00:00:00 2001
From: Alexander Klink <ak-git@cynops.de>
Date: Sat, 28 Apr 2007 14:46:27 +0200
Subject: [PATCH] Workaround for git-svn symlink problem on Mac OS X

git-svn had a problem with creating a symlink for a file which existed
as a "real" file beforehand. See the report from Seth Falcon:
http://permalink.gmane.org/gmane.comp.version-control.git/44445
and the test patch by Eric Wong:
http://permalink.gmane.org/gmane.comp.version-control.git/44469

Apparently, the reason for this is that in this case, perl on Mac OS X
does not like the STDIN redirect in close_file() (which forks to
git-hash-object -w --stdin to create the SHA1 hash).
The workaround now creates a temporary file for the git-hash-object input
using File::Temp, calls git-hash-object -w with the filename and safely
unlinks the file afterwards.
---
 git-svn.perl |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 077d6b3..7af45aa 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2266,6 +2266,7 @@ use warnings;
 use Carp qw/croak/;
 use IO::File qw//;
 use Digest::MD5;
+use File::Temp;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -2448,13 +2449,16 @@ sub close_file {
 			$buf eq 'link ' or die "$path has mode 120000",
 			                       "but is not a link\n";
 		}
-		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
-		if (!$pid) {
-			open STDIN, '<&', $fh or croak $!;
-			exec qw/git-hash-object -w --stdin/ or croak $!;
-		}
-		chomp($hash = do { local $/; <$out> });
-		close $out or croak $!;
+
+        # put the data for git-hash-object in a temporary file,
+        # as redirecting STDIN does not always work for some reason on
+        # Mac OS X
+        my ($temp_fh, $temp_filename) = mkstemp("git-hash-input-XXXXXX");
+        print $temp_fh do { local $/; <$fh> };
+
+        chomp($hash = qx(git-hash-object -w $temp_filename));
+        File::Temp::unlink0($temp_fh, $temp_filename)
+            or die "Error unlinking temporary file $temp_filename";
 		close $fh or croak $!;
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 		close $fb->{base} or croak $!;
-- 
1.5.2.rc0.34.gda94-dirty
