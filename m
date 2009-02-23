From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [PATCH] git-svn: read the dcommit url from the config file on a per remote basis
Date: Mon, 23 Feb 2009 12:02:53 +0100
Message-ID: <200902231202.54054.kumbayo84@arcor.de>
References: <200902191930.10139.kumbayo84@arcor.de> <200902222241.56223.kumbayo84@arcor.de> <20090223020545.GE26706@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 12:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbYcN-0001HI-1n
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 12:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbZBWLDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 06:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZBWLDa
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 06:03:30 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:37115 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752217AbZBWLDa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 06:03:30 -0500
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id 05A6A1AF89F;
	Mon, 23 Feb 2009 12:03:28 +0100 (CET)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id E4F282793F9;
	Mon, 23 Feb 2009 12:03:27 +0100 (CET)
Received: from oberndorfer.lan (212-183-119-218.adsl.highway.telekom.at [212.183.119.218])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-11.arcor-online.net (Postfix) with ESMTPSA id 7288DE3970;
	Mon, 23 Feb 2009 12:03:27 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.6.0 mail-in-11.arcor-online.net 7288DE3970
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1235387007; bh=HFQRV4pe9uf4jKdyBf6l63STxnkcZvRu6zUvdC8h/v4=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type:Content-Transfer-Encoding; b=Iz8KRxGQzcHul
	0L5+Czj3in1vZ1muaYMCw1jLmY70utSAtQrp+v4rzjAls3/AP5Sd0okmrUuuPQvAarA
	zMCuO8ClBi/QTyI67XQcwb/ZAwkL/M9gJxtA+0L45Z8tHImXsVm8um4KN9E4SWuIUdT
	L5Gq9QKjK0PGuVIhIzwXLX3Q=
User-Agent: KMail/1.9.7
In-Reply-To: <20090223020545.GE26706@dcvr.yhbt.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.94.2/9028/Mon Feb 23 09:21:55 2009 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111131>

The commit url for dcommit is determined in the following order:
commandline option --commit-url
svn.commiturl
svn-remote.<name>.commiturl
svn-remote.<name>.url

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---
Now with a short documentation for svn.commiturl.
I hope the wording is OK.

 Documentation/git-svn.txt |    4 ++++
 git-svn.perl              |   12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3d45654..cda3389 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -169,6 +169,10 @@ and have no uncommitted changes.
 	reused if a user is later given access to an alternate transport
 	method (e.g. `svn+ssh://` or `https://`) for commit.
 
+config key: svn-remote.<name>.commiturl
+
+config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
+
 	Using this option for any other purpose (don't ask)
 	is very strongly discouraged.
 --
diff --git a/git-svn.perl b/git-svn.perl
index cbc5211..be4d011 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -438,7 +438,17 @@ sub cmd_dcommit {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history.\nPerhaps the repository is empty.";
 	}
-	$url = defined $_commit_url ? $_commit_url : $gs->full_url;
+
+	if (defined $_commit_url) {
+		$url = $_commit_url;
+	} else {
+		$url = eval { command_oneline('config', '--get',
+			      "svn-remote.$gs->{repo_id}.commiturl") };
+		if (!$url) {
+			$url = $gs->full_url
+		}
+	}
+
 	my $last_rev = $_revision if defined $_revision;
 	if ($url) {
 		print "Committing to $url ...\n";
-- 
1.6.1.3
