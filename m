From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git add: respect core.filemode even with unmerged entries
 in the index
Date: Thu, 28 Jun 2007 18:02:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706281653260.4438@racer.site>
References: <20070625064017.GA2839@mellanox.co.il>  <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
     <20070625071752.GB15343@mellanox.co.il>  <Pine.LNX.4.64.0706250846200.4059@racer.site>
    <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>  
 <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com>
 <Pine.LNX.4.64.0706281506390.4438@racer.site> <4683C5D2.FDF4ED02@eudaptics.com>
 <4683CA7A.7F8070D7@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 19:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3xTe-0000gJ-8S
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 19:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759724AbXF1RIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 13:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758581AbXF1RIO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 13:08:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753786AbXF1RIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 13:08:13 -0400
Received: (qmail invoked by alias); 28 Jun 2007 17:08:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 28 Jun 2007 19:08:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mL8sqC1zmH7C39eMuTTRKcy5LZWeM3Rdxz67FDa
	6TAFU37FXK9CAj
X-X-Sender: gene099@racer.site
In-Reply-To: <4683CA7A.7F8070D7@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51120>


When a merge left unmerged entries, git add failed to pick up the
file mode from the index, when core.filemode == 0.

Noticed by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 28 Jun 2007, Johannes Sixt wrote:

	> Johannes Sixt wrote:
	> 
	> The deficiency is not in merge-recursive, but in 'git add'. The 
	> problem is that after a conflicted merge of an executable file 
	> 'git add' loses the +x bit even if core.filemode=false.

	How's that?

 read-cache.c   |    6 ++++++
 t/t3700-add.sh |   14 ++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4362b11..a74e4a7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -382,6 +382,12 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		struct cache_entry *ent;
 		int pos = index_name_pos(istate, path, namelen);
 
+		/* might be unmerged */
+		if (pos < 0 && 1-pos < istate->cache_nr &&
+				namelen == ce_namelen(istate->cache[1-pos]) &&
+				!memcmp(path, istate->cache[1-pos]->name,
+					namelen))
+			pos = 1-pos;
 		ent = (0 <= pos) ? istate->cache[pos] : NULL;
 		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
 	}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ad8cc7d..d75970b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -110,4 +110,18 @@ test_expect_success 'check correct prefix detection' '
 	git add 1/2/a 1/3/b 1/2/c
 '
 
+test_expect_success 'git add and filemode=0 with unmerged entries' '
+	echo 1 > stage1 &&
+	echo 2 > stage2 &&
+	echo 3 > stage3 &&
+	for s in 1 2 3
+	do
+		echo "100755 $(git hash-object -w stage$s) $s	file"
+	done | git update-index --index-info &&
+	git config core.filemode 0 &&
+	echo new > file &&
+	git add file &&
+	git ls-files --stage | grep "^100755 .* 0	file$"
+'
+
 test_done
-- 
1.5.2.2.3228.g16a27
