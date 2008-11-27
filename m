From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add / command in add --patch
Date: Thu, 27 Nov 2008 14:50:15 -0800
Message-ID: <7vod00aimw.fsf@gitster.siamese.dyndns.org>
References: <492E1D1D.5090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 23:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5piK-0002T6-SR
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 23:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbYK0Wuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 17:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYK0Wuo
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 17:50:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYK0Wun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 17:50:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D5948257D;
	Thu, 27 Nov 2008 17:50:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5323E8257A; Thu,
 27 Nov 2008 17:50:17 -0500 (EST)
In-Reply-To: <492E1D1D.5090101@gmail.com> (William Pursell's message of "Thu,
 27 Nov 2008 04:07:57 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D19C7532-BCD5-11DD-9AB3-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101845>

William Pursell <bill.pursell@gmail.com> writes:

> This command allows the user to skip hunks that don't
> match the specified regex.
>
> BUG:  if the user enters an invalid regex, perl will abort.
> For example: /+\s*foo will abort with:
> Quantifier follows nothing in regex

I think that is a lessor bug that can be fixed more easily.  I think the
bigger problem with your patch is that it breaks the code structure.

If you look at the existing code, you would notice that the loop is
structured in such a way that we show the hunk we currently have focus,
get a command from the user, and the command decides what to do with the
hunk we have focus (no-op for many of them, flip {USE} bit for some) and
where to move the focus (many increments $ix, some decrements $ix).  The
"find" command is about not doing anything to {USE} bit and moving the
focus to the hunk that has the text, so you have your additional code
touching wrong section of the code.

I'd suggest redoing [2/3] like this.

 git-add--interactive.perl |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git c/git-add--interactive.perl w/git-add--interactive.perl
index f20b880..17724d1 100755
--- c/git-add--interactive.perl
+++ w/git-add--interactive.perl
@@ -800,6 +800,7 @@ y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks in the file
 d - do not stage this hunk nor any of the remaining hunks in the file
+/ - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
@@ -919,7 +920,7 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, "Stage this hunk [y,n,a,d$other,?]? ";
+		print colored $prompt_color, "Stage this hunk [y,n,a,d,/$other,?]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -946,6 +947,28 @@ sub patch_update_file {
 				}
 				next;
 			}
+			elsif ($line =~ m|^/(.*)|) {
+				my $search_string;
+				eval {
+					$search_string = qr{$1}m;
+				};
+				if ($@) {
+					my ($err,$exp) = ($@, $1);
+					$err =~ s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
+					print STDERR "Malformed search regexp $exp: $err\n";
+					next;
+				}
+				my $iy = $ix;
+				while (1) {
+					my $text = join ("", @{$hunk[$iy]{TEXT}});
+					last if ($text =~ $search_string);
+					$iy++;
+					$iy = 0 if ($iy >= $num);
+					last if ($ix == $iy);
+				}
+				$ix = $iy;
+				next;
+			}
 			elsif ($other =~ /K/ && $line =~ /^K/) {
 				$ix--;
 				next;
