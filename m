From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 22/25] contrib: remove 'fast-import'
Date: Thu,  8 May 2014 19:58:33 -0500
Message-ID: <1399597116-1851-23-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZLU-0001an-Ql
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbaEIBLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:11:22 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:49924 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013AbaEIBLT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:11:19 -0400
Received: by mail-yh0-f43.google.com with SMTP id f10so3150891yha.2
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B1lUIZPAl1jvKnyllFaxEiWCq41YfPtHgoZKLv2SPDg=;
        b=UGj8yajMF3H1veMSWlbwPUYplyMtJCMFRHVcdCMA0nJTi21UfSj3d7WgfkT1zwh8QW
         BiSXdvnYd5+nKf4hfywMn51VfIZWx8xgL8gfUQxtarZPl3SWbri/bQzz+Qvcvc5lXsiY
         rGcedMjHEu+C+CDVqIHflz01bxouhXK3WmHbvxnmwJvJVR0pDBh/S95OOr7raMizVdah
         swdKU8H/FQLYEnUZPCw0mvNQGsmwafYWzvOlbeaPeY42nu272F3XJ/jceIJBouU1uELv
         fCj71zMmE3VI5r6g8W7PnDu/7cPVr1RZCw8AE+iPALZiKVOMAUzB9hU6uFjLYoKdeLS5
         fKZQ==
X-Received: by 10.236.169.233 with SMTP id n69mr10092046yhl.110.1399597877472;
        Thu, 08 May 2014 18:11:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id g1sm3918120yho.37.2014.05.08.18.11.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:11:15 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248489>

No tests, no documentation.

No chance of ever graduating.

Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/fast-import/git-import.perl         |  64 -----
 contrib/fast-import/git-import.sh           |  38 ---
 contrib/fast-import/git-p4.README           |  12 -
 contrib/fast-import/import-directories.perl | 417 ----------------------------
 contrib/fast-import/import-tars.perl        | 189 -------------
 contrib/fast-import/import-zips.py          |  78 ------
 6 files changed, 798 deletions(-)
 delete mode 100755 contrib/fast-import/git-import.perl
 delete mode 100755 contrib/fast-import/git-import.sh
 delete mode 100644 contrib/fast-import/git-p4.README
 delete mode 100755 contrib/fast-import/import-directories.perl
 delete mode 100755 contrib/fast-import/import-tars.perl
 delete mode 100755 contrib/fast-import/import-zips.py

diff --git a/contrib/fast-import/git-import.perl b/contrib/fast-import/git-import.perl
deleted file mode 100755
index 0891b9e..0000000
--- a/contrib/fast-import/git-import.perl
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/usr/bin/perl
-#
-# Performs an initial import of a directory. This is the equivalent
-# of doing 'git init; git add .; git commit'. It's a little slower,
-# but is meant to be a simple fast-import example.
-
-use strict;
-use File::Find;
-
-my $USAGE = 'usage: git-import branch import-message';
-my $branch = shift or die "$USAGE\n";
-my $message = shift or die "$USAGE\n";
-
-chomp(my $username = `git config user.name`);
-chomp(my $email = `git config user.email`);
-die 'You need to set user name and email'
-  unless $username && $email;
-
-system('git init');
-open(my $fi, '|-', qw(git fast-import --date-format=now))
-  or die "unable to spawn fast-import: $!";
-
-print $fi <<EOF;
-commit refs/heads/$branch
-committer $username <$email> now
-data <<MSGEOF
-$message
-MSGEOF
-
-EOF
-
-find(
-  sub {
-    if($File::Find::name eq './.git') {
-      $File::Find::prune = 1;
-      return;
-    }
-    return unless -f $_;
-
-    my $fn = $File::Find::name;
-    $fn =~ s#^.\/##;
-
-    open(my $in, '<', $_)
-      or die "unable to open $fn: $!";
-    my @st = stat($in)
-      or die "unable to stat $fn: $!";
-    my $len = $st[7];
-
-    print $fi "M 644 inline $fn\n";
-    print $fi "data $len\n";
-    while($len > 0) {
-      my $r = read($in, my $buf, $len < 4096 ? $len : 4096);
-      defined($r) or die "read error from $fn: $!";
-      $r > 0 or die "premature EOF from $fn: $!";
-      print $fi $buf;
-      $len -= $r;
-    }
-    print $fi "\n";
-
-  }, '.'
-);
-
-close($fi);
-exit $?;
diff --git a/contrib/fast-import/git-import.sh b/contrib/fast-import/git-import.sh
deleted file mode 100755
index f8d803c..0000000
--- a/contrib/fast-import/git-import.sh
+++ /dev/null
@@ -1,38 +0,0 @@
-#!/bin/sh
-#
-# Performs an initial import of a directory. This is the equivalent
-# of doing 'git init; git add .; git commit'. It's a lot slower,
-# but is meant to be a simple fast-import example.
-
-if [ -z "$1" -o -z "$2" ]; then
-	echo "usage: git-import branch import-message"
-	exit 1
-fi
-
-USERNAME="$(git config user.name)"
-EMAIL="$(git config user.email)"
-
-if [ -z "$USERNAME" -o -z "$EMAIL" ]; then
-	echo "You need to set user name and email"
-	exit 1
-fi
-
-git init
-
-(
-	cat <<EOF
-commit refs/heads/$1
-committer $USERNAME <$EMAIL> now
-data <<MSGEOF
-$2
-MSGEOF
-
-EOF
-	find * -type f|while read i;do
-		echo "M 100644 inline $i"
-		echo data $(stat -c '%s' "$i")
-		cat "$i"
-		echo
-	done
-	echo
-) | git fast-import --date-format=now
diff --git a/contrib/fast-import/git-p4.README b/contrib/fast-import/git-p4.README
deleted file mode 100644
index cec5ecf..0000000
--- a/contrib/fast-import/git-p4.README
+++ /dev/null
@@ -1,12 +0,0 @@
-The git-p4 script moved to the top-level of the git source directory.
-
-Invoke it as any other git command, like "git p4 clone", for instance.
-
-Note that the top-level git-p4.py script is now the source.  It is
-built using make to git-p4, which will be installed.
-
-Windows users can copy the git-p4.py source script directly, possibly
-invoking it through a batch file called "git-p4.bat" in the same folder.
-It should contain just one line:
-
-    @python "%~d0%~p0git-p4.py" %*
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-import/import-directories.perl
deleted file mode 100755
index 4dec1f1..0000000
--- a/contrib/fast-import/import-directories.perl
+++ /dev/null
@@ -1,417 +0,0 @@
-#!/usr/bin/perl
-#
-# Copyright 2008-2009 Peter Krefting <peter@softwolves.pp.se>
-#
-# ------------------------------------------------------------------------
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-#
-# ------------------------------------------------------------------------
-
-=pod
-
-=head1 NAME
-
-import-directories - Import bits and pieces to Git.
-
-=head1 SYNOPSIS
-
-B<import-directories.perl> F<configfile> F<outputfile>
-
-=head1 DESCRIPTION
-
-Script to import arbitrary projects version controlled by the "copy the
-source directory to a new location and edit it there"-version controlled
-projects into version control. Handles projects with arbitrary branching
-and version trees, taking a file describing the inputs and generating a
-file compatible with the L<git-fast-import(1)> format.
-
-=head1 CONFIGURATION FILE
-
-=head2 Format
-
-The configuration file is based on the standard I<.ini> format.
-
- ; Comments start with semi-colons
- [section]
- key=value
-
-Please see below for information on how to escape special characters.
-
-=head2 Global configuration
-
-Global configuration is done in the B<[config]> section, which should be
-the first section in the file. Configuration can be changed by
-repeating configuration sections later on.
-
- [config]
- ; configure conversion of CRLFs. "convert" means that all CRLFs
- ; should be converted into LFs (suitable for the core.autocrlf
- ; setting set to true in Git). "none" means that all data is
- ; treated as binary.
- crlf=convert
-
-=head2 Revision configuration
-
-Each revision that is to be imported is described in three
-sections. Revisions should be defined in topological order, so
-that a revision's parent has always been defined when a new revision
-is introduced. All the sections for one revision must be defined
-before defining the next revision.
-
-Each revision is assigned a unique numerical identifier. The
-numbers do not need to be consecutive, nor monotonically
-increasing.
-
-For instance, if your configuration file contains only the two
-revisions 4711 and 42, where 4711 is the initial commit, the
-only requirement is that 4711 is completely defined before 42.
-
-=pod
-
-=head3 Revision description section
-
-A section whose section name is just an integer gives meta-data
-about the revision.
-
- [3]
- ; author sets the author of the revisions
- author=Peter Krefting <peter@softwolves.pp.se>
- ; branch sets the branch that the revision should be committed to
- branch=master
- ; parent describes the revision that is the parent of this commit
- ; (optional)
- parent=1
- ; merges describes a revision that is merged into this commit
- ; (optional; can be repeated)
- merges=2
- ; selects one file to take the timestamp from
- ; (optional; if unspecified, the most recent file from the .files
- ;  section is used)
- timestamp=3/source.c
-
-=head3 Revision contents section
-
-A section whose section name is an integer followed by B<.files>
-describe all the files included in this revision. If a file that
-was available previously is not included in this revision, it will
-be removed.
-
-If an on-disk revision is incomplete, you can point to files from
-a previous revision. There are no restrictions on where the source
-files are located, nor on their names.
-
- [3.files]
- ; the key is the path inside the repository, the value is the path
- ; as seen from the importer script.
- source.c=ver-3.00/source.c
- source.h=ver-2.99/source.h
- readme.txt=ver-3.00/introduction to the project.txt
-
-File names are treated as byte strings (but please see below on
-quoting rules), and should be stored in the configuration file in
-the encoding that should be used in the generated repository.
-
-=head3 Revision commit message section
-
-A section whose section name is an integer followed by B<.message>
-gives the commit message. This section is read verbatim, up until
-the beginning of the next section. As such, a commit message may not
-contain a line that begins with an opening square bracket ("[") and
-ends with a closing square bracket ("]"), unless they are surrounded
-by whitespace or other characters.
-
- [3.message]
- Implement foobar.
- ; trailing blank lines are ignored.
-
-=cut
-
-# Globals
-use strict;
-use warnings;
-use integer;
-my $crlfmode = 0;
-my @revs;
-my (%revmap, %message, %files, %author, %branch, %parent, %merges, %time, %timesource);
-my $sectiontype = 0;
-my $rev = 0;
-my $mark = 1;
-
-# Check command line
-if ($#ARGV < 1 || $ARGV[0] =~ /^--?h/)
-{
-    exec('perldoc', $0);
-    exit 1;
-}
-
-# Open configuration
-my $config = $ARGV[0];
-open CFG, '<', $config or die "Cannot open configuration file \"$config\": ";
-
-# Open output
-my $output = $ARGV[1];
-open OUT, '>', $output or die "Cannot create output file \"$output\": ";
-binmode OUT;
-
-LINE: while (my $line = <CFG>)
-{
-	$line =~ s/\r?\n$//;
-	next LINE if $sectiontype != 4 && $line eq '';
-	next LINE if $line =~ /^;/;
-	my $oldsectiontype = $sectiontype;
-	my $oldrev = $rev;
-
-	# Sections
-	if ($line =~ m"^\[(config|(\d+)(|\.files|\.message))\]$")
-	{
-		if ($1 eq 'config')
-		{
-			$sectiontype = 1;
-		}
-		elsif ($3 eq '')
-		{
-			$sectiontype = 2;
-			$rev = $2;
-			# Create a new revision
-			die "Duplicate rev: $line\n " if defined $revmap{$rev};
-			print "Reading revision $rev\n";
-			push @revs, $rev;
-			$revmap{$rev} = $mark ++;
-			$time{$revmap{$rev}} = 0;
-		}
-		elsif ($3 eq '.files')
-		{
-			$sectiontype = 3;
-			$rev = $2;
-			die "Revision mismatch: $line\n " unless $rev == $oldrev;
-		}
-		elsif ($3 eq '.message')
-		{
-			$sectiontype = 4;
-			$rev = $2;
-			die "Revision mismatch: $line\n " unless $rev == $oldrev;
-		}
-		else
-		{
-			die "Internal parse error: $line\n ";
-		}
-		next LINE;
-	}
-
-	# Parse data
-	if ($sectiontype != 4)
-	{
-		# Key and value
-		if ($line =~ m"^\s*([^\s].*=.*[^\s])\s*$")
-		{
-			my ($key, $value) = &parsekeyvaluepair($1);
-			# Global configuration
-			if (1 == $sectiontype)
-			{
-				if ($key eq 'crlf')
-				{
-					$crlfmode = 1, next LINE if $value eq 'convert';
-					$crlfmode = 0, next LINE if $value eq 'none';
-				}
-				die "Unknown configuration option: $line\n ";
-			}
-			# Revision specification
-			if (2 == $sectiontype)
-			{
-				my $current = $revmap{$rev};
-				$author{$current} = $value, next LINE if $key eq 'author';
-				$branch{$current} = $value, next LINE if $key eq 'branch';
-				$parent{$current} = $value, next LINE if $key eq 'parent';
-				$timesource{$current} = $value, next LINE if $key eq 'timestamp';
-				push(@{$merges{$current}}, $value), next LINE if $key eq 'merges';
-				die "Unknown revision option: $line\n ";
-			}
-			# Filespecs
-			if (3 == $sectiontype)
-			{
-				# Add the file and create a marker
-				die "File not found: $line\n " unless -f $value;
-				my $current = $revmap{$rev};
-				${$files{$current}}{$key} = $mark;
-				my $time = &fileblob($value, $crlfmode, $mark ++);
-
-				# Update revision timestamp if more recent than other
-				# files seen, or if this is the file we have selected
-				# to take the time stamp from using the "timestamp"
-				# directive.
-				if ((defined $timesource{$current} && $timesource{$current} eq $value)
-				    || $time > $time{$current})
-				{
-					$time{$current} = $time;
-				}
-			}
-		}
-		else
-		{
-			die "Parse error: $line\n ";
-		}
-	}
-	else
-	{
-		# Commit message
-		my $current = $revmap{$rev};
-		if (defined $message{$current})
-		{
-			$message{$current} .= "\n";
-		}
-		$message{$current} .= $line;
-	}
-}
-close CFG;
-
-# Start spewing out data for git-fast-import
-foreach my $commit (@revs)
-{
-	# Progress
-	print OUT "progress Creating revision $commit\n";
-
-	# Create commit header
-	my $mark = $revmap{$commit};
-
-	# Branch and commit id
-	print OUT "commit refs/heads/", $branch{$mark}, "\nmark :", $mark, "\n";
-
-	# Author and timestamp
-	die "No timestamp defined for $commit (no files?)\n" unless defined $time{$mark};
-	print OUT "committer ", $author{$mark}, " ", $time{$mark}, " +0100\n";
-
-	# Commit message
-	die "No message defined for $commit\n" unless defined $message{$mark};
-	my $message = $message{$mark};
-	$message =~ s/\n$//; # Kill trailing empty line
-	print OUT "data ", length($message), "\n", $message, "\n";
-
-	# Parent and any merges
-	print OUT "from :", $revmap{$parent{$mark}}, "\n" if defined $parent{$mark};
-	if (defined $merges{$mark})
-	{
-		foreach my $merge (@{$merges{$mark}})
-		{
-			print OUT "merge :", $revmap{$merge}, "\n";
-		}
-	}
-
-	# Output file marks
-	print OUT "deleteall\n"; # start from scratch
-	foreach my $file (sort keys %{$files{$mark}})
-	{
-		print OUT "M 644 :", ${$files{$mark}}{$file}, " $file\n";
-	}
-	print OUT "\n";
-}
-
-# Create one file blob
-sub fileblob
-{
-	my ($filename, $crlfmode, $mark) = @_;
-
-	# Import the file
-	print OUT "progress Importing $filename\nblob\nmark :$mark\n";
-	open FILE, '<', $filename or die "Cannot read $filename\n ";
-	binmode FILE;
-	my ($size, $mtime) = (stat(FILE))[7,9];
-	my $file;
-	read FILE, $file, $size;
-	close FILE;
-	$file =~ s/\r\n/\n/g if $crlfmode;
-	print OUT "data ", length($file), "\n", $file, "\n";
-
-	return $mtime;
-}
-
-# Parse a key=value pair
-sub parsekeyvaluepair
-{
-=pod
-
-=head2 Escaping special characters
-
-Key and value strings may be enclosed in quotes, in which case
-whitespace inside the quotes is preserved. Additionally, an equal
-sign may be included in the key by preceding it with a backslash.
-For example:
-
- "key1 "=value1
- key2=" value2"
- key\=3=value3
- key4=value=4
- "key5""=value5
-
-Here the first key is "key1 " (note the trailing white-space) and the
-second value is " value2" (note the leading white-space). The third
-key contains an equal sign "key=3" and so does the fourth value, which
-does not need to be escaped. The fifth key contains a trailing quote,
-which does not need to be escaped since it is inside a surrounding
-quote.
-
-=cut
-	my $pair = shift;
-
-	# Separate key and value by the first non-quoted equal sign
-	my ($key, $value);
-	if ($pair =~ /^(.*[^\\])=(.*)$/)
-	{
-		($key, $value) = ($1, $2)
-	}
-	else
-	{
-		die "Parse error: $pair\n ";
-	}
-
-	# Unquote and unescape the key and value separately
-	return (&unescape($key), &unescape($value));
-}
-
-# Unquote and unescape
-sub unescape
-{
-	my $string = shift;
-
-	# First remove enclosing quotes. Backslash before the trailing
-	# quote leaves both.
-	if ($string =~ /^"(.*[^\\])"$/)
-	{
-		$string = $1;
-	}
-
-	# Second remove any backslashes inside the unquoted string.
-	# For later: Handle special sequences like \t ?
-	$string =~ s/\\(.)/$1/g;
-
-	return $string;
-}
-
-__END__
-
-=pod
-
-=head1 EXAMPLES
-
-B<import-directories.perl> F<project.import>
-
-=head1 AUTHOR
-
-Copyright 2008-2009 Peter Krefting E<lt>peter@softwolves.pp.se>
-
-This program is free software; you can redistribute it and/or modify
-it under the terms of the GNU General Public License as published by
-the Free Software Foundation.
-
-=cut
diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
deleted file mode 100755
index 95438e1..0000000
--- a/contrib/fast-import/import-tars.perl
+++ /dev/null
@@ -1,189 +0,0 @@
-#!/usr/bin/perl
-
-## tar archive frontend for git-fast-import
-##
-## For example:
-##
-##  mkdir project; cd project; git init
-##  perl import-tars.perl *.tar.bz2
-##  git whatchanged import-tars
-##
-## Use --metainfo to specify the extension for a meta data file, where
-## import-tars can read the commit message and optionally author and
-## committer information.
-##
-##  echo 'This is the commit message' > myfile.tar.bz2.msg
-##  perl import-tars.perl --metainfo=msg myfile.tar.bz2
-
-use strict;
-use Getopt::Long;
-
-my $metaext = '';
-
-die "usage: import-tars [--metainfo=extension] *.tar.{gz,bz2,lzma,xz,Z}\n"
-	unless GetOptions('metainfo=s' => \$metaext) && @ARGV;
-
-my $branch_name = 'import-tars';
-my $branch_ref = "refs/heads/$branch_name";
-my $author_name = $ENV{'GIT_AUTHOR_NAME'} || 'T Ar Creator';
-my $author_email = $ENV{'GIT_AUTHOR_EMAIL'} || 'tar@example.com';
-my $committer_name = $ENV{'GIT_COMMITTER_NAME'} || `git config --get user.name`;
-my $committer_email = $ENV{'GIT_COMMITTER_EMAIL'} || `git config --get user.email`;
-
-chomp($committer_name, $committer_email);
-
-open(FI, '|-', 'git', 'fast-import', '--quiet')
-	or die "Unable to start git fast-import: $!\n";
-foreach my $tar_file (@ARGV)
-{
-	my $commit_time = time;
-	$tar_file =~ m,([^/]+)$,;
-	my $tar_name = $1;
-
-	if ($tar_name =~ s/\.(tar\.gz|tgz)$//) {
-		open(I, '-|', 'gunzip', '-c', $tar_file)
-			or die "Unable to gunzip -c $tar_file: $!\n";
-	} elsif ($tar_name =~ s/\.(tar\.bz2|tbz2)$//) {
-		open(I, '-|', 'bunzip2', '-c', $tar_file)
-			or die "Unable to bunzip2 -c $tar_file: $!\n";
-	} elsif ($tar_name =~ s/\.tar\.Z$//) {
-		open(I, '-|', 'uncompress', '-c', $tar_file)
-			or die "Unable to uncompress -c $tar_file: $!\n";
-	} elsif ($tar_name =~ s/\.(tar\.(lzma|xz)|(tlz|txz))$//) {
-		open(I, '-|', 'xz', '-dc', $tar_file)
-			or die "Unable to xz -dc $tar_file: $!\n";
-	} elsif ($tar_name =~ s/\.tar$//) {
-		open(I, $tar_file) or die "Unable to open $tar_file: $!\n";
-	} else {
-		die "Unrecognized compression format: $tar_file\n";
-	}
-
-	my $author_time = 0;
-	my $next_mark = 1;
-	my $have_top_dir = 1;
-	my ($top_dir, %files);
-
-	while (read(I, $_, 512) == 512) {
-		my ($name, $mode, $uid, $gid, $size, $mtime,
-			$chksum, $typeflag, $linkname, $magic,
-			$version, $uname, $gname, $devmajor, $devminor,
-			$prefix) = unpack 'Z100 Z8 Z8 Z8 Z12 Z12
-			Z8 Z1 Z100 Z6
-			Z2 Z32 Z32 Z8 Z8 Z*', $_;
-		last unless length($name);
-		if ($name eq '././@LongLink') {
-			# GNU tar extension
-			if (read(I, $_, 512) != 512) {
-				die ('Short archive');
-			}
-			$name = unpack 'Z257', $_;
-			next unless $name;
-
-			my $dummy;
-			if (read(I, $_, 512) != 512) {
-				die ('Short archive');
-			}
-			($dummy, $mode, $uid, $gid, $size, $mtime,
-			$chksum, $typeflag, $linkname, $magic,
-			$version, $uname, $gname, $devmajor, $devminor,
-			$prefix) = unpack 'Z100 Z8 Z8 Z8 Z12 Z12
-			Z8 Z1 Z100 Z6
-			Z2 Z32 Z32 Z8 Z8 Z*', $_;
-		}
-		next if $name =~ m{/\z};
-		$mode = oct $mode;
-		$size = oct $size;
-		$mtime = oct $mtime;
-		next if $typeflag == 5; # directory
-
-		print FI "blob\n", "mark :$next_mark\n";
-		if ($typeflag == 2) { # symbolic link
-			print FI "data ", length($linkname), "\n", $linkname;
-			$mode = 0120000;
-		} else {
-			print FI "data $size\n";
-			while ($size > 0 && read(I, $_, 512) == 512) {
-				print FI substr($_, 0, $size);
-				$size -= 512;
-			}
-		}
-		print FI "\n";
-
-		my $path;
-		if ($prefix) {
-			$path = "$prefix/$name";
-		} else {
-			$path = "$name";
-		}
-		$files{$path} = [$next_mark++, $mode];
-
-		$author_time = $mtime if $mtime > $author_time;
-		$path =~ m,^([^/]+)/,;
-		$top_dir = $1 unless $top_dir;
-		$have_top_dir = 0 if $top_dir ne $1;
-	}
-
-	my $commit_msg = "Imported from $tar_file.";
-	my $this_committer_name = $committer_name;
-	my $this_committer_email = $committer_email;
-	my $this_author_name = $author_name;
-	my $this_author_email = $author_email;
-	if ($metaext ne '') {
-		# Optionally read a commit message from <filename.tar>.msg
-		# Add a line on the form "Committer: name <e-mail>" to override
-		# the committer and "Author: name <e-mail>" to override the
-		# author for this tar ball.
-		if (open MSG, '<', "${tar_file}.${metaext}") {
-			my $header_done = 0;
-			$commit_msg = '';
-			while (<MSG>) {
-				if (!$header_done && /^Committer:\s+([^<>]*)\s+<(.*)>\s*$/i) {
-					$this_committer_name = $1;
-					$this_committer_email = $2;
-				} elsif (!$header_done && /^Author:\s+([^<>]*)\s+<(.*)>\s*$/i) {
-					$this_author_name = $1;
-					$this_author_email = $2;
-				} elsif (!$header_done && /^$/) { # empty line ends header.
-					$header_done = 1;
-				} else {
-					$commit_msg .= $_;
-					$header_done = 1;
-				}
-			}
-			close MSG;
-		}
-	}
-
-	print FI <<EOF;
-commit $branch_ref
-author $this_author_name <$this_author_email> $author_time +0000
-committer $this_committer_name <$this_committer_email> $commit_time +0000
-data <<END_OF_COMMIT_MESSAGE
-$commit_msg
-END_OF_COMMIT_MESSAGE
-
-deleteall
-EOF
-
-	foreach my $path (keys %files)
-	{
-		my ($mark, $mode) = @{$files{$path}};
-		$path =~ s,^([^/]+)/,, if $have_top_dir;
-		$mode = $mode & 0111 ? 0755 : 0644 unless $mode == 0120000;
-		printf FI "M %o :%i %s\n", $mode, $mark, $path;
-	}
-	print FI "\n";
-
-	print FI <<EOF;
-tag $tar_name
-from $branch_ref
-tagger $author_name <$author_email> $author_time +0000
-data <<END_OF_TAG_MESSAGE
-Package $tar_name
-END_OF_TAG_MESSAGE
-
-EOF
-
-	close I;
-}
-close FI;
diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
deleted file mode 100755
index d12c296..0000000
--- a/contrib/fast-import/import-zips.py
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/usr/bin/env python
-
-## zip archive frontend for git-fast-import
-##
-## For example:
-##
-##  mkdir project; cd project; git init
-##  python import-zips.py *.zip
-##  git log --stat import-zips
-
-from os import popen, path
-from sys import argv, exit, hexversion, stderr
-from time import mktime
-from zipfile import ZipFile
-
-if hexversion < 0x01060000:
-    # The limiter is the zipfile module
-    stderr.write("import-zips.py: requires Python 1.6.0 or later.\n")
-    exit(1)
-
-if len(argv) < 2:
-    print 'usage:', argv[0], '<zipfile>...'
-    exit(1)
-
-branch_ref = 'refs/heads/import-zips'
-committer_name = 'Z Ip Creator'
-committer_email = 'zip@example.com'
-
-fast_import = popen('git fast-import --quiet', 'w')
-def printlines(list):
-    for str in list:
-        fast_import.write(str + "\n")
-
-for zipfile in argv[1:]:
-    commit_time = 0
-    next_mark = 1
-    common_prefix = None
-    mark = dict()
-
-    zip = ZipFile(zipfile, 'r')
-    for name in zip.namelist():
-        if name.endswith('/'):
-            continue
-        info = zip.getinfo(name)
-
-        if commit_time < info.date_time:
-            commit_time = info.date_time
-        if common_prefix == None:
-            common_prefix = name[:name.rfind('/') + 1]
-        else:
-            while not name.startswith(common_prefix):
-                last_slash = common_prefix[:-1].rfind('/') + 1
-                common_prefix = common_prefix[:last_slash]
-
-        mark[name] = ':' + str(next_mark)
-        next_mark += 1
-
-        printlines(('blob', 'mark ' + mark[name], \
-                    'data ' + str(info.file_size)))
-        fast_import.write(zip.read(name) + "\n")
-
-    committer = committer_name + ' <' + committer_email + '> %d +0000' % \
-        mktime(commit_time + (0, 0, 0))
-
-    printlines(('commit ' + branch_ref, 'committer ' + committer, \
-        'data <<EOM', 'Imported from ' + zipfile + '.', 'EOM', \
-        '', 'deleteall'))
-
-    for name in mark.keys():
-        fast_import.write('M 100644 ' + mark[name] + ' ' +
-            name[len(common_prefix):] + "\n")
-
-    printlines(('',  'tag ' + path.basename(zipfile), \
-        'from ' + branch_ref, 'tagger ' + committer, \
-        'data <<EOM', 'Package ' + zipfile, 'EOM', ''))
-
-if fast_import.close():
-    exit(1)
-- 
1.9.2+fc1.27.gbce2056
