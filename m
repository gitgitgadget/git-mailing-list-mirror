From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Sun, 27 Aug 2006 16:49:33 -0500
Message-ID: <E1GHSVZ-00070W-HI@jdl.com>
X-From: git-owner@vger.kernel.org Sun Aug 27 23:49:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSVd-0004rM-Hs
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 23:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWH0Vtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 17:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWH0Vtg
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 17:49:36 -0400
Received: from mail.jdl.com ([66.118.10.122]:5301 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932268AbWH0Vtf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 17:49:35 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GHSVZ-00070W-HI
	for git@vger.kernel.org; Sun, 27 Aug 2006 16:49:34 -0500
To: git@vger.kernel.org
In-Reply-To: 7v64gexxgl.fsf@assigned-by-dhcp.cox.net
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26118>


The other day, Junio lamented:
> I have to admit that I kinda liked JDL's simpler one first (and
> it has been in production use for some time).  We'll see.

I think the two aspects of my implementation that are
favorable are the slightly more general table-driven string
interplotion routine and the generalization of the interface
to the upload() call here:

    @@ -310,8 +377,14 @@ #endif
    	if (len && line[len-1] == '\n')
    		line[--len] = 0;
     
    -	if (!strncmp("git-upload-pack ", line, 16))
    -		return upload(line+16);
    +	if (len != pktlen) {
    +	    parse_extra_args(line + len + 1, pktlen - len - 1);
    +	}
    +
    +	if (!strncmp("git-upload-pack ", line, 16)) {
    +		interp_table[INTERP_SLOT_DIR].value = line+16;
    +		return upload(interp_table);
    +	}


Naturally, I only placed entries into the interpolation table
that I needed to get my code working, but it could easily be
extended and filled with additional entries such as the %u for
user paths and %IP for IP address, etc.  I might even recommend
some form of lower-case-izing option too.

In any event, we should clearly attempt to unify my proposed
implementation with Pierre's proposal.

jdl
