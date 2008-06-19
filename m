From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as 
 errors.
Date: Thu, 19 Jun 2008 11:33:12 -0700
Message-ID: <7vhcbpuvfb.fsf@gitster.siamese.dyndns.org>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org>
 <20080619133747.GA31209@sigill.intra.peff.net>
 <20080619135159.GA19560@artemis.madism.org>
 <20080619151110.GA31654@sigill.intra.peff.net>
 <20080619162801.GA2468@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:34:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Oxk-0005ML-O5
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbYFSSd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755074AbYFSSd0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:33:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089AbYFSSd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:33:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 68DB91B731;
	Thu, 19 Jun 2008 14:33:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 361C11B730; Thu, 19 Jun 2008 14:33:15 -0400 (EDT)
In-Reply-To: <20080619162801.GA2468@artemis.madism.org> (Pierre Habouzit's
 message of "Thu, 19 Jun 2008 18:28:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 324AD382-3E2E-11DD-AEA4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85508>

Pierre Habouzit <madcoder@debian.org> writes:

> On Thu, Jun 19, 2008 at 03:11:10PM +0000, Jeff King wrote:
>> On Thu, Jun 19, 2008 at 03:52:00PM +0200, Pierre Habouzit wrote:
>> > >   - there is a possible danger with "git push -f", in that you force
>> > >     both rejected branches as well as stale branches. Junio and I
>> >   Well afaict this is a separate issue, as we're (with such a patch)
>> > only changing what gets printed on the console, not the internal
>> > behavior. So solving this second issue should not really be a
>> > precondition to the inclusion of such a patch.
>> 
>> It is a separate issue, but it is exacerbated by hiding stale refs.
>> Imagine:
>> 
>> $ git push
>> To /path/to/repo
>>    ! [rejected]        master -> master (non-fast forward)
>> 
>> $ git push -f
>> To /path/to/repo
>>    + 0abfa88...c1ed93b master -> master (forced update)
>>    + 0329485...3498576 stale_branch -> stale_branch (forced update)
>> 
>> I think that is a nasty surprise to spring on an unsuspecting user.
>> Another solution might be "-f" not pushing rewound branches, but then we
>> need a way to specify "no, really, push this rewound branch". Perhaps
>> "-f -f"?
>
>   Well then we could keep the [stalled] lines for now until this issue
> is resolved then, despite what the people at the beginning of the other
> thread complained about. My real issue is that I have my shell
> configured so that my prompt becomes inverted if the last command
> failed. So do many people I know, and well, git push for stalled
> references should just not generate an error. _this_ is my sole concern
> :)

There are two cases the push does not fast forward.  The case where you
are truly behind (aka "stale") and you and the pushed-to repository have
diverged history.  Reporting success when you did not push due to the
latter is unacceptable.  I personally rely on the fast-forward safety in
my push-out scripts, but I do not think it is just me.  The exit status from
commands are designed to be used that way.

The issue of "many refs in the repo but I work only on a few" has already
been resolved by being able to say "I push only the current branch" in the
previous thread, I think, but I am too busy to go back to re-study the
history, so could you kindly do that for us?

The thing is, the user asked to push certain refs, and some did not get
updated.  The user has the right to expect a failure indication from the
command.  If you choose to _ignore_ the failure, that is _your_ choice,
like:

	$ git push || :

You might argue that the case where you are truly behind _could_ be
ignored and pretend as if the user did not even _ask_ to push it (hence,
return success without doing anything to that branch), but I am not
convinced even that is a good idea.
