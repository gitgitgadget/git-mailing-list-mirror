From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Thu, 17 Nov 2011 16:15:20 +0100
Message-ID: <4EC52508.9070907@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 17 16:25:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR3q5-00051r-Hw
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 16:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004Ab1KQPZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 10:25:15 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:30399 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196Ab1KQPZN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 10:25:13 -0500
X-Greylist: delayed 664 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Nov 2011 10:25:13 EST
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 8657042205B;
	Thu, 17 Nov 2011 16:14:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; s=dkim1; bh=aftMWPA43owwzid2Eg55l720
	lys=; b=BzzYWPh3VmSb9Iwz4JZLAh3JnjIQmcrhJ2o8lUbccAQU79D2MDbGDFPh
	0h/Z0k/so4PeIE16UYM2WKD5WtUd2+2EI3u86Lix3qdeoF5LMYMcLXwlLwboI2C6
	5ShZ0n2rZu982ma29FdcYXpDX1tobsNctjh/v6m1a/e/OM84/Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; q=dns; s=dkim1; b=hFLQ3xnqeGS8Qba8jk
	6oH2POtGgKlqxM6nMsylHZVp6qSFLaouMJroiABXuhPPv0n42ZSjS2XTw6IZ5UOQ
	58xkOCutX/fXz2sOI7SC/jepwQX3xFTDRr6wSprJsgh4I7BZDPWCy1ADzneKXq+1
	mmdZMV2ZVfy5FX3HaNbJSga9E=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 49FC842203C;
	Thu, 17 Nov 2011 16:14:07 +0100 (CET)
Received: from [139.174.101.48] (account sstri@tu-clausthal.de [139.174.101.48] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.2)
  with ESMTPSA id 23491104; Thu, 17 Nov 2011 16:14:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
X-Enigmail-Version: 1.3.3
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185600>

>From 8e576705ca949c32ff22d3216006073ee70652eb Mon Sep 17 00:00:00 2001
From: Sven Strickroth <email@cs-ware.de>
Date: Thu, 17 Nov 2011 15:43:25 +0100
Subject: [PATCH 1/2] honour GIT_ASKPASS for querying username

git-svn reads usernames from an interactive terminal.
This behavior cause GUIs to hang waiting for git-svn to
complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).

Also see commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e30df22..8ec3dfc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4403,6 +4403,11 @@ sub username {
 	my $username;
 	if (defined $_username) {
 		$username = $_username;
+	} else if (exists $ENV{GIT_ASKPASS}) {
+		open(PH, "-|", $ENV{GIT_ASKPASS}, "Username: ");
+		$username = <PH>;
+		$username =~ s/[\012\015]//; # \n\r
+		close(PH);
 	} else {
 		print STDERR "Username: ";
 		STDERR->flush;
-- 
1.7.7.1.msysgit.0

-- 
Best regards,
 Sven Strickroth
