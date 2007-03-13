From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 13 Mar 2007 12:43:51 -0700
Message-ID: <7vhcsphqtk.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	<7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>,
	Santi =?utf-8?B?Qu+/ve+/vWphcg==?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 20:44:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRCud-0000QM-SS
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 20:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbXCMTn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 15:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbXCMTn4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 15:43:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60324 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbXCMTnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 15:43:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313194352.RIOC748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Mar 2007 15:43:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aKjs1W00R1kojtg0000000; Tue, 13 Mar 2007 15:43:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42145>

Junio C Hamano <junkio@cox.net> writes:

> Here are the topics that have been cooking.

> * sb/fetch (Mon Mar 12 19:01:11 2007 -0700) 19 commits
>  + git-fetch.sh:append_fetch_head() no longer has a remote_nick
>    argument
>  + git-fetch: Split fetch and merge logic
>
> I have a soft spot to anything that claims to be a clean-up, but
> I suspect that the shell loop this series introduces may defeat
> the git-fetch--tool optimization.  Also I think having to base
> the patch on this made Paolo's "dot is special token to mean
> 'git pull' merges from a local branch" needlessly complex (but I
> haven't tried rewriting it myself without these two).  Although
> I merged these to 'next', I am considering to revert them.

I tried the "NULL fetch between 1000-refs repositories" test,
which prompted the git-fetch--tool work that was done on
jc/fetch topic in 'next', with the following versions:

 (1) 1.5.0 (without any git-fetch--tool optimization)
 (2) master (ditto)
 (3) master with jc/fetch (but not sb/fetch topic)
 (4) next ((3) plus sb/fetch and others)

The test scripts are at the end of this message.  Both (1) and
(2) take 3 minutes 7 seconds wallclock time.  (3) improves it
down to 15 seconds.  (4) makes the operation spend 24 seconds
(the times are all on my primary machine x86-64 with 1GB, hot
cache and average of three runs each).

So the "Split fetch and merge" series hurts the performance
quite a bit.  If it had enough "code clean-up" merit to warrant
this, I would say it probably is a cost we should bear, but I
personally do not see it.

Paolo recently worked on top of next to base the fake '.' remote
patch.  This wants to allow:

	[branch "foo"]
        	remote = .
                merge = refs/heads/master

with an implicit (meaning, you do not have to have this in your
configuration):

	[remote "."]
        	url = .
                fetch = refs/*

so that you can say:

	$ git checkout foo
        $ git pull

to merge from the local 'master' branch.

I haven't reimplemented Paolo's patch on top of (3) above for
comparison, but I have a feeling that it would not have been
helped by the alleged clean-up value of "Split fetch and merge"
patch (iow, I do not think it would be the case that the code
got clearer to understand thanks to the clean-up).

What Paolo's patch needs to do is to bypass the actual fetch and
generate the following line in .git/FETCH_HEAD:

	sha1-of-our-master <TAB> <TAB> branch 'master' of .

I even suspect that "Split fetch and merge", by introducing
FETCH_FETCHED and making FETCH_HEAD generated from it, made
Paolo's patch more difficult to do and the end result less
efficient.

So unless there is a convincing counterexample otherwise, I'd
like to revert the "Split fetch and merge" series.


-- >8 -- setting up test repositories -- >8 --
#!/bin/sh

rm -fr origin clone

mkdir origin
cd origin
git init
: >hello
git add hello
git commit -a -m 'initial'
i=0
while test $i -lt 500
do
	git tag t$i
	git branch b$i
	i=$(($i+1))
done

: >bye
git add bye
git commit -a -m 'second'
while test $i -lt 1000
do
	git tag t$i
	git branch b$i
	i=$(($i+1))
done

cd ..
-- >8 -- NULL fetch test -- >8 --
#!/bin/sh

cd clone
echo '* fetching'
time git fetch origin
