From: Dave Zarzycki <zarzycki@apple.com>
Subject: [PATCH] Make filter-branch work with many branches
Date: Tue, 19 Jul 2011 09:29:44 -0700
Message-ID: <E186982C-71AE-4C08-B857-A67BDCD21E3D@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 18:29:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDBE-00050k-5i
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 18:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab1GSQ3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 12:29:51 -0400
Received: from mail-out.apple.com ([17.151.62.51]:35312 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab1GSQ3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 12:29:50 -0400
Received: from relay13.apple.com ([17.128.113.29])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LOL00E5Z9TDEUT0@mail-out.apple.com> for git@vger.kernel.org;
 Tue, 19 Jul 2011 09:29:44 -0700 (PDT)
X-AuditID: 1180711d-b7c5fae000001427-40-4e25b0bcebeb
Received: from jimbu (jimbu.apple.com [17.151.62.37])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay13.apple.com (Apple SCV relay)
 with SMTP id CA.0C.05159.CB0B52E4; Tue, 19 Jul 2011 09:28:44 -0700 (PDT)
Received: from davez.apple.com (davez.apple.com [17.226.34.35])
 by cardamom.apple.com
 (Oracle Communications Messaging Exchange Server 7u4-20.01 64bit (built Nov 21
 2010)) with ESMTPSA id <0LOL00AJO9TJ8480@cardamom.apple.com> for
 git@vger.kernel.org; Tue, 19 Jul 2011 09:29:43 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42IRnG6nqrtng6qfweV7BhZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4MrYcPA3W8FL9optH9axNTCuYeti5OSQEDCRWLz2AZQtJnHh3nog
	m4tDSKCVSWJB73WwBK+AoMSPyfdYuhg5OJgF5CUOnpcFCTMLaEl8f9TKAlG/gkmie+92dpAE
	m4CGxKdTd5lBbGEBa4muzR9ZQWwWAVWJS/snsELMtJFo72kHmy8iIC7x9vhMdogj5CUWt3xm
	nMDIOwvJ6lkIq2chWb2AkXkVo2BRak5ipaGxXmJBQU6qXnJ+7iZGULg0FMruYNz/k/8QowAH
	oxIPr+V6FT8h1sSy4srcQ4wSHMxKIrzbmlT9hHhTEiurUovy44tKc1KLDzFKc7AoifM2nwaq
	FkhPLEnNTk0tSC2CyTJxcEo1MGpvfu/T/2yhDrNbxPzDuXEvF/3XunzJ/3SxZdDh2v0JvaIF
	ie2uLbZ/6/Y+rmFuWPrmsoO0l4dMRoVWh8edeYt5HR8uOaSj3Bui0G0ncOyWvEuVod0yB1Ge
	M7wbdpucsYyUCWScyxE09/CFlb/+pV7e3fToo9dSxm93ns+XTlhhvt5NkTdtgRJLcUaioRZz
	UXEiAGXDLCcTAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177459>

When there are many branches, we can overflow the maximum number of
arguments to exec*().

Signed-off-by: Dave Zarzycki <zarzycki@apple.com>
---
 git-filter-branch.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..0c03db0 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -274,8 +274,6 @@ else
 	remap_to_ancestor=t
 fi
 
-rev_args=$(git rev-parse --revs-only "$@")
-
 case "$filter_subdir" in
 "")
 	eval set -- "$(git rev-parse --sq --no-revs "$@")"
@@ -286,8 +284,8 @@ case "$filter_subdir" in
 	;;
 esac
 
-git rev-list --reverse --topo-order --default HEAD \
-	--parents --simplify-merges $rev_args "$@" > ../revs ||
+git rev-parse --revs-only "$@" | git rev-list --stdin --reverse --topo-order \
+	--default HEAD --parents --simplify-merges "$@" > ../revs ||
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
-- 
1.7.6.135.g8cdba
