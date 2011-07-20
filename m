From: Dave Zarzycki <zarzycki@apple.com>
Subject: [PATCHv2] Make filter-branch work with many branches
Date: Wed, 20 Jul 2011 06:42:37 -0700
Message-ID: <CA809344-F7C2-4A41-B4F7-15B5EEB9B7E2@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 15:42:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjX36-0003bs-Ca
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 15:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab1GTNml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 09:42:41 -0400
Received: from mail-out.apple.com ([17.151.62.49]:41391 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab1GTNmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 09:42:40 -0400
Received: from relay12.apple.com ([17.128.113.53])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LOM009WPWQFAVS1@mail-out.apple.com> for git@vger.kernel.org;
 Wed, 20 Jul 2011 06:42:40 -0700 (PDT)
X-AuditID: 11807135-b7b76ae000001169-d9-4e26dbe9a913
Received: from kencur (kencur.apple.com [17.151.62.38])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay12.apple.com (Apple SCV relay)
 with SMTP id 1F.91.04457.9EBD62E4; Wed, 20 Jul 2011 06:45:13 -0700 (PDT)
Received: from 67-218-102-134.cust.layer42.net
 (67-218-102-134.cust.layer42.net [67.218.102.134])
 by kencur.apple.com (Oracle Communications Messaging Exchange Server 7u4-20.01
 64bit (built Nov 21 2010)) with ESMTPSA id <0LOM009I6WR0C290@kencur.apple.com>
 for git@vger.kernel.org; Wed, 20 Jul 2011 06:42:39 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJMWRmVeSWpSXmKPExsUiON1OTfflbTU/g1/NQhZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mp4uHIDa8Ed9oqtjXYNjEvYuhg5OSQETCTenLjJCGGLSVy4tx4o
	zsUhJNDOJNH8ZiU7SIJXQFDix+R7LF2MHBzMAvISB8/LgoSZBbQkvj9qZYGoP8Yk8eLTNCaQ
	BJuAhsSnU3eZQeqFBWwl/j4LAgmzCKhKzG79wggx0kai/fF/sHIRAXGJt8dnskPcIC+xuOUz
	4wRG3llINs9C2DwLyeYFjMyrGAWLUnMSKw2N9BILCnJS9ZLzczcxgkKlodB0B+OjheqHGAU4
	GJV4eHduVfUTYk0sK67MPcQowcGsJMLbckjNT4g3JbGyKrUoP76oNCe1+BCjNAeLkjhvyT1x
	PyGB9MSS1OzU1ILUIpgsEwenVAPjLGdp3okcFmVXL7s8/2OfwnimJecI733VyXZeyisSi5Zv
	Cunwnj2hK6W85KrZ03dVc7Y0yWz8vnpbTumq+8pB87b4dsyvSnf58vCkgfI/xrtrl7CsWjLN
	7dlH21OylepNv7Y9arCaOKdswTmfjXYReuaWzyKnGN/xvBX6ctv8d990V92UWpzZqMRSnJFo
	qMVcVJwIAMa3qJwRAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177539>

When there are many branches, we can overflow the maximum number of
arguments to exec*().

Signed-off-by: Dave Zarzycki <zarzycki@apple.com>
---
 git-filter-branch.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..a93e582 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -274,7 +274,7 @@ else
 	remap_to_ancestor=t
 fi
 
-rev_args=$(git rev-parse --revs-only "$@")
+rev_parse_args="$@"
 
 case "$filter_subdir" in
 "")
@@ -286,8 +286,9 @@ case "$filter_subdir" in
 	;;
 esac
 
-git rev-list --reverse --topo-order --default HEAD \
-	--parents --simplify-merges $rev_args "$@" > ../revs ||
+git rev-parse --revs-only "$rev_parse_args" | git rev-list --stdin \
+	--reverse --topo-order --default HEAD	\
+	--parents --simplify-merges "$@" > ../revs ||
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
-- 
1.7.6.235.gfdb98
