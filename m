From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix error in git_patchset_body for deletion in merge commit
Date: Thu, 17 May 2007 22:54:28 +0200
Message-ID: <200705172254.29021.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 00:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hooop-0005PY-Rm
	for gcvg-git@gmane.org; Fri, 18 May 2007 00:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbXEQWv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 18:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756738AbXEQWv1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 18:51:27 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:53390 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807AbXEQWv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 18:51:26 -0400
Received: by ik-out-1112.google.com with SMTP id b35so478997ika
        for <git@vger.kernel.org>; Thu, 17 May 2007 15:51:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YVDUhXQA06DdiAqktaZYirePup4ebvV5gl6Dsjt/OaqeUVRW/MZrEY5iBCbRYdV58HYIuC1r9lJTDRMkyVCg2nPlOPysuT6p7V8ojRKHO5nx+ej55ilhFinW4/w3oIC/sPm7R8XogMuZ+e4jMnHwr9JKfwUaBiawOL5kvPI48H8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Fp+xJgC2L0gYsW7OMqvPZI57yraO+RxGFkrmgnp6lNz6hxsUroARJ6/bLh/b2YZ9idL8jbANGX1ltg7dkcyoaTzldDL3b0IBixQX9NUsFu/oKxn1aTJgjVStDPqbj9AXLFCzxa47nqYpQvIqm+4fHhg/Nv8IMHoIiLhkR7v0pBk=
Received: by 10.82.176.3 with SMTP id y3mr1612562bue.1179442285558;
        Thu, 17 May 2007 15:51:25 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm3102669mue.2007.05.17.15.51.24;
        Thu, 17 May 2007 15:51:24 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47562>

Checking if $diffinfo->{'status'} is equal 'D' is no longer the way to
check if the file was deleted in result.  For merge commits
$diffinfo->{'status'} is reference to array of statuses for each
parent.  Use the fact that $diffinfo->{'to_id'} is all zeros as sign
that file was deleted in result.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8c688be..fa8cc02 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2720,8 +2720,9 @@ sub git_patchset_body {
 					delete $from{'href'};
 				}
 			}
+
 			$to{'file'} = $diffinfo->{'to_file'} || $diffinfo->{'file'};
-			if ($diffinfo->{'status'} ne "D") { # not deleted file
+			if ($diffinfo->{'to_id'} ne ('0' x 40)) { # file exists in result
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
 				                   file_name=>$to{'file'});
-- 
1.5.1.4
