From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] git-svn: Print revision while searching for earliest use of path
Date: Thu,  5 Feb 2009 00:09:30 -0500
Message-ID: <1233810570-30765-1-git-send-email-deskinm@umich.edu>
Cc: gitster@pobox.com, normalperson@yhbt.net,
	Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 06:11:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUwWO-0006Yi-WB
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 06:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbZBEFJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 00:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbZBEFJm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 00:09:42 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:35058 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbZBEFJl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 00:09:41 -0500
Received: by yx-out-2324.google.com with SMTP id 8so23280yxm.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 21:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=kJUQBBSFcg6Vgw2BoZAc8ImnwxxMIL28Mvsu9218OjY=;
        b=YTUmV3eSLY5qTxdZjCCBnpYIHKDRyeN/jw8Z2gqUCmBX4WK7VYN8LTaxkOWxlsh9rM
         sccuPu0xR6FwN6pkcIFaW/67GXE3SexDT6U4Iz37sMHNqT7/JxNsthaxo8P4+lS2nEAB
         a3DbKX7MEeB9ARdNGp2v8Xc2aOozojldT+tf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=OYQFJvdCUt99HM4M1Ygq811hMgCmvPVyCKn9X5TjwTNQvdUPBa08+jUfTikevSDo7d
         ELN8TK46HqCjRFOwgf2TVM2WivqXMzCEleFrR0qjH/DsJnDp2s2rtqLHYutJn/P5y9b7
         TH97d3SA2bsXCIBc/qtjvKmWXiTb8BntKV6s0=
Received: by 10.65.200.13 with SMTP id c13mr85317qbq.35.1233810579483;
        Wed, 04 Feb 2009 21:09:39 -0800 (PST)
Received: from localhost.localdomain ([68.40.49.130])
        by mx.google.com with ESMTPS id k8sm393714qba.13.2009.02.04.21.09.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 21:09:38 -0800 (PST)
X-Mailer: git-send-email 1.6.1.399.g0d272
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108497>

When initializing a git-svn repository from a Subversion repository, it
is common to be interested in a path which did not exist in the initial
commit to Subversion.  In a large repository like e.g. Apache, this may
take some time while the user receives no additional feedback.  Print
the highest revision number scanned thus far to let the user know
something is still happening.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
This came about on account of patmaddox asking on #git why git-svn
seemed to be hung on clone.  Despite the admonition that this might take
a long time, I also like to have some indication that progress is being
made.  My first version of this printed using '\rChecked through
r$revision' but the subsequent output line when the path is found ends
up clobbered on the same line, and I'm not skilled enough at the
terminal or Perl to address this cleanly.  If the current version is
felt to be too verbose since it is printing a new line, I'd be up for
squelching the output to e.g. every 1000 revisions or so.

Anecdotally, it looks like Subversion looks for the path in blocks of
100 revisions, so we get the nice whole revision number for free.  I
couldn't find any documentation on the proper format of the error
message, so I just came up with the regular expressions to parse the
revision myself; if they need to be more explicit to avoid really
egregious path names, I can make an effort.

I tested on both http:// and file:// transport, to come up with the
different error strings; since the error number for file is the same as
svn:// I'm hoping that the error string is the same too.  If someone can
bounce this off a svn:// repo I'd appreciate it, otherwise I'll dig out
the documentation and set up a network-served svn repository myself
(which is really my job as the patch author anyway).

Deskin Miller

 git-svn.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 79888a0..60b56be 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4542,6 +4542,12 @@ sub skip_unknown_revs {
 	#   More codes may be discovered later...
 	if ($errno == 175007 || $errno == 175002 || $errno == 160013) {
 		my $err_key = $err->expanded_message;
+		my $revision = $err_key;
+		if ($errno == 175007 || $errno == 175002 ) {
+			$revision =~ s/.*!svn\/bc\/(\d+).*/$1/;
+		} elsif ($errno == 160013) {
+			$revision =~ s/.*File not found: revision (\d+).*/$1/;
+		}
 		# revision numbers change every time, filter them out
 		$err_key =~ s/\d+/\0/g;
 		$err_key = "$errno\0$err_key";
@@ -4555,6 +4561,7 @@ sub skip_unknown_revs {
 			     "This may take a while on large repositories\n";
 			$ignored_err{$err_key} = 1;
 		}
+		print "Checked through r$revision\n";
 		return;
 	}
 	die "Error from SVN, ($errno): ", $err->expanded_message,"\n";
-- 
1.6.1.399.g0d272
