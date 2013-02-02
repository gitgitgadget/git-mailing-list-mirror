From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Sat, 02 Feb 2013 06:57:29 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87k3qrx712.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 12:58:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1bjQ-0002EJ-Uf
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 12:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818Ab3BBL5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 06:57:42 -0500
Received: from plane.gmane.org ([80.91.229.3]:36155 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab3BBL5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 06:57:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U1bjI-00029A-T7
	for git@vger.kernel.org; Sat, 02 Feb 2013 12:57:56 +0100
Received: from c-65-96-148-157.hsd1.ma.comcast.net ([65.96.148.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 12:57:56 +0100
Received: from tzz by c-65-96-148-157.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 12:57:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-65-96-148-157.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:Cr+tC1Q4UTuxOlBjKVWeVLzeO9Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215289>

--=-=-=
Content-Type: text/plain

On Thu, 31 Jan 2013 14:38:45 -0500 Jeff King <peff@peff.net> wrote: 

JK> On Thu, Jan 31, 2013 at 10:23:51AM -0500, Ted Zlatanov wrote:
>> Jeff, is there a way for git-credential to currently support
>> authinfo/netrc parsing?  I assume that's the right way, instead of using
>> Michal's proposal to parse internally?
>> 
>> I'd like to add that, plus support for the 'string' and "string"
>> formats, and authinfo.gpg decoding through GPG.  I'd write it in Perl,
>> if there's a choice.

JK> Yes, you could write a credential helper that understands netrc and
JK> friends; git talks to the helpers over a socket, so there is no problem
JK> with writing it in Perl. See Documentation/technical/api-credentials.txt
JK> for an overview, or the sample implementation in credential-store.c for a
JK> simple example.

I wrote a Perl credential helper for netrc parsing which is pretty
robust, has built-in docs with -h, and doesn't depend on external
modules.  The netrc parser regex was stolen from Net::Netrc.

It will by default use ~/.authinfo.gpg, ~/.netrc.gpg, ~/.authinfo, and
~/.netrc (whichever is found first) and this can be overridden with -f.

If the file name ends with ".gpg", it will run "gpg --decrypt FILE" and
use the output.  So non-interactively, that could hang if GPG was
waiting for input.  Does Git handle that, or should I check for a TTY?

Take a look at the proposed patch and let me know if it's usable, if you
need a formal copyright assignment, etc.

Thanks
Ted


--=-=-=
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: inline; filename=p
Content-Transfer-Encoding: 8bit
Content-Description: Add git-credential-netrc

commit 3d28bc2a610ebcc988eba5443d82d0ded92c24bc
Author: Ted Zlatanov <tzz@lifelogs.com>
Date:   Sat Feb 2 06:42:13 2013 -0500

    Add contrib/credentials/netrc with GPG support

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
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
+my $VERSION = "0.1";
+
+my %options = (
+               help => 0,
+               debug => 0,
+
+               # identical token maps, e.g. host -> host, will be inserted later
+               tmap => {
+                        port => 'protocol',
+                        machine => 'host',
+                        path => 'path',
+                        login => 'username',
+                        user => 'username',
+                        password => 'password',
+                       }
+              );
+
+foreach my $v (values %{$options{tmap}})
+{
+ $options{tmap}->{$v} = $v;
+}
+
+foreach my $suffix ('.gpg', '')
+{
+ foreach my $base (qw/authinfo netrc/)
+ {
+  my $file = glob("~/.$base$suffix");
+  next unless (defined $file && -f $file);
+  $options{file} = $file ;
+ }
+}
+
+Getopt::Long::Configure("bundling");
+
+# TODO: maybe allow the token map $options{tmap} to be configurable.
+GetOptions(\%options,
+           "help|h",
+           "debug|d",
+           "file|f=s",
+          );
+
+if ($options{help})
+{
+ my $shortname = basename($0);
+ $shortname =~ s/git-credential-//;
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
+   The protocol that will be used (e.g., https). (protocol=X)
+
+ 'machine|host':
+   The remote hostname for a network credential. (host=X)
+
+ 'path':
+   The path with which the credential will be used. (path=X)
+
+ 'login|user|username':
+   The credential’s username, if we already have one. (username=X)
+
+Thus, when we get "protocol=https\nusername=tzz", this credential
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
+my $mode = shift @ARGV;
+
+# credentials may get 'get', 'store', or 'erase' as parameters but
+# only acknowledge 'get'
+die "Syntax: $0 [-f AUTHFILE] [-d] get" unless defined $mode;
+
+# only support 'get' mode
+exit unless $mode eq 'get';
+
+my $debug = $options{debug};
+my $file = $options{file};
+
+die "Sorry, you need to specify an existing netrc file (with or without a .gpg extension) with -f AUTHFILE"
+ unless defined $file;
+
+die "Sorry, the specified netrc $file is not accessible"
+ unless -f $file;
+
+if ($file =~ m/\.gpg$/)
+{
+ $file = "gpg --decrypt $file|";
+}
+
+my @data = load($file);
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
+ next unless m/([a-z]+)=(.+)/;
+
+ my ($token, $value) = ($1, $2);
+ die "Unknown search token $1" unless exists $q{$token};
+ $q{$token} = $value;
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
+  printf STDERR "searching for %s = %s\n",
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
+        $line =~ s/^("((?:[^"]+|\\.)*)"|((?:[^\\\s]+|\\.)*))\s*//)
+ {
+  (my $tok = $+) =~ s/\\(.)/$1/g;
+  push(@tok, $tok);
+ }
+
+ my %tokens;
+ while (@tok)
+ {
+  my ($k, $v) = (shift @tok, shift @tok);
+  next unless defined $v;
+  next unless exists $options{tmap}->{$k};
+  $tokens{$options{tmap}->{$k}} = $v;
+ }
+
+ foreach my $check (sort keys %q)
+ {
+  if (exists $tokens{$check} && defined $q{$check})
+  {
+   print STDERR "comparing [$tokens{$check}] to [$q{$check}] in line [$line]\n" if $debug;
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
+   next if defined $q{$rctoken};           # don't re-print given tokens
+  }
+
+  print STDERR "FOUND: $token=$tokens{$token}\n" if $debug;
+  printf "%s=%s\n", $token, $tokens{$token};
+ }
+
+ last;
+}
+
+sub load
+{
+ my $file = shift;
+ # this supports pipes too
+ my $io = new IO::File($file) or die "Could not open $file: $!\n";
+
+ return <$io>;                          # whole file
+}

--=-=-=--
