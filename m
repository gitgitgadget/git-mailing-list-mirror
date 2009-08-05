From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] don't let the delta cache grow unbounded in 'git repack'
Date: Wed, 05 Aug 2009 16:55:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908051639360.16073@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:55:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnW7-0007UQ-GW
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbZHEUzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbZHEUzO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:55:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53916 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZHEUzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:55:13 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KNX000OF8RWWA10@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Aug 2009 16:55:08 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124978>

I have 4GB of RAM on my system which should, in theory, be quite enough 
to repack a 600 MB repository.  However the unbounded delta cache size 
always pushes it into swap, at which point everything virtually comes to 
a halt.  So unbounded caches are never a good idea.

A default of 256MB should be a good compromize between memory usage and 
speed where medium sized repositories are still likely to fit in the 
cache with a reasonable memory usage, and larger repositories are going 
to take quite some time to repack already anyway.

While at it, clarify the associated config variable documentation 
entries a bit.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c6f09f8..7791c32 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1218,12 +1218,20 @@ pack.compression::
 
 pack.deltaCacheSize::
 	The maximum memory in bytes used for caching deltas in
-	linkgit:git-pack-objects[1].
-	A value of 0 means no limit. Defaults to 0.
+	linkgit:git-pack-objects[1] before writing them out to a pack.
+	This cache is used to speed up the writing object phase by not
+	having to recompute the final delta result once the best match
+	for all objects is found.  Repacking large repositories on machines
+	which are tight with memory might be badly impacted by this though,
+	especially if this cache pushes the system into swapping.
+	A value of 0 means no limit. The smallest size of 1 byte may be
+	used to virtually disable this cache. Defaults to 256 MiB.
 
 pack.deltaCacheLimit::
 	The maximum size of a delta, that is cached in
-	linkgit:git-pack-objects[1]. Defaults to 1000.
+	linkgit:git-pack-objects[1]. This cache is used to speed up the
+	writing object phase by not having to recompute the final delta
+	result once the best match for all objects is found. Defaults to 1000.
 
 pack.threads::
 	Specifies the number of threads to spawn when searching for best
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 961b639..c433748 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -86,7 +86,7 @@ static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
 
 static unsigned long delta_cache_size = 0;
-static unsigned long max_delta_cache_size = 0;
+static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
 static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
