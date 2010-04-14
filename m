From: Ed Santiago <santiago@redhat.com>
Subject: [PATCH] git-cvsimport: strip question-mark characters in tags
Date: Wed, 14 Apr 2010 07:38:31 -0600
Message-ID: <20100414133831.GA12135@f.santiago.vpn.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 15:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O22nh-0003JP-1W
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 15:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab0DNNie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 09:38:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755585Ab0DNNid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 09:38:33 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3EDcW5l006391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 14 Apr 2010 09:38:33 -0400
Received: from f.santiago.vpn.redhat.com (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o3EDcWuJ015976
	for <git@vger.kernel.org>; Wed, 14 Apr 2010 09:38:32 -0400
Received: by f.santiago.vpn.redhat.com (Postfix, from userid 14904)
	id 5BAEB280535; Wed, 14 Apr 2010 07:38:31 -0600 (MDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144872>

Question mark character appears to be valid in a CVS tag,
but not a git one.  Remove it.  Leave open the possibility that there may
be more such characters; and comment (FIXME) that we may want to replace
those instead of removing them.

Also: if git tag command fails, do not include $! in our
error message: it is not useful after system(), and will
only serve as a red herring.
---
 git-cvsimport.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 9e03eee..48de2b4 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -840,10 +840,12 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
-		$xtag =~ s/\[//g;
+		# The following characters are valid in CVS tags but not git.
+		# Remove them. (FIXME: optionally replace?)
+		$xtag =~ tr/\[\?//d;
 
 		system('git' , 'tag', '-f', $xtag, $cid) == 0
-			or die "Cannot create tag $xtag: $!\n";
+			or die "Cannot create tag $xtag\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
 	}
-- 
1.6.6.1


-- 
Ed Santiago             Software Engineer             santiago@redhat.com
