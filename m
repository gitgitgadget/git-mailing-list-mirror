From: =?utf-8?Q?Jan_Pe=C5=A1ta?= <jan.pesta@certicon.cz>
Subject: [PATCH] git svn: ignore partial svn:mergeinfo
Date: Thu, 7 Mar 2013 12:28:14 +0100
Message-ID: <000e01ce1b26$dbb65570$93230050$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>,
	"'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>,
	"'Sam Vilain'" <sam@vilain.net>
To: "'Eric Wong'" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 12:28:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDZ09-0004cT-LH
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 12:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407Ab3CGL2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 06:28:20 -0500
Received: from service.certicon.cz ([90.183.112.10]:4750 "EHLO
	service.certicon.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab3CGL2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 06:28:19 -0500
Received: from miami (c-006.certicon.cz [90.183.112.6])
	(Authenticated sender: pesta)
	by service.certicon.cz (Postfix) with ESMTPSA id 242B017080B;
	Thu,  7 Mar 2013 12:28:15 +0100 (CET)
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac4bJttG09FJeJKdTMyRuwCFMdh0kQ==
Content-Language: cs
X-certicon-MailScanner-Information: Please contact our ICT for more information
X-MailScanner-ID: 242B017080B.69247
X-certicon-MailScanner: Found to be clean
X-certicon-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.2, required 5.1, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_50 0.80)
X-certicon-MailScanner-From: jan.pesta@certicon.cz
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217593>

Currently this is cosmetic change - the merges are ignored, becuase the methods 
(lookup_svn_merge, find_rev_before, find_rev_after) are failing on comparing text with number.

See http://www.open.collab.net/community/subversion/articles/merge-info.html
Extract:
The range r30430:30435 that was added to 1.5.x in this merge has a '*' suffix for 1.5.x\www.
This '*' is the marker for a non-inheritable mergeinfo range.
The '*' means that only the path on which the mergeinfo is explicitly set has had this range merged into it.

Signed-off-by: Jan Pesta <jan.pesta@certicon.cz>
---
 perl/Git/SVN.pm | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 0ebc68a..74d49bb 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1493,6 +1493,11 @@ sub lookup_svn_merge {
 	my @merged_commit_ranges;
 	# find the tip
 	for my $range ( @ranges ) {
+		if ($range =~ /[*]$/) {
+			warn "W:Ignoring partial merge in svn:mergeinfo "
+				."dirprop: $source:$range\n";
+			next;
+		}
 		my ($bottom, $top) = split "-", $range;
 		$top ||= $bottom;
 		my $bottom_commit = $gs->find_rev_after( $bottom, 1, $top );
-- 
1.8.1.msysgit.1
