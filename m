From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] reflog-walk: don't segfault on non-commit sha1's in
 the reflog
Date: Tue, 5 Jan 2016 20:05:46 -0500
Message-ID: <CAPig+cRufd4qOwZRpw2TR39npkRGg=7S+7YwfSu6EvRR95kRSA@mail.gmail.com>
References: <1451552227.11138.6.camel@kaarsemaker.net>
	<20160105211206.GA12057@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:06:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGcY6-0001cf-0o
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 02:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbcAFBFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 20:05:48 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36069 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbcAFBFr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 20:05:47 -0500
Received: by mail-vk0-f66.google.com with SMTP id a185so20093982vkb.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 17:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vosoyaCx4QcgDY5FxwIyFgxMOfmxkzTg4grf7E+nB/o=;
        b=WSGRnR9jg82QVVJjRBFzjm0FLUbtB1wJRiSHr4AO1bLUJZflXGhtLwEZ0QrD5KEKxS
         CXHxxDzn9X1R9T17p1GbEL1ZYxMuIbyMKsDVLJgDebFxG33PGSTDijCXYfPmzWsELtNm
         F5b0grpvQ1bRisnPgLceqe5OjLFpIjQYUYV9dsCizV617iL3T7OIaexEt26uKUwFmbko
         IFLrWcRifJXg5jzWCqPVazhENAnF+6dL4WornW53mEZekuVi+CytWFgiIVmEST94gTIH
         r2NXk2NeCaalKxVXDwP/szOOuYSnck0nPjmZ5qmblpkHoLg642wWYb6QBBEGg0YyZu82
         hvCA==
X-Received: by 10.31.58.142 with SMTP id h136mr66957599vka.115.1452042346236;
 Tue, 05 Jan 2016 17:05:46 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 5 Jan 2016 17:05:46 -0800 (PST)
In-Reply-To: <20160105211206.GA12057@spirit>
X-Google-Sender-Auth: 8BkXXqa60Ve2O9Jlmu0x0Z9Wo2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283411>

On Tue, Jan 5, 2016 at 4:12 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> git reflog (ab)uses the log machinery to display its list of log
> entries. To do so it must fake commit parent information for the log
> walker.
>
> For refs in refs/heads this is no problem, as they should only ever
> point to commits. Tags and other refs however can point to anything,
> thus their reflog may contain non-commit objects.
>
> To avoid segfaulting, we check whether reflog entries are commits before
> feeding them to the log walker and skip any non-commits. This means that
> git reflog output will be incomplete for such refs, but that's one step
> up from segfaulting. A more complete solution would be to decouple git
> reflog from the log walker machinery.
>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> @@ -325,4 +325,17 @@ test_expect_success 'parsing reverse reflogs at BUFSIZ boundaries' '
> +test_expect_success 'no segfaults for reflog containing non-commit sha1s' '

Nit: It's kind of strange for a test title to talk about not
segfaulting; that's behavior you'd expect to be true for all tests.
Perhaps describe it as "non-commit reflog entries handled sanely" or
something.

> +       git update-ref --create-reflog -m "Creating ref" \
> +               refs/tests/tree-in-reflog HEAD &&
> +       git update-ref -m "Forcing tree" refs/tests/tree-in-reflog HEAD^{tree} &&
> +       git update-ref -m "Restoring to commit" refs/tests/tree-in-reflog HEAD &&
> +       git reflog refs/tests/tree-in-reflog
> +'

Hmm, this test is successful for me on OS X even without the
reflog-walk.c changes applied.

> +test_expect_failure 'reflog with non-commit entries displays all entries' '
> +       git reflog refs/tests/tree-in-reflog >actual &&
> +       test_line_count = 3 actual
> +'

And this test actually fails (inversely) because it's expecting a
failure, but doesn't get one since the command produces the expected
output.

By the way, it may make sense to combine these two tests. If a
segfault occurs, the actual output likely will not match the expected
output, thus the test will fail anyhow (unless the segfault occurs
after all output).

> +
>  test_done
> --
> 2.7.0-rc3-219-g24972d4
