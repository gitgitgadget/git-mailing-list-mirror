From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCHv5] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 15:55:43 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <8738xaqy40.fsf_-_@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
	<87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com>
	<7vhalqsfkf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:56:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2pYm-00024t-JZ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461Ab3BEUzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 15:55:45 -0500
Received: from z.lifelogs.com ([173.255.230.239]:57072 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab3BEUzp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 15:55:45 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 4CC97DE0E3;
	Tue,  5 Feb 2013 20:55:44 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vhalqsfkf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2013 11:53:20 -0800, Tue, 05 Feb 2013 11:47:56
	-0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215539>

Add Git credential helper that can parse netrc/authinfo files.

This credential helper support multiple files, returning the first one
that matches.  It checks file permissions and owner.  For *.gpg files,
it will run GPG to decrypt the file.

Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
---
Changes since PATCHv4:

- indentation and brace fixes
- test makefile uses "=3D>" as the decorative prefix
- documentation fixes about order and show query with "hostname"
- add --insecure to ignore owner and permission checks
- check permissions just once and only for unencrypted files
- change IO::File to simple open() and quote $file
- fixed macdef buglet from Net::Netrc
- ignore 'default' entries

 contrib/credential/netrc/Makefile             |   12 +
 contrib/credential/netrc/git-credential-netrc |  424 +++++++++++++++++=
++++++++
 2 files changed, 436 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential/netrc/Makefile
 create mode 100755 contrib/credential/netrc/git-credential-netrc

diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/net=
rc/Makefile
new file mode 100644
index 0000000..18a924f
--- /dev/null
+++ b/contrib/credential/netrc/Makefile
@@ -0,0 +1,12 @@
+test_netrc:
+	@(echo "bad data" | ./git-credential-netrc -f A -d -v) || echo "Bad i=
nvocation test, ignoring failure"
+	@echo "=3D> Silent invocation... nothing should show up here with a m=
issing file"
+	@echo "bad data" | ./git-credential-netrc -f A get
+	@echo "=3D> Back to noisy: -v and -d used below, missing file"
+	echo "bad data" | ./git-credential-netrc -f A -d -v get
+	@echo "=3D> Look for any entry in the default file set"
+	echo "" | ./git-credential-netrc -d -v get
+	@echo "=3D> Look for github.com in the default file set"
+	echo "host=3Dgoogle.com" | ./git-credential-netrc -d -v get
+	@echo "=3D> Look for a nonexistent machine in the default file set"
+	echo "host=3Dkorovamilkbar" | ./git-credential-netrc -d -v get
diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/cr=
edential/netrc/git-credential-netrc
new file mode 100755
index 0000000..8298564
--- /dev/null
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -0,0 +1,424 @@
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
+	       help =3D> 0,
+	       debug =3D> 0,
+	       verbose =3D> 0,
+	       insecure =3D> 0,
+	       file =3D> [],
+
+	       # identical token maps, e.g. host -> host, will be inserted la=
ter
+	       tmap =3D> {
+			port =3D> 'protocol',
+			machine =3D> 'host',
+			path =3D> 'path',
+			login =3D> 'username',
+			user =3D> 'username',
+			password =3D> 'password',
+		       }
+	      );
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
+           "insecure|k",
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
+$0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] [-v] [-k] get
+
+Version $VERSION by tzz\@lifelogs.com.  License: BSD.
+
+Options:
+
+  -f|--file AUTHFILE : specify netrc-style files.  Files with the .gpg=
 extension
+                       will be decrypted by GPG before parsing.  Multi=
ple -f
+                       arguments are OK.  They are processed in order,=
 and the
+                       first matching entry found is returned via the =
credential
+                       helper protocol (see below).
+
+  -k|--insecure      : ignore bad file ownership or permissions
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
+host=3Dgithub.com
+protocol=3Dhttps
+username=3Dtzz
+
+this credential helper will look for the first entry in every AUTHFILE=
 that
+matches
+
+machine github.com port https login tzz
+
+OR
+
+machine github.com protocol https login tzz
+
+OR... etc. acceptable tokens as listed above.  Any unknown tokens are
+simply ignored.
+
+Then, the helper will print out whatever tokens it got from the entry,=
 including
+"password" tokens, mapping back to Git's helper protocol; e.g. "port" =
is mapped
+back to "protocol".  Any redundant entry tokens (part of the original =
query) are
+skipped.
+
+Again, note that only the first matching entry from all the AUTHFILEs,=
 processed
+in the sequence given on the command line, is used.
+
+Netrc/authinfo tokens can be quoted as 'STRING' or "STRING".
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
+unless (scalar @$files) {
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
+foreach my $file (@$files) {
+	my $gpgmode =3D $file =3D~ m/\.gpg$/;
+	unless (-r $file) {
+		log_verbose("Unable to read $file; skipping it");
+		next FILE;
+	}
+
+	# the following check is copied from Net::Netrc, for non-GPG files
+	# OS/2 and Win32 do not handle stat in a way compatable with this che=
ck :-(
+	unless ($gpgmode || $options{insecure} ||
+		$^O eq 'os2'
+		|| $^O eq 'MSWin32'
+		|| $^O eq 'MacOS'
+		|| $^O =3D~ /^cygwin/) {
+		my @stat =3D stat($file);
+
+		if (@stat) {
+			if ($stat[2] & 077) {
+				log_verbose("Insecure $file (mode=3D%04o); skipping it",
+					    $stat[2] & 07777);
+				next FILE;
+			}
+
+			if ($stat[4] !=3D $<) {
+				log_verbose("Not owner of $file; skipping it");
+				next FILE;
+			}
+		}
+	}
+
+	my @entries =3D load_netrc($file, $gpgmode);
+
+	unless (scalar @entries) {
+		if ($!) {
+			log_verbose("Unable to open $file: $!");
+		}
+		else {
+			log_verbose("No netrc entries found in $file");
+		}
+
+		next FILE;
+	}
+
+	my $entry =3D find_netrc_entry($query, @entries);
+	if ($entry) {
+		print_credential_data($entry, $query);
+		# we're done!
+		last FILE;
+	}
+}
+
+exit 0;
+
+sub load_netrc {
+	my $file =3D shift @_;
+	my $gpgmode =3D shift @_;
+
+	my $io;
+	if ($gpgmode) {
+		# typical shell character escapes from http://www.slac.stanford.edu/=
slac/www/resource/how-to-use/cgi-rexx/cgi-esc.html
+		my $f =3D $file;
+		$f =3D~ s/([;<>\*\|`&\$!#\(\)\[\]\{\}:'"])/\\$1/g;
+		# GPG doesn't work well with 2- or 3-argument open
+		my $cmd =3D "gpg --decrypt $f";
+		log_verbose("Using GPG to open $file: [$cmd]");
+		open $io, "$cmd|";
+	}
+	else {
+		log_verbose("Opening $file...");
+		open $io, '<', $file;
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
+sub net_netrc_loader {
+	my $fh =3D shift @_;
+	my @entries;
+	my ($mach, $macdef, $tok, @tok);
+
+    LINE:
+	while (<$fh>) {
+		undef $macdef if /\A\n\Z/;
+
+		if ($macdef) {
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
+			if ($tok[0] eq "default") {
+				shift(@tok);
+				undef $mach; # ignore 'default' lines
+
+				next TOKEN;
+			}
+
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
+				$macdef =3D 1;
+			}
+		}
+	}
+
+	return @entries;
+}
+
+sub read_credential_data_from_stdin {
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
+sub find_netrc_entry {
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
+sub print_credential_data {
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
