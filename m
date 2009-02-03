From: Thomas Rast <trast@student.ethz.ch>
Subject: [Illustration PATCH] add -i: accept single-keypress input
Date: Tue,  3 Feb 2009 09:54:08 +0100
Message-ID: <1233651248-26717-1-git-send-email-trast@student.ethz.ch>
References: <20090203062437.GB21367@sigill.intra.peff.net>
Cc: Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 09:55:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUH4S-0003Vk-Cq
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 09:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbZBCIy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 03:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbZBCIy0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 03:54:26 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:56798 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbZBCIyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 03:54:25 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 09:54:22 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 09:54:21 +0100
X-Mailer: git-send-email 1.6.1.2.513.g04677
In-Reply-To: <20090203062437.GB21367@sigill.intra.peff.net>
X-OriginalArrivalTime: 03 Feb 2009 08:54:21.0538 (UTC) FILETIME=[01737420:01C985DD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108166>

Demonstrate how to add Term::ReadKey functionality to the main add -i
prompt function list_and_choose().

Not really great because if several input choices share a common first
character, it prompts for the _rest_ of the line, meaning the choice
of the first character cannot be undone again.
---

Jeff King wrote:
> Minor nit: the name of this variable implies that it will be used across
> all interactive commands (including any future ones).

That would be the point :-)  Not sure what other tools could be
adapted however.  Mergetool maybe, but I don't use that myself.

> But the
> description is intimately linked with perl. Maybe structure it like
> "here is what this does in general, but here are some specific caveats".
[...]
> But since there is only _one_ place it is used now, and since that
> program _is_ a Perl program, maybe this is overengineering.

I just figured that when another program/language comes along that
attempts to do the same, it should be changed.  I suppose for shell
scripts it would read something along the lines of "if the required
'stty' calls fail, the feature is silently disabled".

> Other than that, your series looks OK to me. I think it would be nice to
> have a 5/4 that extends the feature to other menus for the sake of
> consistency. But like you, I really just use "git add -p" myself.

This patch (on top of 3/4) does roughly that.  As I mentioned, I'm not
happy with the prompting behaviour for several characters (e.g. if you
go to the [p]atch menu and have several files starting with the same
character).  It would be nicer to start a readline-ish prompt that
already has the character filled in, but I don't know how to do that,
and then I don't care _that_ much.


 git-add--interactive.perl |   68 ++++++++++++++++++++++++++++++--------------
 1 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3aa21db..f41dd09 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -34,9 +34,11 @@ my ($diff_new_color) =
 my $normal_color = $repo->get_color("", "reset");
 
 my $use_readkey = 0;
+my %control_chars;
 if ($repo->config_bool("interactive.readkey")) {
 	eval {
 		use Term::ReadKey;
+		%control_chars = GetControlChars;
 		$use_readkey = 1;
 	};
 }
@@ -333,12 +335,55 @@ sub highlight_prefix {
 	return "$prompt_color$prefix$normal_color$remainder";
 }
 
+sub _restore_terminal_and_die {
+	ReadMode 'restore';
+	print "\n";
+	exit 1;
+}
+
+sub prompt_single_character {
+	my ($single_chars) = @_;
+	$single_chars = "." unless defined $single_chars;
+	if ($use_readkey) {
+		local $SIG{TERM} = \&_restore_terminal_and_die;
+		local $SIG{INT} = \&_restore_terminal_and_die;
+		ReadMode 'cbreak';
+		my $key = ReadKey 0;
+		ReadMode 'restore';
+		$key = undef if $key eq $control_chars{EOF};
+		if ((defined $key) && $key !~ /$single_chars/) {
+			print colored $prompt_color, $key;
+			my $rest = <STDIN>;
+			$rest = '' unless defined $rest;
+			return $key.$rest;
+		}
+		print "$key" if defined $key;
+		print "\n";
+		return $key;
+	} else {
+		return <STDIN>;
+	}
+}
+
 sub list_and_choose {
 	my ($opts, @stuff) = @_;
 	my (@chosen, @return);
 	my $i;
 	my @prefixes = find_unique_prefixes(@stuff) unless $opts->{LIST_ONLY};
 
+	my $single_chars = '';
+	for (@prefixes) {
+		my ($pre, $post) = @{$_};
+		if (length $pre == 1) {
+			$single_chars .= $pre;
+		}
+	}
+	for ($i = 0; $i < 10; $i++) {
+		if (10*$i > scalar @stuff) {
+			$single_chars .= $i;
+		}
+	}
+
       TOPLOOP:
 	while (1) {
 		my $last_lf = 0;
@@ -392,7 +437,7 @@ sub list_and_choose {
 		else {
 			print ">> ";
 		}
-		my $line = <STDIN>;
+		my $line = prompt_single_character('['.$single_chars.']');
 		if (!$line) {
 			print "\n";
 			$opts->{ON_EOF}->() if $opts->{ON_EOF};
@@ -766,27 +811,6 @@ sub diff_applies {
 	return close $fh;
 }
 
-sub _restore_terminal_and_die {
-	ReadMode 'restore';
-	print "\n";
-	exit 1;
-}
-
-sub prompt_single_character {
-	if ($use_readkey) {
-		local $SIG{TERM} = \&_restore_terminal_and_die;
-		local $SIG{INT} = \&_restore_terminal_and_die;
-		ReadMode 'cbreak';
-		my $key = ReadKey 0;
-		ReadMode 'restore';
-		print "$key" if defined $key;
-		print "\n";
-		return $key;
-	} else {
-		return <STDIN>;
-	}
-}
-
 sub prompt_yesno {
 	my ($prompt) = @_;
 	while (1) {
-- 
1.6.1.2.513.g04677
