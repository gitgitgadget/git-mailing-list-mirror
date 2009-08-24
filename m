From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH v2] Add script for importing bits-and-pieces to Git.
Date: Mon, 24 Aug 2009 18:09:10 +0100
Message-ID: <20090824171110.DA9202FC20@perkele>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 19:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfd4o-0002Rp-1E
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 19:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbZHXRLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 13:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbZHXRLN
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 13:11:13 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54923 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752926AbZHXRLL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 13:11:11 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW00KFF52ORV60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 24 Aug 2009 19:11:13 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW00IJE52N8180@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 24 Aug 2009 19:11:12 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.24.165417
Received: by perkele (Postfix, from userid 501)	id DA9202FC20; Mon,
 24 Aug 2009 19:11:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126946>

Allows the user to import version history that is stored in bits and
pieces in the file system, for instance snapshots of old development
trees, or day-by-day backups. A configuration file is used to
describe the relationship between the different files and allow
describing branches and merges, as well as authorship and commit
messages.

Output is created in a format compatible with git-fast-import.

Full documentation is provided inline in perldoc format.

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
Changed the use of stat() as suggested by Thomas Adam.

 contrib/fast-import/import-directories.perl |  332 +++++++++++++++++++++++++++
 1 files changed, 332 insertions(+), 0 deletions(-)
 create mode 100755 contrib/fast-import/import-directories.perl

diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-import/import-directories.perl
new file mode 100755
index 0000000..98079ad
--- /dev/null
+++ b/contrib/fast-import/import-directories.perl
@@ -0,0 +1,332 @@
+#!/usr/bin/perl -w
+#
+# Copyright 2008-2009 Peter Krefting <peter@softwolves.pp.se>
+#
+# ------------------------------------------------------------------------
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#
+# ------------------------------------------------------------------------
+
+=pod
+
+=head1 NAME
+
+import-directories - Import bits and pieces to Git.
+
+=head1 SYNOPSIS
+
+B<import-directories.perl> F<configfile>
+
+=head1 DESCRIPTION
+
+Script to import arbitrary projects version controlled by the "copy the
+source directory to a new location and edit it there"-version controlled
+projects into version control. Handles projects with arbitrary branching
+and version trees, taking a file describing the inputs and generating a
+file compatible with the L<git-fast-import(1)> format.
+
+=head1 CONFIGURATION FILE
+
+=head2 Format
+
+The configuration file is using a standard I<.ini> format.
+
+ ; Comments start with semi-colons
+ [section]
+ key=value
+
+=head2 Global configuration
+
+Global configuration is done in the B<[config]> section, which should be
+the first section in the file. Configuration can be changed by
+repeating configuration sections later on.
+
+ [config]
+ ; configure conversion of CRLFs. "convert" means that all CRLFs
+ ; should be converted into LFs (suitable for the core.autocrlf
+ ; setting set to true in Git). "none" means that all data is
+ ; treated as binary.
+ crlf=convert
+
+=head2 Revision configuration
+
+Each revision that is to be imported is described in three
+sections. Sections should be defined chronologically, so that a
+revision's parent has always been defined when a new revision
+is introduced. All sections for one revision should be defined
+before defining the next revision.
+
+Revisions are specified numerically, but they numbers need not be
+consecutive, only unique.
+
+=pod
+
+=head3 Revision description section
+
+A section whose section name is just an integer gives meta-data
+about the revision.
+
+ [3]
+ ; author sets the author of the revisions
+ author=Peter Krefting <peter@softwolves.pp.se>
+ ; branch sets the branch that the revision should be committed to
+ branch=master
+ ; parent describes the revision that is the parent of this commit
+ ; (optional)
+ parent=1
+ ; merges describes a revision that is merged into this commit
+ ; (optional; can be repeated)
+ merges=2
+ ; selects one file to take the timestamp from
+ ; (optional; if unspecified, the most recent file from the .files
+ ;  section is used)
+ timestamp=3/source.c
+
+=head3 Revision contents section
+
+A section whose section name is an integer followed by B<.files>
+describes the files included in this revision.
+
+ [3.files]
+ ; the key is the path inside the repository, the value is the path
+ ; as seen from the importer script.
+ source.c=3/source.c
+ source.h=3/source.h
+
+=head3 Revision commit message section
+
+A section whose section name is an integer followed by B<.message>
+gives the commit message. This section is read verbatim.
+
+ [3.message]
+ Implement foobar.
+ ; trailing blank lines are ignored.
+
+=cut
+
+# Globals
+use strict;
+use integer;
+my $crlfmode = 0;
+my @revs;
+my (%revmap, %message, %files, %author, %branch, %parent, %merges, %time, %timesource);
+my $sectiontype = 0;
+my $rev = 0;
+my $mark = 1;
+
+# Check command line
+if ($#ARGV == -1 || $ARGV[0] =~ /^--?h/)
+{
+    exec('perldoc', $0);
+    exit 1;
+}
+
+# Open configuration
+my $config = $ARGV[0];
+open CFG, '<', $config or die "Cannot open configuration file \"$config\": ";
+
+# Open output
+my $output = $ARGV[1];
+open OUT, '>', $output or die "Cannot create output file \"$output\": ";
+binmode OUT;
+
+LINE: while (my $line = <CFG>)
+{
+	$line =~ s/\r?\n$//;
+	next LINE if $sectiontype != 4 && $line eq '';
+	next LINE if $line =~ /^;/;
+	my $oldsectiontype = $sectiontype;
+	my $oldrev = $rev;
+
+	# Sections
+	if ($line =~ m"^\[(config|(\d+)(|\.files|\.message))\]$")
+	{
+		if ($1 eq 'config')
+		{
+			$sectiontype = 1;
+		}
+		elsif ($3 eq '')
+		{
+			$sectiontype = 2;
+			$rev = $2;
+			# Create a new revision
+			die "Duplicate rev: $line\n " if defined $revmap{$rev};
+			print "Reading revision $rev\n";
+			push @revs, $rev;
+			$revmap{$rev} = $mark ++;
+			$time{$revmap{$rev}} = 0;
+		}
+		elsif ($3 eq '.files')
+		{
+			$sectiontype = 3;
+			$rev = $2;
+			die "Revision mismatch: $line\n " unless $rev == $oldrev;
+		}
+		elsif ($3 eq '.message')
+		{
+			$sectiontype = 4;
+			$rev = $2;
+			die "Revision mismatch: $line\n " unless $rev == $oldrev;
+		}
+		else
+		{
+			die "Internal parse error: $line\n ";
+		}
+		next LINE;
+	}
+
+	# Parse data
+	if ($sectiontype != 4)
+	{
+		# Key and value
+		if ($line =~ m"^(.*)=(.*)$")
+		{
+			my ($key, $value) = ($1, $2);
+			# Global configuration
+			if (1 == $sectiontype)
+			{
+				if ($key eq 'crlf')
+				{
+					$crlfmode = 1, next LINE if $value eq 'convert';
+					$crlfmode = 0, next LINE if $value eq 'none';
+				}
+				die "Unknown configuration option: $line\n ";
+			}
+			# Revision specification
+			if (2 == $sectiontype)
+			{
+				my $current = $revmap{$rev};
+				$author{$current} = $value, next LINE if $key eq 'author';
+				$branch{$current} = $value, next LINE if $key eq 'branch';
+				$parent{$current} = $value, next LINE if $key eq 'parent';
+				$timesource{$current} = $value, next LINE if $key eq 'timestamp';
+				push(@{$merges{$current}}, $value), next LINE if $key eq 'merges';
+				die "Unknown revision option: $line\n ";
+			}
+			# Filespecs
+			if (3 == $sectiontype)
+			{
+				# Add the file and create a marker
+				die "File not found: $line\n " unless -f $value;
+				my $current = $revmap{$rev};
+				${$files{$current}}{$key} = $mark;
+				my $time = &fileblob($value, $crlfmode, $mark ++);
+
+				# Update revision timestamp if more recent than other
+				# files seen, or if this is the file we have selected
+				# to take the time stamp from using the "timestamp"
+				# directive.
+				if ((defined $timesource{$current} && $timesource{$current} eq $value)
+				    || $time > $time{$current})
+				{
+					$time{$current} = $time;
+				}
+			}
+		}
+		else
+		{
+			die "Parse error: $line\n ";
+		}
+	}
+	else
+	{
+		# Commit message
+		my $current = $revmap{$rev};
+		if (defined $message{$current})
+		{
+			$message{$current} .= "\n";
+		}
+		$message{$current} .= $line;
+	}
+}
+close CFG;
+
+# Start spewing out data for git-fast-import
+foreach my $commit (@revs)
+{
+	# Progress
+	print OUT "progress Creating revision $commit\n";
+
+	# Create commit header
+	my $mark = $revmap{$commit};
+
+	# Branch and commit id
+	print OUT "commit refs/heads/", $branch{$mark}, "\nmark :", $mark, "\n";
+
+	# Author and timestamp
+	die "No timestamp defined for $commit (no files?)\n" unless defined $time{$mark};
+	print OUT "committer ", $author{$mark}, " ", $time{$mark}, " +0100\n";
+
+	# Commit message
+	die "No message defined for $commit\n" unless defined $message{$mark};
+	my $message = $message{$mark};
+	$message =~ s/\n$//; # Kill trailing empty line
+	print OUT "data ", length($message), "\n", $message, "\n";
+
+	# Parent and any merges
+	print OUT "from :", $revmap{$parent{$mark}}, "\n" if defined $parent{$mark};
+	if (defined $merges{$mark})
+	{
+		foreach my $merge (@{$merges{$mark}})
+		{
+			print OUT "merge :", $revmap{$merge}, "\n";
+		}
+	}
+
+	# Output file marks
+	print OUT "deleteall\n"; # start from scratch
+	foreach my $file (sort keys %{$files{$mark}})
+	{
+		print OUT "M 644 :", ${$files{$mark}}{$file}, " $file\n";
+	}
+	print OUT "\n";
+}
+
+# Create one file blob
+sub fileblob
+{
+	my ($filename, $crlfmode, $mark) = @_;
+
+	# Import the file
+	print OUT "progress Importing $filename\nblob\nmark :$mark\n";
+	open FILE, '<', $filename or die "Cannot read $filename\n ";
+	binmode FILE;
+	my ($size, $mtime) = (stat(FILE))[7,9];
+	my $file;
+	read FILE, $file, $size;
+	close FILE;
+	$file =~ s/\r\n/\n/g if $crlfmode;
+	print OUT "data ", length($file), "\n", $file, "\n";
+
+	return $time;
+}
+
+__END__
+
+=pod
+
+=head1 EXAMPLES
+
+B<import-directories.perl> F<project.import>
+
+=head1 AUTHOR
+
+Copyright 2008-2009 Peter Krefting E<lt>peter@softwolves.pp.se>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation.
+
+=cut
-- 
1.6.3.3
