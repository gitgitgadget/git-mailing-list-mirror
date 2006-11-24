X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Thu, 23 Nov 2006 21:47:21 -0800
Message-ID: <7vzmahe6qe.fsf@assigned-by-dhcp.cox.net>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
	<20061123234203.GN7201@pasky.or.cz>
	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 05:47:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vlkm1hf57.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 23 Nov 2006 16:17:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32188>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnTuK-0006sk-F7 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 06:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934430AbWKXFrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 00:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934431AbWKXFrZ
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 00:47:25 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36241 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S934430AbWKXFrY
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 00:47:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124054722.LACW9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 00:47:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qVnV1V00W1kojtg0000000; Fri, 24 Nov 2006
 00:47:30 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> I agree --bare should continue to be a "snapshot mirror"; I am
> not advocating for the removal of the internal implementation
> detail such as $use_separate_remote variable.
>
> However, I think having one sane behaviour is the right thing to
> do for a clone that prepares a repository with a working tree
> (including the one made with -n option, which only means "do not
> do the check-out immediately after cloning" for such a
> repository).

Just to let you know, I'll take the patch almost as is (even
with the --use-immingled-remote), except with a slight rewording
in the documentation to warn people that the backward
compatibility option will be removed before the next major
release.

However, this simple command fails:

	$ git push $URL master

if the target repository $URL is made with use-separate-remote.

This is because 'master' matches more than one on the remote
side (heads/master and remotes/origin/master) which triggers
"Hey, that's ambiguous, make yourself clear which one you mean!"
check.  This breaks t5400 test.  We could "fix" the test to make
it more explicit, but that is just a workaround.

I think the send-pack/receive-pack pair needs to be taught that
an unadorned branch name 'master' never matches anything under
refs/remotes. This means that it would require an explicit
refspec heads/master:remotes/origin/master in order to pudate
refs under refs/remotes on the remote side with a push.  I do
not think that is a big problem, because the normal patch-flow
for shared repository workflow is:

	remote			local

		      (fecth)
	heads/master	--->	remotes/origin/master ---.
							 | (merge)
	heads/master	<---	heads/master	      <--'

and pushing into remotes/origin/* is not a norm.

The function to fix is connect.c::match_explicit_refs() and I
_think_ making connect.c::count_refspec_match() not to consider
'foo' to match 'refs/remotes/origin/foo' (but still keeping it
to match 'refs/heads/foo' or 'refs/tags/foo') is enough to make
this happen.

This brings up two related issues.  Currently we automatically
prepare "Pull: refs/heads/$branch:refs/remotes/origin/$branch"
for all branches that exists at the remote site when a clone
happens.  Andy Parkins has a patch to allow a glob pattern to be
there, like this [*1*]:

	Pull: refs/heads/*:refs/remotes/origin/*

which makes sense, and we might want to have this as the default
after the clone [*2*].

Another is if we might want to add "Push: " entry in the default
after the clone.  I am a bit reluctant to make the default setup
too specific to CVS style "central shared repo" workflow, but
any stupid default would not suit people with truly distributed
workflow anyway, so it might be fine.

[Footnotes]

*1* I rewrote the patch because I wanted to deal with the
    fallout from recent packed-refs work at the same time.  So bugs
    in the counter-proposal patch is mine while the credit for the
    initiative and the idea goes to Andy.

*2* I think the fetch wildcarding has an issue with what remote
    head to merge when used with "git pull".  I think it should
    use the one that is pointed at by refs/remotes/origin/HEAD,
    but there is no code for that yet.  Hints, hints...


