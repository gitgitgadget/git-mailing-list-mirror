From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] git-rerere.txt: Mention rr-cache directory
Date: Wed, 9 Jul 2008 11:21:03 +0200
Message-ID: <20080709092103.GA5185@leksak.fem-net>
References: <1215562653-5043-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807090225050.5277@eeepc-johanness> <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 11:22:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGVsC-0005ud-KQ
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 11:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYGIJVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 05:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbYGIJVH
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 05:21:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:59062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753645AbYGIJVG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 05:21:06 -0400
Received: (qmail invoked by alias); 09 Jul 2008 09:21:04 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp024) with SMTP; 09 Jul 2008 11:21:04 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+YzFE438aYaPctFHwF0S0lZZYoAbgk828bAAPdXY
	qKTdGS7uewZBsm
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KGVrD-00026z-EL; Wed, 09 Jul 2008 11:21:03 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87862>

Hi,

On Wed, Jul 09, Johannes Schindelin wrote:
> On Wed, 9 Jul 2008, Johannes Schindelin wrote:
> > On Wed, 9 Jul 2008, Stephan Beyer wrote:
> > 
> > > If a user reads the rerere documentation, he or she is not told to 
> > > create the $GIT_DIR/rr-cache directory to be able to use git-rerere. 
> > 
> > Is it?  The config setting is not enough?  Then that is a bug, and should 
> > not be blessed by a bug in the documentation.

I don't know if this is exactly a bug, at least config.txt says:

rerere.enabled::
	Activate recording of resolved conflicts, so that identical
	conflict hunks can be resolved automatically, should they
	be encountered again.  linkgit:git-rerere[1] command is by
	default enabled if you create `rr-cache` directory under
	`$GIT_DIR`, but can be disabled by setting this option to false.

So according to *that* documentation it is right, according to the
git-rerere.txt documentation it was wrong, and according to the
source it is...
> -- snip --
> static int is_rerere_enabled(void)
> {
>         struct stat st;
>         const char *rr_cache;
>         int rr_cache_exists;
> 
>         if (!rerere_enabled)
>                 return 0;
> 
>         rr_cache = git_path("rr-cache");
>         rr_cache_exists = !stat(rr_cache, &st) && S_ISDIR(st.st_mode);
>         if (rerere_enabled < 0)
>                 return rr_cache_exists;
> 
>         if (!rr_cache_exists &&
>             (mkdir(rr_cache, 0777) || adjust_shared_perm(rr_cache)))
>                 die("Could not create directory %s", rr_cache);
>         return 1;
> }
> -- snap --
> 
> As you can see, in the case rerere_enabled < 0 (i.e. the config did not 
> say anything about rerere), it is assumed enabled _exactly_ when 
> .git/rr_cache/ exists.
> 
> But if it is > 0, the directory is created.

Yes.
There is also an important part in the file:
-- snip --
/* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
static int rerere_enabled = -1;
-- snap --

So this means it's the following behavior:
 - rerere_enabled < 0: enable, iff rr-cache exists
 - rerere_enabled ==0: disable
 - rerere_enabled > 0: enable and create rr-cache if it does not exist

So this is my fault, sorry :) Both documentations (config.txt and
git-rerere.txt) are right.
It was not explicitly enabled on this one machine which lead me to the
wrong assumption. I should sync my ~/.gitconfig more often ;)

Sorry for that,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
