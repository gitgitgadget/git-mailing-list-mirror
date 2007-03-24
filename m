From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Sat, 24 Mar 2007 15:44:51 +0000
Message-ID: <200703241550.05590.andyparkins@gmail.com>
References: <200703231023.58911.andyparkins@gmail.com> <7vlkhmg6c3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 16:53:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV8YA-0005cb-5q
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 16:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbXCXPw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 11:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbXCXPw7
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 11:52:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:5004 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXCXPw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 11:52:57 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1260151uga
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 08:52:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HPnJDZtBMEX1KaZmlYh9AEioRpZAGWkD0mVx2PaSgZ6eH/s5b6Hi15IU7/vUEEEyOyi+97FEb6STNGI8mJEilhmnFq6NTNq/GyUNXuOm6iV6F+9lrZcXysAD0lZ7ntxcaNF1VEEl9R0HIxpeRpT+abw4QVgW5miW2dJKSV+XFgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jEMSeWphXVnVv7Zl+jdpJUNfrM1NYObUMIpOuEQpWlRK8S11UxtldjZPkyhEq0LvMdF5zwFHgO746PGbYRxOEKvnSZnuUrjlinXWD6UfawtadvybM48std0Vy6NI+MxyF/nc9HNZjldKhHyrjuUKs0ofuux3QyWZoxKcs6YbpnI=
Received: by 10.67.28.4 with SMTP id f4mr8735087ugj.1174751575802;
        Sat, 24 Mar 2007 08:52:55 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id w40sm4543357ugc.2007.03.24.08.52.54;
        Sat, 24 Mar 2007 08:52:54 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vlkhmg6c3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43006>

On Saturday 2007, March 24, Junio C Hamano wrote:

> Is $(<$refname) even POSIX?  Are we sure $refname is always a
> file (not a packed ref)?

Oh dear; I had no idea that packed refs made the ref file itself 
disappear.  Would

 git-rev-parse $refname

Be a better way of getting the revision?

> If the other push updates the same ref you are filtering out,
> that would make "grep -v" to remove it from the exclusion set,
> which is a neat trick.  However, wouldn't that cause the
> rev-list to report the effect of the other push, and not your
> push?  I am wondering if the mail would say "Alice pushed and
> this branch has these commits as the result" and ends up
> including Bob's commits in it when that happens.

I hope not, 

  o --- O --- n --- n --- N --- m --- m --- M (refname)

The revs O and N come from stdin so git-receive-pack will pass (with 
refname pointing at M in both cases)
  O N refname
  N M refname
on stdin.  In case 1 (Alice),

  git rev-parse --not --all | grep -v $(git rev-parse $refname) |
  git rev-list --pretty --stdin $newrev

filters out the "^M" from the git-rev-parse output, and the git-rev-list 
adds N in.  So although "^M" isn't the "^N" that the grep is normally 
there to remove, it doesn't matter because the $newrev makes the 
rev-list start at "N", ignoring the "m" commits.

> I think that is a good discipline in general, but I wonder if it
> is strictly necessary.  Doesn't hook already get invoked with
> environment that has GIT_EXEC_PATH at the beginning of the PATH?

It's certainly not necessary; just an idea I picked up off the mailing 
list, but I forget from whom I got it.

> Huh?  Did you mean to send the first one also to stderr?
> Huh?  Did you mean to send the second one also to stderr?
>
> It usually is easier to spot this kind of gotchas if you
> consistently write like this instead:
>
> 	echo >&2 "your message comes here..."
> 	echo >&2 "... and the second line is here"

Done, done and done.

> Please never pipe grep into sed, or the other way around.  It
> makes the script look amateurish.

Okay; my unfamiliarity with sed is showing up; I don't use it a lot so 
I'd say I am an amateur.  Fixed.

> Is it assumed that pushing developers do not cross-pull,
> bypassing the repository this hook is in?  Otherwise, if Alice

I did think about that problem, but I couldn't think of a truely "right" 
solution.  It seemed strange to have emails appearing to be from 
someone who wasn't mentioned in the commits.  Also; I couldn't see that 
there was any sensible way of finding the email address of the person 
doing the push.

> It would not be a problem as long as you use this repository as
> the _ONLY_ place developers meet, but that's a big assumption:
> centralized repo with CVS-mentality.

I thought it was safe to make that assumption because the use of this 
hook script implies a centralised-repo mentality.

> The assumption is not wrong per-se, but I think that needs to be
> documented at one place, near the top: "if you subscribe to this

Done.

> Similarly the other assumption your script makes should be
> documented: the "list only new commits to the entire repository"

Done.

> I do not think so.  It is a good style as long as you do not
> botch it and leave the variables empty -- even in that case the
> runtime would notice and say "generate___email: no such command"
> ;-).

I can't see a path through the script that leaves either $change_type or 
$fn_name unset; so I hope that won't be a problem.

> Please indent the case arms at the same level as "case/esac",
> like this:

Done.

> Micronit.  Some committer names (GIT_COMMITTER_NAME) that are
> not quoted may need to be quoted to appear on the From: header
> (most notable is a name with dot after middle initial).

How does

  committer=$(git show --pretty=full -s $rev | sed -ne "s/^Commit: //" |
		sed -e 's/\(.*\) </"\1" </')

Look?

> A signature separator line is usually "^-- $", not "^--$".

Done.

> I'd rather not to have name Git there, for two reasons.  If you

Done.  $projectdesc used instead.

> Also, this is (as described in the first part of the script)
> only an example script, and although I am willing to help making
> sure this is bug-free (like spending time writing this message
> right now -- wow, I've been sitting here typing this e-mail for
> almost two hours), I do not want to be held responsible for any

Wow; that is a long time.

> bugs in it, nor I do not want anybody to mistakenly think that
> what this script does is the way to run things recommended by
> the Git community.  It really is just "a useful script to use
> WITH git Andy wrote", not "THE hook Git gives us".

No problem at all.

> I kind of like the attention to the detail of giving an empty
> argv[1] to echo (it used to be customary to do this for
> portability), but I wonder if it is still needed...

I don't know were I picked that habbit up from; I think some early 
scripts I wrote needed it, so from then on I just put it in whenever I 
need a blank.

On ocassion it's also helped for find and replace operations.

> Where does $baserev come from?  Random leftover garbage from
> invocation for the branch the main while loop handled before
> this branch?

Oops.  Done; baserev removed.

> You are doing this one branch at a time even though a single
> push may update more than one branch.  I wonder what happens if
> branch A and B are pushed, and they both contain shared new
> material?  When this is run for A, the entire contribution of B
> (after push happened) is excluded.  Then when this is run for
> B, the entire contribution of A is excluded.  Doesn't that mean
> the commits new to this repository that are shared between A and
> B appear for neither branches?  There must be something obvious
> I am missing...

Hmmm, that's a good point.  That's an assumption from the old update 
hook that is no longer true.  I have no answer for that.

> This comment and logic is wrong.  In the above graph, if you say
> "rev-list O..N" (which is "rev-list N ^O"), you would get
> commits that are reachable from N, excluding the ones that are
> also reachable from O, so you would get N, * before it, X and *
> before it.

The comment was indeed the wrong way round; but I got the baserev stuff 
from the old hook script:

$ git-blame v1.4.4 -- templates/hooks--update
(Junio C Hamano     75)  base=$(git-merge-base "$2" "$3")
(Junio C Hamano     86)  git-rev-list --pretty "$3" "^$base"

I just assumed there was good reason for it and copied it.  If rev-list 
O..N is fine, I'll do that.

> That's bog-standard way we use to see if O->N transition is a
> fast forward, but for this application, since it is far more
> likely to be than it isn't, I think computing "rev-list N..O"
> and checking if it reports anything is a better check
> (especially because its results can be used in a way I'll
> describe later).

I like it.

I've thrown away all the baserev stuff and used the N..O notation to 
list the discarded revisions.  This also makes it easy to detect the 
fast forward as you say.

> > +	echo ""
> > +	echo "Summary of changes:"
> > +	git diff-tree --no-color --stat -M -C --find-copies-harder
> > $baserev..$newrev +}
>
> Comment and code mismatch between $baserev and $oldrev?

Comment was right; what I was actually trying to show was the difference 
between oldrev and newrev, whatever the path it took to get from old to 
new.

> "-M -C" is redundant.  Just "-C" should do.  If you really want
> to spend extra cycles, then "--find-copies-harder" is fine, but

Done.  I think wasting the extra cycles is okay, because no one is going 
to notice if the notification email is a bit delayed in its generation, 
but they might appreciate the extra detail in the email that will be 
there to refer to forever.

> Do you even need --no-color?  I thought we specifically tried

Paranoia on my part.  Removed.

> I would add --summary to the list, though.

Done; but I think the interesting extra information in the summary (i.e. 
the creations/deletions) would be better if it were on the --stat and 
the --summary can go again.

> > +
> > +#
> > +# Called for the deletion of a branch
> > +#
> > +generate_delete_branch_email()
> > +{
> > +	echo "       was  $oldrev"
> > +	echo ""
> > +}
>
> Perhaps with a one-line?

Don't understand.  Do you mean throw the excessive size?  I made it a 
function on purpose to keep the "example" quality.  Makes it obvious 
were to put customisations.

> Perfect example of using for-each-ref and nicely done.  Contrary
> to what you said earlier, I see a hyphen between git and
> for-each-ref, though.

Fixed.  I wish I could take credit, but it was Shawn's idea :-)

> > +		# If the tagged object is a commit, then we assume this is a
> > +		# release, and so we calculate which tag this tag is replacing
> > +		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
>
> What if $newrev is a merge, I wonder...

Oh yes; but that one is Andreas's fault:

(Andreas Ericsson   54)  prev=$(git describe "$3^" | sed 's/-g.*//')

Can we hope that even if it is a merge, that either parent would be on 
the same previous tag?

 X --- * -- * --- * --- * -- Y
        \                   /
         * --- * --- * --- *

Not guaranteed, but what else is valid?

> Didn't you mean to update this with:
>
> 	... | sed -e '1,/^$/d'

I did; and could swear I had.  Wonder how I managed to undo that one.

> You won't get a tag to another tag with %(*objecttype), so you
> only have to worry about trees and blobs.  But in addition to
> the "length XX bytes" you already said the type of what it tags
> upfront, so I do not think of anything else to say here.

I did think that when gitattributes arrive, they might offer some 
interesting possibilities for that section.

> This goes on the Subject: header; you'd better make sure the
> repository is not misconfigured to have more than one lines in
> it.

projectdesc=$(cat $GIT_DIR/description | sed -ne '1p')

?

> I vaguely recall you made this die instead of leaving unnamed...

I did for the update hook; when that would prevent the update; the 
post-receive hook can't stop the update so we /have/ to issue the 
email - there is no second chance.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
