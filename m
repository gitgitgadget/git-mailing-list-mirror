From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 5/5] mingw_rmdir: set errno=ENOTEMPTY when
 appropriate
Date: Wed, 15 Dec 2010 01:21:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1012150114010.1461@bonsai2>
References: <20101214220604.GA4084@sandbox> <20101214222830.GF4084@sandbox> <AANLkTi=12WqYn5GJpqPYqKE_2L51Em7Ek5szTZYryHd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 01:21:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSf7R-0004Nz-Er
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 01:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472Ab0LOAVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 19:21:11 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:53638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755127Ab0LOAVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 19:21:09 -0500
Received: (qmail invoked by alias); 15 Dec 2010 00:21:08 -0000
Received: from pD9EB205C.dip0.t-ipconnect.de (EHLO noname) [217.235.32.92]
  by mail.gmx.net (mp020) with SMTP; 15 Dec 2010 01:21:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18mMcpiY2Em4YO7tAFS25RsHTNC0DgyeSgIj+q2Xk
	aYNPKQeuuOZKfX
X-X-Sender: gene099@bonsai2
In-Reply-To: <AANLkTi=12WqYn5GJpqPYqKE_2L51Em7Ek5szTZYryHd9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163725>

Hi,

On Tue, 14 Dec 2010, Erik Faye-Lund wrote:

> On Tue, Dec 14, 2010 at 11:28 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On Windows, EACCES overrules ENOTEMPTY when calling rmdir(). But if the
> > directory is busy, we only want to retry deleting the directory if it
> > is empty, so test specifically for that case and set ENOTEMPTY rather
> > than EACCES.
> >
> 
> Hmm... According to MSDN, rmdir(*) should already handle ENOTEMPTY. 
> Isn't the problem rather the structure of that loop? Shouldn't it be 
> sufficient to do something like this (note: untested, but the concept 
> should work, no)?

This is how the patch looks in current 4msysgit.git's devel branch:

-- snip --
 #undef rmdir
 int mingw_rmdir(const char *pathname)
 {
-    int ret, tries = 0;
+       int ret, tries = 0;
 
        while ((ret = rmdir(pathname)) == -1 && tries < ARRAY_SIZE(delay)) 
{
                if (errno != EACCES)
                        break;
+               if (!is_dir_empty(pathname)) {
+                       errno = ENOTEMPTY;
+                       break;
+               }
                /*
                 * We assume that some other process had the source or
                 * destination file open at the wrong moment and retry.
-- snap --

Of course, with so much water running down the Elbe between me writing 
that patch and me answering you, I cannot really say whether rmdir() 
set errno to ENOTEMPTY.

But as the patch looked the same when I wrote it originally (you can see 
it in the history, since I introduced rebasing merges prior to making this 
patch) I would assume that in my tests, errno was set to EACCESS rather 
than ENOTEMPTY.

However, since I am distrusted on the Git mailing list it would be good if 
you tried your version and verified whether what I say is true.

Thanks,
Dscho
