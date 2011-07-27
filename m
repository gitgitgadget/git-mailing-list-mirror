From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] add--interactive: factor out regex error handling
Date: Wed, 27 Jul 2011 02:05:34 -0600
Message-ID: <20110727080534.GB14002@sigill.intra.peff.net>
References: <20110727080303.GA8105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 10:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlz7f-0005Mg-Gw
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab1G0IFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:05:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42544
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab1G0IFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 04:05:37 -0400
Received: (qmail 28407 invoked by uid 107); 27 Jul 2011 08:06:07 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 04:06:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2011 02:05:34 -0600
Content-Disposition: inline
In-Reply-To: <20110727080303.GA8105@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177940>

When perl complains about compiling a regex the user has
given us, we trim the error to get a nicer message. It's
only one line of code, but it's ugly and non-obvious, so
let's factor it into a reusable function.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c5cd300..3e4c8a4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1267,6 +1267,12 @@ sub display_hunks {
 	return $i;
 }
 
+sub trim_error {
+	local $_ = shift;
+	s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
+	return $_;
+}
+
 sub patch_update_file {
 	my $quit = 0;
 	my ($ix, $num);
@@ -1419,9 +1425,8 @@ sub patch_update_file {
 					$search_string = qr{$regex}m;
 				};
 				if ($@) {
-					my ($err,$exp) = ($@, $1);
-					$err =~ s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
-					error_msg "Malformed search regexp $exp: $err\n";
+					my $exp = $1;
+					error_msg "Malformed search regexp $exp: " . trim_error($@) . "\n";
 					next;
 				}
 				my $iy = $ix;
-- 
1.7.5.4.31.ge4d5e
