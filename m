From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Tue, 10 Apr 2012 14:13:17 -0400
Message-ID: <20120410181317.GA17776@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:13:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHfZM-00021N-2W
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 20:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab2DJSN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 14:13:27 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:51233 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab2DJSN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 14:13:26 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SHfZ8-0006LJ-JZ; Tue, 10 Apr 2012 14:13:21 -0400
Content-Disposition: inline
In-Reply-To: <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195115>

On Tue, Apr 10, 2012 at 09:45:46AM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > git cherry-pick fails when picking a non-ff commit that is empty.  The advice
> > given with the failure is that a git-commit --allow-empty should be issued to
> > explicitly add the empty commit during the cherry pick.  This option allows a
> > user to specify before hand that they want to keep the empty commit.  This
> > eliminates the need to issue both a cherry pick and a commit operation.
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > ---
> >  Documentation/git-cherry-pick.txt |    9 +++++++++
> >  builtin/commit.c                  |    6 +++---
> >  builtin/revert.c                  |    2 ++
> >  sequencer.c                       |    7 +++++--
> >  sequencer.h                       |    1 +
> >  5 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> > index fed5097..730237a 100644
> > --- a/Documentation/git-cherry-pick.txt
> > +++ b/Documentation/git-cherry-pick.txt
> > @@ -103,6 +103,15 @@ effect to your index in a row.
> >  	cherry-pick'ed commit, then a fast forward to this commit will
> >  	be performed.
> >  
> > +--allow-empty::
> > +	By default, cherry-picking an empty commit will fail,
> > +	indicating that an explicit invocation of `git commit
> > +	--allow-empty` is required. This option overrides that
> > +	behavior, allowing empty commits to be preserved automatically
> > +	in a cherry-pick. Note that when "--ff" is in effect, empty
> > +	commits that meet the "fast-forward" requirement will be kept
> > +	even without this option.
> > +
> >  --strategy=<strategy>::
> >  	Use the given merge strategy.  Should only be used once.
> >  	See the MERGE STRATEGIES section in linkgit:git-merge[1]
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 3714582..0cd10ab 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -56,10 +56,10 @@ N_("You asked to amend the most recent commit, but doing so would make\n"
> >  "remove the commit entirely with \"git reset HEAD^\".\n");
> >  
> >  static const char empty_cherry_pick_advice[] =
> > -N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\n"
> > -"If you wish to commit it anyway, use:\n"
> > +N_("The previous cherry-pick is empty.\n"
> > +"If the commit was created empty, please use:\n"
> 
> After reading this three times, I have to say that the updated wording do
> not look like an improvement for two reasons.
> 
>  (1) After a failed cherry-pick, the index can match the current HEAD for
>      two reasons.  Either the original cherry-pick was attempting to pick
>      an empty commit (which is likely to be a mistake unless you are doing
>      something unusual like creating an empty commit in the first place),
>      or the change in the original commit was already found in the current
>      version (may be result of a conflict resolution).  The message before
>      your change used "possibly" to hint this, and if the reader gets it,
>      it is understandable why the reader is seeing this advise.  Updated
>      message loses this information by simply saying "is empty".
> 
I can re-instate the possible language if you like, I don't have a problem with
that.

>  (2) The message is given by the "git commit" command.  "If the commit was
>      created empty" looks confusing.  Even though I can understand that
Its coded within the git commit command code, but is only ever displayed if
whence is GIT_CHERRY_PICK, so as far as I can see, from a users perspective,
this will only be seen if they type git cherry-pick on the command line.

>      "the commit" refers to the original commit the user tried to
>      cherry-pick before running this command while reviewing this patch, I
>      suspect that the reader who sees this message may not be able to tell
>      if the "git commit" command created a possibly empty commit and then
>      telling the user to do something further on _that_ commit, or if it
>      is referring to the commit the user tried to pick with the previous
>      "git cherry-pick" command.
> 
Given that this message is displayed because the index and HEAD have no changes
leading to what would be an empty commit, which is by default no allowed unless
expressly enabled, I don't think its that confusing at all.  "The commit" can
only refer to the commit being cherry picked, since there is no other.

> That is, unless you are making "git cherry-pick --allow-empty" not to stop
> and leave it to "git commit" to clean it up.  If that were the case (which
> is not, after applying this patch alone), then this message will be issued
> only when a conflict resolution resulted in an empty commit, so "If the
> commit you were trying to cherry-pick was empty to begin with" would not
> apply, either.

Ok, I see what you're saying.  This advice makes sense if you issue git
cherry-pick, but not if you issue git cherry-pick --allow-empty.  I think the
additional advice provided when you add in the keep-redundant-commits patch
though, assuming I re-add the possibly language above, yes?
Neil


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
