From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH RFC 2/2] gitweb: Hyperlink multiple git hashes on the same commit message line
Date: Tue, 17 Feb 2009 19:00:43 -0800
Message-ID: <1234926043-7471-2-git-send-email-marcel@oak.homeunix.org>
References: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
Cc: jnareb@gmail.com, fg@one2team.net, giuseppe.bilotta@gmail.com,
	pasky@suse.cz, "Marcel M. Cary" <marcel@oak.homeunix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 04:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZchl-0005q6-7o
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 04:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbZBRDA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 22:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbZBRDAz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 22:00:55 -0500
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:29307 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752296AbZBRDAy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 22:00:54 -0500
Received: (qmail 41492 invoked from network); 18 Feb 2009 03:00:53 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp118.sbc.mail.sp1.yahoo.com with SMTP; 18 Feb 2009 03:00:53 -0000
X-YMail-OSG: nUj7dRUVM1kMdbtCY8ji_oKaw02Dap4JlV27LTuLhwMQ9wfHhlCAGlTPOE6AFTBx.hXqsLq0Jv2oGX_TfG6sYzVrI3qm8pt5pFkr3HwE0CofJ_voeviz8ltYRD7AzelFPCedWcXPUVa1P0crBFRSAXZFrE3QpoEDWCMQWkdUqIwIu32NFM54i7byC1aZoA--
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LZcfz-0002PP-Jz; Tue, 17 Feb 2009 19:00:43 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
In-Reply-To: <499AD871.8000808@oak.homeunix.org>
References: <499AD871.8000808@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110500>

The current implementation only hyperlinks the first hash on
a given line of the commit message.  It seems sensible to
highlight all of them if there are multiple, and it seems
plausible that there would be multiple even with a tidy line
length limit, because they can be abbreviated as short as 8
characters.

Benchmark:

I wanted to make sure that using the 'e' switch to the Perl regex
wasn't going to kill performance, since this is called once per commit
message line displayed.

In all three A/B scenarios I tried, the A and B yielded the same
results within 2%, where A is the version of code before this patch
and B is the version after.

1: View a commit message containing the last 1000 commit hashes
2: View a commit message containing 1000 lines of 40 dots to avoid
   hyperlinking at the same message length
3: View a short merge commit message with a few lines of text and
   no hashes

All were run in CGI mode on my sub-production hardware on a recent
clone of git.git.  Numbers are the average of 10 reqests per second
with the first request discarded, since I expect this change to affect
primarily CPU usage.  Measured with ApacheBench.

Note that the web page rendered was the same; while the new code
supports multiple hashes per line, there was at most one per line.

The primary purpose of scenarios 2 and 3 were to verify that the
addition of 1000 commit messages had an impact on how much of the time
was spent rendering commit messages.  They were all within 2% of 0.80
requests per second (much faster).

So I think the patch has no noticeable effect on performance.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---

And here's another.

Marcel


 gitweb/gitweb.perl |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 653f0be..51b7f56 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1384,13 +1384,11 @@ sub format_log_line_html {
 	my $line = shift;
 
 	$line = esc_html($line, -nbsp=>1);
-	if ($line =~ m/\b([0-9a-fA-F]{8,40})\b/) {
-		my $hash_text = $1;
-		my $link =
-			$cgi->a({-href => href(action=>"object", hash=>$hash_text),
-			        -class => "text"}, $hash_text);
-		$line =~ s/$hash_text/$link/;
-	}
+	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
+		return $cgi->a({-href => href(action=>"object", hash=>$1),
+					   -class => "text"}, $1);
+	}eg;
+
 	return $line;
 }
 
-- 
1.6.1
