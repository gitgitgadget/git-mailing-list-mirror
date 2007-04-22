From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetch failure from git2.kernel.org?
Date: Sun, 22 Apr 2007 11:26:01 -0700
Message-ID: <7virbonu4m.fsf@assigned-by-dhcp.cox.net>
References: <86fy6ssp32.fsf@blue.stonehenge.com>
	<alpine.LFD.0.98.0704221050350.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfglM-0002uM-2X
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbXDVS0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754351AbXDVS0F
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:26:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42095 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbXDVS0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 14:26:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422182602.MDSC1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 14:26:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qJS11W00F1kojtg0000000; Sun, 22 Apr 2007 14:26:01 -0400
In-Reply-To: <alpine.LFD.0.98.0704221050350.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 22 Apr 2007 10:53:13 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45261>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Apr 2007, Randal L. Schwartz wrote:
>> 
>> is this known?  transient?
>
> Junio seems to have tightened his permissions on kernel.org, and as a 
> result the most recent pack is unreadable by anybody but him (I'm not sure 
> if such private files even get mirrored out - but even if they do, they 
> will get mirrored out with the same tight permissions and won't be 
> readable).

That's not *me* per-se, it's Nico ;-). 

Anybody who runs the new pack-objects that has been cooking in
'next' would get this.

I think this patch minimally fixes it, but some existing tests
(e.g. t5300) assume that pack/idx are writable which makes them
break.


diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c72e07a..4eb88e8 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1783,11 +1783,17 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		write_index_file(last_obj_offset, object_list_sha1);
 		snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
 			 base_name, sha1_to_hex(object_list_sha1));
+		if (chmod(pack_tmp_name, 0444))
+			die("unable to make temporary pack file readable: %s",
+			    strerror(errno));
 		if (rename(pack_tmp_name, tmpname))
 			die("unable to rename temporary pack file: %s",
 			    strerror(errno));
 		snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
 			 base_name, sha1_to_hex(object_list_sha1));
+		if (chmod(idx_tmp_name, 0444))
+			die("unable to make temporary index file readable: %s",
+			    strerror(errno));
 		if (rename(idx_tmp_name, tmpname))
 			die("unable to rename temporary index file: %s",
 			    strerror(errno));
