From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 1/3] Add contrib/credentials/netrc with GPG support
Date: Mon, 04 Feb 2013 11:42:12 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87sj5cvxnf.fsf_-_@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:42:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2P7t-0002Ek-6W
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756414Ab3BDQmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 11:42:14 -0500
Received: from z.lifelogs.com ([173.255.230.239]:54038 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab3BDQmN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2013 11:42:13 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 40B4CDE0C5;
	Mon,  4 Feb 2013 16:42:13 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
Gmane-Reply-To-List: yes
In-Reply-To: <20130203194148.GA26318@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 3 Feb 2013 14:41:49 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215390>


Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/git-credential-netrc |  242 +++++++++++++++++=
++++++++
 1 files changed, 242 insertions(+), 0 deletions(-)
 create mode 100755 contrib/credential/netrc/git-credential-netrc

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/cr=
edential/netrc/git-credential-netrc
new file mode 100755
index 0000000..92fc306
--- /dev/null
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -0,0 +1,242 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+use Data::Dumper;
+
+use Getopt::Long;
+use File::Basename;
+
+my $VERSION =3D "0.1";
+
+my %options =3D (
+               help =3D> 0,
+               debug =3D> 0,
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
+foreach my $v (values %{$options{tmap}})
+{
+ $options{tmap}->{$v} =3D $v;
+}
+
+foreach my $suffix ('.gpg', '')
+{
+ foreach my $base (qw/authinfo netrc/)
+ {
+  my $file =3D glob("~/.$base$suffix");
+  next unless (defined $file && -f $file);
+  $options{file} =3D $file ;
+ }
+}
+
+Getopt::Long::Configure("bundling");
+
+# TODO: maybe allow the token map $options{tmap} to be configurable.
+GetOptions(\%options,
+           "help|h",
+           "debug|d",
+           "file|f=3Ds",
+          );
+
+if ($options{help})
+{
+ my $shortname =3D basename($0);
+ $shortname =3D~ s/git-credential-//;
+
+ print <<EOHIPPUS;
+
+$0 [-f AUTHFILE] [-d] get
+
+Version $VERSION by tzz\@lifelogs.com.  License: any use is OK.
+
+Options:
+  -f AUTHFILE: specify a netrc-style file
+  -d: turn on debugging
+
+To enable (note that Git will prepend "git-credential-" to the helper
+name and look for it in the path):
+
+  git config credential.helper '$shortname -f AUTHFILE'
+
+And if you want lots of debugging info:
+
+  git config credential.helper '$shortname -f AUTHFILE -d'
+
+Only "get" mode is supported by this credential helper.  It opens
+AUTHFILE and looks for entries that match the requested search
+criteria:
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
+Thus, when we get "protocol=3Dhttps\nusername=3Dtzz", this credential
+helper will look for lines in AUTHFILE that match
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
+Then, the helper will print out whatever tokens it got from the line,
+including "password" tokens, mapping e.g. "port" back to "protocol".
+
+The first matching line is used.  Tokens can be quoted as 'STRING' or
+"STRING".
+
+No caching is performed by this credential helper.
+
+EOHIPPUS
+
+ exit;
+}
+
+my $mode =3D shift @ARGV;
+
+# credentials may get 'get', 'store', or 'erase' as parameters but
+# only acknowledge 'get'
+die "Syntax: $0 [-f AUTHFILE] [-d] get" unless defined $mode;
+
+# only support 'get' mode
+exit unless $mode eq 'get';
+
+my $debug =3D $options{debug};
+my $file =3D $options{file};
+
+die "Sorry, you need to specify an existing netrc file (with or withou=
t a .gpg extension) with -f AUTHFILE"
+ unless defined $file;
+
+die "Sorry, the specified netrc $file is not accessible"
+ unless -f $file;
+
+if ($file =3D~ m/\.gpg$/)
+{
+ $file =3D "gpg --decrypt $file|";
+}
+
+my @data =3D load($file);
+chomp @data;
+
+die "Sorry, we could not load data from [$file]"
+ unless (scalar @data);
+
+# the query
+my %q;
+
+foreach my $v (values %{$options{tmap}})
+{
+ undef $q{$v};
+}
+
+while (<STDIN>)
+{
+ next unless m/([a-z]+)=3D(.+)/;
+
+ my ($token, $value) =3D ($1, $2);
+ die "Unknown search token $1" unless exists $q{$token};
+ $q{$token} =3D $value;
+}
+
+# build reverse token map
+my %rmap;
+foreach my $k (keys %{$options{tmap}})
+{
+ push @{$rmap{$options{tmap}->{$k}}}, $k;
+}
+
+# there are CPAN modules to do this better, but we want to avoid
+# dependencies and generally, complex netrc-style files are rare
+
+if ($debug)
+{
+ foreach (sort keys %q)
+ {
+  printf STDERR "searching for %s =3D %s\n",
+   $_, $q{$_} || '(any value)';
+ }
+}
+
+LINE: foreach my $line (@data)
+{
+
+ print STDERR "line [$line]\n" if $debug;
+ my @tok;
+ # gratefully stolen from Net::Netrc
+ while (length $line &&
+        $line =3D~ s/^("((?:[^"]+|\\.)*)"|((?:[^\\\s]+|\\.)*))\s*//)
+ {
+  (my $tok =3D $+) =3D~ s/\\(.)/$1/g;
+  push(@tok, $tok);
+ }
+
+ my %tokens;
+ while (@tok)
+ {
+  my ($k, $v) =3D (shift @tok, shift @tok);
+  next unless defined $v;
+  next unless exists $options{tmap}->{$k};
+  $tokens{$options{tmap}->{$k}} =3D $v;
+ }
+
+ foreach my $check (sort keys %q)
+ {
+  if (exists $tokens{$check} && defined $q{$check})
+  {
+   print STDERR "comparing [$tokens{$check}] to [$q{$check}] in line [=
$line]\n" if $debug;
+   next LINE unless $tokens{$check} eq $q{$check};
+  }
+  else
+  {
+   print STDERR "we could not find [$check] but it's OK\n" if $debug;
+  }
+ }
+
+ print STDERR "line has passed all the search checks\n" if $debug;
+ foreach my $token (sort keys %rmap)
+ {
+  print STDERR "looking for useful token $token\n" if $debug;
+  next unless exists $tokens{$token}; # did we match?
+
+  foreach my $rctoken (@{$rmap{$token}})
+  {
+   next if defined $q{$rctoken};           # don't re-print given toke=
ns
+  }
+
+  print STDERR "FOUND: $token=3D$tokens{$token}\n" if $debug;
+  printf "%s=3D%s\n", $token, $tokens{$token};
+ }
+
+ last;
+}
+
+sub load
+{
+ my $file =3D shift;
+ # this supports pipes too
+ my $io =3D new IO::File($file) or die "Could not open $file: $!\n";
+
+ return <$io>;                          # whole file
+}
--=20
1.7.9.rc2
