From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 7/3] Make index preloading check the whole path to the file
Date: Thu, 9 Jul 2009 13:50:26 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907091348490.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain> <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 22:51:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP0aj-0000K8-Qh
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227AbZGIUvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 16:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755914AbZGIUvf
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 16:51:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55527 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753653AbZGIUve (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 16:51:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69KowAx018313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 13:50:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69KoQOc013954;
	Thu, 9 Jul 2009 13:50:27 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123008>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jul 2009 13:37:02 -0700
Subject: [PATCH 7/3] Make index preloading check the whole path to the file

This uses the new thread-safe 'threaded_has_symlink_leading_path()'
function to efficiently verify that the whole path leading up to the
filename is a proper path, and does not contain symlinks.

This makes 'ce_uptodate()' a much stronger guarantee: it no longer just
guarantees that the 'lstat()' of the path would match, it also means
that we know that people haven't played games with moving directories
around and covered it up with symlinks.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Totally trivial, now that we have a thread-safe symlink checker.

If we have leading symlinks in the cache-entry path, we will refuse to 
mark it up-to-date. There's no need to even try to stat anything under 
that directory.

 preload-index.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 88edc5f..c3462dc 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -34,6 +34,7 @@ static void *preload_thread(void *_data)
 	struct thread_data *p = _data;
 	struct index_state *index = p->index;
 	struct cache_entry **cep = index->cache + p->offset;
+	struct cache_def cache;
 
 	nr = p->nr;
 	if (nr + p->offset > index->cache_nr)
@@ -49,6 +50,8 @@ static void *preload_thread(void *_data)
 			continue;
 		if (!ce_path_match(ce, p->pathspec))
 			continue;
+		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
+			continue;
 		if (lstat(ce->name, &st))
 			continue;
 		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
-- 
1.6.3.3.415.ga8877
