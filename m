X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] mimic unpack-objects when --stdin is used with
 index-pack
Date: Thu, 26 Oct 2006 09:46:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610260940020.12418@xanadu.home>
References: <Pine.LNX.4.64.0610252330320.12418@xanadu.home>
 <7vmz7jqzoo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 13:46:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vmz7jqzoo.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30218>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5Yt-0003G7-EY for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161369AbWJZNqU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161370AbWJZNqU
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:46:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12257 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1161369AbWJZNqT
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 09:46:19 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Q00L4PWX6ER90@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 26 Oct 2006 09:46:18 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > It appears that git-unpack-objects writes the last part of the input
> > buffer to stdout after the pack has been parsed.  This looks a bit
> > suspicious since the last fill() might have filled the buffer up to
> > the 4096 byte limit and more data might still be pending on stdin,
> > but since this is about being a drop-in replacement for unpack-objects
> > let's simply duplicate the same behavior for now.
> 
> This seems to break t5300 when applied on top of everything
> else.  The other two numbered patches are Ok.

Yeah.... actually the problem appeared to me in my sleep! (Worrisome 
isn't it?)

So you just need to amend this patch with:

diff --git a/index-pack.c b/index-pack.c
index 7f7dc5d..5c747a6 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -461,7 +461,7 @@ static void parse_pack_objects(unsigned
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
 		die("cannot fstat packfile: %s", strerror(errno));
-	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes + 20)
+	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
 		die("pack has junk at the end");
 
 	if (!nr_deltas)


