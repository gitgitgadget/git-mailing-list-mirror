From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH v7] Add contrib/credentials/netrc with GPG support
Date: Mon, 25 Feb 2013 10:49:15 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <877glwv1fo.fsf_-_@lifelogs.com>
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
	<8738xaqy40.fsf_-_@lifelogs.com>
	<7vip66qu0u.fsf@alter.siamese.dyndns.org>
	<7vtxpqnwiv.fsf@alter.siamese.dyndns.org>
	<876226p97h.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 16:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA0JD-0002IO-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 16:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759906Ab3BYPtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 10:49:19 -0500
Received: from z.lifelogs.com ([173.255.230.239]:37266 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759895Ab3BYPtR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 10:49:17 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 2F98C205FF;
	Mon, 25 Feb 2013 15:49:16 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <876226p97h.fsf_-_@lifelogs.com> (Ted Zlatanov's message of "Tue,
	05 Feb 2013 19:38:58 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217062>

This credential helper supports multiple files, returning the first one
that matches.  It checks file permissions and owner.  For *.gpg files,
it will run GPG to decrypt the file.

Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
---
Changes since PATCHv6:

- change Makefile test to test.pl (using Perl Test module) + test.netrc
 * `make test' runs all the tests in the standard Test format
 * `make testverbose' runs the tests with -d -v to see what's happening
- fix missing semicolons and minor typos

 contrib/credential/netrc/Makefile             |    5 +
 contrib/credential/netrc/git-credential-netrc |  421 +++++++++++++++++=
++++++++
 contrib/credential/netrc/test.netrc           |   13 +
 contrib/credential/netrc/test.pl              |  106 +++++++
 4 files changed, 545 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential/netrc/Makefile
 create mode 100755 contrib/credential/netrc/git-credential-netrc
 create mode 100644 contrib/credential/netrc/test.netrc
 create mode 100755 contrib/credential/netrc/test.pl

diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/net=
rc/Makefile
new file mode 100644
index 0000000..51b7613
--- /dev/null
+++ b/contrib/credential/netrc/Makefile
@@ -0,0 +1,5 @@
+test:
+	./test.pl
+
+testverbose:
+	./test.pl -d -v
diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/cr=
edential/netrc/git-credential-netrc
new file mode 100755
index 0000000..6c51c43
--- /dev/null
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -0,0 +1,421 @@
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
+                       When no -f option is given, .authinfo.gpg, .net=
rc.gpg,
+		       .authinfo, and .netrc files in your home directory are used
+		       in this order.
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
+	# OS/2 and Win32 do not handle stat in a way compatible with this che=
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
+		} else {
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
+		my @cmd =3D (qw(gpg --decrypt), $file);
+		log_verbose("Using GPG to open $file: [@cmd]");
+		open $io, "-|", @cmd;
+	} else {
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
+		if (!defined $nentry->{machine}) {
+			next;
+		}
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
+				$mach =3D { machine =3D> undef };
+				next TOKEN;
+			}
+
+			$tok =3D shift(@tok);
+
+			if ($tok eq "machine") {
+				my $host =3D shift @tok;
+				$mach =3D { machine =3D> $host };
+				push @entries, $mach;
+			} elsif (exists $options{tmap}->{$tok}) {
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
+			} elsif ($tok eq "macdef") { # we ignore macros
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
+			} else {
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
diff --git a/contrib/credential/netrc/test.netrc b/contrib/credential/n=
etrc/test.netrc
new file mode 100644
index 0000000..ba119a9
--- /dev/null
+++ b/contrib/credential/netrc/test.netrc
@@ -0,0 +1,13 @@
+machine imap login tzz@lifelogs.com port imaps password letmeknow
+machine imap login bob port imaps password bobwillknow
+
+# comment test
+
+machine imap2 login tzz port 1099 password tzzknow
+machine imap2 login bob password bobwillknow
+
+# another command
+
+machine github.com
+  multilinetoken anothervalue
+  login carol password carolknows
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netr=
c/test.pl
new file mode 100755
index 0000000..169b646
--- /dev/null
+++ b/contrib/credential/netrc/test.pl
@@ -0,0 +1,106 @@
+#!/usr/bin/perl
+
+use warnings;
+use strict;
+use Test;
+use IPC::Open2;
+
+BEGIN { plan tests =3D> 15 }
+
+my @global_credential_args =3D @ARGV;
+my $netrc =3D './test.netrc';
+print "# Testing insecure file, nothing should be found\n";
+chmod 0644, $netrc;
+my $cred =3D run_credential(['-f', $netrc, 'get'],
+			  { host =3D> 'github.com' });
+
+ok(scalar keys %$cred, 0, "Got 0 keys from insecure file");
+
+print "# Testing missing file, nothing should be found\n";
+chmod 0644, $netrc;
+$cred =3D run_credential(['-f', '///nosuchfile///', 'get'],
+		       { host =3D> 'github.com' });
+
+ok(scalar keys %$cred, 0, "Got 0 keys from missing file");
+
+chmod 0600, $netrc;
+
+print "# Testing with invalid data\n";
+$cred =3D run_credential(['-f', $netrc, 'get'],
+		       "bad data");
+ok(scalar keys %$cred, 4, "Got first found keys with bad data");
+
+print "# Testing netrc file for a missing corovamilkbar entry\n";
+$cred =3D run_credential(['-f', $netrc, 'get'],
+		       { host =3D> 'corovamilkbar' });
+
+ok(scalar keys %$cred, 0, "Got no corovamilkbar keys");
+
+print "# Testing netrc file for a github.com entry\n";
+$cred =3D run_credential(['-f', $netrc, 'get'],
+		       { host =3D> 'github.com' });
+
+ok(scalar keys %$cred, 2, "Got 2 Github keys");
+
+ok($cred->{password}, 'carolknows', "Got correct Github password");
+ok($cred->{username}, 'carol', "Got correct Github username");
+
+print "# Testing netrc file for a username-specific entry\n";
+$cred =3D run_credential(['-f', $netrc, 'get'],
+		       { host =3D> 'imap', username =3D> 'bob' });
+
+ok(scalar keys %$cred, 2, "Got 2 username-specific keys");
+
+ok($cred->{password}, 'bobwillknow', "Got correct user-specific passwo=
rd");
+ok($cred->{protocol}, 'imaps', "Got correct user-specific protocol");
+
+print "# Testing netrc file for a host:port-specific entry\n";
+$cred =3D run_credential(['-f', $netrc, 'get'],
+		       { host =3D> 'imap2:1099' });
+
+ok(scalar keys %$cred, 2, "Got 2 host:port-specific keys");
+
+ok($cred->{password}, 'tzzknow', "Got correct host:port-specific passw=
ord");
+ok($cred->{username}, 'tzz', "Got correct host:port-specific username"=
);
+
+print "# Testing netrc file that 'host:port kills host' entry\n";
+$cred =3D run_credential(['-f', $netrc, 'get'],
+		       { host =3D> 'imap2' });
+
+ok(scalar keys %$cred, 2, "Got 2 'host:port kills host' keys");
+
+ok($cred->{password}, 'bobwillknow', "Got correct 'host:port kills hos=
t' password");
+ok($cred->{username}, 'bob', "Got correct 'host:port kills host' usern=
ame");
+
+sub run_credential
+{
+	my $args =3D shift @_;
+	my $data =3D shift @_;
+	my $pid =3D open2(my $chld_out, my $chld_in,
+			'./git-credential-netrc', @global_credential_args,
+			@$args);
+
+	die "Couldn't open pipe to netrc credential helper: $!" unless $pid;
+
+	if (ref $data eq 'HASH')
+	{
+		print $chld_in "$_=3D$data->{$_}\n" foreach sort keys %$data;
+	}
+	else
+	{
+		print $chld_in "$data\n";
+	}
+
+	close $chld_in;
+	my %ret;
+
+	while (<$chld_out>)
+	{
+		chomp;
+		next unless m/^([^=3D]+)=3D(.+)/;
+
+		$ret{$1} =3D $2;
+	}
+
+	return \%ret;
+}
--=20
1.7.9.rc2
