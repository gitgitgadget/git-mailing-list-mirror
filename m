From: Greg KH <greg@kroah.com>
Subject: Re: git-pull-script hates me
Date: Wed, 6 Jul 2005 13:46:27 -0700
Message-ID: <20050706204627.GA19481@kroah.com>
References: <20050706203139.GA19198@kroah.com> <Pine.LNX.4.58.0507061335100.4159@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 23:36:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqHYe-0008Ip-2T
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 23:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVGFVX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVGFUs7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 16:48:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:16851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262530AbVGFUqf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 16:46:35 -0400
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j66Kk7q31108;
	Wed, 6 Jul 2005 13:46:07 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DqGmp-54a-00; Wed, 06 Jul 2005 13:46:27 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507061335100.4159@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2005 at 01:37:55PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 6 Jul 2005, Greg KH wrote:
> >
> > I just updated to the latest git tree, and now get the following when I
> > try to pull from a ssh repo:
> > 
> >  $ git-pull-script gregkh@someserver.org:/public_html/udev.git/
> >  fatal: I don't like '@'. Sue me.
> > 
> > So I drop the @ and then get:
> >  $ git-pull-script someserver.org:/public_html/udev.git/
> >  fatal: I don't like '_'. Sue me.
> 
> Heh. It really is personal.
> 
> The new git-pack handling tries to avoid special characters, because it 
> passes some things off to a shell (ie it opens up an ssh connection.
> 
> But yeah, it's being a bit too anal. Just look at connect.c: shell_safe(),
> and add both '_' and '@' to the safe list (and any other safe characters),
> and off you go.

Ok, below is a patch for this.  It works, but then errors out with:
	bash: git-upload-pack: command not found
	fatal: unexpected EOF

So I'm guessing that I have to convince the server owner to update their
version of git too?

thanks,

greg k-h

--------------------

Subject: allow _ and @ in addresses

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/connect.c b/connect.c
--- a/connect.c
+++ b/connect.c
@@ -57,6 +57,7 @@ static char *shell_safe(char *url)
 		['A'...'Z'] = 1,
 		['.'] = 1, ['/'] = 1,
 		['-'] = 1, ['+'] = 1,
+		['@'] = 1, ['_'] = 1,
 		[':'] = 1
 	};
 
