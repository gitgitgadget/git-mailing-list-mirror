From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Fri, 24 Apr 2009 17:46:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904241722220.6741@xanadu.home>
References: <cover.1240115957.git.cloos@jhcloos.com>
 <d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
 <alpine.LFD.2.00.0904210054190.6741@xanadu.home>
 <m3skk2szgv.fsf@lugabout.jhcloos.org>
 <alpine.LFD.2.00.0904211319570.6741@xanadu.home>
 <m3d4b5oj76.fsf@lugabout.jhcloos.org> <m34owgoj08.fsf@lugabout.jhcloos.org>
 <7vljps324a.fsf@gitster.siamese.dyndns.org>
 <m3ab68mi3q.fsf@lugabout.jhcloos.org> <m3zle5hkpa.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:49:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxTH5-0001xZ-55
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbZDXVqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbZDXVqW
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:46:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16677 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbZDXVqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:46:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIM0016DKH3QX20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Apr 2009 17:46:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3zle5hkpa.fsf@lugabout.jhcloos.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117495>

On Fri, 24 Apr 2009, James Cloos wrote:

> It turns out that the off by one is intentional.
> 
> >From upload-pack.c:
> 
> /* Data ready; we keep the last byte to ourselves
>  * in case we detect broken rev-list, so that we
>  * can leave the stream corrupted.  This is
>  * unfortunate -- unpack-objects would happily
>  * accept a valid packdata with trailing garbage,
>  * so appending garbage after we pass all the
>  * pack data is not good enough to signal
>  * breakage to downstream.
>  */
> 
> Upload-pack uses a buffer of 8193 octets, which is why it is always
> the second xread() that returns 0xFFF.  It first sends 8191 octets,
> then n chunks of 8192 and then the final chunk.
> 
> It seems to only way to fix the progress annoyance -- and it is most
> annoying -- would be to round correctly in progress.c.
> 
> (The .99 comes from 1023/1024, which is .999 and therefor ought to
> round up to 1.00, not down to 0.99.)
> 
> Will a patch which does round-to-nearest (instead of the current
> round-to-zero) be accepted?

Sure.  What about this (untested):

diff --git a/progress.c b/progress.c
index 55a8687..621c34e 100644
--- a/progress.c
+++ b/progress.c
@@ -121,13 +121,13 @@ static void throughput_string(struct throughput *tp, off_t total,
 			      (int)(total >> 30),
 			      (int)(total & ((1 << 30) - 1)) / 10737419);
 	} else if (total > 1 << 20) {
+		int x = total + 5243;  /* for rounding */
 		l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
-			      (int)(total >> 20),
-			      ((int)(total & ((1 << 20) - 1)) * 100) >> 20);
+			      x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
 	} else if (total > 1 << 10) {
+		int x = total + 5;  /* for rounding */
 		l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
-			      (int)(total >> 10),
-			      ((int)(total & ((1 << 10) - 1)) * 100) >> 10);
+			      x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
 	} else {
 		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
 	}

Nicolas
