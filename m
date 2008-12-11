From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] autodetect number of CPUs by default when using threads
Date: Thu, 11 Dec 2008 15:36:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:38:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAsIa-0001eV-KE
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbYLKUgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758020AbYLKUgz
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:36:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61139 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757997AbYLKUgx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 15:36:53 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBQ00AZRBW1JJ41@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Dec 2008 15:36:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102822>

... and display the actual number of threads used when locally 
repacking.  A remote server still won't tell you how many threads it 
uses during a fetch though.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

I've spent quite a while wondering why repacking in one repo was faster 
than repacking in a clone of that repo on the same machine.  So let's 
display how many threads are actually used.

We have comprehensive test in Makefile to determine if threads are 
available, just to not use them by default.  I think that code has 
proven itself for long enough now not to let people benefit from it.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index cedef52..619e597 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -78,7 +78,7 @@ static int progress = 1;
 static int window = 10;
 static uint32_t pack_size_limit, pack_size_limit_cfg;
 static int depth = 50;
-static int delta_search_threads = 1;
+static int delta_search_threads;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress *progress_state;
@@ -1612,6 +1612,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		find_deltas(list, &list_size, window, depth, processed);
 		return;
 	}
+	if (progress > pack_to_stdout)
+		fprintf(stderr, "Delta compression using %d threads.\n",
+				delta_search_threads);
 
 	/* Partition the work amongst work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
