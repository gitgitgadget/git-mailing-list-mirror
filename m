From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Thu, 28 Dec 2006 22:14:12 -0800
Message-ID: <7vmz57p6tn.fsf@assigned-by-dhcp.cox.net>
References: <20061228073441.GB17304@spearce.org>
	<7vmz58whnx.fsf@assigned-by-dhcp.cox.net>
	<20061228084245.GA18150@spearce.org>
	<7vtzzguvrp.fsf@assigned-by-dhcp.cox.net>
	<20061229045327.GD12072@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 07:14:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0B0d-000822-SM
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 07:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbWL2GOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 01:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbWL2GOO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 01:14:14 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56134 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbWL2GOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 01:14:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229061413.HSOT29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Fri, 29 Dec 2006 01:14:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4WES1W00p1kojtg0000000; Fri, 29 Dec 2006 01:14:27 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061229045327.GD12072@spearce.org> (Shawn Pearce's message of
	"Thu, 28 Dec 2006 23:53:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35585>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> While I was looking at the problem, I noticed something a bit
>> easier to reproduce and should be lot easier to diagnose.  At
>> http://userweb.kernel.org/~junio/broken.tar, I have a tarball of
>> git.git repository.
>
> Thanks.  I downloaded that tar but I can't debug it right now.
> I'm feeling under the weather and already had a long day; I'm too
> fried to seriously look at this pack code.  I'll do it tomorrow
> evening.

I think there is a thinko in the OFS_DELTA arm of that switch
statement.  You are resetting buf to (in-pack-offset + used), so
you should fetch the variably encoded length starting from buf[0].

This seems to fix that particular repacking for me.

---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e9a1804..42dd8c8 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1003,6 +1003,7 @@ static void check_object(struct object_entry *entry)
 		if (!no_reuse_delta) {
 			unsigned char c, *base_name;
 			unsigned long ofs;
+			unsigned long used_0;
 			/* there is at least 20 bytes left in the pack */
 			switch (entry->in_pack_type) {
 			case OBJ_REF_DELTA:
@@ -1013,14 +1014,15 @@ static void check_object(struct object_entry *entry)
 			case OBJ_OFS_DELTA:
 				buf = use_pack(p, &w_curs,
 					entry->in_pack_offset + used, NULL);
-				c = buf[used++];
+				used_0 = 0;
+				c = buf[used_0++];
 				ofs = c & 127;
 				while (c & 128) {
 					ofs += 1;
 					if (!ofs || ofs & ~(~0UL >> 7))
 						die("delta base offset overflow in pack for %s",
 						    sha1_to_hex(entry->sha1));
-					c = buf[used++];
+					c = buf[used_0++];
 					ofs = (ofs << 7) + (c & 127);
 				}
 				if (ofs >= entry->in_pack_offset)
@@ -1028,6 +1030,7 @@ static void check_object(struct object_entry *entry)
 					    sha1_to_hex(entry->sha1));
 				ofs = entry->in_pack_offset - ofs;
 				base_name = find_packed_object_name(p, ofs);
+				used += used_0;
 				break;
 			default:
 				base_name = NULL;
