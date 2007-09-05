From: Mike Hommey <mh@glandium.org>
Subject: Significant performance waste in git-svn and friends
Date: Wed, 5 Sep 2007 20:47:10 +0200
Organization: glandium.org
Message-ID: <20070905184710.GA3632@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 20:48:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISzus-0003DN-Ov
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 20:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbXIESrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 14:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbXIESrt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 14:47:49 -0400
Received: from vawad.err.no ([85.19.200.177]:36564 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987AbXIESrs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 14:47:48 -0400
Received: from aputeaux-153-1-85-89.w86-205.abo.wanadoo.fr ([86.205.43.89] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ISzuj-0000aP-SQ
	for git@vger.kernel.org; Wed, 05 Sep 2007 20:47:49 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1ISzuA-00012q-9u
	for git@vger.kernel.org; Wed, 05 Sep 2007 20:47:10 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57738>

Hi,

Being a pervert abusing the way subversion doesn't deal with branches
and tags, I'm actually not a user of git-svn or git-svnimport, because
they just can't deal easily with my perversion. So I'm writing a script
to do the conversion for me, and since I also like to learn new things
when I'm coding, I'm writing it in ruby.

Anyways, one of the things I'm trying to convert is my svk repository
for debian packaging of xulrunner (so, a significant subset of the
mozilla tree), which doesn't involve a lot of revisions (around 280,
because I only imported releases or CVS snapshots), but involves a lot
of files (roughly 20k).

The first thing I noticed when twisting around the svk repo so that
git-svn could somehow import it a while ago, is that running git-svn
was in my case significantly slower than svnadmin dump | svnadmin load
(more than 2 times slower).

And now, with my own script, I got the same kind of "slowdown". So I
investigated it, and it didn't take long to realize that replacing
git-hash-object by a simple reimplementation in ruby was *way* faster.
git-hash-object being more than probably what you do the most when you
import a remote repository, it is not much of a surprise that forking
thousands of times is a huge performance waste.

So, just for the record, I did a lame hack of git-svn to see what kind
of speedup could happen in git-svn. You can find this lame hack as a
patch below. I did some tests (with a 1.5.2.1 release) and here are the
results, importing only the trunk (192 revisions), with no checkout, and
redirecting stdout to /dev/null:

original git-svn:
real    25m1.871s
user    8m51.593s
sys     12m31.659s

patched git-svn:
real    14m45.870s
user    7m31.928s
sys     4m1.047s

Some notes about the patch:
- I've not looked at the rest of the code to see if there was a way to
  get the size of the file so that SHA-1 sum and compression could be
  done in one pass and without copying the whole file in memory.
- The object creation in the .git/objects directory is not as safe as
  what git-hash-object does.

Some notes about git-svn:
- A few lines above the patched zone, the file is already read once to
  do the MD5 sum. It should be possible to do SHA-1, MD5 sums and
  deflate in just one pass.
- It might be worth testing if git-cat-file is called a lot. If so,
  implementing a simple git-cat-file equivalent that would work for
  unpacked objects could improve speed.

The same things obviously apply to git-cvsimport and other scripts
calling git-hash-object a lot.

Mike

diff --git a/git-svn.perl b/git-svn.perl
index d3c8cd0..202c228 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2417,6 +2417,8 @@ use warnings;
 use Carp qw/croak/;
 use IO::File qw//;
 use Digest::MD5;
+use Digest::SHA1;
+use Compress::Zlib;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -2603,15 +2605,26 @@ sub close_file {
 			$buf eq 'link ' or die "$path has mode 120000",
 			                       "but is not a link\n";
 		}
-		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
-		if (!$pid) {
-			open STDIN, '<&', $fh or croak $!;
-			exec qw/git-hash-object -w --stdin/ or croak $!;
+		my $size = 0;
+		my $buf = "";
+		while (my $read = sysread $fh, my $tmp, 4096) {
+			$size += $read;
+			$buf .= $tmp;
 		}
-		chomp($hash = do { local $/; <$out> });
-		close $out or croak $!;
+		my $sha1 = Digest::SHA1->new;
+		$sha1->add("blob $size\0");
+		$sha1->add($buf);
+		$hash = $sha1->hexdigest;
 		close $fh or croak $!;
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
+		my $blob_dir = "$ENV{GIT_DIR}/objects/" . substr($hash, 0, 2);
+		my $blob_file = $blob_dir . "/" . substr($hash, 2);
+		if (! -f $blob_file) {
+			mkdir $blob_dir unless -d $blob_dir;
+			open BLOB, ">$blob_file";
+			print BLOB compress("blob $size\0" . $buf);
+			close BLOB;
+		}
 		close $fb->{base} or croak $!;
 	} else {
 		$hash = $fb->{blob} or die "no blob information\n";
