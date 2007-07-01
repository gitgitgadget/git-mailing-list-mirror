From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] contrib/hooks: add post-update hook for updating working
 copy
Date: Mon, 02 Jul 2007 10:30:10 +1200
Message-ID: <46882AF2.6020705@vilain.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>	<11831937813223-git-send-email-sam.vilain@catalyst.net.nz>	<11831937822346-git-send-email-sam.vilain@catalyst.net.nz>	<11831937823184-git-send-email-sam.vilain@catalyst.net.nz>	<11831937823982-git-send-email-sam.vilain@catalyst.net.nz>	<1183193782172-git-send-email-sam.vilain@catalyst.net.nz>	<11831937822249-git-send-email-sam.vilain@catalyst.net.nz>	<11831937823756-git-send-email-sam.vilain@catalyst.net.nz>	<11831937822950-git-send-email-sam.vilain@catalyst.net.nz>	<11831937823588-git-send-email-sam.vilain@catalyst.net.nz> <7vejjte4wp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 00:30:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I57w7-0001o1-HN
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 00:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbXGAWaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 18:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXGAWaV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 18:30:21 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:50153 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbXGAWaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 18:30:20 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 1A58B15F3C1; Mon,  2 Jul 2007 10:30:16 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 687EA15F3C0;
	Mon,  2 Jul 2007 10:30:13 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <7vejjte4wp.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51326>

Junio C Hamano wrote:
> >  You can make interesting things happen to a repository
> > >  every time you push into it, by setting up 'hooks' there.  See
> > > -documentation for gitlink:git-receive-pack[1].
> > > +documentation for gitlink:git-receive-pack[1].  One commonly
> > > +requested feature, updating the working copy of the target
> > > +repository, must be enabled in this way.
>
> That is more like "could be", not "must be", and it is not the
> manpage's job to pass judgement on if a feature is often requested.

Ok, I'll just remove that clause.  Or do you think it perhaps belongs in
a NOTES or HINTS section?

>> +    if tree_in_revlog $ref $current_tree
>> +    then
> 
> Why should it behave differently depending on whether the index
> matches one of the arbitrary (i.e. taken from "tail" default)
> number of commits the user happened to be at in the recent past?
> If the check were "does it match with the HEAD", there could be
> a valid justification but this check does not make any sense to
> me.

Ok, well first we check that the index matches the working copy.  But if
there are staged changes which have not been committed, then the written
tree will (probably) not exist anywhere in the reflog for the current
branch, and we can stop.

Basically I'm trying to figure out "does the current index have any
uncommitted changes".  If it matches the tree from the previous (handful
of) ref(s), then the answer is "no".  If we can't find it anywhere then
it's probably got staged changes, and short of trying to move the
changes forward, we should stop.

>> +      if git-diff-index -R --name-status HEAD >&2 &&
>> +         git-diff-index -z --name-only --diff-filter=A HEAD | xargs -0r rm &&
>> +         git-reset --hard HEAD
> 
> I do not understand the first two lines at all.  Are you trying
> to lose working files for the paths that were added to the index
> since HEAD?  "git reset --hard HEAD" should take care of that
> already.

The first one simply displays what is happening to the working copy for
the benefit of the user.

The second is implementing something I for some reason thought git-reset
wasn't doing.

> But more importantly, why is it justified to throw away such
> files to begin with?

Because we've already previously decided that they are safely stowed in
a previous (via time/reflog) revision of the current branch.

>> +        echo "E:unexpected error during update" >&2
>> +      fi
>> +    else
>> +      echo "E:uncommitted, staged changes found" >&2
>> +    fi
>> +  else
>> +    echo "E:unstaged changes found" >&2
>> +  fi
> 
> I think this part is a good demonstration why pushing into a
> live branch should not attempt to update the working tree.  It
> sometimes happens, and it sometimes cannot (which is not your
> fault at all), but the indication of what happened (or did not
> happen) goes to the person who pushed the changes, not to the
> person who gets confusing behaviour if the index/worktree
> suddenly goes out of sync with respect to the updated HEAD.

One counter-argument to this is that you indicate that is the behaviour
that you want when you chmod +x the hook.  It should gracefully step out
of the way when people who currently set that hook active keep doing it.

But this problem exists without this hook, in fact it is far worse.  The
indication of what happened goes nowhere, and the person gets extremely
confusing behaviour when they commit.

Perhaps it would make sense to do this check in the "update" hook as
well, thereby chmod +x refuses to allow a push that touches the
currently checked out branch.  The check would then be run twice if both
hooks are enabled, unless the first one can signal success/verification
to the second somehow.

> The longer I look at this patch, the more inclined I become to
> say that the only part that is worth saving is the next hunk.
> 
>> -exec git-update-server-info
>> +  if [ -z "$success" ]
>> +  then
>> +    (
>> +    echo "Non-bare repository checkout is not clean - not updating it"
>> +    echo "However I AM going to update the index.  Any half-staged commit"
>> +    echo "in that checkout will be thrown away, but on the bright side"
>> +    echo "this is probably the least confusing thing for us to do and at"
>> +    echo "least we're not throwing any files somebody has changed away"
>> +    git-reset --mixed HEAD
>> +    echo
>> +    echo "This is the new status of the upstream working copy:"
>> +    git-status
>> +    ) >&2
>> +  fi
>> +fi
>> +done

I disagree; I think any half-measure is going to leave new users
horribly surprised by what happens, and if you just reset the index then
the staged commit is lost.

Sam.
