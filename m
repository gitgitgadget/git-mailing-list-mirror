From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] git-send-email: handle email address with quoted comma
Date: Fri, 19 Dec 2008 11:40:12 +0800
Message-ID: <1229658012-9240-1-git-send-email-fengguang.wu@intel.com>
Cc: Wu Fengguang <fengguang.wu@intel.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 04:44:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDWHV-00084x-JO
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 04:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbYLSDml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 22:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYLSDml
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 22:42:41 -0500
Received: from mga14.intel.com ([143.182.124.37]:27969 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbYLSDmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 22:42:40 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 18 Dec 2008 19:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,246,1228118400"; 
   d="scan'208";a="91937769"
Received: from unknown (HELO localhost) ([10.254.153.195])
  by azsmga001.ch.intel.com with ESMTP; 18 Dec 2008 19:42:18 -0800
Received: from wfg by localhost with local (Exim 4.69)
	(envelope-from <fengguang.wu@intel.com>)
	id 1LDWDk-0002Pe-Hi; Fri, 19 Dec 2008 11:40:12 +0800
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103537>

Correctly handle email addresses containing quoted commas, e.g.

	"Zhu, Yi" <yi.zhu@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>

Here the commas inside the double quotes are NOT email separators.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 git-send-email.perl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3112f76..d44e99c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -20,6 +20,7 @@ use strict;
 use warnings;
 use Term::ReadLine;
 use Getopt::Long;
+use Text::ParseWords;
 use Data::Dumper;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir /;
@@ -359,6 +360,12 @@ foreach my $entry (@bcclist) {
 	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
 }
 
+sub split_addrs($) {
+	my ($addrs) = @_;
+
+	return &quotewords('\s*,\s*', 1, $addrs);
+}
+
 my %aliases;
 my %parse_alias = (
 	# multiline formats can be supported in the future
@@ -367,7 +374,7 @@ my %parse_alias = (
 			my ($alias, $addr) = ($1, $2);
 			$addr =~ s/#.*$//; # mutt allows # comments
 			 # commas delimit multiple addresses
-			$aliases{$alias} = [ split(/\s*,\s*/, $addr) ];
+			$aliases{$alias} = [ split_addrs($addr) ];
 		}}},
 	mailrc => sub { my $fh = shift; while (<$fh>) {
 		if (/^alias\s+(\S+)\s+(.*)$/) {
@@ -379,7 +386,7 @@ my %parse_alias = (
 			chomp $x;
 		        $x .= $1 while(defined($_ = <$fh>) && /^ +(.*)$/);
 			$x =~ /^(\S+)$f\t\(?([^\t]+?)\)?(:?$f){0,2}$/ or next;
-			$aliases{$1} = [ split(/\s*,\s*/, $2) ];
+			$aliases{$1} = [ split_addrs($2) ];
 		}},
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
@@ -588,7 +595,7 @@ if (!@to) {
 	}
 
 	my $to = $_;
-	push @to, split /,\s*/, $to;
+	push @to, split_addrs($to);
 	$prompting++;
 }
 
-- 
1.6.0.4
