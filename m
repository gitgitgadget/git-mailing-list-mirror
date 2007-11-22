From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 22 Nov 2007 00:23:39 -0800
Message-ID: <7vd4u28z90.fsf@gitster.siamese.dyndns.org>
References: <20071121105517.GA11875@denkbrett.schottelius.org>
	<7vabp79hjt.fsf@gitster.siamese.dyndns.org>
	<C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:24:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7Lz-0004io-1K
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbXKVIXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 03:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbXKVIXq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:23:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58932 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbXKVIXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 03:23:46 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BAE662EF;
	Thu, 22 Nov 2007 03:24:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 206089756A;
	Thu, 22 Nov 2007 03:24:03 -0500 (EST)
In-Reply-To: <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de> (Steffen Prohaska's
	message of "Thu, 22 Nov 2007 08:08:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65752>

Steffen Prohaska <prohaska@zib.de> writes:

> On Nov 22, 2007, at 2:48 AM, Junio C Hamano wrote:
> ...
>> An alternative could be to split [remote "name"] url into two
>> variants, fetch-url and push-url.  While fetching by default
>> from two places without telling from which one does not make any
>> sense, pushing by default to two different places is quite a
>> normal thing to do, and we already do support more than one url
>> entries in [remote "name"] section used for pushing.
>>
>> If we were to do this, it might also make sense to rename the
>> word 'origin' we use for the default remote name to 'default' or
>> something.  People with shared repository workflow would fetch
>> from one repository and push back to the same repository, so the
>> distinction would not matter, but for others who need something
>> like you suggest, the default repository for fetching and
>> pushing are different, and while you may still consider where
>> you fetch from your 'origin', where you push into is not your
>> 'origin' anymore.
>
> I like this idea.
>
> But in addition, we should have a branch.$name.push line that
> can contain a remote head to push to.

Yes, but.

At that point, I think you would introduce a mismatch between
the traditional semantics of refspec and what you are trying to
do, unless you are careful.

The traditional semantics of refspecs-tied-to-remote is strongly
based on the assumption: "I will push to this remote when these
local branches are all ready to be pushed out, and they will all
go there together as an atomic update.  When I am _that_ ready
to push, it does not matter which local branch I am on.  The
branches that matter are all in good shape when I push."

You are making the behaviour of push dependent on which branch
you are on.  During such a push, it is safe to assume that the
current branch is ready to be pushed out, but other ones can be
very much un-ready.  The user needs a safety valve to prevent
other branches from being pushed out.  Otherwise the user would
not be adding branch.$name.push to begin with.

It would probably need to become a target ref or a list of <URL,
target ref>, not a list of general refspecs like the value for
remote.$there.push variable.  For example, you would want to say
"while on master, push it to repository A as refs/heads/master
and to repository B as refs/remotes/satellite/master", which
would be a typical arrangement if you are working on a satellite
machine, A is the shared central repository and B is mothership
to your satellite machine.  The specification would talk only
about the target ref (not just "'can contain' a remote head to
push to"), and the source ref would always be the current
branch.

I guess you could use general refspec on branch.$name.push and
implement the safety by requiring (1) only one refspec appears
for such a variable, and (2) the LHS of the refspec matches the
$name of the branch, in order to make the parsing easier and to
keep the syntax uniform.

Or maybe I am being overly cautious again not to introduce any
more unnecessary user confusion, and just should give them even
longer rope to hang themselves.  I dunno.
