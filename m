From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rerere.txt: Mention rr-cache directory
Date: Wed, 9 Jul 2008 02:38:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness>
References: <1215562653-5043-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807090225050.5277@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGNiI-0001Zc-Dd
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbYGIAiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 20:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbYGIAiG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 20:38:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:42302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755710AbYGIAiD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 20:38:03 -0400
Received: (qmail invoked by alias); 09 Jul 2008 00:38:02 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp052) with SMTP; 09 Jul 2008 02:38:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9Xk5/0fL9MtvTi+NGxGqphRUTGz8tejISUgt2T4
	JjwbkOI3+y5NnV
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.DEB.1.00.0807090225050.5277@eeepc-johanness>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87820>

Hi,

On Wed, 9 Jul 2008, Johannes Schindelin wrote:

> On Wed, 9 Jul 2008, Stephan Beyer wrote:
> 
> > If a user reads the rerere documentation, he or she is not told to 
> > create the $GIT_DIR/rr-cache directory to be able to use git-rerere. 
> 
> Is it?  The config setting is not enough?  Then that is a bug, and should 
> not be blessed by a bug in the documentation.

Okay, I took a look:

-- snip --
static int is_rerere_enabled(void)
{
        struct stat st;
        const char *rr_cache;
        int rr_cache_exists;

        if (!rerere_enabled)
                return 0;

        rr_cache = git_path("rr-cache");
        rr_cache_exists = !stat(rr_cache, &st) && S_ISDIR(st.st_mode);
        if (rerere_enabled < 0)
                return rr_cache_exists;

        if (!rr_cache_exists &&
            (mkdir(rr_cache, 0777) || adjust_shared_perm(rr_cache)))
                die("Could not create directory %s", rr_cache);
        return 1;
}
-- snap --

As you can see, in the case rerere_enabled < 0 (i.e. the config did not 
say anything about rerere), it is assumed enabled _exactly_ when 
.git/rr_cache/ exists.

But if it is > 0, the directory is created.

Of course, this only holds true when the config is read, i.e. when 
setup_rerere() was called in time.  Which is the case when you call 
rerere() (as is done both from cmd_rerere() as well as cmd_commit()).

Of course, I haven't tested it.  Other than running the test script, that 
is.

So care to elaborate what is going wrong?

BTW I think it is a horrible thing that rerere() is declared in commit.h 
(a libgit header), but implemented in builtin-rerere.c, which is not part 
of libgit.a.

Ciao,
Dscho
