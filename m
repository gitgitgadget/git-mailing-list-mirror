From: Junio C Hamano <junkio@cox.net>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 13:10:21 -0700
Message-ID: <7vy7reitzm.fsf@assigned-by-dhcp.cox.net>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171134130.1971@xanadu.home>
	<7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171251210.1971@xanadu.home>
	<7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171437250.1971@xanadu.home>
	<20061017233630.72a0aae5.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Tue Oct 17 22:10:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZvGc-0000lW-IO
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 22:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWJQUKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 16:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWJQUKX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 16:10:23 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36048 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751130AbWJQUKW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 16:10:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017201022.SALT6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 16:10:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bYA81V00P1kojtg0000000
	Tue, 17 Oct 2006 16:10:09 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <20061017233630.72a0aae5.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Tue, 17 Oct 2006 23:36:30 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29111>

Sergey Vlasov <vsu@altlinux.ru> writes:

> On Tue, 17 Oct 2006 14:47:16 -0400 (EDT) Nicolas Pitre wrote:
>
>> Is it possible that sizeof(union delta_base) might not be equal to 20 
>> for you?
>
> Yes, on x86_64 this is 24 because of 8-byte alignment for longs:

Enough eyeballs made this bug shallow ;-)  Thanks.

diff --git a/index-pack.c b/index-pack.c
index fffddd2..49b6efe 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -166,6 +166,7 @@ static void *unpack_raw_entry(unsigned l
 	case OBJ_REF_DELTA:
 		if (pos + 20 >= pack_limit)
 			bad_object(offset, "object extends past end of pack");
+		memset(delta_base, 0, sizeof(*delta_base));
 		hashcpy(delta_base->sha1, pack_base + pos);
 		pos += 20;
 		break;
@@ -290,6 +291,7 @@ static void resolve_delta(struct delta_e
 		bad_object(obj->offset, "failed to apply delta");
 	sha1_object(result, result_size, type, obj->sha1);
 
+	memset(&delta_base, 0, sizeof(delta_base));
 	hashcpy(delta_base.sha1, obj->sha1);
 	if (!find_delta_childs(&delta_base, &first, &last)) {
 		for (j = first; j <= last; j++)
@@ -365,6 +367,7 @@ static void parse_pack_objects(void)
 
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA)
 			continue;
+		memset(&base, 0, sizeof(base));
 		hashcpy(base.sha1, obj->sha1);
 		ref = !find_delta_childs(&base, &ref_first, &ref_last);
 		memset(&base, 0, sizeof(base));
