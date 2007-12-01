From: Wincent Colaiuta <win@wincent.com>
Subject: [REPLACEMENT PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Sat,  1 Dec 2007 15:29:11 +0100
Message-ID: <1196519351-86280-1-git-send-email-win@wincent.com>
References: <697AB37F-784D-4374-A290-0E6290712B29@wincent.com>
Cc: gitster@pobox.com, dzwell@gmail.com, peff@peff.net,
	Matthieu.Moy@imag.fr, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 15:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyTPq-0004v2-Hw
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 15:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbXLAOcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 09:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbXLAOcF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 09:32:05 -0500
Received: from wincent.com ([72.3.236.74]:55204 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbXLAOcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 09:32:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB1ETB5N030099;
	Sat, 1 Dec 2007 08:29:14 -0600
X-Mailer: git-send-email 1.5.3.6.953.gdffc
In-Reply-To: <697AB37F-784D-4374-A290-0E6290712B29@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66723>

The user interface provided by the command loop in git-add--interactive
gives the impression that subcommands can only be launched by entering
an integer identifier from 1 through 8.

A "hidden" feature is that any string can be entered, and an anchored
regex search is used to find the uniquely matching option.

This patch makes this feature a little more obvious by highlighting the
first character of each subcommand (for example "patch" is displayed as
"[p]atch").

A new function is added to detect the shortest unique prefix and this
is used to decide what to highlight. Highlighting is also applied when
choosing files.

In the case where the common prefix may be unreasonably large
highlighting is omitted; in this patch the soft limit (above which the
highlighting will be omitted for a particular item) is 0 (in other words,
there is no soft limit) and the hard limit (above which highlighting will
be omitted for all items) is 3, but this can be tweaked.

The actual highlighting is done by the highlight_prefix function, which
will enable us to implement ANSI color code-based highlighting (most
likely using underline or boldface) in the future.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

I will go now and crawl under a rock.

 git-add--interactive.perl |  110 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 100 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index fb1e92a..0e358b5 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -44,7 +44,6 @@ my $status_fmt = '%12s %12s %s';
 my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
 
 # Returns list of hashes, contents of each of which are:
-# PRINT:	print message
 # VALUE:	pathname
 # BINARY:	is a binary path
 # INDEX:	is index different from HEAD?
@@ -122,8 +121,6 @@ sub list_modified {
 		}
 		push @return, +{
 			VALUE => $_,
-			PRINT => (sprintf $status_fmt,
-				  $it->{INDEX}, $it->{FILE}, $_),
 			%$it,
 		};
 	}
@@ -159,10 +156,95 @@ sub find_unique {
 	return $found;
 }
 
+# inserts string into trie and updates count for each character
+sub update_trie {
+	my ($trie, $string) = @_;
+	foreach (split //, $string) {
+		$trie = $trie->{$_} ||= {COUNT => 0};
+		$trie->{COUNT}++;
+	}
+}
+
+# returns an array of tuples (prefix, remainder)
+sub find_unique_prefixes {
+	my @stuff = @_;
+	my @return = ();
+
+	# any single prefix exceeding the soft limit is omitted
+	# if any prefix exceeds the hard limit all are omitted
+	# 0 indicates no limit
+	my $soft_limit = 0;
+	my $hard_limit = 3;
+
+	# build a trie modelling all possible options
+	my %trie;
+	foreach my $print (@stuff) {
+		if ((ref $print) eq 'ARRAY') {
+			$print = $print->[0];
+		}
+		elsif ((ref $print) eq 'HASH') {
+			$print = $print->{VALUE};
+		}
+		update_trie(\%trie, $print);
+		push @return, $print;
+	}
+
+	# use the trie to find the unique prefixes
+	for (my $i = 0; $i < @return; $i++) {
+		my $ret = $return[$i];
+		my @letters = split //, $ret;
+		my %search = %trie;
+		my ($prefix, $remainder);
+		my $j;
+		for ($j = 0; $j < @letters; $j++) {
+			my $letter = $letters[$j];
+			if ($search{$letter}{COUNT} == 1) {
+				$prefix = substr $ret, 0, $j + 1;
+				$remainder = substr $ret, $j + 1;
+				last;
+			}
+			else {
+				my $prefix = substr $ret, 0, $j;
+				return ()
+				    if ($hard_limit && $j + 1 > $hard_limit);
+			}
+			%search = %{$search{$letter}};
+		}
+		if ($soft_limit && $j + 1 > $soft_limit) {
+			$prefix = undef;
+			$remainder = $ret;
+		}
+		$return[$i] = [$prefix, $remainder];
+	}
+	return @return;
+}
+
+# filters out prefixes which have special meaning to list_and_choose()
+sub is_valid_prefix {
+	my $prefix = shift;
+	return (defined $prefix) &&
+	    !($prefix =~ /[\s,]/) && # separators
+	    !($prefix =~ /^-/) &&    # deselection
+	    !($prefix =~ /^\d+/) &&  # selection
+	    ($prefix ne '*');        # "all" wildcard
+}
+
+# given a prefix/remainder tuple return a string with the prefix highlighted
+# for now use square brackets; later might use ANSI colors (underline, bold)
+sub highlight_prefix {
+	my $prefix = shift;
+	my $remainder = shift;
+	return $remainder unless defined $prefix;
+	return is_valid_prefix($prefix) ?
+	    "[$prefix]$remainder" :
+	    "$prefix$remainder";
+}
+
 sub list_and_choose {
 	my ($opts, @stuff) = @_;
 	my (@chosen, @return);
 	my $i;
+	my @prefixes = find_unique_prefixes(@stuff) unless $opts->{LIST_ONLY};
 
       TOPLOOP:
 	while (1) {
@@ -177,13 +259,21 @@ sub list_and_choose {
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
 			my $print = $stuff[$i];
-			if (ref $print) {
-				if ((ref $print) eq 'ARRAY') {
-					$print = $print->[0];
-				}
-				else {
-					$print = $print->{PRINT};
-				}
+			my $ref = ref $print;
+			my $highlighted = highlight_prefix(@{$prefixes[$i]})
+			    if @prefixes;
+			if ($ref eq 'ARRAY') {
+				$print = $highlighted || $print->[0];
+			}
+			elsif ($ref eq 'HASH') {
+				my $value = $highlighted || $print->{VALUE};
+				$print = sprintf($status_fmt,
+				    $print->{INDEX},
+				    $print->{FILE},
+				    $value);
+			}
+			else {
+				$print = $highlighted || $print;
 			}
 			printf("%s%2d: %s", $chosen, $i+1, $print);
 			if (($opts->{LIST_FLAT}) &&
-- 
1.5.3.6.953.gdffc
