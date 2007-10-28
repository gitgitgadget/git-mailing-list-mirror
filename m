From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/8] push: change push to fail if short ref name does not exist
Date: Sun, 28 Oct 2007 09:43:13 +0100
Message-ID: <9C8E1C6D-8DC1-4B32-AB78-1D97D3F44447@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <7vabq3wvd6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 09:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im3il-0003sv-Oo
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 09:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXJ1Il5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 04:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXJ1Il5
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 04:41:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:32929 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbXJ1Ilz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 04:41:55 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9S8fljG015218;
	Sun, 28 Oct 2007 09:41:47 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9S8fklC000459
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 09:41:46 +0100 (MET)
In-Reply-To: <7vabq3wvd6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62540>


On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> You can use a branch's shortname to push it. Push used to create
>> the branch on the remote side if it did not yet exist. If you
>> specified the wrong branch accidentally it was created. A safety
>> valve that pushes only existing branches may help to avoid
>> errors.
>
> I do not agree with this change.
>
> If you misspelled the branch name (by the way, it is not a
> "shortname", but what follows refs/heads/ is _the_ name of the
> branch)

True. Is "short refname" the correct wording?


> "frotz" as "frtoz", and if a branch with the misspelled
> name did _not_ exist locally, it would fail, with or without
> this change, which is a good thing.
>
> But if you named "nitfol" that exists locally when you meant to
> push "frotz" out, if "nitfol" remotely existed, we will push
> that anyway by mistake, even with this change.  It will prevent
> the push only when "nitfol" did not happen to exist at the
> remote side.

My proposed change is more defensive than the current
implementation. It allows distinguishing between "push existing
branch" and "create new branch on the remote side", which I
believe is a good thing. The current implementation uses
the same command line in both cases.

Daniel suggested that git push should print a recommendation
what full ref to use. This would make it easy to correct
the command. Ot you could use the '--create' flag to make
your intention explicit.

If we take the "push origin HEAD" patch, the existence check is
even more important. If you're on the wrong branch and push HEAD
you may be surprised if a new branch is created. This can be
avoided by requiring either a full ref or the '--create' flag.


> Earlier there was a discussion to introduce an optional
> configuration that makes "git push" without any parameter to
> push only the current branch out, in order to help people who
> work with shared remote central repository.  That might be a
> better alternative to avoid pushing out wrong branch by
> mistake.  That approach would also make your 8/8 unnecessary.

I didn't have the impression that the discussion went in
this direction. There were quite a few people who just said
"git push" is the counter-part of "git fetch". Therefore
"git push" pushes _all_ branches. Period.

With "git push HEAD" 5/8 you could now push only the current branch
(its existence would be verified if 1/8 is also accepted).

8/8 solves a different issue, too. I never advance local branches if
I do not intend to push them. Therefore I can always say "git push"
without any argument. It does always the right thing for me; except
for the annoying error messages that are avoided by 8/8. With 8/8
I can push several local branches while ignoring the ones that I'm
not interested in.

	Steffen
