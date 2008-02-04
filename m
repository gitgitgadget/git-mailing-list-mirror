From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: [PATCH] Make git-remote.perl "use strict" compliant
Date: Mon, 4 Feb 2008 11:09:00 +0100
Message-ID: <b77c1dce0802040209m11ad0ba7w67d07aee6fc4bccb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 11:09:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLyGg-0003sY-BL
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 11:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbYBDKJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 05:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbYBDKJE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 05:09:04 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:59095 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750743AbYBDKJC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 05:09:02 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1878942hsz.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 02:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=xW4pujZ7o7l0E46AgS6GEFIL5/LiX8CyUh7ejEkqol0=;
        b=L+Yxk5ZOnYvjK/5wsoAFfOzeleXExK/o9/fZo8qXkzZh8nqfFM+5ONW/dLFtFDIaWvO+WiWkejSTsgrUQofuo/UgfnyBUO9pXeUemMn7lEqck0J7oa43P6w0dNuPAZT8T7Ye/DxCBTxs1r9tusUbET616gBTVu9IxpT596/V418=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N7JkVI197IlzkJAOMVGZDWQdV3Hl60VfP4ExY4AiWxe6XXk3au+FoGsXsIzUVBxjDsL+gcFZ5Hb5W1NubTEmVLkTH1GOaAWui5cwKaSXktQP9YYl4uA/8e+8o8u6jfj8HBYUEdMEXxsaEw0FI2A/MmL+z4+P85QhqADlwpPL0Fo=
Received: by 10.142.213.9 with SMTP id l9mr3256351wfg.104.1202119740130;
        Mon, 04 Feb 2008 02:09:00 -0800 (PST)
Received: by 10.142.156.10 with HTTP; Mon, 4 Feb 2008 02:09:00 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72483>

I was looking at some of the perl commands, and noticed that
git-remote was the only one to lack a 'use strict' pragma at the top,
which could be a good thing for its maintainability. Hopefully, the
required changes are minimal.

Make git-remote.perl "use strict" compliant

Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
---
 git-remote.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index d13e4c1..5cd6951 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -1,5 +1,6 @@
 #!/usr/bin/perl -w

+use strict;
 use Git;
 my $git = Git->repository();

@@ -296,12 +297,13 @@ sub add_remote {

 sub update_remote {
 	my ($name) = @_;
+	my @remotes;

         my $conf = $git->config("remotes." . $name);
 	if (defined($conf)) {
 		@remotes = split(' ', $conf);
 	} elsif ($name eq 'default') {
-		undef @remotes;
+		@remotes = ();
 		for (sort keys %$remote) {
 			my $do_fetch = $git->config_bool("remote." . $_ .
 						    ".skipDefaultUpdate");
@@ -341,7 +343,7 @@ sub rm_remote {
 	my @refs = $git->command('for-each-ref',
 		'--format=%(refname) %(objectname)', "refs/remotes/$name");
 	for (@refs) {
-		($ref, $object) = split;
+		my ($ref, $object) = split;
 		$git->command(qw(update-ref -d), $ref, $object);
 	}
 	return 0;
@@ -352,7 +354,7 @@ sub add_usage {
 	exit(1);
 }

-local $VERBOSE = 0;
+my $VERBOSE = 0;
 @ARGV = grep {
 	if ($_ eq '-v' or $_ eq '--verbose') {
 		$VERBOSE=1;
@@ -395,7 +397,7 @@ elsif ($ARGV[0] eq 'update') {
 		update_remote("default");
 		exit(1);
 	}
-	for ($i = 1; $i < @ARGV; $i++) {
+	for (my $i = 1; $i < @ARGV; $i++) {
 		update_remote($ARGV[$i]);
 	}
 }
