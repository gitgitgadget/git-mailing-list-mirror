From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix merge-recursive on cygwin: broken errno when unlinking a directory
Date: Thu, 19 Apr 2007 01:40:34 +0200
Message-ID: <20070418234034.GE2477@steel.home>
References: <20070418223327.GC2477@steel.home> <alpine.LFD.0.98.0704181537590.9964@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 01:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeJlT-0002Rl-9H
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 01:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992998AbXDRXkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 19:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993002AbXDRXkk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 19:40:40 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:33150 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992998AbXDRXkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 19:40:39 -0400
Received: from tigra.home (Fca1e.f.strato-dslnet.de [195.4.202.30])
	by post.webmailer.de (klopstock mo4) (RZmta 5.5)
	with ESMTP id O03fedj3ILICe8 ; Thu, 19 Apr 2007 01:40:35 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E7514277BD;
	Thu, 19 Apr 2007 01:40:34 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C7ACEBDDE; Thu, 19 Apr 2007 01:40:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704181537590.9964@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl6Sg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44963>

Linus Torvalds, Thu, Apr 19, 2007 01:04:06 +0200:
> >
> > +				struct stat st;
> > +				int err = errno;
> > +				if (err == EISDIR ||
> > +				    (err == EPERM && !lstat(path, &st) && S_ISDIR(st.st_mode))) {
> 
> Can I ask people to please *not* write things like this?
> 

Err... ok.

> 
> (Side note: EPERM is actually apparently the POSIXLY correct error!)
> 

Indeed it is 8-[]

> 
> So here's a suggested and totally untested patch. It makes the code more 
> readable, and probably fixes *two* bugs in the process. It also simply 
> doesn't really even care what the error actually was - the important part 
> was not that it was a directory, but that the unlink didn't succeed!
>

Well, it is a bit tested now. I'll repeat the testing tomorrow on that
windows box.

> +	/* .. but not some other error (who really cares what?) */
> +	return error(msg, path, ": perhaps a D/F conflict?");

I have to care sometimes when cygwin breaks where you never expect it
to. These annoying strerror(errno)'s a very helpful. IOW, how can
the user respond to the message which just tells "maybe it is
expected and you can fix it. Perhaps"? What do I do here next?
(well, I know what to do, but someone wont).

An lstat + S_ISDIR would at least make it plain "D/F conflict".
