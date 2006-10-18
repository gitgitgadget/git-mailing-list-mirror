From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:09:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610181506030.1971@xanadu.home>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
 <200610180057.25411.jnareb@gmail.com>
 <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
 <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 21:09:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaGnS-0004db-Rx
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWJRTJn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbWJRTJn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:09:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52116 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1161088AbWJRTJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:09:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7C00BUNIK50GM2@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 15:09:41 -0400 (EDT)
In-reply-to: <20061018185907.GV20017@pasky.or.cz>
X-X-Sender: nico@xanadu.home
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29254>

On Wed, 18 Oct 2006, Petr Baudis wrote:

> By the way, originally I just wanted to index and save the pack, but
> when trying to feed it to git-index-pack, I kept getting
> 
> 	fatal: packfile '.git/objects/pack/pack-b2ab684daebea5b9c5a6492fa732e0d2e1799c8e.pack' has unresolved deltas
> 
> while feeding it to git-unpack-objects works fine. Any idea what's wrong?

Did you really manage to miss the "heads-up: git-index-pack in "next" is 
broken" thread?

The fix:

diff --git a/index-pack.c b/index-pack.c
index fffddd2..56c590e 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -23,6 +23,12 @@ union delta_base {
 	unsigned long offset;
 };
 
+/*
+ * Even if sizeof(union delta_base) == 24 on 64-bit archs, we really want
+ * to memcmp() only the first 20 bytes.
+ */
+#define UNION_BASE_SZ	20
+
 struct delta_entry
 {
 	struct object_entry *obj;
@@ -211,7 +217,7 @@ static int find_delta(const union delta_
                 struct delta_entry *delta = &deltas[next];
                 int cmp;
 
-                cmp = memcmp(base, &delta->base, sizeof(*base));
+                cmp = memcmp(base, &delta->base, UNION_BASE_SZ);
                 if (!cmp)
                         return next;
                 if (cmp < 0) {
@@ -232,9 +238,9 @@ static int find_delta_childs(const union
 
 	if (first < 0)
 		return -1;
-	while (first > 0 && !memcmp(&deltas[first - 1].base, base, sizeof(*base)))
+	while (first > 0 && !memcmp(&deltas[first - 1].base, base, UNION_BASE_SZ))
 		--first;
-	while (last < end && !memcmp(&deltas[last + 1].base, base, sizeof(*base)))
+	while (last < end && !memcmp(&deltas[last + 1].base, base, UNION_BASE_SZ))
 		++last;
 	*first_index = first;
 	*last_index = last;
@@ -312,7 +318,7 @@ static int compare_delta_entry(const voi
 {
 	const struct delta_entry *delta_a = a;
 	const struct delta_entry *delta_b = b;
-	return memcmp(&delta_a->base, &delta_b->base, sizeof(union delta_base));
+	return memcmp(&delta_a->base, &delta_b->base, UNION_BASE_SZ);
 }
 
 static void parse_pack_objects(void)


Nicolas
