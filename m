From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] contrib: update stats/mailmap script
Date: Wed, 12 Dec 2012 06:41:41 -0500
Message-ID: <20121212114141.GE18803@sigill.intra.peff.net>
References: <20121212113036.GB19625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 12:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TikhN-0004WY-FW
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab2LLLlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 06:41:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42824 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab2LLLlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 06:41:44 -0500
Received: (qmail 23429 invoked by uid 107); 12 Dec 2012 11:42:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 06:42:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 06:41:41 -0500
Content-Disposition: inline
In-Reply-To: <20121212113036.GB19625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211345>

This version changes quite a few things:

  1. The original parsed the mailmap file itself, and it did
     it wrong (it did not understand entries with an extra
     email key).

     Instead, this version uses git's "%aE" and "%aN"
     formats to have git perform the mapping, meaning we do
     not have to read .mailmap at all, but still operate on
     the current state that git sees (and it also works
     properly from subdirs).

  2. The original would find multiple names for an email,
     but not the other way around.

     This version can do either or both. If we find multiple
     emails for a name, the resolution is less obvious than
     the other way around. However, it can still be a
     starting point for a human to investigate.

  3. The original would order only by count, not by recency.

     This version can do either. Combined with showing the
     counts, it can be easier to decide how to resolve.

  4. This version shows similar entries in a blank-delimited
     stanza, which makes it more clear which options you are
     picking from.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/stats/mailmap.pl | 108 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 38 deletions(-)
 rewrite contrib/stats/mailmap.pl (97%)

diff --git a/contrib/stats/mailmap.pl b/contrib/stats/mailmap.pl
dissimilarity index 97%
index 4b852e2..9513f5e 100755
--- a/contrib/stats/mailmap.pl
+++ b/contrib/stats/mailmap.pl
@@ -1,38 +1,70 @@
-#!/usr/bin/perl -w
-my %mailmap = ();
-open I, "<", ".mailmap";
-while (<I>) {
-	chomp;
-	next if /^#/;
-	if (my ($author, $mail) = /^(.*?)\s+<(.+)>$/) {
-		$mailmap{$mail} = $author;
-	}
-}
-close I;
-
-my %mail2author = ();
-open I, "git log --pretty='format:%ae	%an' |";
-while (<I>) {
-	chomp;
-	my ($mail, $author) = split(/\t/, $_);
-	next if exists $mailmap{$mail};
-	$mail2author{$mail} ||= {};
-	$mail2author{$mail}{$author} ||= 0;
-	$mail2author{$mail}{$author}++;
-}
-close I;
-
-while (my ($mail, $authorcount) = each %mail2author) {
-	# %$authorcount is ($author => $count);
-	# sort and show the names from the most frequent ones.
-	my @names = (map { $_->[0] }
-		sort { $b->[1] <=> $a->[1] }
-		map { [$_, $authorcount->{$_}] }
-		keys %$authorcount);
-	if (1 < @names) {
-		for (@names) {
-			print "$_ <$mail>\n";
-		}
-	}
-}
-
+#!/usr/bin/perl
+
+use warnings 'all';
+use strict;
+use Getopt::Long;
+
+my $match_emails;
+my $match_names;
+my $order_by = 'count';
+Getopt::Long::Configure(qw(bundling));
+GetOptions(
+	'emails|e!' => \$match_emails,
+	'names|n!'  => \$match_names,
+	'count|c'   => sub { $order_by = 'count' },
+	'time|t'    => sub { $order_by = 'stamp' },
+) or exit 1;
+$match_emails = 1 unless $match_names;
+
+my $email = {};
+my $name = {};
+
+open(my $fh, '-|', "git log --format='%at <%aE> %aN'");
+while(<$fh>) {
+	my ($t, $e, $n) = /(\S+) <(\S+)> (.*)/;
+	mark($email, $e, $n, $t);
+	mark($name, $n, $e, $t);
+}
+close($fh);
+
+if ($match_emails) {
+	foreach my $e (dups($email)) {
+		foreach my $n (vals($email->{$e})) {
+			show($n, $e, $email->{$e}->{$n});
+		}
+		print "\n";
+	}
+}
+if ($match_names) {
+	foreach my $n (dups($name)) {
+		foreach my $e (vals($name->{$n})) {
+			show($n, $e, $name->{$n}->{$e});
+		}
+		print "\n";
+	}
+}
+exit 0;
+
+sub mark {
+	my ($h, $k, $v, $t) = @_;
+	my $e = $h->{$k}->{$v} ||= { count => 0, stamp => 0 };
+	$e->{count}++;
+	$e->{stamp} = $t unless $t < $e->{stamp};
+}
+
+sub dups {
+	my $h = shift;
+	return grep { keys($h->{$_}) > 1 } keys($h);
+}
+
+sub vals {
+	my $h = shift;
+	return sort {
+		$h->{$b}->{$order_by} <=> $h->{$a}->{$order_by}
+	} keys($h);
+}
+
+sub show {
+	my ($n, $e, $h) = @_;
+	print "$n <$e> ($h->{$order_by})\n";
+}
-- 
1.8.0.2.4.g59402aa
