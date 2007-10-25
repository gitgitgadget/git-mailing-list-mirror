From: Adam Roben <aroben@apple.com>
Subject: [PATCH 8/9] Git.pm: Add hash_and_insert_object and cat_blob
Date: Thu, 25 Oct 2007 03:25:26 -0700
Message-ID: <1193307927-3592-9-git-send-email-aroben@apple.com>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
 <1193307927-3592-2-git-send-email-aroben@apple.com>
 <1193307927-3592-3-git-send-email-aroben@apple.com>
 <1193307927-3592-4-git-send-email-aroben@apple.com>
 <1193307927-3592-5-git-send-email-aroben@apple.com>
 <1193307927-3592-6-git-send-email-aroben@apple.com>
 <1193307927-3592-7-git-send-email-aroben@apple.com>
 <1193307927-3592-8-git-send-email-aroben@apple.com>
Cc: Junio Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 12:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikzvk-0007WS-UZ
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460AbXJYK0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756074AbXJYK0X
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:26:23 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:63571 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141AbXJYK0H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:26:07 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 246E91639CF5;
	Thu, 25 Oct 2007 03:26:06 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 0887C280AC;
	Thu, 25 Oct 2007 03:26:06 -0700 (PDT)
X-AuditID: 11807134-a8e60bb000000c52-48-47206f3d5498
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id DDCD7280AB;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1342.g32de
In-Reply-To: <1193307927-3592-8-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62304>

These functions are more efficient ways of executing `git hash-object -w` and
`git cat-file blob` when you are dealing with many files/objects.

Signed-off-by: Adam Roben <aroben@apple.com>
---
Eric Wong wrote:
> > +package Git::Commands;
> 
> Can this be a separate file, or a part of Git.pm?  I'm sure other
> scripts can eventually use this and I've been meaning to split
> git-svn.perl into separate files so it's easier to follow.

I ended up making it part of Git.pm, because I realized that made far more
sense than splitting it into a separate file.

 perl/Git.pm |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 46c5d10..f23edef 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -39,6 +39,9 @@ $VERSION = '0.01';
   my $lastrev = $repo->command_oneline( [ 'rev-list', '--all' ],
                                         STDERR => 0 );
 
+  my $sha1 = $repo->hash_and_insert_object('file.txt');
+  my $contents = $repo->cat_blob($sha1);
+
 =cut
 
 
@@ -218,7 +221,6 @@ sub repository {
 	bless $self, $class;
 }
 
-
 =back
 
 =head1 METHODS
@@ -675,6 +677,93 @@ sub hash_object {
 }
 
 
+=item hash_and_insert_object ( FILENAME )
+
+Compute the SHA1 object id of the given C<FILENAME> and add the object to the
+object database.
+
+The function returns the SHA1 hash.
+
+=cut
+
+# TODO: Support for passing FILEHANDLE instead of FILENAME
+sub hash_and_insert_object {
+	my ($self, $filename) = @_;
+
+	$self->_open_hash_and_insert_object_if_needed();
+	my ($in, $out) = ($self->{hash_object_in}, $self->{hash_object_out});
+
+	print $out $filename, "\n";
+	chomp(my $hash = <$in>);
+	return $hash;
+}
+
+sub _open_hash_and_insert_object_if_needed {
+	my ($self) = @_;
+
+	return if defined($self->{hash_object_pid});
+
+	($self->{hash_object_pid}, $self->{hash_object_in},
+	 $self->{hash_object_out}, $self->{hash_object_ctx}) =
+		command_bidi_pipe(qw(hash-object -w --stdin-paths));
+}
+
+sub _close_hash_and_insert_object {
+	my ($self) = @_;
+
+	return unless defined($self->{hash_object_pid});
+
+	my @vars = map { 'hash_object' . $_ } qw(pid in out ctx);
+
+	command_close_bidi_pipe($self->{@vars});
+	delete $self->{@vars};
+}
+
+=item cat_blob ( SHA1 )
+
+Returns the contents of the blob identified by C<SHA1>.
+
+=cut
+
+sub cat_blob {
+	my ($self, $sha1) = @_;
+
+	$self->_open_cat_blob_if_needed();
+	my ($in, $out) = ($self->{cat_blob_in}, $self->{cat_blob_out});
+
+	print $out $sha1, "\n";
+	chomp(my $size = <$in>);
+
+	my $blob;
+	my $result = read($in, $blob, $size);
+	defined $result or carp $!;
+
+	# Skip past the trailing newline.
+	read($in, my $newline, 1);
+
+	return $blob;
+}
+
+sub _open_cat_blob_if_needed {
+	my ($self) = @_;
+
+	return if defined($self->{cat_blob_pid});
+
+	($self->{cat_blob_pid}, $self->{cat_blob_in},
+	 $self->{cat_blob_out}, $self->{cat_blob_ctx}) =
+		command_bidi_pipe(qw(cat-file blob --stdin));
+}
+
+sub _close_cat_blob {
+	my ($self) = @_;
+
+	return unless defined($self->{cat_blob_pid});
+
+	my @vars = map { 'cat_blob' . $_ } qw(pid in out ctx);
+
+	command_close_bidi_pipe($self->{@vars});
+	delete $self->{@vars};
+}
 
 =back
 
@@ -892,7 +981,11 @@ sub _cmd_close {
 }
 
 
-sub DESTROY { }
+sub DESTROY {
+	my ($self) = @_;
+	$self->_close_hash_and_insert_object();
+	$self->_close_cat_blob();
+}
 
 
 # Pipe implementation for ActiveState Perl.
-- 
1.5.3.4.1342.g32de
