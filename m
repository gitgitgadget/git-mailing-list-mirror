From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 17/17] revert: Introduce --continue to continue the
 operation
Date: Tue, 12 Jul 2011 15:46:50 -0500
Message-ID: <20110712204650.GG14909@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-18-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 22:47:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgjrM-0001Q5-Ch
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 22:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab1GLUrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 16:47:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45185 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab1GLUq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 16:46:59 -0400
Received: by iwn6 with SMTP id 6so4971991iwn.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JNNaxGhDkaBfDovyUWWrUusMAchQO+BK1NuRj0etH1o=;
        b=WCQAqO9eQtwevPddHFcelDhc4PkDokItg4lUK/XFGUzhtwAva++i0ByC1EGd4hwCHD
         qrFhcV0NMmAqtJuINBAYY8PU+oX628nY6RHALcgRx6oLfRXkbvKo+NST5WafVnyjQEj5
         d1q7MV7veqPfH2+UXKcKoOeX+YhY6uGXerlA8=
Received: by 10.231.114.206 with SMTP id f14mr275584ibq.104.1310503618457;
        Tue, 12 Jul 2011 13:46:58 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id q13sm5972857ibi.9.2011.07.12.13.46.56
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 13:46:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-18-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176979>

Ramkumar Ramachandra wrote:

> Using the information in ".git/sequencer", it is now possible to
> continue a cherry-pick or continue after a conflict.  To do this, we
> have to parse the information in ".git/sequencer/opts" into the
> replay_opts structure and
[...]

Might be simpler to say:

	Introduce a new "git cherry-pick --continue" command which uses
	the information in ".git/sequencer" to continue a cherry-pick that
	stopped because of a conflict or other error.  It works by dropping
	the first instruction from .git/sequencer/todo and performing the
	remaining cherry-picks listed there, with options (think "-s" and
	"-X") from the initial command listed in .git/sequencer/opts.

	So now you can do:

		$ git cherry-pick -Xpatience foo..bar
		... description conflict in commit moo ...
		$ git cherry-pick --continue
		error: 'cherry-pick' is not possible because you have unmerged files.
		fatal: failed to resume cherry-pick
		$ echo resolved >conflictingfile
		$ git add conflictingfile && git commit
		$ git cherry-pick --continue; # resumes with the commit after "moo"

> During the "git commit" stage, CHERRY_PICK_HEAD will aid by providing
> the commit message from the conflicting "moo" commit.  Note that the
> cherry-pick mechanism has no control at this stage, so the user is
> free to violate anything that was specified during the first
> cherry-pick invocation.  For example, if "-x" was specified during the
> first cherry-pick invocation, the user is free to edit out the message
> during commit time.  One glitch to note is that the "--signoff" option
> specified at cherry-pick invocation time is not reflected in the
> commit message provided by CHERRY_PICK_HEAD; the user must take care
> to add "--signoff" during the "git commit" invocation.

The -s thing doesn't have much to do with this change.  But is it a
bug or not?  If it's not a bug, then this is not so much a glitch to
note as an important feature to ensure people don't sign off on a
conflict resolution without thinking about it.  (I guess I think it's
a bug.  It's hard to decide.)

> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -101,4 +101,97 @@ test_expect_success '--reset cleans up sequencer state' '
[...]
> +test_expect_success '--continue complains when no cherry-pick is in progress' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick --continue >actual 2>&1 &&
> +	test_i18ngrep "error" actual

This would start to fail if the message ever changed from "error" to
"fatal", right?  I don't think that's a good thing.

> +test_expect_success '--continue complains when there are unresolved conflicts' '
> +	pristine_detach initial &&
> +	head=$(git rev-parse HEAD) &&
> +	test_must_fail git cherry-pick base..picked &&
> +	test_must_fail git cherry-pick --continue &&
> +	git cherry-pick --reset
> +'
> +
> +test_expect_success '--continue continues after conflicts are resolved' '
> +	pristine_detach initial &&
> +	head=$(git rev-parse HEAD) &&

How is $head used?

> +	test_must_fail git cherry-pick base..anotherpick &&
> +	echo "c" >foo &&
> +	git add foo &&
> +	git commit &&
> +	git cherry-pick --continue &&
> +	test_path_is_missing .git/sequencer &&
> +	{
> +		git rev-list HEAD |
> +		git diff-tree --root --stdin |
> +		sed "s/[0-9a-f]\{40\}/OBJID/g"
> +	} >actual &&

$_x40 is idiomatic and safer with old seds.

> +test_expect_success '--continue respects opts' '
> +	pristine_detach initial &&
> +	head=$(git rev-parse HEAD) &&
> +	test_must_fail git cherry-pick -s -x base..anotherpick &&
> +	echo "c" >foo &&
> +	git add foo &&
> +	git commit -s &&
> +	git cherry-pick --continue &&
> +	test_path_is_missing .git/sequencer &&
> +	git cat-file commit HEAD >anotherpick_msg &&
> +	git cat-file commit HEAD~1 >picked_msg &&
> +	git cat-file commit HEAD~2 >unrelatedpick_msg &&
> +	git cat-file commit HEAD~3 >initial_msg &&
> +	test_must_fail test_i18ngrep "Signed-off-by:" initial_msg &&

This will break when GETTEXT_POISON is set --- test_i18ngrep
automatically succeeds in that case.

Is "Signed-off-by" meant to be translated anyway?  I would use

	! grep

if testing that.

By the way, that probably should go in a separate test assertion
("-s is not automatically propagated to resolved conflict") to make
it easier to change the behavior later.
