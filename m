From: Marcus Griep <marcus@griep.us>
Subject: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Mon, 11 Aug 2008 11:53:53 -0400
Message-ID: <1218470035-13864-2-git-send-email-marcus@griep.us>
References: <489DBB8A.2060207@griep.us>
 <1218470035-13864-1-git-send-email-marcus@griep.us>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZk7-00080k-83
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbYHKPx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755763AbYHKPx6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:53:58 -0400
Received: from boohaunt.net ([209.40.206.144]:33688 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699AbYHKPx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:53:56 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id DE8D51878AB4; Mon, 11 Aug 2008 11:53:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218470035-13864-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91952>

This patch offers a generic interface to allow temp files to be
cached while using an instance of the 'Git' package. If many
temp files are created and destroyed during the execution of a
program, this caching mechanism can help reduce the amount of
files created and destroyed by the filesystem.

There are two methods offered for creating a new file: a no-lock and
a acquire-lock version. The no-lock version provides no
guarantee that a file is not in use or that the temp file may be
stolen by a subsequent request. The acquire-lock version provides a
weak guarantee that a temp file will not be stolen by subsequent
requests even from a no-lock request. If a file is locked when
another acquire request is made, a simple error is thrown.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 perl/Git.pm |  145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index e1ca5b4..fc24f55 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -57,7 +57,8 @@ require Exporter;
                 command_output_pipe command_input_pipe command_close_pipe
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path hash_object git_cmd_try
-                remote_refs);
+                remote_refs
+                temp_acquire temp_release temp_unsafe temp_reset);
 
 
 =head1 DESCRIPTION
@@ -99,7 +100,9 @@ use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
 use Cwd qw(abs_path);
 use IPC::Open2 qw(open2);
-
+use File::Temp ();
+require File::Spec;
+use Fcntl qw(SEEK_SET);
 }
 
 
@@ -933,6 +936,143 @@ sub _close_cat_blob {
 	delete @$self{@vars};
 }
 
+
+{ # %TEMP_* Lexical Context
+
+my (%TEMP_LOCKS, %TEMP_FILES);
+
+=item temp_acquire ( NAME )
+
+Attempts to retreive the temporary file mapped to the string C<NAME>. If an
+associated temp file has not been created this session or was closed, it is
+created, cached, and set for autoflush and binmode.
+
+Internally locks the file mapped to C<NAME>. This lock must be released with
+C<temp_release()> when the temp file is no longer needed. Subsequent attempts
+to retrieve temporary files mapped to the same C<NAME> while still locked will
+cause an error. This locking mechanism provides a weak guarantee and is not
+threadsafe. It does provide some error checking to help prevent temp file refs
+writing over one another.
+
+The L<File::Handle> returned is truncated and seeked to position 0.
+
+In general, the L<File::Handle> returned should not be closed by consumers as
+it defeats the purpose of this caching mechanism. If you need to close the temp
+file handle, then you should use L<File::Temp> or another temp file faculty
+directly. If a handle is closed and then requested again, then a warning will
+issue.
+
+=cut
+
+sub temp_acquire {
+	my ($self, $name) = _maybe_self(@_);
+
+	my $temp_fd = _temp_cache($name);
+
+	$TEMP_LOCKS{$temp_fd} = 1;
+	$temp_fd;
+}
+
+=item temp_release ( NAME [, BOOL] )
+
+=item temp_release ( FILEHANDLE [, BOOL] )
+
+Releases a lock acquired through C<temp_acquire()>. Can be called either with
+the C<NAME> mapping used when acquiring the temp file or with the C<FILEHANDLE>
+referencing a locked temp file.
+
+Warns if an attempt is made to release a file that is not locked.
+
+If called with C<BOOL> true, then the temp file will be truncated before being
+released. This can help to reduce disk I/O where the system is smart enough to
+detect the truncation while data is in the output buffers.
+
+=cut
+
+sub temp_release {
+	my ($self, $temp_fd, $trunc) = _maybe_self(@_);
+
+	if (ref($temp_fd) ne 'File::Temp') {
+		$temp_fd = $TEMP_FILES{$temp_fd};
+	}
+	unless ($TEMP_LOCKS{$temp_fd}) {
+		carp "Attempt to release temp file '$temp_fd' that has not been locked";
+	}
+	temp_reset($temp_fd) if $trunc and $temp_fd->opened;
+
+	$TEMP_LOCKS{$temp_fd} = 0;
+	undef;
+}
+
+=item temp_unsafe ( NAME )
+
+Attempts to retreive the temporary file mapped to the string C<NAME>. If an
+associated temp file has not been created this session or was closed, it is
+created, cached, and set for autoflush and binmode.
+
+If the file mapped to C<NAME> has been locked using C<temp_acquire()>, then
+this method will throw an L<Error::Simple>.
+
+The L<File::Handle> returned is truncated and seeked to position 0.
+
+In general, the L<File::Handle> returned should not be closed by consumers as
+it defeats the purpose of this caching mechanism. If you need to close the temp
+file handle, then you should use L<File::Temp> or another temp file faculty
+directly. If a handle is closed and then requested again, then a warning will
+issue.
+
+=cut
+
+sub temp_unsafe {
+	my ($self, $name) = _maybe_self(@_);
+
+	_temp_cache($name);
+}
+
+sub _temp_cache {
+	my ($name) = @_;
+
+	my $temp_fd = \$TEMP_FILES{$name};
+	if (defined $$temp_fd and $$temp_fd->opened) {
+		if ($TEMP_LOCKS{$$temp_fd}) {
+			throw Error::Simple("Temp file with moniker '$name' already in use");
+		}
+		temp_reset($$temp_fd);
+	} else {
+		if (defined $$temp_fd) { # then we're here because of a closed handle.
+			carp "Temp file '$name' was closed. Opening replacement.";
+		}
+		$$temp_fd = File::Temp->new(
+			TEMPLATE => 'Git_XXXXXX',
+			DIR => File::Spec->tmpdir
+			) or throw Error::Simple("couldn't open new temp file");
+		$$temp_fd->autoflush;
+		binmode $$temp_fd;
+	}
+	$$temp_fd;
+}
+
+=item temp_reset ( FILEHANDLE )
+
+Truncates and resets the position of the C<FILEHANDLE>.  Uses C<sysseek>.
+
+=cut
+
+sub temp_reset {
+	my ($self, $temp_fd) = _maybe_self(@_);
+
+	truncate $temp_fd, 0
+		or throw Error::Simple("couldn't truncate file");
+	sysseek $temp_fd, 0, SEEK_SET
+		or throw Error::Simple("couldn't seek to beginning of file");
+}
+
+sub END {
+	unlink values %TEMP_FILES if %TEMP_FILES;
+}
+
+} # %TEMP_* Lexical Context
+
 =back
 
 =head1 ERROR HANDLING
@@ -1153,6 +1293,7 @@ sub DESTROY {
 	my ($self) = @_;
 	$self->_close_hash_and_insert_object();
 	$self->_close_cat_blob();
+	unlink values %{$self->{temp_files}} if $self->{temp_files};
 }
 
 
-- 
1.6.0.rc2.6.g8eda3
