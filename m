From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] cherry-pick: allow "-" as abbreviation of '@{-1}'
Date: Sat, 3 Aug 2013 12:51:28 +0200
Message-ID: <87wqo33v4f.fsf@hexa.v.cablecom.net>
References: <1375506913-3390-1-git-send-email-hiroshige88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Hiroshige Umino <hiroshige88@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 12:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ZRB-0003sm-Ut
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 12:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab3HCKvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 06:51:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:2283 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab3HCKvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 06:51:31 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 12:51:24 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 12:51:28 +0200
In-Reply-To: <1375506913-3390-1-git-send-email-hiroshige88@gmail.com>
	(Hiroshige Umino's message of "Sat, 3 Aug 2013 14:15:13 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231579>

Hiroshige Umino <hiroshige88@gmail.com> writes:

> As "git cherry-pick -" or "git merge -" is convenient to
> switch back to or merge the previous branch,
> "git cherry-pick -" is abbreviation of "git cherry-pick @{-1}"
> to pick up a commit from the previous branch conveniently.

The first line is confusing.  Did you mean to invoke the existing 'git
*checkout* -' and 'git merge -' functionality as a reason why 'git
cherry-pick -' should exist?

What other commands could reasonably use the '-' shorthand?

[...]
> diff --git a/t/t3512-cherry-pick-last.sh b/t/t3512-cherry-pick-last.sh

Do you have to use a new test file for this?

[...]
> +test_expect_success 'setup' '
> + echo hello >world &&
> + git add world &&
(*)
> + git commit -m initial &&
> + git branch other &&
> + echo "hello again" >>world &&
> + git add world &&
(*)
> + git commit -m second
> +'

Our style is to indent the test snippets with a hard tab, not a single
(or eight, for that matter) space.

[...]
> +test_expect_success 'cherry-pick the commit in the previous branch' '
> + prev=$(git rev-parse HEAD) &&
> + git checkout other &&
(*)
> + git cherry-pick - &&
> + test "z$(git rev-parse HEAD)" = "z$prev"
> +'

If you insert 'test_tick' in the places marked with (*), the test fails.

The tests run under a fake clock to ensure that everything, including
the SHA1s produced, are deterministic.  You never advance the clock, so
all commits generated in this script share the same timestamp.

This means that the cherry-pick of 'second' has the same SHA1 as the
original: its tree, parents, author, timestamp etc. all agree.  If you
advance the clock at the last (*), this fails.  You should find some
other way of checking what was picked, e.g., by looking at the file
contents.

That said, please use test_commit in the 'setup' snippet instead of
manually rolling the commits.  It will lead to shorter code, and it
handles test_tick for you.  It is documented in t/README and in a
comment in t/test-lib-functions.sh.  (You still need test_tick
immediately before the cherry-pick!)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
