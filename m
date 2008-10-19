From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFR&A] Fix reading of cloud tags
Date: Sun, 19 Oct 2008 00:06:57 -0700
Message-ID: <7vbpxh83n2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Oct 19 09:08:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrSOs-00011H-Jn
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 09:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbYJSHHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 03:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbYJSHHH
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 03:07:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbYJSHHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 03:07:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B12047105F;
	Sun, 19 Oct 2008 03:07:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 284EE7105C; Sun, 19 Oct 2008 03:06:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 884441FA-9DAC-11DD-8FE8-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98598>

This is in 'next' but it would be nice to get acked before advancing it to
master.

-- >8 --

The projectroot path could have SP in it, in which case iterating over
<$git_dir/ctags/*> does not correctly enumerate the cloud tags files at
all.

This can be observed by creating an empty t/trash directory and running
t9500 test.  The $projectroot ends with "trash directory.t9500-gitweb-/"
and <$glob> would give "trash", which can be opened and reading from it
immediately yields undef, which in turn gives an undef value warning to
the standard error stream upon attempt to chomp it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1116800..41b6866 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1805,7 +1805,10 @@ sub git_get_project_ctags {
 	my $ctags = {};
 
 	$git_dir = "$projectroot/$path";
-	foreach (<$git_dir/ctags/*>) {
+	unless (opendir D, "$git_dir/ctags") {
+		return $ctags;
+	}
+	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir(D)) {
 		open CT, $_ or next;
 		my $val = <CT>;
 		chomp $val;
@@ -1813,6 +1816,7 @@ sub git_get_project_ctags {
 		my $ctag = $_; $ctag =~ s#.*/##;
 		$ctags->{$ctag} = $val;
 	}
+	closedir D;
 	$ctags;
 }
 
-- 
1.6.0.2.767.g8f0e
