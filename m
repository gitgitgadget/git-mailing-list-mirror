From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 16:23:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 22:23:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZvTL-0003e1-86
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 22:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWJQUX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 16:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWJQUX2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 16:23:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30058 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751266AbWJQUX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 16:23:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7A001RNRB2WQA0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 16:23:27 -0400 (EDT)
In-reply-to: <20061017233630.72a0aae5.vsu@altlinux.ru>
X-X-Sender: nico@xanadu.home
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29112>

On Tue, 17 Oct 2006, Sergey Vlasov wrote:

> On Tue, 17 Oct 2006 14:47:16 -0400 (EDT) Nicolas Pitre wrote:
> 
> > Is it possible that sizeof(union delta_base) might not be equal to 20 
> > for you?
> 
> Yes, on x86_64 this is 24 because of 8-byte alignment for longs:

Ah bummer.  Then this is most likely the cause.  And here's a simple 
fix (Junio please confirm):

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
