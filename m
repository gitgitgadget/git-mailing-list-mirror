From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCHv4] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 13:55:27 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87fw1ar3og.fsf_-_@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 19:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ngP-0000AA-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 19:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab3BESza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 13:55:30 -0500
Received: from z.lifelogs.com ([173.255.230.239]:40697 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941Ab3BESz3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 13:55:29 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id AD295DE0E3;
	Tue,  5 Feb 2013 18:55:28 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <87k3qmr8yc.fsf@lifelogs.com> (Ted Zlatanov's message of "Tue, 05
	Feb 2013 12:01:31 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215526>

Changes since PATCHv3:

- simple tests in Makefile
- support multiple files, code refactored
- documentation and comments updated
- fix IO::File for GPG pipe
- exit peacefully in almost every situation, die on bad invocation or q=
uery
- use log_verbose() and -v for logging for the user
- use log_debug() and -d for logging for the developer
- use Net::Netrc parser and `man netrc' to improve parsing
- ignore 'default' and 'macdef' netrc entries
- require 'machine' token in netrc lines
- ignore netrc files with bad permissions or owner (from Net::Netrc)

Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/Makefile             |   10 +
 contrib/credential/netrc/git-credential-netrc |  423 +++++++++++++++++=
++++++++
 2 files changed, 433 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential/netrc/Makefile
 create mode 100755 contrib/credential/netrc/git-credential-netrc

diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/net=
rc/Makefile
new file mode 100644
index 0000000..ee8c5f0
--- /dev/null
+++ b/contrib/credential/netrc/Makefile
@@ -0,0 +1,10 @@
+test_netrc:
+	@(echo "bad data" | ./git-credential-netrc -f A -d -v) || echo "Bad i=
nvocation test, ignoring failure"
+	@echo "-> Silent invocation... nothing should show up here with a mis=
sing file"
+	@echo "bad data" | ./git-credential-netrc -f A get
+	@echo "-> Back to noisy: -v and -d used below, missing file"
+	echo "bad data" | ./git-credential-netrc -f A -d -v get
+	@echo "-> Look for any entry in the default file set"
+	echo "" | ./git-credential-netrc -d -v get
+	@echo "-> Look for github.com in the default file set"
+	echo "host=3Dgoogle.com" | ./git-credential-netrc -d -v get
diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/cr=
edential/netrc/git-credential-netrc
new file mode 100755
index 0000000..6946217
--- /dev/null
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -0,0 +1,423 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+use Getopt::Long;
+use File::Basename;
+
+my $VERSION =3D "0.1";
+
+my %options =3D (
+               help =3D> 0,
+               debug =3D> 0,
+               verbose =3D> 0,
+	       file =3D> [],
+
+               # identical token maps, e.g. host -> host, will be inse=
rted later
+               tmap =3D> {
+                        port =3D> 'protocol',
+                        machine =3D> 'host',
+                        path =3D> 'path',
+                        login =3D> 'username',
+                        user =3D> 'username',
+                        password =3D> 'password',
+                       }
+              );
+
+# Map each credential protocol token to itself on the netrc side.
+foreach (values %{$options{tmap}}) {
+	$options{tmap}->{$_} =3D $_;
+}
+
+# Now, $options{tmap} has a mapping from the netrc format to the Git c=
redential
+# helper protocol.
+
+# Next, we build the reverse token map.
+
+# When $rmap{foo} contains 'bar', that means that what the Git credent=
ial helper
+# protocol calls 'bar' is found as 'foo' in the netrc/authinfo file.  =
Keys in
+# %rmap are what we expect to read from the netrc/authinfo file.
+
+my %rmap;
+foreach my $k (keys %{$options{tmap}}) {
+	push @{$rmap{$options{tmap}->{$k}}}, $k;
+}
+
+Getopt::Long::Configure("bundling");
+
+# TODO: maybe allow the token map $options{tmap} to be configurable.
+GetOptions(\%options,
+           "help|h",
+           "debug|d",
+           "verbose|v",
+           "file|f=3Ds@",
+          );
+
+if ($options{help}) {
+	my $shortname =3D basename($0);
+	$shortname =3D~ s/git-credential-//;
+
+	print <<EOHIPPUS;
+
+$0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] [-v] get
+
+Version $VERSION by tzz\@lifelogs.com.  License: BSD.
+
+Options:
+
+  -f|--file AUTHFILE : specify netrc-style files.  Files with the .gpg=
 extension
+                       will be decrypted by GPG before parsing.  Multi=
ple -f
+                       arguments are OK, and the order is respected.
+
+  -d|--debug         : turn on debugging (developer info)
+
+  -v|--verbose       : be more verbose (show files and information fou=
nd)
+
+To enable this credential helper:
+
+  git config credential.helper '$shortname -f AUTHFILE1 -f AUTHFILE2'
+
+(Note that Git will prepend "git-credential-" to the helper name and l=
ook for it
+in the path.)
+
+...and if you want lots of debugging info:
+
+  git config credential.helper '$shortname -f AUTHFILE -d'
+
+...or to see the files opened and data found:
+
+  git config credential.helper '$shortname -f AUTHFILE -v'
+
+Only "get" mode is supported by this credential helper.  It opens ever=
y AUTHFILE
+and looks for the first entry that matches the requested search criter=
ia:
+
+ 'port|protocol':
+   The protocol that will be used (e.g., https). (protocol=3DX)
+
+ 'machine|host':
+   The remote hostname for a network credential. (host=3DX)
+
+ 'path':
+   The path with which the credential will be used. (path=3DX)
+
+ 'login|user|username':
+   The credential=E2=80=99s username, if we already have one. (usernam=
e=3DX)
+
+Thus, when we get this query on STDIN:
+
+protocol=3Dhttps
+username=3Dtzz
+
+this credential helper will look for the first entry in every AUTHFILE=
 that
+matches
+
+port https login tzz
+
+OR
+
+protocol https login tzz
+
+OR... etc. acceptable tokens as listed above.  Any unknown tokens are
+simply ignored.
+
+Then, the helper will print out whatever tokens it got from the entry,=
 including
+"password" tokens, mapping back to Git's helper protocol; e.g. "port" =
is mapped
+back to "protocol".
+
+Again, note that the first matching entry from all the AUTHFILEs is us=
ed.
+
+Tokens can be quoted as 'STRING' or "STRING".
+
+No caching is performed by this credential helper.
+
+EOHIPPUS
+
+	exit 0;
+}
+
+my $mode =3D shift @ARGV;
+
+# Credentials must get a parameter, so die if it's missing.
+die "Syntax: $0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] get" unless defined=
 $mode;
+
+# Only support 'get' mode; with any other unsupported ones we just exi=
t.
+exit 0 unless $mode eq 'get';
+
+my $files =3D $options{file};
+
+# if no files were given, use a predefined list.
+# note that .gpg files come first
+unless (scalar @$files)
+{
+	my @candidates =3D qw[
+				   ~/.authinfo.gpg
+				   ~/.netrc.gpg
+				   ~/.authinfo
+				   ~/.netrc
+			  ];
+
+	$files =3D $options{file} =3D [ map { glob $_ } @candidates ];
+}
+
+my $query =3D read_credential_data_from_stdin();
+
+FILE:
+foreach my $file (@$files)
+{
+	unless (-r $file)
+	{
+		log_verbose("Unable to read $file; skipping it");
+		next FILE;
+	}
+
+	# the following check is copied from Net::Netrc
+	# OS/2 and Win32 do not handle stat in a way compatable with this che=
ck :-(
+	unless ($^O eq 'os2'
+		|| $^O eq 'MSWin32'
+		|| $^O eq 'MacOS'
+		|| $^O =3D~ /^cygwin/)
+	{
+		my @stat =3D stat($file);
+
+		if (@stat) {
+			if ($stat[2] & 077) {
+				log_verbose("Insecure $file (mode=3D%04o); skipping it",
+					    $stat[2] & 07777);
+				next FILE;
+			}
+			if ($stat[4] !=3D $<) {
+				log_verbose("Not owner of $file; skipping it");
+				next FILE;
+			}
+		}
+	}
+
+	my $mode =3D (stat($file))[2];
+	if ($mode & 077)
+	{
+		log_verbose("Insecure $file (mode=3D%04o); skipping it",
+			    $mode & 07777);
+		next FILE;
+	}
+
+	my @entries =3D load_netrc($file);
+
+	unless (scalar @entries)
+	{
+		if ($!)
+		{
+			log_verbose("Unable to open $file: $!");
+		}
+		else
+		{
+			log_verbose("No netrc entries found in $file");
+		}
+
+		next FILE;
+	}
+
+	my $entry =3D find_netrc_entry($query, @entries);
+	if ($entry)
+	{
+		print_credential_data($entry, $query);
+		# we're done!
+		last FILE;
+	}
+}
+
+exit 0;
+
+sub load_netrc
+{
+	my $file =3D shift @_;
+
+	my $io;
+	if ($file =3D~ m/\.gpg$/) {
+		log_verbose("Using GPG to open $file");
+		# GPG doesn't work well with 2- or 3-argument open
+		$io =3D new IO::File("gpg --decrypt $file|");
+	}
+	else {
+		log_verbose("Opening $file...");
+		$io =3D new IO::File($file, '<');
+	}
+
+	# nothing to do if the open failed (we log the error later)
+	return unless $io;
+
+	# Net::Netrc does this, but the functionality is merged with the file
+	# detection logic, so we have to extract just the part we need
+	my @netrc_entries =3D net_netrc_loader($io);
+
+	# these entries will use the credential helper protocol token names
+	my @entries;
+
+	foreach my $nentry (@netrc_entries) {
+		my %entry;
+		my $num_port;
+
+		if (defined $nentry->{port} && $nentry->{port} =3D~ m/^\d+$/) {
+			$num_port =3D $nentry->{port};
+			delete $nentry->{port};
+		}
+
+		# create the new entry for the credential helper protocol
+		$entry{$options{tmap}->{$_}} =3D $nentry->{$_} foreach keys %$nentry=
;
+
+		# for "host X port Y" where Y is an integer (captured by
+		# $num_port above), set the host to "X:Y"
+		if (defined $entry{host} && defined $num_port) {
+			$entry{host} =3D join(':', $entry{host}, $num_port);
+		}
+
+		push @entries, \%entry;
+	}
+
+	return @entries;
+}
+
+sub net_netrc_loader
+{
+	my $fh =3D shift @_;
+	my @entries;
+	my ($mach, $macdef, $tok, @tok) =3D (0, 0);
+
+    LINE:
+	while (<$fh>) {
+		undef $macdef if /\A\n\Z/;
+
+		if ($macdef) {
+			push(@$macdef, $_);
+			next LINE;
+		}
+
+		s/^\s*//;
+		chomp;
+
+		while (length && s/^("((?:[^"]+|\\.)*)"|((?:[^\\\s]+|\\.)*))\s*//) {
+			(my $tok =3D $+) =3D~ s/\\(.)/$1/g;
+			push(@tok, $tok);
+		}
+
+	    TOKEN:
+		while (@tok) {
+			$tok =3D shift(@tok);
+
+			if ($tok eq "machine") {
+				my $host =3D shift @tok;
+				$mach =3D { machine =3D> $host };
+				push @entries, $mach;
+			}
+			elsif (exists $options{tmap}->{$tok}) {
+				unless ($mach) {
+					log_debug("Skipping token $tok because no machine was given");
+					next TOKEN;
+				}
+
+				my $value =3D shift @tok;
+				unless (defined $value) {
+					log_debug("Token $tok had no value, skipping it.");
+					next TOKEN;
+				}
+
+				# Following line added by rmerrell to remove '/' escape char in .n=
etrc
+				$value =3D~ s/\/\\/\\/g;
+				$mach->{$tok} =3D $value;
+			}
+			elsif ($tok eq "macdef") { # we ignore macros
+				next TOKEN unless $mach;
+				my $value =3D shift @tok;
+				$mach->{macdef} =3D {} unless exists $mach->{macdef};
+				$macdef =3D $mach->{machdef}{$value} =3D [];
+			}
+		}
+	}
+
+	return @entries;
+}
+
+sub read_credential_data_from_stdin
+{
+	# the query: start with every token with no value
+	my %q =3D map { $_ =3D> undef } values(%{$options{tmap}});
+
+	while (<STDIN>) {
+		next unless m/^([^=3D]+)=3D(.+)/;
+
+		my ($token, $value) =3D ($1, $2);
+		die "Unknown search token $token" unless exists $q{$token};
+		$q{$token} =3D $value;
+		log_debug("We were given search token $token and value $value");
+	}
+
+	foreach (sort keys %q) {
+		log_debug("Searching for %s =3D %s", $_, $q{$_} || '(any value)');
+	}
+
+	return \%q;
+}
+
+# takes the search tokens and then a list of entries
+# each entry is a hash reference
+sub find_netrc_entry
+{
+	my $query =3D shift @_;
+
+    ENTRY:
+	foreach my $entry (@_)
+	{
+		my $entry_text =3D join ', ', map { "$_=3D$entry->{$_}" } keys %$ent=
ry;
+		foreach my $check (sort keys %$query) {
+			if (defined $query->{$check}) {
+				log_debug("compare %s [%s] to [%s] (entry: %s)",
+					  $check,
+					  $entry->{$check},
+					  $query->{$check},
+					  $entry_text);
+				unless ($query->{$check} eq $entry->{$check}) {
+					next ENTRY;
+				}
+			}
+			else {
+				log_debug("OK: any value satisfies check $check");
+			}
+		}
+
+		return $entry;
+	}
+
+	# nothing was found
+	return;
+}
+
+sub print_credential_data
+{
+	my $entry =3D shift @_;
+	my $query =3D shift @_;
+
+	log_debug("entry has passed all the search checks");
+ TOKEN:
+	foreach my $git_token (sort keys %$entry) {
+		log_debug("looking for useful token $git_token");
+		# don't print unknown (to the credential helper protocol) tokens
+		next TOKEN unless exists $query->{$git_token};
+
+		# don't print things asked in the query (the entry matches them)
+		next TOKEN if defined $query->{$git_token};
+
+		log_debug("FOUND: $git_token=3D$entry->{$git_token}");
+		printf "%s=3D%s\n", $git_token, $entry->{$git_token};
+	}
+}
+sub log_verbose {
+	return unless $options{verbose};
+	printf STDERR @_;
+	printf STDERR "\n";
+}
+
+sub log_debug {
+	return unless $options{debug};
+	printf STDERR @_;
+	printf STDERR "\n";
+}
--=20
1.7.9.rc2
