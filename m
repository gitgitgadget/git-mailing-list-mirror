From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Sun, 25 Mar 2007 00:07:16 -0700
Message-ID: <7vfy7tajiz.fsf@assigned-by-dhcp.cox.net>
References: <200703231023.58911.andyparkins@gmail.com>
	<7vlkhmg6c3.fsf@assigned-by-dhcp.cox.net>
	<200703241550.05590.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 09:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVMpF-0004Uf-IX
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 09:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbXCYHHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 03:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbXCYHHU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 03:07:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59284 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbXCYHHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 03:07:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325070718.FOUM1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 03:07:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ev7G1W00F1kojtg0000000; Sun, 25 Mar 2007 03:07:17 -0400
In-Reply-To: <200703241550.05590.andyparkins@gmail.com> (Andy Parkins's
	message of "Sat, 24 Mar 2007 15:44:51 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43035>

Andy Parkins <andyparkins@gmail.com> writes:

> On Saturday 2007, March 24, Junio C Hamano wrote:
> ...
>> You are doing this one branch at a time even though a single
>> push may update more than one branch.  I wonder what happens if
>> branch A and B are pushed, and they both contain shared new
>> material?  When this is run for A, the entire contribution of B
>> (after push happened) is excluded.  Then when this is run for
>> B, the entire contribution of A is excluded.  Doesn't that mean
>> the commits new to this repository that are shared between A and
>> B appear for neither branches?  There must be something obvious
>> I am missing...
>
> Hmmm, that's a good point.  That's an assumption from the old update 
> hook that is no longer true.  I have no answer for that.

I think you can do something along the following line.

 (1) You say "for-each-ref --all" to get the ref information
     that is after update.

 (2) Instead of looping and processing one at a time, grab all
     information upfront.  replace the object name you obtained
     in (1) for the ref being updated with the oldrev info you
     discovered.

 (3) Handle the branch one at a time, but instead of using --all,
     use the result of (2) as the "state of the repository and
     its refs before this update".

In other words, you have enough information to reconstruct the
view of the repository before your push took place.  After
running "for-each-ref --all" once upfront, you reconstruct such
a view, and after that you do not ever look at where the real
refs are in the repository.  That would perhaps alleviate the
issue of racing pushers as a side effect.

>> > +
>> > +#
>> > +# Called for the deletion of a branch
>> > +#
>> > +generate_delete_branch_email()
>> > +{
>> > +	echo "       was  $oldrev"
>> > +	echo ""
>> > +}
>>
>> Perhaps with a one-line?
>
> Don't understand.  Do you mean throw the excessive size?

Sorry, what I meant was:

	git show -s --pretty=oneline "$oldrev"

>> Perfect example of using for-each-ref and nicely done.  Contrary
>> to what you said earlier, I see a hyphen between git and
>> for-each-ref, though.
>
> Fixed.  I wish I could take credit, but it was Shawn's idea :-)

Actually it was not quite "nicely done".  If taggername has an
unusual character then dq pair you hard coded there may not
quote the string correctly.

> +	# Use git-for-each-ref to pull out the individual fields from the tag
> +	eval $(git-for-each-ref --format='
> +	tagobject="%(*objectname)"
> +	tagtype="%(*objecttype)"
> +	tagger="%(taggername)"
> +	tagged="%(taggerdate)"' $refname
> +	)

I even suspect that a malicious tagger could do:

	GIT_COMMITTER_NAME='Andy `rm -fr .` Parkins' \
        git tag -a my-malicious-tag

and push it to you.  Telling for-each-ref to quote properly for
the host language, like this:

	git-for-each-ref --shell --format='
        	o=%(*objectname)
                t=%(*objecttype)
                n=%(taggername)
                d=%(taggerdate)' $refname

would be safer.

>> > +		# If the tagged object is a commit, then we assume this is a
>> > +		# release, and so we calculate which tag this tag is replacing
>> > +		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
>>
>> What if $newrev is a merge, I wonder...
>
> Oh yes; but that one is Andreas's fault:
>
> (Andreas Ericsson   54)  prev=$(git describe "$3^" | sed 's/-g.*//')
>
> Can we hope that even if it is a merge, that either parent would be on 
> the same previous tag?
>
>  X --- * -- * --- * --- * -- Y
>         \                   /
>          * --- * --- * --- *
>
> Not guaranteed, but what else is valid?

You could describe all the parents and see if they differ.  If
they reach different tag, we could see which one is newer.  Or
something like that.  In the special (but usual) case of a
single parent commit, "describing all the parents" is what you
are already doing, so it is not any more expensive in the normal
case.

>> This goes on the Subject: header; you'd better make sure the
>> repository is not misconfigured to have more than one lines in
>> it.
>
> projectdesc=$(cat $GIT_DIR/description | sed -ne '1p')
>
> ?

Please do not have cat on either side of a pipe.  That makes a
shell script look ... eh, you know the word ;-).

	sed -e 1q "$GIT_DIR/description"
