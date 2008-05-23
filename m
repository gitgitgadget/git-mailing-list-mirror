From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 5/8] Git.pm: Add hash_and_insert_object and cat_blob
Date: Fri, 23 May 2008 16:19:40 +0200
Message-ID: <1211552384-29636-6-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY57-00066y-9z
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbYEWOQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbYEWOQW
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:22 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51554 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753539AbYEWOQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:14 -0400
Received: (qmail 32513 invoked by uid 89); 23 May 2008 14:14:55 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:54 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82702>

From: Adam Roben <aroben@apple.com>

These functions are more efficient ways of executing `git hash-object -w` and
`git cat-file blob` when you are dealing with many files/objects.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 perl/Git.pm |  152 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index d766974..6ba8ee5 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -39,6 +39,10 @@ $VERSION = '0.01';
   my $lastrev = $repo->command_oneline( [ 'rev-list', '--all' ],
                                         STDERR => 0 );
 
+  my $sha1 = $repo->hash_and_insert_object('file.txt');
+  my $tempfile = tempfile();
+  my $size = $repo->cat_blob($sha1, $tempfile);
+
 =cut
 
 
@@ -218,7 +222,6 @@ sub repository {
 	bless $self, $class;
 }
 
-
 =back
 
 =head1 METHODS
@@ -734,6 +737,147 @@ sub hash_object {
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
+	carp "Bad filename \"$filename\"" if $filename =~ /[\r\n]/;
+
+	$self->_open_hash_and_insert_object_if_needed();
+	my ($in, $out) = ($self->{hash_object_in}, $self->{hash_object_out});
+
+	unless (print $out $filename, "\n") {
+		$self->_close_hash_and_insert_object();
+		throw Error::Simple("out pipe went bad");
+	}
+
+	chomp(my $hash = <$in>);
+	unless (defined($hash)) {
+		$self->_close_hash_and_insert_object();
+		throw Error::Simple("in pipe went bad");
+	}
+
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
+	my @vars = map { 'hash_object_' . $_ } qw(pid in out ctx);
+
+	command_close_bidi_pipe($self->{@vars});
+	delete $self->{@vars};
+}
+
+=item cat_blob ( SHA1, FILEHANDLE )
+
+Prints the contents of the blob identified by C<SHA1> to C<FILEHANDLE> and
+returns the number of bytes printed.
+
+=cut
+
+sub cat_blob {
+	my ($self, $sha1, $fh) = @_;
+
+	$self->_open_cat_blob_if_needed();
+	my ($in, $out) = ($self->{cat_blob_in}, $self->{cat_blob_out});
+
+	unless (print $out $sha1, "\n") {
+		$self->_close_cat_blob();
+		throw Error::Simple("out pipe went bad");
+	}
+
+	my $description = <$in>;
+	if ($description =~ / missing$/) {
+		carp "$sha1 doesn't exist in the repository";
+		return 0;
+	}
+
+	if ($description !~ /^[0-9a-fA-F]{40} \S+ (\d+)$/) {
+		carp "Unexpected result returned from git cat-file";
+		return 0;
+	}
+
+	my $size = $1;
+
+	my $blob;
+	my $bytesRead = 0;
+
+	while (1) {
+		my $bytesLeft = $size - $bytesRead;
+		last unless $bytesLeft;
+
+		my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
+		my $read = read($in, $blob, $bytesToRead, $bytesRead);
+		unless (defined($read)) {
+			$self->_close_cat_blob();
+			throw Error::Simple("in pipe went bad");
+		}
+
+		$bytesRead += $read;
+	}
+
+	# Skip past the trailing newline.
+	my $newline;
+	my $read = read($in, $newline, 1);
+	unless (defined($read)) {
+		$self->_close_cat_blob();
+		throw Error::Simple("in pipe went bad");
+	}
+	unless ($read == 1 && $newline eq "\n") {
+		$self->_close_cat_blob();
+		throw Error::Simple("didn't find newline after blob");
+	}
+
+	unless (print $fh $blob) {
+		$self->_close_cat_blob();
+		throw Error::Simple("couldn't write to passed in filehandle");
+	}
+
+	return $size;
+}
+
+sub _open_cat_blob_if_needed {
+	my ($self) = @_;
+
+	return if defined($self->{cat_blob_pid});
+
+	($self->{cat_blob_pid}, $self->{cat_blob_in},
+	 $self->{cat_blob_out}, $self->{cat_blob_ctx}) =
+		command_bidi_pipe(qw(cat-file --batch));
+}
+
+sub _close_cat_blob {
+	my ($self) = @_;
+
+	return unless defined($self->{cat_blob_pid});
+
+	my @vars = map { 'cat_blob_' . $_ } qw(pid in out ctx);
+
+	command_close_bidi_pipe($self->{@vars});
+	delete $self->{@vars};
+}
 
 =back
 
@@ -951,7 +1095,11 @@ sub _cmd_close {
 }
 
 
-sub DESTROY { }
+sub DESTROY {
+	my ($self) = @_;
+	$self->_close_hash_and_insert_object();
+	$self->_close_cat_blob();
+}
 
 
 # Pipe implementation for ActiveState Perl.
-- 
1.5.5.1
