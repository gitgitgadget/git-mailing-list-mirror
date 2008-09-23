From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 22:41:42 +0200
Message-ID: <200809232241.42649.johannes.sixt@telecom.at>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <200809232103.09133.johannes.sixt@telecom.at> <20080923194802.GQ21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiEip-000184-AL
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 22:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbYIWUls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 16:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYIWUlr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 16:41:47 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:45326 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbYIWUlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 16:41:47 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 5D4A1971CA;
	Tue, 23 Sep 2008 22:41:43 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BA33D1D23E;
	Tue, 23 Sep 2008 22:41:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080923194802.GQ21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96591>

On Dienstag, 23. September 2008, Dmitry Potapov wrote:
> On Tue, Sep 23, 2008 at 09:03:08PM +0200, Johannes Sixt wrote:
> > On Dienstag, 23. September 2008, Dmitry Potapov wrote:
> > > +static int do_stat(const char *file_name, struct stat *buf, stat_fn_t
> > > cygstat) +{
> > > +	WIN32_FILE_ATTRIBUTE_DATA fdata;
> > > +
> > > +	if (file_name[0] == '/')
> > > +		return cygstat (file_name, buf);
> >
> > You should do this in the caller; it would make this function's
> > semantics much clearer.
>
> IMHO, the semantic of this function is clear: do_stat performs stat/lstat
> using Windows API with falling back on Cygwin implementation in those
> rare cases that it cannot handle correctly. Absolute path is just one of
> those cases. So, I am not sure what you win by moving this two lines out.

You copied the function from compat/mingw.c. There it has the meaning "Fill in 
struct stat using Win32 API" and nothing else. Here it has the meaning "Fill 
in struct stat using Win32 API if you can, and using cygstat() in certain 
exceptional cases". If you stayed with the original meaning, it would be 
slightly easier to factor out common code.

> > > +		/* st_dev, st_rdev are not used by Git */
> > > +		buf->st_dev = buf->st_rdev = 0;
>
> I set this to 0, while MinGW Git uses _getdrive(). I have no idea why
> it does so. 

Indeed. Calling _getdrive() is absolutely useless.

> > You do duplicate a lot of code here. Any chances to factor out the
> > common parts?
>
> I don't see much common code here. Initialization of 5 variables where
> four of them are just constants? Perhaps, the biggest common part here
> is conversion of dwFileAttributes to st_mode, but it is still 5 lines of
> trivial code.

Sigh. I gave a pointer how to unify the two functions (although I missed the 
fact that the member variables are named differently). I'd appreciate if you 
did not make it more difficult than necessary to factor out common code.

-- Hannes
