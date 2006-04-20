From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 14:40:10 -0700
Message-ID: <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net>
References: <20060420133640.GA31198@spearce.org>
	<Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
	<20060420150315.GB31198@spearce.org>
	<Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
	<20060420164351.GB31738@spearce.org>
	<Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
	<20060420175554.GH31738@spearce.org>
	<Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
	<7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604201630320.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 23:40:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWgss-0007BM-EP
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 23:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWDTVkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 17:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWDTVkO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 17:40:14 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:59862 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751342AbWDTVkM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 17:40:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420214011.OZQH18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 17:40:11 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain> (Nicolas
	Pitre's message of "Thu, 20 Apr 2006 17:02:25 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19001>

Nicolas Pitre <nico@cam.org> writes:

>> But I suspect we have a built-in "we sort bigger to smaller, and
>> we cut off when we switch bins" somewhere in find_delta() loop,
>> which I do not recall touching when I did that change, so that
>> may be interfering and preventing 0-11-AdjLite.deg from all over
>> the place to delta against each other.
>
> I just cannot find something that would do that in the code.  When 
> --no-reuse-delta is specified, the only things that will break the loop
> in find_delta() is when try_delta() returns -1, and that happens only 
> when changing object type or when the size difference is too big, but 
> nothing looks at the name hash.

The list is sorted by type then hash then size (type_size_sort),
so if you have t/Makefile that are big medium small too-small
and then doc/Makefile that are big medium, once you see the
too-small t/Makefile it would not consider the big doc/Makefile
as a candidate X-<.

This _might_ improve things:

diff --git a/pack-objects.c b/pack-objects.c
index 09f4f2c..0c6abe9 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1037,7 +1039,7 @@ static int try_delta(struct unpacked *cu
 	sizediff = oldsize > size ? oldsize - size : size - oldsize;
 
 	if (size < 50)
-		return -1;
+		return 0;
 	if (old_entry->depth >= max_depth)
 		return 0;
 
@@ -1052,7 +1054,7 @@ static int try_delta(struct unpacked *cu
 	if (cur_entry->delta)
 		max_size = cur_entry->delta_size-1;
 	if (sizediff >= max_size)
-		return -1;
+		return 0;
 	delta_buf = diff_delta(old->data, oldsize,
 			       cur->data, size, &delta_size, max_size);
 	if (!delta_buf)
