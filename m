From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Mon, 23 Jul 2007 12:58:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231239460.14781@racer.site>
References: <20070723041741.GA22461@midwinter.com> <Pine.LNX.4.64.0707231059490.14781@racer.site>
 <46A481B4.7000502@midwinter.com> <Pine.LNX.4.64.0707231136530.14781@racer.site>
 <46A48949.1020501@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 13:58:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICwYN-0005dv-VG
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 13:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbXGWL6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 07:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbXGWL6Q
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 07:58:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:53721 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750748AbXGWL6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 07:58:16 -0400
Received: (qmail invoked by alias); 23 Jul 2007 11:58:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 23 Jul 2007 13:58:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ihMh9LapinOcQUyGp4fa02uep4D5EAUwgIqjw8b
	LiBGRGpXaZQD3E
X-X-Sender: gene099@racer.site
In-Reply-To: <46A48949.1020501@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53431>

Hi,

On Mon, 23 Jul 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
> > Ah, I missed that.  But IIRC your patch does not wrap that logic behind test
> > ! -z "$templatefile", right?  So this is my modified suggestion:
> > 
> > test ! -z "$templatefile" && {
> > 	grep -vie '^Signed-off-by:' < "$GIT_DIR"/COMMIT_MSG" > "$GIT_DIR"/tmp1
> > 	grep -ve '^#' < "$templatefile" > "$GIT_DIR"/tmp1
> > 	trap 'rm "$GIT_DIR"/tmp[12]' 0
> > 	cmp "$GIT_DIR"/tmp[12] &&
> > 	die "Unchanged message; will not commit"
> > }
> >   
> 
> So you are suggesting I do this in addition to the existing git-commit
> stripping of Signed-off-by: lines? I can certainly do that, but I didn't want
> to make two passes over the commit message doing exactly the same stripping.
> 
> Hmm, maybe I should outline my understanding of the current (unpatched)
> behavior and what I want it to do. Currently:
> 
> * Strip off all comment lines (happens when COMMIT_MSG is created)
> * Strip off all Signed-off-by: lines
> * Trim whitespace
> * If the result has no content (`wc -l` == 0), abort.
> 
> With the patch, my intent was:
> 
> * Strip off all comment lines
> * Strip off all Signed-off-by: lines
> * Trim whitespace
> * If the result has no content (! -s file), abort.
> * If a template file was specified:
>   * Strip off all comment and Signed-off-by: lines from the template
>   * Trim whitespace from the template
>   * If the resulting trimmed template is the same as the trimmed commit
> message, abort.
> 
> So I guess before getting to the specifics of the code, I'll ask: does the
> above make sense as a design? I wanted to preserve the existing behavior in
> the absence of a template.

Yes, I think that makes sense.

> Since the existing code is already stripping Signed-off-by: lines to test for
> a zero-length commit message, I figured I should reuse that work. However,
> it's no big deal to do it twice if people feel that results in more readable
> code -- certainly no human will ever notice the time it takes to re-grep the
> commit message.

Okay, but I was really confused by the big if thing.

I'd make sure that COMMIT_BAREMSG is removed with a trap, and really try 
to just enhance the

	if cnt=`grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
	        git stripspace |
	        wc -l` &&
	   test 0 -lt $cnt

so that it reads something like

	if test -s "$GIT_DIR"/COMMIT_BAREMSG &&
		test -z "$templatefile" ||
		(grep -ve '^#' < "$templatefile" |
		 git stripspace |
		 git diff --quiet - "$GIT_DIR"/COMMIT_BAREMSG)
	then
		...

(Totally untested, of course.) Hmm?

Ciao,
Dscho
