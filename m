From: Fabian Keil <fk@fabiankeil.de>
Subject: [PATCH] git-cvsimport.perl: Bail out right away when reading from
 the server fails
Date: Mon, 31 Jan 2011 20:29:46 +0100
Message-ID: <20110131202946.0a3162b3@r500.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 20:43:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjzel-0002du-67
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 20:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936Ab1AaTnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 14:43:16 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:33419 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab1AaTnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 14:43:16 -0500
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jan 2011 14:43:16 EST
Received: from [78.34.172.116] (helo=r500.local)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <fk@fabiankeil.de>)
	id 1PjzWb-000558-Ab
	for git@vger.kernel.org; Mon, 31 Jan 2011 20:34:57 +0100
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.1; amd64-portbld-freebsd9.0)
X-PGP-KEY-URL: http://www.fabiankeil.de/gpg-keys/fk-2008-08-18.asc
X-Df-Sender: 180909
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165742>

If the CVS server is down, this reduced the git-cvsimport output from:

ssh: connect to host ijbswa.cvs.sourceforge.net port 22: Connection refused
Use of uninitialized value $rep in scalar chomp at /usr/local/libexec/git-core/git-cvsimport line 369.
Use of uninitialized value $rep in substitution (s///) at /usr/local/libexec/git-core/git-cvsimport line 370.
Expected Valid-requests from server, but got: <unknown>

to the less noisy:

ssh: connect to host ijbswa.cvs.sourceforge.net port 22: Connection refused
Failed to read from server at /usr/local/libexec/git-core/git-cvsimport line 370.

In this case a silent exit() instead of the die() would probably do,
but I assume that there could be cases where the connection attempt
succeeds, but reading from the server fails for other reasons.

Signed-off-by: Fabian Keil <fk@fabiankeil.de>
---
 git-cvsimport.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

1d8b7c2be2b7dd281a0799735d00c8111404260f
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8e683e5..2a76d9e 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -366,7 +366,9 @@ sub conn {
 	$self->{'socketo'}->write("valid-requests\n");
 	$self->{'socketo'}->flush();
 
-	chomp(my $rep=$self->readline());
+	my $rep=$self->readline();
+	die "Failed to read from server" unless defined $rep;
+	chomp($rep);
 	if ($rep !~ s/^Valid-requests\s*//) {
 		$rep="<unknown>" unless $rep;
 		die "Expected Valid-requests from server, but got: $rep\n";
-- 
1.7.3.5
