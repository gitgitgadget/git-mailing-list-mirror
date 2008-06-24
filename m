From: Nicolas Pitre <nico@cam.org>
Subject: Re: Segmentation fault on http clone, post-1.5.6
Date: Tue, 24 Jun 2008 17:24:49 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806241720440.2979@xanadu.home>
References: <20080624130457.GB13696@mithlond.arda.local>
 <20080624164034.GB4654@sigill.intra.peff.net>
 <20080624185723.GA3368@mithlond.arda.local>
 <alpine.LFD.1.10.0806241524480.2979@xanadu.home>
 <20080624205556.GA3565@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jun 24 23:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBG1N-0000WP-Ki
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 23:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbYFXVYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 17:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbYFXVYv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 17:24:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51269 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbYFXVYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 17:24:50 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Z00MV1KTD7JN0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 17:24:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080624205556.GA3565@mithlond.arda.local>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86151>

On Tue, 24 Jun 2008, Teemu Likonen wrote:

> Nicolas Pitre wrote (2008-06-24 15:34 -0400):
> 
> > I'm trying to reproduce your segfault with current master
> > (v1.5.6-56-g29b0d01) but I just can't.
> > 
> > Can you provide a gdb backtrace of the segfault?
> 
> Let's hope I'm doing this right. Just installed gdb for the first time.
> I started with "gdb git" and then typed "run clone http://...".
> Eventually it gave this:

Excellent!

The problem is probably fixed with this:

diff --git a/sha1_file.c b/sha1_file.c
index a92f023..b7d1a82 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -844,6 +844,8 @@ struct packed_git *parse_pack_index(unsigned char *sha1)
 
 	strcpy(p->pack_name, path);
 	p->pack_size = 0;
+	p->num_bad_objects = 0;
+	p->bad_object_sha1 = NULL;
 	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;

Could you confirm it?

However I just don't like the fact that pack structures are allocated 
and initialized in two places, which makes it error prone as 
demonstrated here.  So I'll cook up a better patch that fixes the 
duplication issue.


Nicolas
