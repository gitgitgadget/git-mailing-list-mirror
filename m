From: <trast@student.ethz.ch>
Subject: [PATCH] add -i: ignore terminal escape sequences
Date: Tue, 17 May 2011 17:19:08 +0200
Message-ID: <05ce7ccdb3f4e07724d430f6ea2a8c9730971c9d.1305645331.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 17 17:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMM9I-0005n2-4q
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab1EQPZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 11:25:22 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:2682 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120Ab1EQPZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 11:25:21 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 May 2011 11:25:20 EDT
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 17 May
 2011 17:19:05 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 17 May
 2011 17:19:09 +0200
X-Mailer: git-send-email 1.7.5.1.520.g98107.dirty
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173804>

From: Thomas Rast <trast@student.ethz.ch>

On the author's terminal, the up-arrow input sequence is ^[[A, and
thus fat-fingering an up-arrow into 'git checkout -p' is quite
dangerous: git-add--interactive.perl will ignore the ^[ and [
characters and happily treat A as "discard everything".

As a band-aid fix, use Term::Cap to get all terminal capabilities.
Then use the heuristic that any capability value that starts with ^[
(i.e., \e in perl) must be a key input sequence.  Finally, given an
input that starts with ^[, read more characters until we have read a
full escape sequence, then return that to the caller.  We use a
timeout of 0.5 seconds on the subsequent reads to avoid getting stuck
if the user actually input a lone ^[.

Since none of the currently recognized keys start with ^[, the net
result is that the sequence as a whole will be ignored and the help
displayed.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I nearly managed to lose a bunch of uncommitted work today, but could
salvage most of it from the pieces of diffs in the terminal
scrollback.  Sigh.

Future work might include mapping such sequences to the keys they
represent, so that (shift) up-arrow can be k (K) and (shift)
down-arrow j (J), or some such.

Oh yeah, PS: I'm alive ;-)

 git-add--interactive.perl |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 4f08fe7..8f0839d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -45,6 +45,9 @@
 my $normal_color = $repo->get_color("", "reset");
 
 my $use_readkey = 0;
+my $use_termcap = 0;
+my %term_escapes;
+
 sub ReadMode;
 sub ReadKey;
 if ($repo->config_bool("interactive.singlekey")) {
@@ -53,6 +56,14 @@
 		Term::ReadKey->import;
 		$use_readkey = 1;
 	};
+	eval {
+		require Term::Cap;
+		my $termcap = Term::Cap->Tgetent;
+		foreach (values %$termcap) {
+			$term_escapes{$_} = 1 if /^\e/;
+		}
+		$use_termcap = 1;
+	};
 }
 
 sub colored {
@@ -1067,6 +1078,14 @@ sub prompt_single_character {
 		ReadMode 'cbreak';
 		my $key = ReadKey 0;
 		ReadMode 'restore';
+		if ($use_termcap and $key eq "\e") {
+			while (!defined $term_escapes{$key}) {
+				my $next = ReadKey 0.5;
+				last if (!defined $next);
+				$key .= $next;
+			}
+			$key =~ s/\e/^[/;
+		}
 		print "$key" if defined $key;
 		print "\n";
 		return $key;
-- 
1.7.5.1.520.g98107.dirty
