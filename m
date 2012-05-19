From: Subho Sankar Banerjee <subs.zero@gmail.com>
Subject: [PATCH][GIT.PM 2/3] Getting rid of throwing Error::Simple objects in favour of simple Perl scalars which can be caught in eval{} blocks
Date: Sat, 19 May 2012 12:38:36 +0530
Message-ID: <1337411317-14931-2-git-send-email-subs.zero@gmail.com>
References: <7vobpulhbk.fsf@alter.siamese.dyndns.org>
 <1337411317-14931-1-git-send-email-subs.zero@gmail.com>
Cc: Subho Sankar Banerjee <subs.zero@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 09:09:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVdn5-0006lj-1w
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 09:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779Ab2ESHJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 03:09:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46365 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab2ESHJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 03:09:10 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4725603dad.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=STetWU9bXxtXq6La6N3gD7JH7EjmdRBWlndmm1DLMbs=;
        b=AV3tt8Vx368xi5C+ed19YSvdntgIUfHor7ZBnvqS5o8kMKP5jQGTizhmeIs9EsyH4k
         Vxhgu0n3HaQ7iBKWw29ZqBCtwuHjTd4LCGspPKLpy9J1rRAqKr/i+EK61pPRk9NGQvx0
         tq9oqaQhV+zjxsdTCROkJ2nEdglaYvDync4RjVbkr1odQmr7Js9aVwzBqIeyCulFvFki
         5jbP4ZMVtC528NePTm+LYgiWjHcs+mMHDtwmfbsBQijruBu2fUzM8st//xiLT5UsoxdY
         43pEVFQcE9SitPzM6VzNjRMOwJoymXOfWldkF0+3QxUQSM3/MIAzH97dm0jlfTKe11Li
         d5FQ==
Received: by 10.68.232.129 with SMTP id to1mr25684340pbc.27.1337411350403;
        Sat, 19 May 2012 00:09:10 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-120.61.158.30.mtnl.net.in. [120.61.158.30])
        by mx.google.com with ESMTPS id rj4sm15424408pbc.30.2012.05.19.00.09.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 00:09:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1337411317-14931-1-git-send-email-subs.zero@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198021>


Signed-off-by: Subho Sankar Banerjee <subs.zero@gmail.com>
---
 perl/Git.pm |   52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 497f420..52777d4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -160,7 +160,7 @@ sub repository {
 	if (defined $args[0]) {
 		if ($#args % 2 != 1) {
 			# Not a hash.
-			$#args == 0 or throw Error::Simple("bad usage");
+			$#args == 0 or die "bad usage";
 			%opts = ( Directory => $args[0] );
 		} else {
 			%opts = @args;
@@ -173,7 +173,7 @@ sub repository {
 	}
 
 	if (defined $opts{Directory}) {
-		-d $opts{Directory} or throw Error::Simple("Directory not found: $opts{Directory} $!");
+		-d $opts{Directory} or die "Directory not found: $opts{Directory} $!";
 
 		my $search = Git->repository(WorkingCopy => $opts{Directory});
 		my $dir;
@@ -193,7 +193,7 @@ sub repository {
 			$dir = abs_path($opts{Directory}) . '/';
 			if ($prefix) {
 				if (substr($dir, -length($prefix)) ne $prefix) {
-					throw Error::Simple("rev-parse confused me - $dir does not have trailing $prefix");
+					die "rev-parse confused me - $dir does not have trailing $prefix";
 				}
 				substr($dir, -length($prefix)) = '';
 			}
@@ -206,14 +206,14 @@ sub repository {
 
 			unless (-d "$dir/refs" and -d "$dir/objects" and -e "$dir/HEAD") {
 				# Mimic git-rev-parse --git-dir error message:
-				throw Error::Simple("fatal: Not a git repository: $dir");
+				die "fatal: Not a git repository: $dir";
 			}
 			my $search = Git->repository(Repository => $dir);
 			try {
 				$search->command('symbolic-ref', 'HEAD');
 			} catch Git::Error::Command with {
 				# Mimic git-rev-parse --git-dir error message:
-				throw Error::Simple("fatal: Not a git repository: $dir");
+				die "fatal: Not a git repository: $dir";
 			}
 
 			$opts{Repository} = abs_path($dir);
@@ -469,7 +469,7 @@ sub command_noisy {
 
 	my $pid = fork;
 	if (not defined $pid) {
-		throw Error::Simple("fork failed: $!");
+		die "fork failed: $!";
 	} elsif ($pid == 0) {
 		_cmd_exec($self, $cmd, @args);
 	}
@@ -552,10 +552,10 @@ and the directory must exist.
 sub wc_chdir {
 	my ($self, $subdir) = @_;
 	$self->wc_path()
-		or throw Error::Simple("bare repository");
+		or die "bare repository";
 
 	-d $self->wc_path().'/'.$subdir
-		or throw Error::Simple("subdir not found: $subdir $!");
+		or die "subdir not found: $subdir $!";
 	# Of course we will not "hold" the subdirectory so anyone
 	# can delete it now and we will never know. But at least we tried.
 
@@ -825,13 +825,13 @@ sub hash_and_insert_object {
 
 	unless (print $out $filename, "\n") {
 		$self->_close_hash_and_insert_object();
-		throw Error::Simple("out pipe went bad");
+		die "out pipe went bad";
 	}
 
 	chomp(my $hash = <$in>);
 	unless (defined($hash)) {
 		$self->_close_hash_and_insert_object();
-		throw Error::Simple("in pipe went bad");
+		die "in pipe went bad";
 	}
 
 	return $hash;
@@ -873,7 +873,7 @@ sub cat_blob {
 
 	unless (print $out $sha1, "\n") {
 		$self->_close_cat_blob();
-		throw Error::Simple("out pipe went bad");
+		die "out pipe went bad";
 	}
 
 	my $description = <$in>;
@@ -900,7 +900,7 @@ sub cat_blob {
 		my $read = read($in, $blob, $bytesToRead, $bytesRead);
 		unless (defined($read)) {
 			$self->_close_cat_blob();
-			throw Error::Simple("in pipe went bad");
+			die "in pipe went bad";
 		}
 
 		$bytesRead += $read;
@@ -911,16 +911,16 @@ sub cat_blob {
 	my $read = read($in, $newline, 1);
 	unless (defined($read)) {
 		$self->_close_cat_blob();
-		throw Error::Simple("in pipe went bad");
+		die "in pipe went bad";
 	}
 	unless ($read == 1 && $newline eq "\n") {
 		$self->_close_cat_blob();
-		throw Error::Simple("didn't find newline after blob");
+		die "didn't find newline after blob";
 	}
 
 	unless (print $fh $blob) {
 		$self->_close_cat_blob();
-		throw Error::Simple("couldn't write to passed in filehandle");
+    die "couldn't write to passed in filehandle";
 	}
 
 	return $size;
@@ -1023,8 +1023,8 @@ sub _temp_cache {
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
 		if ($TEMP_FILES{$$temp_fd}{locked}) {
-			throw Error::Simple("Temp file with moniker '" .
-				$name . "' already in use");
+			die "Temp file with moniker '" .
+				$name . "' already in use";
 		}
 	} else {
 		if (defined $$temp_fd) {
@@ -1041,7 +1041,7 @@ sub _temp_cache {
 
 		($$temp_fd, $fname) = File::Temp->tempfile(
 			'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
-			) or throw Error::Simple("couldn't open new temp file");
+			) or die "couldn't open new temp file";
 
 		$$temp_fd->autoflush;
 		binmode $$temp_fd;
@@ -1052,7 +1052,7 @@ sub _temp_cache {
 
 sub _verify_require {
 	eval { require File::Temp; require File::Spec; };
-	$@ and throw Error::Simple($@);
+	$@ and die "$@";
 }
 
 =item temp_reset ( FILEHANDLE )
@@ -1065,11 +1065,11 @@ sub temp_reset {
 	my ($self, $temp_fd) = _maybe_self(@_);
 
 	truncate $temp_fd, 0
-		or throw Error::Simple("couldn't truncate file");
+		or die "couldn't truncate file";
 	sysseek($temp_fd, 0, SEEK_SET) and seek($temp_fd, 0, SEEK_SET)
-		or throw Error::Simple("couldn't seek to beginning of file");
+		or die "couldn't seek to beginning of file";
 	sysseek($temp_fd, 0, SEEK_CUR) == 0 and tell($temp_fd) == 0
-		or throw Error::Simple("expected file position to be reset");
+		or die "expected file position to be reset";
 }
 
 =item temp_path ( NAME )
@@ -1100,8 +1100,8 @@ sub END {
 =head1 ERROR HANDLING
 
 All functions are supposed to throw Perl exceptions in case of errors.
-See the L<Error> module on how to catch those. Most exceptions are mere
-L<Error::Simple> instances.
+These errors are perl scalars which can be caught in the $@ values in
+eval{} blocks.
 
 However, the C<command()>, C<command_oneline()> and C<command_noisy()>
 functions suite can throw C<Git::Error::Command> exceptions as well: those are
@@ -1227,7 +1227,7 @@ sub _maybe_self {
 # Check if the command id is something reasonable.
 sub _check_valid_cmd {
 	my ($cmd) = @_;
-	$cmd =~ /^[a-z0-9A-Z_-]+$/ or throw Error::Simple("bad command: $cmd");
+	$cmd =~ /^[a-z0-9A-Z_-]+$/ or die "bad command: $cmd";
 }
 
 # Common backend for the pipe creators.
@@ -1261,7 +1261,7 @@ sub _command_common_pipe {
 	} else {
 		my $pid = open($fh, $direction);
 		if (not defined $pid) {
-			throw Error::Simple("open failed: $!");
+			die "open failed: $!";
 		} elsif ($pid == 0) {
 			if (defined $opts{STDERR}) {
 				close STDERR;
-- 
1.7.9.5
