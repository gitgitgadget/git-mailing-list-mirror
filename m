From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 4/4] git-commit-interactive: Allow rebasing to preserve
 empty commits
Date: Sat, 31 Mar 2012 09:11:16 -0400
Message-ID: <20120331131116.GE2409@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-5-git-send-email-nhorman@tuxdriver.com>
 <7v4nt5lsa1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 15:11:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDy62-0001ZP-J5
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 15:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab2CaNLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 09:11:23 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:42882 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab2CaNLW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 09:11:22 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDy5N-0005kg-8j; Sat, 31 Mar 2012 09:11:19 -0400
Content-Disposition: inline
In-Reply-To: <7v4nt5lsa1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194453>

On Fri, Mar 30, 2012 at 01:59:02PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > This updates git-commit-interactive to recognize and make use of the keep_empty
> > flag.  When not set, git-rebase -i will now comment out commits that are empty,
> > and informs the user that commits which they wish to explicitly keep that are
> > empty should be uncommented, or --keep-empty should be specified.  if keep_empty
> > is specified, all commits, regardless of their empty status are included.
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > CC: Jeff King <peff@peff.net>
> > CC: Phil Hord <phil.hord@gmail.com>
> > CC: Junio C Hamano <gitster@pobox.com>
> > ---
> >  git-rebase--interactive.sh |   38 +++++++++++++++++++++++++++++++++++---
> >  1 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 5812222..97eeb21 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -191,12 +191,24 @@ git_sequence_editor () {
> >  
> >  pick_one () {
> >  	ff=--ff
> > +	is_empty=$(git show --pretty=format:%b "$@" | wc -l)
> 
> That is a very expensive way to see if the commit is empty, no?
> 
> If and only if commit C is empty, "git rev-parse" on C^{tree} and
> C^^{tree}" will yield the same tree object name.
> 
Ah, you see, I'm learning something :).  I can fix that up.

> > +	if [ $is_empty -eq 0 ]
> 
> Also this test (which by the way is against our coding style guideline)
> shows that the variable is misnamed.
> 
Ok, sorry about that.  I'll switch that to use test

> > +	then
> > +		empty_args=--keep-empty
> > +	fi
> > +
> > +	if [ -n "$keep_empty" ]
> > +	then
> > +		empty_args=--keep_empty
> > +	fi
> > +
> >  	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
> >  	case "$force_rebase" in '') ;; ?*) ff= ;; esac
> >  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
> >  	test -d "$rewritten" &&
> >  		pick_one_preserving_merges "$@" && return
> > -	output git cherry-pick $ff "$@"
> > +	output git cherry-pick $empty_args $ff "$@"
> >  }
> >  
> >  pick_one_preserving_merges () {
> > @@ -780,9 +792,24 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
> >  	sed -n "s/^>//p" |
> >  while read -r shortsha1 rest
> >  do
> > +	local comment_out
> 
> bashism.
> 
Roger.

> > +
> > +	if [ -z "$keep_empty" ]
> > +	then
> > +		comment_out=$(git show --pretty=format:%b $shortsha1 | wc -l)
> 
> Ditto.
> 
> > +		if [ $comment_out -eq 0 ]
> > +		then
> > +			comment_out="#pick"
> 
> Perhaps it is easier to read if you say "# pick"?
> 
Sure, easy enough fix

> > +		else
> > +			comment_out="pick"
> > +		fi
> > +	else
> > +		comment_out="pick"
> > +	fi
> > +
> >  	if test t != "$preserve_merges"
> >  	then
> > -		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
> > +		printf '%s\n' "$comment_out $shortsha1 $rest" >> "$todo"
> 
> The variable comment_out is grossly misnamed.  Why not do it this way?
> 
I think you meant to assign leader there instead of comment_out, but your point
is a good one :).

> 	comment_out=
> 	if test -z "$keep_empty" && is_empty_commit $shortsha1
>         then
>         	comment_out="# "
> 	fi
> 
>         if ...
>         then
> 		printf "%s\n" "${leader}pick $shortsha1 $rest" >>"$todo"
> 
> > @@ -849,6 +876,11 @@ cat >> "$todo" << EOF
> >  # If you remove a line here THAT COMMIT WILL BE LOST.
> >  # However, if you remove everything, the rebase will be aborted.
> >  #
> > +# Note that commits which are empty at the time of rebasing are 
> > +# commented out.  If you wish to keep empty commits, either 
> > +# specify the --keep-empty option to the rebase command, or 
> > +# uncomment the commits you wish to keep
> > +#
> 
> Good.
> 
> I do not think " either specify...rebase command, or" is necessary here,
> though.  This message is meant to be a quick reminder, not a tutorial.
> Keep it short and sweet.
> 
Copy that, I'll tone down the verbosity.

> Also, you may probably want to add this text _only_ when you have actually
> commented out something.
> 
Easily done.  thanks!
Neil
