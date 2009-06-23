From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 10:51:58 -0700
Message-ID: <7vprcu96td.fsf@alter.siamese.dyndns.org>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org>
	<4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org>
	<4A40D864.8040208@gmail.com> <20090623144805.GB24974@pvv.org>
	<f865508f0906230932n4a2f2b54s1e76ab1d70d95073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Tue Jun 23 19:52:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJAA9-00041f-Kg
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 19:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbZFWRv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 13:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbZFWRv6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 13:51:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61949 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbZFWRv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 13:51:56 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090623175158.NCHF18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Tue, 23 Jun 2009 13:51:58 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 7Vry1c00C4aMwMQ04Vryh7; Tue, 23 Jun 2009 13:51:58 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=B1Z8y4ogzYsUjm66qG8A:9
 a=_97t4PA9bHraRmmF9cMA:7 a=X2Zt6Jd6lIMsEDz0DmschGxowf0A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <f865508f0906230932n4a2f2b54s1e76ab1d70d95073@mail.gmail.com> (Paolo Bonzini's message of "Tue\, 23 Jun 2009 18\:32\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122105>

Paolo Bonzini <paolo.bonzini@gmail.com> writes:

>> If a group sets up a shared public branch, it is typically for
>> working together on some feature.
>>
>> For people used to CVS, this is a nice way to start working with git.
>> It requires --tracking to work properly though (--current only works
>> if you remember to use the same branch name).
>
> Ok, this *is* a usecase.  Your local branch is named as a feature but
> it pushes into master.  Thanks, I have something to reason about now.
> :-)

I actually have been having a hard time imagining how such a set-up makes
sense, even during your absense (i.e. the timeframe we did push.default).

You are forking off of shared 'master', but you are developing a feature
on a separate branch 'feature'.

That is a sane thing to do for two reasons.  (1) Until 'feature' is done
to your own satisfaction, you do not want to contaminate your own 'master'
with the half-cooked feature development in it. (2) While you are working
on 'feature', you may want to update your own 'master' from the shared
repository to monitor how others are doing.  Having a separate, pristine
'master' branch allows you to do so more easily, than detaching HEAD at
'origin/master' every once in a while.

However, when 'feature' is fully cooked, before pushing it back to be
shared with others in the group, don't you do any testing with the work
done by others while you were working on 'feature'?  That means you first
integrate your 'feature' locally into shared 'master' and make sure all
fits together well.

Until you do that, you cannot be confident that the feature you developed
is fit for public consumption.  But if you test after merging 'feature'
into 'master', what you determined as good is in 'master', which you can
push back to the remote's 'master'.

One glitch I can think of is what would happen if you do not want to merge
your feature for final testing to master, but instead rebase your feature
on top of master (let's not discuss why you should or should not rebase at
this point; some projects seem to insist you rebase and there may be no
good technical reason but that is not the topic here).  There currently is
no easy UI other than:

	$ git checkout master
        $ git pull --rebase . feature
	$ test test test
	$ git push origin master

or even worse:

	$ git checkout feature
        $ git rebase master
        $ git checkout master
        $ git merge feature
	$ test test test
	$ git push origin master

to tell git to integrate your local work done in 'feature' to 'master' by
rebasing, instead of merging.  If you do a merge, that is quite
straightforward:

	$ git checkout master
        $ git merge feature
	$ test test test
	$ git push origin master

but instead you have to do something like:

	$ git checkout feature
        $ git rebase master
        $ test test test
        $ git push origin feature:master

and you end up needing "put my 'feature' into their 'master'".

Could it be possible that this desire to push "tracking" is not a cure for
anything real, but merely a kludge to work around a misfeature of "rebase"
UI that does not allow "integrate that branch here but do not merge it but
by first rebasing it"?  In other words, if we had "git merge --rebase" (I
know, I know, it is a terrible name.  The word "merge" in this context
means "to integrate"), the above can be done more naturally:

	$ git checkout master
        $ git merge --rebase feature
	$ test test test
	$ git push origin master

and the matching push (or "git push origin HEAD") becomes the right thing
to do, eliminating the need for "put my 'feature' into their 'master'".

For a group that sets up a shared public branch to be used for working
together on some feature, replace 'master' with 'some feature' above, and
'feature' with 'your part of the work on the feature'; the story is the
same.
