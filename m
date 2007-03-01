From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-revert & git-cherry-pick a builtin
Date: Thu, 1 Mar 2007 22:37:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703012230290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703010526080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm6xqj0d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMsxr-0005JB-40
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 22:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbXCAVhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 16:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbXCAVhX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 16:37:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:45871 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030300AbXCAVhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 16:37:22 -0500
Received: (qmail invoked by alias); 01 Mar 2007 21:37:21 -0000
X-Provags-ID: V01U2FsdGVkX1/lHdJmZD3lXRBE/cRNJmRvGpQz9uca1LAE02lhCQ
	Au0sCSzDdkUd2V
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm6xqj0d.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41129>

Hi,

On Thu, 1 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Makefile         |   11 +-
> >  builtin-revert.c |  406 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  builtin.h        |    2 +
> >  git-revert.sh    |  197 --------------------------
> >  git.c            |    2 +
> >  5 files changed, 414 insertions(+), 204 deletions(-)
> >  create mode 100644 builtin-revert.c
> >  delete mode 100755 git-revert.sh
> 
> Thanks.  I haven't looked the patch closely but I trust this
> round is a fairly faithful straight translation from the shell
> script, which is good.

I tried. Of course, it helped tremendously that there were test cases. 
Nevertheless would I appreciate review from the list...

> I have a few gripes on the behaviour of these commands, and it might be 
> worthwhile to address them in the later rounds.

Yes, that was part of the reason I rewrote these two in C: For example, I 
would like a little bit better locking (double locking index would be a 
good start).

Of course, it makes it easier to write cmd_rebase(): I plan to put it into 
the same file so that the function revert_or_cherry_pick() can easily be 
reused.

> > +static int merge_recursive(const char *base_sha1,
> > +		const char *head_sha1, const char *head_name,
> > +		const char *next_sha1, const char *next_name)
> > +{
> > + ...
> > +}
> 
> Somehow I would have expected you to call merge-recursive not spawn, but 
> this is saner ;-).

I briefly considered this, until I realized that merge-recursive is no 
builtin yet!

Speaking of this issue: Would it be conceivable to make the standalones 
into builtins? (This adds a dependency on libcurl to core Git programs, 
but I could live with that... It would make a builtin fetch easier, too.)

> > +static int revert_or_cherry_pick(int argc, const char **argv)
> > +{
> > + ...
> > +	msg_fd = hold_lock_file_for_update(&msg_file, ".msg", 1);
> 
> Although the detailed reason escapes me, we earlier moved the
> temporary files to $GIT_DIR/.  This .msg in the current
> directory somehow survived.  It probably is a good idea to move
> this to $GIT_DIR/ in later rounds.

Okay. I have no idea how much the tests rely on that locations, let alone 
other scripts. Therefore I think it is sane to do it in a separate step.

> > +		if (action == CHERRY_PICK) {
> > +			fprintf(stderr, "You may choose to use the following "
> > +				"when making the commit:\n"
> > +				"GIT_AUTHOR_NAME=\"%s\"\n",
> > +				getenv("GIT_AUTHOR_NAME"));
> > +			fprintf(stderr, "GIT_AUTHOR_EMAIL=\"%s\"\n",
> > +				getenv("GIT_AUTHOR_EMAIL"));
> > +			fprintf(stderr, "GIT_AUTHOR_DATE=\"%s\"\n"
> > +				"export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL "
> > +				"GIT_AUTHOR_DATE\n",
> > +				getenv("GIT_AUTHOR_DATE"));
> > +		}
> > +		exit(1);
> > +	}
> 
> I am to blame for this crap, but I think this part of code was done 
> before we invented "git commit -C <commit>".  It would be a lot better 
> to suggest using that command.

Yeah, let's do that, too.

BTW it took me so long because there was a hard-to-catch bug with the 
encodings (of course!). In the end I realized that I only forgot to call 
git_config(git_default_config)... D'oh.

Ciao,
Dscho
