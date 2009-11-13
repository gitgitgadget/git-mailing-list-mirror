From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] remote: Fix glibc error in ref_remove_duplicates
Date: Fri, 13 Nov 2009 21:25:56 +0000
Message-ID: <20091113212557.40912.20173.julian@quantumfyre.co.uk>
References: <alpine.LFD.2.00.0911121513470.16711@xanadu.home>
	<4AFC8960.9090808@lsrfire.ath.cx>
	<alpine.LNX.2.00.0911122239150.6967@reaper.quantumfyre.co.uk>
	<alpine.LFD.2.00.0911122345450.16711@xanadu.home>
	<alpine.LNX.2.00.0911130910150.17726@reaper.quantumfyre.co.uk>
	<alpine.LFD.2.00.0911131152120.16711@xanadu.home>
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 22:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N93o1-0002jH-KI
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 22:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbZKMVfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbZKMVfb
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 16:35:31 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52937 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754289AbZKMVfb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2009 16:35:31 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id DEBE5E121B
	for <git@vger.kernel.org>; Fri, 13 Nov 2009 21:35:35 +0000 (GMT)
Received: (qmail 10545 invoked by uid 103); 13 Nov 2009 21:31:19 +0000
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/10020. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025755 secs); 13 Nov 2009 21:31:19 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 13 Nov 2009 21:31:19 +0000
X-git-sha1: 111f1508f2e8daa9b236f5bf526e8b93c13d49ab 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <alpine.LFD.2.00.0911131152120.16711@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132845>

In ref_remove_duplicates, when we encounter a duplicate and remove it
from the list we need to make sure that the prev pointer stays
pointing at the last entry and also skip over adding the just freed
entry to the string_list.

Previously fetch could crash with:
*** glibc detected *** git: corrupted double-linked list: ...

Also add a test to try and catch problems with duplicate removal in
the future.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

Thanks to Rene for pointing me at the problem before I even looked at
it.  Made it much easier to figure out what was going wrong. :)

 remote.c         |    2 ++
 t/t5510-fetch.sh |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 4f9f0cc..002f790 100644
--- a/remote.c
+++ b/remote.c
@@ -754,6 +754,8 @@ void ref_remove_duplicates(struct ref *ref_map)
 			prev->next = ref_map->next;
 			free(ref_map->peer_ref);
 			free(ref_map);
+			ref_map = prev; // don't change the prev pointer.
+			continue;
 		}
 
 		item = string_list_insert(ref_map->peer_ref->name, &refs);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d13c806..169af1e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -341,4 +341,15 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
 
 '
 
+test_expect_success "should be able to fetch with duplicate refspecs" '
+        mkdir dups &&
+        cd dups &&
+        git init &&
+        git config branch.master.remote three &&
+        git config remote.three.url ../three/.git &&
+        git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
+        git config --add remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
+        git fetch three
+'
+
 test_done
-- 
1.6.5.rc2
