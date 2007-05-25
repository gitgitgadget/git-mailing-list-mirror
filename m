From: Dana How <danahow@gmail.com>
Subject: [PATCH] Ensure git-repack -a -d --max-pack-size=N deletes correct
 packs
Date: Thu, 24 May 2007 19:06:42 -0700
Message-ID: <465644B2.5040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 04:06:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPCa-0001DX-Bl
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbXEYCGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbXEYCGr
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:06:47 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:51954 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbXEYCGq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:06:46 -0400
Received: by nz-out-0506.google.com with SMTP id f1so713078nzc
        for <git@vger.kernel.org>; Thu, 24 May 2007 19:06:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ZK3EtjY7iTdk+OwahzzB4YBsXYI3BqKxix9yA8E4hAM96npVqp11k/zCJvveokeHtyLcnGWh3dNTjtnHCWVxQZ/JCBkIrWDNIlmE+lVuWhbERFvJYPqO0CO7iEJa0sjicmPSvNiovUplNgirv+6JPg4MONsxgRPeS19zc9wROoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=rc9i8/Iw8wvg3Okwb5H/yuny1qX/1Lwnm4MpnYc1eq5fyj3BV3pzn59k0x/jyjJNuHql49WvZIqCIjBuCLVCPtkSVlAQ1aN/R3pb6WIBzxeUA5HAnN6o33hpBPpnCsoPVsG8XLCZDvjfn09EClCaFGahLcbNdYf2nt72sRJj9Wk=
Received: by 10.114.160.1 with SMTP id i1mr1263784wae.1180058805616;
        Thu, 24 May 2007 19:06:45 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id q20sm1854465pog.2007.05.24.19.06.43;
        Thu, 24 May 2007 19:06:44 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48330>


The packfile portion of the "remove redundant" code
near the bottom of git-repack.sh is broken when
pack splitting occurs.  Particularly since this is
the only place where we automatically delete packfiles,
make sure it works properly for all cases,  old or new.

This is based on "next".

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 git-repack.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 4ea6e5b..0591bd7 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -69,6 +69,7 @@ if [ -z "$names" ]; then
 	echo Nothing new to pack.
 fi
 for name in $names ; do
+	fullbases="$fullbases pack-$name"
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
 	if test "$quiet" != '-q'; then
@@ -105,8 +106,8 @@ then
 		( cd "$PACKDIR" &&
 		  for e in $existing
 		  do
-			case "$e" in
-			pack-$name) ;;
+			case " $fullbases " in
+			*\ $e\ *) ;;
 			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
 			esac
 		  done
-- 
1.5.2.762.gd8c6-dirty
