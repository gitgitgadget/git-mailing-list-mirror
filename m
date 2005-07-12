From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] tagger id
Date: Tue, 12 Jul 2005 09:04:23 -0600
Message-ID: <m14qb012x4.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
	<m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com>
	<m18y0c1prv.fsf@ebiederm.dsl.xmission.com>
	<7veka48lcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 17:08:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsML3-0000LN-2A
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 17:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVGLPGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 11:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGLPFp
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 11:05:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12186 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261533AbVGLPEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 11:04:42 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6CF4QhE022474;
	Tue, 12 Jul 2005 09:04:26 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6CF4N0Z022470;
	Tue, 12 Jul 2005 09:04:23 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7veka48lcw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 12 Jul 2005 01:44:15 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Should this default to git_author_ident or git_committer_ident?
>> I'm not really certain how we expect to use the different flavors.
>
> The only in-tree user after your patch is applied is the tagger
> stuff, so in that sense committer_ident may make more sense.

There is also the commit path, and that comes from C.  I'm not
quite certain how we should be using the environmental variables.

> Having said that, for something like this that would not be used
> constantly and interatively by the users, my preference is not
> to have any default at all, and always require --author or
> --committer.  You have to type a bit more when doing the script,
> but that needs to be done only once.  You will be sure which one
> you are asking from the command two weeks after you wrote the
> script so it is not a big loss.

Make sense.  Although I'm not quite certain we actually need the
information twice.  Possibly we just have GIT_AUTHOR_NAME and
GIT_AUTHOR_EMAIL, and then have commit-write take a flag to
override the author bit.  That would certainly make it less
confusing when setting up environmental variables for git.
And that would also give us a better name.

> I am not seriously suggesting the below as an alternative, but
> have you thought about doing an inverse function of your
> computation for the case when the user has all the environment
> variables, and have script eval its output, like this [*1*]:
>
>     $ git-id
>     GIT_AUTHOR_NAME='Junio C Hamano'
>     GIT_AUTHOR_EMAIL='junkio@cox.net'
>     GIT_COMMITTER_NAME='Junio C Hamano'
>     GIT_COMMITTER_EMAIL='junkio@cox.net'
>     $ eval "`git-id`"
>     $ tagger="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
>
> Having names and emails available separately may turn out to be
> easier to use in other situation.  Just a thought.

Part of the request was to put all of this information together
in a common place.  And note that it is actually:
tagger="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE"
Where the date is a human unreadable string of the number of seconds
since the epoch (aka 1 Jan 1970 UTC).

> By the way, I do not particularly like the name "git-id".  There
> could be IDs for different kinds (not just people) we would want
> later (file IDs, for example).  Naming what you are computing
> _the_ "id" feels a bit too generic.  I do not have a better
> alternative to suggest, though.

Agreed.  Something like git-author or git-author-stamp is probably
better.

> *1* This makes its output syntax a bit too specific to the shell
> and unfriendly to Porcelain written in other languages.  The
> only non-shell Porcelains I am aware of are done in Perl (I do
> not remember hearing its name) and Python (StGIT), both of which
> have reasonable regexp support to grok something like this, so
> it would not be a big issue.

And in git-commit-script this is actually parsed by sed which makes
it so the shell can parse the information as well so I think
we are fine in that sense.

Eric
