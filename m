From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 09:33:19 -0700
Message-ID: <7vvdmurfao.fsf@alter.siamese.dyndns.org>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:33:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGy4q-00017g-Un
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 18:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbZFQQdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 12:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbZFQQdS
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 12:33:18 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:33739 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbZFQQdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 12:33:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090617163320.EUDC2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jun 2009 12:33:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 54ZK1c00N4aMwMQ044ZKPo; Wed, 17 Jun 2009 12:33:19 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=YxPdjzc2vGsA:10 a=pGLkceISAAAA:8
 a=Ig78mY8V_9IrRM53NKUA:9 a=csUtR_38eKdGsupy9TOj7DpstfsA:4 a=MSl-tDqOz04A:10
 a=AfyOrcljuhh4hafP:21 a=O-yVj1OU2cQPWnJe:21
X-CM-Score: 0.00
In-Reply-To: <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> (John Tapsell's message of "Wed\, 17 Jun 2009 13\:55\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121757>

John Tapsell <johnflux@gmail.com> writes:

>> branch, hack, commit.
>> hack, commit, hack, commit
>
> What if you used  commit --append  instead?
>
> The trouble though of squashing all the commits into one is that it
> makes it impossible to bisect later.  Are you really sure that your
> final commit cannot be broken into small commits?  Ideally each commit
> is small but self contained.  Squashing should be done only to fix
> cases where you introduced a bug then fixed it, or to fix a partial
> implementation etc.

I think you meant --amend, but it often happens to me that after preparing
a three-patch series:

	[1/3] Clean up the surrounding code I will touch
        [2/3] Lay the groundwork
        [3/3] Implement a cool new feature

I find that there are more clean-up that should have been done in [1/3].
The way "rebase -i" expects me to work is:

	$ edit ;# more clean-ups
	$ git commit -a -m 'squash to "clean up"'
        $ git rebase -i HEAD~5

which will give me
        
        pick 1/3 Clean up ...
        pick 2/3 Lay the groundwork
        pick 3/3 Implement
        pick 4/3 squash to "clean up"

that I'll change to 

        pick 1/3 Clean up ...
        squash 4/3 squash to "clean up"
        pick 2/3 Lay the groundwork
        pick 3/3 Implement

and then I'll need to edit the commit message for the first two combined.
More than half of the time (but not necessarily all the time), the edit
involves just removing the single-liner 'squash to "clean up"',

You _could_ work this way instead using "amend".  Immediately after
finishing the three-patch series:

	$ git rebase -i HEAD~4

which gives me

        pick 1/3 Clean up ...
        pick 2/3 Lay the groundwork
        pick 3/3 Implement

that I'll change to

        edit 1/3 Clean up ...
        pick 2/3 Lay the groundwork
        pick 3/3 Implement

and then perform extra clean-up when "rebase -i" let's me amend the first
one.

But this is much less convenient than being able to accumulate fix-ups as
separate commits on top of the mostly finished main series, and then being
able to later insert these fix-ups into the main series to be squashed
using "rebase -i", if (and only if) what you need to do are many small
fixups (imagine there are not just a single '[4/3] squash to "clean up"'
but a lot more fix-up commits in the above example).  Depending on the
style you work, "go back to amend" is Ok, or you may even prefer to.  But
some people do not switch context as rapidly as others.  After finding a
small "missed piece", having to go back to edit and come back is much more
heavyweight operation than being able to make a small "fix-up" commit on
top and keep going.  The latter keeps your thought process less disrupted.

And it is very likely that the "small fixups" won't change what the
original commit log message of the commit in the main needs to say
(otherwise they won't be "small").

So I can see why a variant of "squash" that does not change (nor even ask
for a replacement of) the commit log message from the one that is being
amended could be useful.  I am tempted to suggest calling that a "fixup"
operation, but some people may expect "fixup" to mean a variant of "edit"
that does not bother you by dropping you back to the shell to touch the
tree that is recorded (i.e. "fixing up the commit log message only"), so
it is not a very good word.
