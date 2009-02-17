From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-add -i/-p: learn to unwrap C-quoted paths
Date: Mon, 16 Feb 2009 23:02:35 -0800
Message-ID: <7v3aeda6lw.fsf_-_@gitster.siamese.dyndns.org>
References: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com>
 <87tz6vr0g4.fsf@iki.fi>
 <2b8265360902151100n2eca0182odf9543c1dd8a7f98@mail.gmail.com>
 <87prhjqzwb.fsf@iki.fi> <20090216033634.GA12461@coredump.intra.peff.net>
 <7v63jbf2v0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 08:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZK05-0000Lz-44
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbZBQHCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbZBQHCp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:02:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbZBQHCo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:02:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E166C992FE;
	Tue, 17 Feb 2009 02:02:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EA76992FD; Tue,
 17 Feb 2009 02:02:37 -0500 (EST)
In-Reply-To: <7v63jbf2v0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 15 Feb 2009 20:00:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F8CB1606-FCC0-11DD-8D04-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110316>

The underlying plumbing commands are not run with -z option, so the paths
returned from them need to be unquoted as needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Junio C Hamano <gitster@pobox.com> writes:

 > I did not spell the specifics out because this change won't happen in any
 > near future anyway, but my thinking was to give a way for "add -p" to
 > either (1) internally run without quotepath regardless of the user's
 > settings or (2) unquote the paths correctly when it learns the set of
 > paths affected by the change.
 >
 > I think the right approach is (2), because you need to unquote pathnames
 > with some byte values that even with core.quotepath=false will not pass
 > unquoted *anyway*.

 I deliberately avoided using :utf8 because pathnames to git are always
 binary text, not necessarily utf8, and for the same reason I dropped the
 "shortcut by first character", as the pathnames are stored as raw
 sequence of bytes and using the first byte is obviously wrong.  It would
 be very much welcomed if somebody feels inclined to test and polish it.

 This hopefully makes the discussion on default value for core.quotepath
 independent of "git-add -i/-p".

 git-add--interactive.perl |   55 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5f129a4..064d4c6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -3,6 +3,8 @@
 use strict;
 use Git;
 
+binmode(STDOUT, ":raw");
+
 my $repo = Git->repository();
 
 my $menu_use_color = $repo->get_colorbool('color.interactive');
@@ -91,6 +93,47 @@ if (!defined $GIT_DIR) {
 }
 chomp($GIT_DIR);
 
+my %cquote_map = (
+ "b" => chr(8),
+ "t" => chr(9),
+ "n" => chr(10),
+ "v" => chr(11),
+ "f" => chr(12),
+ "r" => chr(13),
+ "\\" => "\\",
+ "\042" => "\042",
+);
+
+sub unquote_path {
+	local ($_) = @_;
+	my ($retval, $remainder);
+	if (!/^\042(.*)\042$/) {
+		return $_;
+	}
+	($_, $retval) = ($1, "");
+	while (/^([^\\]*)\\(.*)$/) {
+		$remainder = $2;
+		$retval .= $1;
+		for ($remainder) {
+			if (/^([0-3][0-7][0-7])(.*)$/) {
+				$retval .= chr(oct($1));
+				$_ = $2;
+				last;
+			}
+			if (/^([\\\042btnvfr])(.*)$/) {
+				$retval .= $cquote_map{$1};
+				$_ = $2;
+				last;
+			}
+			# This is malformed -- just return it as-is for now.
+			return $_[0];
+		}
+		$_ = $remainder;
+	}
+	$retval .= $_;
+	return $retval;
+}
+
 sub refresh {
 	my $fh;
 	open $fh, 'git update-index --refresh |'
@@ -104,7 +147,7 @@ sub refresh {
 sub list_untracked {
 	map {
 		chomp $_;
-		$_;
+		unquote_path($_);
 	}
 	run_cmd_pipe(qw(git ls-files --others --exclude-standard --), @ARGV);
 }
@@ -141,7 +184,8 @@ sub list_modified {
 
 	if (@ARGV) {
 		@tracked = map {
-			chomp $_; $_;
+			chomp $_;
+			unquote_path($_);
 		} run_cmd_pipe(qw(git ls-files --exclude-standard --), @ARGV);
 		return if (!@tracked);
 	}
@@ -153,6 +197,7 @@ sub list_modified {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			my ($change, $bin);
+			$file = unquote_path($file);
 			if ($add eq '-' && $del eq '-') {
 				$change = 'binary';
 				$bin = 1;
@@ -168,6 +213,7 @@ sub list_modified {
 		}
 		elsif (($adddel, $file) =
 		       /^ (create|delete) mode [0-7]+ (.*)$/) {
+			$file = unquote_path($file);
 			$data{$file}{INDEX_ADDDEL} = $adddel;
 		}
 	}
@@ -175,6 +221,7 @@ sub list_modified {
 	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
+			$file = unquote_path($file);
 			if (!exists $data{$file}) {
 				$data{$file} = +{
 					INDEX => 'unchanged',
@@ -196,6 +243,7 @@ sub list_modified {
 		}
 		elsif (($adddel, $file) =
 		       /^ (create|delete) mode [0-7]+ (.*)$/) {
+			$file = unquote_path($file);
 			$data{$file}{FILE_ADDDEL} = $adddel;
 		}
 	}
@@ -302,7 +350,8 @@ sub find_unique_prefixes {
 			}
 			%search = %{$search{$letter}};
 		}
-		if ($soft_limit && $j + 1 > $soft_limit) {
+		if (ord($letters[0]) > 127 ||
+		    ($soft_limit && $j + 1 > $soft_limit)) {
 			$prefix = undef;
 			$remainder = $ret;
 		}
-- 
1.6.2.rc1.47.g30e1d8
