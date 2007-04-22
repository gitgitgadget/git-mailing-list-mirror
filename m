From: Nicolas Pitre <nico@cam.org>
Subject: Re: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 14:34:09 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704221431430.28339@xanadu.home>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
 <7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
 <7vvefonvdz.fsf@assigned-by-dhcp.cox.net>
 <7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221422250.28339@xanadu.home>
 <7vejmcnu28.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:34:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfgt5-0006eo-Kj
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbXDVSeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbXDVSeL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:34:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56582 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbXDVSeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 14:34:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGW00J0XWWXRD10@VL-MO-MR003.ip.videotron.ca>; Sun,
 22 Apr 2007 14:34:09 -0400 (EDT)
In-reply-to: <7vejmcnu28.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45263>

On Sun, 22 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Sun, 22 Apr 2007, Junio C Hamano wrote:
> >
> >> With recent glibc, mkstemp() creates 0400 file.  Updated
> >> pack-objects uses it in pack/idx writing without fixing this,
> >> hence this problem.
> >
> > Oops.  I guess I'm guilty for this.  I didn't bother looking at the 
> > permission on the pack for git-pack-objects since git-repack seemed to 
> > take care of that.  But it only _remove_ write permissions.
> 
> Ok, then probably we can change the 0444 in my "quickfix" patch
> to 0644.  That should also let the 5300 test pass.

Well, actually there is no point making pack files writable.  If they're 
modified, they get corrupted.

Here's the fix I wanted to propose:

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c72e07a..85c6e6e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1786,11 +1786,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		if (rename(pack_tmp_name, tmpname))
 			die("unable to rename temporary pack file: %s",
 			    strerror(errno));
+		chmod(tmpname, 0444);
 		snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
 			 base_name, sha1_to_hex(object_list_sha1));
 		if (rename(idx_tmp_name, tmpname))
 			die("unable to rename temporary index file: %s",
 			    strerror(errno));
+		chmod(tmpname, 0444);
 		puts(sha1_to_hex(object_list_sha1));
 	}
 	if (progress)


Nicolas
