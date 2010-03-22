From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git clone over smart-http hanging for just one repo.
Date: Mon, 22 Mar 2010 07:12:30 -0700
Message-ID: <20100322141230.GA8916@spearce.org>
References: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brady Catherman <brady@catherman.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 15:12:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtiMy-0000jr-Mj
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 15:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab0CVOMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 10:12:35 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:37239 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab0CVOMe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 10:12:34 -0400
Received: by qyk9 with SMTP id 9so3301886qyk.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 07:12:34 -0700 (PDT)
Received: by 10.229.14.157 with SMTP id g29mr3475441qca.57.1269267153885;
        Mon, 22 Mar 2010 07:12:33 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm1656386qyk.1.2010.03.22.07.12.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 07:12:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142931>

Brady Catherman <brady@catherman.org> wrote:
> I have a git repo that fails to clone or fetch over smart-http, but  
> works great over dav. I am wondering if somebody can help me debug the  
> issue since I am at a loss why this is happening.

Yea, I'm at a loss too. :-(

> The interesting parts of a strace of git-http-backend following a git  
> clone follow:
...
> 12037 close(1)                          = 0

Why did the CGI process just close stdout?  I'm guessing this is
part of the exec of the upload-pack child in the background.  Oh,
right, we closed it because we passed the descriptor to the child
and now the parent CGI doesn't want it anymore.

> 12037 write(1, "Status: 500 Internal Server Error\r\n", 35) = -1 EBADF  
> (Bad file descriptor)

This smells like the backend upload-pack process got into trouble and
exited early, so now the CGI is trying to change the status to 500
since the backend exited with a non-zero status.  Only its too late,
as the filedescriptor was already closed after the successful fork().

We're stuck in a loop because we're failing during the die routine.

Because the file descriptor is closed, safe_write() which was what
originated that write(1, ...) above, tries to call die().  But that
die() call invokes die_webcgi() which in turn tries to write that
500 error message again to 1.  So this goes on a for a while...

> 12037 --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> 12037 +++ killed by SIGSEGV +++

and then we run out of stack space, due to too many recursions,
and the process is aborted by a SIGSEGV.

> Anybody have any thoughts why this would happen or what can be done to  
> fix it?

A gdb trace or something of the upload-pack process would help.
That appears to have also died and we don't know why.  Its death
is what contributed to the CGI crashing above.

I'll try to send a patch for this recursive crashing problem in
the CGI.

-- 
Shawn.
