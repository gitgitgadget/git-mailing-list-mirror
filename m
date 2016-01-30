From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Sat, 30 Jan 2016 09:13:06 +0100
Message-ID: <20160130081306.GA2931@ecki.hitronhub.home>
References: <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
 <xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
 <20160125144250.GM7100@hank>
 <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
 <xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
 <20160127151602.GA1690@ecki.hitronhub.home>
 <xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
 <xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
 <20160128070959.GA6815@ecki.hitronhub.home>
 <xmqqk2mtmlu9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 09:16:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPQi1-0006W3-4y
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 09:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbcA3IP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 03:15:57 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:37361 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbcA3IP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 03:15:56 -0500
Received: from [127.0.0.1] (ip5f5ade73.dynamic.kabel-deutschland.de [95.90.222.115])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pspJK2fggz5tlG;
	Sat, 30 Jan 2016 09:15:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqk2mtmlu9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285106>

On Thu, Jan 28, 2016 at 01:32:30PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > If we do this, then git diff should show the diff between
> > convert_to_worktree(index state) and the worktree state.
> 
> And that unfortunately is a very good reason why this approach
> should not be taken.

Ok, then let's take a step back. I do not actually care if git diff and
friends say the worktree is clean or not. But I know that I did not make
any modifications to the worktree, because I just did git reset --hard.
And now I want to use commands like cherry-pick and checkout without
failure. But they can fail, because they essentially use git diff to
check if there are worktree changes, and if so refuse to overwrite them.

So, if the check "Am I allowed to modify the worktree file?", would go
the extra mile to also check if the worktree is clean in the sense that
convert_to_worktree(index state) matches the worktree. If this is the
case, then it is safe to modify the file because it is the committed
state, and can be recovered.

Regarding performance impact: We only need to do this extra check if the
usual check convert_to_git(work tree) against index state fails, and
conversion is in effect.

> Besides, I do not think the above approach really solves the issue,
> either.  After "git reset --hard" to have the contents in the index
> dumped to the working tree, if your core.autocrlf is flipped,

Indeed, if the user configuration changes, then we cannot always detect
this (at least if the filter is an external program, and the behavior of
that changes). But the user is in control of that, and we can document
this limitation.

On the other hand, a user who simply follows an upstream repository by
doing git pull all the time, and who does not make changes to their
configuration, can still run into this issue, because upstream could
change .gitattributes. This part we could actually detect by hashing the
attributes for each index entry, and if that changes we re-evaluate the
file state.

This is also an issue only if a smudge filter is in place. The eol
conversion which only acts in the convert_to_git direction is not
affected.
