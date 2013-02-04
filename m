From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 3/3] Fix contrib/credentials/netrc minor issues: exit
 quietly; use 3-parameter open; etc.
Date: Mon, 04 Feb 2013 11:43:14 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87k3qovxlp.fsf_-_@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:43:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2P8u-0002kl-9k
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab3BDQnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 11:43:17 -0500
Received: from z.lifelogs.com ([173.255.230.239]:54042 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348Ab3BDQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 11:43:15 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 239FEDE0C5;
	Mon,  4 Feb 2013 16:43:15 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215392>


Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/git-credential-netrc |   38 +++++++++++++------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index a47a223..0e35918 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -3,8 +3,6 @@
 use strict;
 use warnings;
 
-use Data::Dumper;
-
 use Getopt::Long;
 use File::Basename;
 
@@ -58,7 +56,7 @@ if ($options{help})
 
 $0 [-f AUTHFILE] [-d] get
 
-Version $VERSION by tzz\@lifelogs.com.  License: any use is OK.
+Version $VERSION by tzz\@lifelogs.com.  License: BSD.
 
 Options:
   -f AUTHFILE: specify a netrc-style file
@@ -129,31 +127,36 @@ my $file = $options{file};
 die "Sorry, you need to specify an existing netrc file (with or without a .gpg extension) with -f AUTHFILE"
  unless defined $file;
 
-die "Sorry, the specified netrc $file is not accessible"
- unless -f $file;
+unless (-f $file)
+{
+ print STDERR "Sorry, the specified netrc $file is not accessible\n" if $debug;
+ exit 0;
+}
 
+my @data;
 if ($file =~ m/\.gpg$/)
 {
- $file = "gpg --decrypt $file|";
+ @data = load('-|', qw(gpg --decrypt), $file)
+}
+else
+{
+ @data = load('<', $file);
 }
 
-my @data = load($file);
 chomp @data;
 
-die "Sorry, we could not load data from [$file]"
- unless (scalar @data);
-
-# the query
-my %q;
-
-foreach my $v (values %{$options{tmap}})
+unless (scalar @data)
 {
- undef $q{$v};
+ print STDERR "Sorry, we could not load data from [$file]\n" if $debug;
+ exit;
 }
 
+# the query: start with every token with no value
+my %q = map { $_ => undef } values(%{$options{tmap}});
+
 while (<STDIN>)
 {
- next unless m/([a-z]+)=(.+)/;
+ next unless m/([^=]+)=(.+)/;
 
  my ($token, $value) = ($1, $2);
  die "Unknown search token $1" unless exists $q{$token};
@@ -237,9 +240,8 @@ LINE: foreach my $line (@data)
 
 sub load
 {
- my $file = shift;
  # this supports pipes too
- my $io = new IO::File($file) or die "Could not open $file: $!\n";
+ my $io = new IO::File(@_) or die "Could not open [@_]: $!\n";
 
  return <$io>;                          # whole file
 }
-- 
1.7.9.rc2
