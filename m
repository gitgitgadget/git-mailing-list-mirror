From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: let command-line options override saved options
Date: Tue, 28 Jul 2015 10:09:59 -0700
Message-ID: <xmqqegjsfbtk.fsf@gitster.dls.corp.google.com>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
	<20150724180921.GA17730@peff.net>
	<CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
	<xmqq8ua1k7fc.fsf@gitster.dls.corp.google.com>
	<20150728164311.GA1948@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:10:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK8OH-0001av-Tq
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbG1RKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:10:03 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36219 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbG1RKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 13:10:01 -0400
Received: by pachj5 with SMTP id hj5so72712261pac.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=z2WOQIKXnpdZ/jz7lbvjJv/kt05i0zPPLtjaZIr+8Ts=;
        b=HbRHh90x3mABCWgYc/z3RJwApkX2LUjv5MQLbv/C0kJifEYikzMNgX196l9dxNjn8g
         vDVz1s68F1qtf5In/Wa1Ffr8K/Bxo8ZweY/zAiXCuTLAkxW0Todf5vMkdd0P2Qx6FBx+
         fG7qB090Urwm0qYOri6wVjitDl534bDM85dZBcZICKqu3emtSQ9whj9C6QDzjDm5FkuE
         QnhyqPaS/4G2nY9eZOLyDPInax5Q2aBfkwM1N9//xUTg/kFY9xtSQB5ZB4A+z2UyUscC
         R3CpX3kteEiUo1FeCQwE811BP2+UvQW6+Kdkuiuf8MJB03M8ifdAH7VJETd48S2cQw2V
         hB+w==
X-Received: by 10.66.245.142 with SMTP id xo14mr81362180pac.151.1438103401202;
        Tue, 28 Jul 2015 10:10:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id rh11sm36211913pdb.22.2015.07.28.10.09.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 10:09:59 -0700 (PDT)
In-Reply-To: <20150728164311.GA1948@yoshi.chippynet.com> (Paul Tan's message
	of "Wed, 29 Jul 2015 00:43:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274792>

Paul Tan <pyokagan@gmail.com> writes:

> diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
> new file mode 100755
> index 0000000..c49457c
> --- /dev/null
> +++ b/t/t4153-am-resume-override-opts.sh
> @@ -0,0 +1,144 @@
> +#!/bin/sh
> +
> +test_description='git-am command-line options override saved options'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit initial file &&
> +	test_commit first file &&
> +
> +	git checkout -b side initial &&
> +	test_commit side-first file &&
> +	test_commit side-second file &&
> +
> +	{
> +		echo "Message-Id: <side-first@example.com>" &&
> +		git format-patch --stdout -1 side-first | sed -e "1d"
> +	} >side-first.patch &&

Hmm, puzzled...  Ah, you want to make sure Message-Id comes at the
very beginning, and you are going to use a single e-mail per mailbox
so it is easier to strip the Beginning of Message marker than to
insert Message-Id after it.  I can understand what is going on.

> +	{
> +		sed -ne "1,/^\$/p" side-first.patch &&

sed -e "/^\$/q" would work just as well here

> +		echo "-- >8 --" &&
> +		sed -e "1,/^\$/d" side-first.patch
> +	} >side-first.scissors &&

So *.scissors version has -- >8 -- inserted at the beginning of the
body.

> +	{
> +		echo "Message-Id: <side-second@example.com>" &&
> +		git format-patch --stdout -1 side-second | sed -e "1d"
> +	} >side-second.patch &&
> +	{
> +		sed -ne "1,/^\$/p" side-second.patch &&
> +		echo "-- >8 --" &&
> +		sed -e "1,/^\$/d" side-second.patch
> +	} >side-second.scissors
> +'

A helper function that takes the branch name may be a good idea,
not just to consolidate the implementation but as a place to
document how these pairs of files are constructed and why.

> +test_expect_success '--3way, --no-3way' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	test_must_fail git am --3way side-first.patch side-second.patch &&
> +	test -n "$(git ls-files -u)" &&
> +	echo will-conflict >file &&
> +	git add file &&
> +	test_must_fail git am --no-3way --continue &&
> +	test -z "$(git ls-files -u)"
> +'
> +
> +test_expect_success '--no-quiet, --quiet' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	test_must_fail git am --no-quiet side-first.patch side-second.patch &&
> +	test_must_be_empty out &&

Where did this 'out' come from?

> +	echo side-first >file &&
> +	git add file &&
> +	git am --quiet --continue >out &&
> +	test_must_be_empty out

I can see this one, though I am not sure if it is sensible to see
what the command says under --quiet option, especially if you are
making sure it does not fail, which you already have checked for its
exit status.

> +'
> +
> +test_expect_success '--signoff, --no-signoff' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	test_must_fail git am --signoff side-first.patch side-second.patch &&
> +	echo side-first >file &&
> +	git add file &&
> +	git am --no-signoff --continue &&
> +
> +	# applied side-first will be signed off
> +	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
> +	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
> +	test_cmp expected actual &&
> +
> +	# applied side-second will not be signed off
> +	test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
> +'

Hmm, the command was run with --signoff at the start, first gets
applied with "am --no-signoff --resolved" so I would expect it does
not get signed off, but the second one will apply cleanly on top, so
shouldn't it get signed off?  Or perhaps somehow I misread Peff's
idea to make these override one-shot in $gmane/274635?
