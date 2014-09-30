From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] t0090: avoid passing empty string to printf %d
Date: Tue, 30 Sep 2014 19:42:03 +0200
Message-ID: <542AEB6B.1020509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 19:43:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ1SF-00088h-9I
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbaI3RnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 13:43:09 -0400
Received: from mout.web.de ([212.227.15.3]:53922 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbaI3RnH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 13:43:07 -0400
Received: from [192.168.178.27] ([79.250.171.120]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LePBV-1Y2pp60JUj-00qC0z; Tue, 30 Sep 2014 19:42:57
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Provags-ID: V03:K0:qyENiUsH0Y8+FabLErxoiU5Ix2ttiCAtafOt6PAlP74V56i9fdP
 C6Sfwn+6oT9DnBcPvseVl04o5OafWPYMwzBy4agoOjYv6pjEcT6zqwHxmSrjOzk3YUmyHpz
 HET1FetbHUO5jNnCeZSQ2JpTPGXTpZOT1g44I7KPZdDMkFnpHKdq9LuWO3wBzkE0hi49paw
 U8gmbtlmzLVpnKbE95grg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257675>

FreeBSD's printf(1) doesn't accept empty strings for numerical format
specifiers:

	$ printf "%d\n" "" >/dev/null; echo $?
	printf: : expected numeric value
	1

Initialize the AWK variable c to make sure the shell variable
subtree_count always contains a numerical value, in order to keep the
subsequently called printf happy.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t0090-cache-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index f9648a8..158cf4f 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -22,7 +22,7 @@ generate_expected_cache_tree_rec () {
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
 	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
-	subtree_count=$(echo "$subtrees"|awk '$1 {++c} END {print c}') &&
+	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 {++c} END {print c}') &&
 	entries=$(git ls-files|wc -l) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
-- 
2.1.1
