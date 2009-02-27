From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Fri, 27 Feb 2009 11:42:47 +0100
Message-ID: <49A7C3A7.6060202@drmicha.warpmail.net>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com> <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net> <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org> <49A66057.1050501@drmicha.warpmail.net> <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 11:44:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld0Cl-00059z-Ld
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 11:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148AbZB0KnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 05:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757062AbZB0KnA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 05:43:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47807 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756230AbZB0Km6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 05:42:58 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 948FE2A408C;
	Fri, 27 Feb 2009 05:42:55 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 27 Feb 2009 05:42:55 -0500
X-Sasl-enc: 6/1764Go2iGIG3uq/OzwV2bS85C53ou9o270SlsA2KFB 1235731375
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8A5B04F265;
	Fri, 27 Feb 2009 05:42:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090227 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111659>

Junio C Hamano venit, vidit, dixit 26.02.2009 18:09:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> First of all: I define good/bad as matching the documentation.
> 
> Ok, I was primarily working from this:
> 
> commit bcc785f611dc6084be75999a3b6bafcc950e21d6
> Author: Linus Torvalds <torvalds@osdl.org>
> Date:   Mon Oct 30 08:28:59 2006 -0800


[snip]
> You will see that:
> 
>  (1) bf07cc5 (i.e. J6t's documentation) passes your tests;

Hmm, I don't see that, we must be doing something differently, see below.

>  (2) somewhere between that and v1.6.2-rc2, there is a regression to make
>      your test fail.
> 
> if the above conjecture is true, and we may want to fix that regression to
> match the documentation.
> 
> On the other hand, if bf07cc5 does not pass your tests, it means that the
> documentation update was the cause of the confusion, and it is not the
> behaviour that needs to be fixed.
> 
> Sorry, but I do not have time today to look into this.  Could you help?

I'll try and provide the necessary info below, but I think there is a
decision to be made about the desired order of priorities for "repo
argument", "repo option (--repo=)" and "tracking info config
(branch.$branch.remote=)".

Current code: argument > option > track config > 'origin'
Current doc: argument > track config > option > 'origin'

I'd say the documented version is more natural, meaning --repo=$repo is
fully equivalent to changing "origin" to "$repo".

Now, here's if you want to know the details:

When Linus introduced "--repo" there was no heeding of the tracking info
at all:

bcc785f (git push: add verbose flag and allow overriding of default
target repository, 2006-10-30) Linus introduces --repo.

5751f49 (Move remote parsing into a library file out of builtin-push.,
2007-05-12) Daniel Barkalow introduces the use of branch.$branch.remote
info for the repo if git push has no other repo arguments nor --repo
options.

378c483 (Use parseopts in builtin-push, 2007-11-04) Daniel switches
git-push to parseopts, without changing the behaviour.

bf07cc5 (git-push.txt: Describe --repo option in more detail,
2008-10-07) J6t writes the current version of the doc.

Using a trimmed down ./t5516-fetch-push.sh from my patch (and a copy of
current test-lib), all 4 of them give the same results:

*   ok 1: setup
*   ok 2: push with --repo=repourl from non-tracking branch
*   ok 3: push with --repo=remoterepo from non-tracking branch
* FAIL 4: push with --repo=repo from tracking branch with bad config


                mk_test heads/master &&
                git config branch.master.remote origin &&
                test_must_fail git push --repo=testrepo

* FAIL 5: push with --repo=repo from tracking branch with good config


                mk_test heads/master &&
                git config branch.master.remote testrepo &&
                git push --repo=origin &&
                check_push_result $the_commit heads/master

[testrepo exists, origin does not]

Note that bcc785f was not even supposed to heed the value of
branch.master.remote, so it's clear they fail 4&5. 2&3 only test whether
--repo is considered if there's no other info, so it's clear they pass
(versions without bcc785f would fail).

Cheers,
Michael
