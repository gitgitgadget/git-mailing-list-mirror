From: Adam Roben <aroben@apple.com>
Subject: [PATCH 10/11] Git.pm: Add hash_and_insert_object and cat_blob
Date: Wed, 23 Apr 2008 15:17:52 -0400
Message-ID: <1208978273-98146-11-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
 <1208978273-98146-5-git-send-email-aroben@apple.com>
 <1208978273-98146-6-git-send-email-aroben@apple.com>
 <1208978273-98146-7-git-send-email-aroben@apple.com>
 <1208978273-98146-8-git-send-email-aroben@apple.com>
 <1208978273-98146-9-git-send-email-aroben@apple.com>
 <1208978273-98146-10-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUy-00058u-IF
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbYDWTSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbYDWTSQ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:16 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:50308 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbYDWTSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:18:06 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 3F2612A6A25E;
	Wed, 23 Apr 2008 12:18:06 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 2237528042;
	Wed, 23 Apr 2008 12:18:06 -0700 (PDT)
X-AuditID: 1180711d-acb99bb000000ed7-43-480f8b6c6c8a
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 09D2B28087;
	Wed, 23 Apr 2008 12:18:04 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-10-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80245>

These functions are more efficient ways of executing `git hash-object -w` and
`git cat-file blob` when you are dealing with many files/objects.

Signed-off-by: Adam Roben <aroben@apple.com>
---
Eric Wong <normalperson@yhbt.net> wrote:
> > diff --git a/perl/Git.pm b/perl/Git.pm
> > index 46c5d10..f23edef 100644
> > --- a/perl/Git.pm
> > +++ b/perl/Git.pm
> > @@ -39,6 +39,9 @@ $VERSION = '0.01';
> >    my $lastrev = $repo->command_oneline( [ 'rev-list', '--all' ],
> >                                          STDERR => 0 );
> >  
> > +  my $sha1 = $repo->hash_and_insert_object('file.txt');
> > +  my $contents = $repo->cat_blob($sha1);
> 
> I missed this the first time around.  But I'd rather be able to pass a
> file handle to cat_blob for writing, instead of returning a potentially
> huge string in memory.

Fixed.

> > @@ -675,6 +677,93 @@ sub hash_object {
> >  }
> >  
> >  
> > +=item hash_and_insert_object ( FILENAME )
> > +
> > +Compute the SHA1 object id of the given C<FILENAME> and add the object to the
> > +object database.
> > +
> > +The function returns the SHA1 hash.
> > +
> > +=cut
> > +
> > +# TODO: Support for passing FILEHANDLE instead of FILENAME
> 
> Filenames are fine for this input since they (are/should be) generated
> by File::Temp and not from an untrusted repo.
> 
> We should, however assert that the caller of this function
> isn't using a stupid filename with "\n" in it.

Fixed.

> > +sub hash_and_insert_object {
> > +   my ($self, $filename) = @_;
> > +
> > +   $self->_open_hash_and_insert_object_if_needed();
> > +   my ($in, $out) = ($self->{hash_object_in}, $self->{hash_object_out});
> > +
> > +   print $out $filename, "\n";
> > +   chomp(my $hash = <$in>);
> > +   return $hash;
> > +}
> > +
> > +sub _open_hash_and_insert_object_if_needed {
> > +   my ($self) = @_;
> > +
> > +   return if defined($self->{hash_object_pid});
> > +
> > +   ($self->{hash_object_pid}, $self->{hash_object_in},
> > +    $self->{hash_object_out}, $self->{hash_object_ctx}) =
> > +           command_bidi_pipe(qw(hash-object -w --stdin-paths));
> > +}
> > +
> > +sub _close_hash_and_insert_object {
> > +   my ($self) = @_;
> > +
> > +   return unless defined($self->{hash_object_pid});
> > +
> > +   my @vars = map { 'hash_object' . $_ } qw(pid in out ctx);
> 
> It looks like you're missing a '_' in there.

Fixed.

> > +=item cat_blob ( SHA1 )
> > +
> > +Returns the contents of the blob identified by C<SHA1>.
> > +
> > +=cut
> > +
> > +sub cat_blob {
> > +   my ($self, $sha1) = @_;
> > +
> > +   $self->_open_cat_blob_if_needed();
> > +   my ($in, $out) = ($self->{cat_blob_in}, $self->{cat_blob_out});
> > +
> > +   print $out $sha1, "\n";
> > +   chomp(my $size = <$in>);
> > +
> > +   my $blob;
> > +   my $result = read($in, $blob, $size);
> > +   defined $result or carp $!;
> > +
> > +   # Skip past the trailing newline.
> > +   read($in, my $newline, 1);
> > +
> > +   return $blob;
> > +}
> 
> However, I'd very much like to be able to pass a file handle to this
> function.  This should read()/print() to a file handle passed to it in a
> loop rather than slurping all of $size at once, since the files we're
> receiving can be huge.

Fixed.

> I'd also be happier if we checked that we actually read $size bytes in
> the loop, and that $newline is actually "\n" to safeguard against bugs
> in cat-blob.

Fixed.

> > +sub _open_cat_blob_if_needed {
> > +   my ($self) = @_;
> > +
> > +   return if defined($self->{cat_blob_pid});
> > +
> > +   ($self->{cat_blob_pid}, $self->{cat_blob_in},
> > +    $self->{cat_blob_out}, $self->{cat_blob_ctx}) =
> > +           command_bidi_pipe(qw(cat-file blob --stdin));
> > +}
> > +
> > +sub _close_cat_blob {
> > +   my ($self) = @_;
> > +
> > +   return unless defined($self->{cat_blob_pid});
> > +
> > +   my @vars = map { 'cat_blob' . $_ } qw(pid in out ctx);
> 
> It looks like you're missing a '_' here, too.

Fixed.

> One more nit, I'm a bit paranoid, but I personally like to die/croak if
> the result of every print()/syswrite() to make sure the pipe we're
> writing to didn't die or if there were other error indicators.

Fixed.

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
1.5.5.1.152.g9aeb7
