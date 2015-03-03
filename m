From: John Keeping <john@keeping.me.uk>
Subject: Re: Unexpected/unexplained difference between git pull --rebase and
 git rebase
Date: Tue, 3 Mar 2015 21:46:53 +0000
Message-ID: <20150303214653.GQ890@serenity.lan>
References: <CAPfvZp6oNnM=M-9BAVqAE052jQApH-O_t3gEoq6JWC2kQrR8gg@mail.gmail.com>
 <20150303210900.GP890@serenity.lan>
 <CAPfvZp5KmEwY_903aUJE0p7qKMUbABYpC3Y8JvPSc_Dmd0ppGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Botsko <botsko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSueg-0004dL-IF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 22:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757330AbbCCVrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 16:47:02 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:42814 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852AbbCCVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 16:47:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 5FC6A22D99;
	Tue,  3 Mar 2015 21:46:59 +0000 (GMT)
X-Quarantine-ID: <GbZkEnO8MQfw>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GbZkEnO8MQfw; Tue,  3 Mar 2015 21:46:58 +0000 (GMT)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id C0DA022CAD;
	Tue,  3 Mar 2015 21:46:55 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAPfvZp5KmEwY_903aUJE0p7qKMUbABYpC3Y8JvPSc_Dmd0ppGA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264694>

On Tue, Mar 03, 2015 at 01:31:39PM -0800, Mike Botsko wrote:
> I'm using git 2.2.1 on Mac OS X Yosemite.
> 
> I just tried the git rebase with "--fork-point" added, and it works properly:
> 
> $ git rebase upstream/our-branch-name --fork-point
> First, rewinding head to replay your work on top of it...
> Applying: B-07241
> 
> While discussing with someone else, he mentioned "poking about a bit
> more, git rebase began defaulting to --fork-point in git 1.9, so one
> might expect it to be there in that version" - but we figured it might
> be related to https://github.com/git/git/commit/1e0dacdbdb751caa5936b6d1510f5e8db4d1ed5f.
> I upgraded my version of git, but it wasn't fixed.
> 
> I assume he was incorrect in that git rebase uses --fork-point by default?

git-rebase assumes that if you give an explicit upstream then you want
precisely what you asked for.  From git-rebase(1):

	If either <upstream> or --root is given on the command line,
	then the default is `--no-fork-point`, otherwise the default is
	`--fork-point`.

> On Tue, Mar 3, 2015 at 1:09 PM, John Keeping <john@keeping.me.uk> wrote:
> > On Tue, Mar 03, 2015 at 12:39:31PM -0800, Mike Botsko wrote:
> >> I'm seeing unexpected behavior between "git pull --rebase" and "git
> >> rebase" commands, which are supposed to be (and always described as)
> >> synonymous:
> >>
> >> git pull --rebase upstream our-branch-name
> >>
> >> and
> >>
> >> git fetch upstream
> >> git rebase upstream/our-branch-name
> >>
> >> We have a situation where the upstream/our-branch-name was rebased, to
> >> incorporate changes from master. Somehow, the person who did the
> >> rebase discarded a merge commit:
> >>
> >> 634b622 Sue Merge pull request #254 from bob/B-07290
> >> bc76e5b Bob [B-07290] Order Parts Ship To/Comments
> >>
> >> became:
> >>
> >> c1452be Sue [B-07290] Order Parts Ship To/Comments
> >>
> >>
> >> A developer who had a local branch tried to rebase their work (a
> >> single commit on top of that feature branch).
> >>
> >> At the moment, his now-out-of-date branch looks like this:
> >>
> >> 92b2194 Rick B-07241
> >> 634b622 Sue Merge pull request #254 from dboyle/B-07290
> >> bc76e5b Bob [B-07290] Order Parts Ship To/Comments
> >>
> >> I've done some debugging, and the above "git pull" command generates
> >> the following and sends it to eval():
> >>
> >> git-rebase --onto c1452be62cf271a25d3d74cc63cd67eca51a127d
> >> 634b622870a1016e717067281c7739b1fe08e08d
> >>
> >> This process works perfectly. The old commits are discarded and his
> >> branch now correctly reflects upstream/our-branch-name, with his
> >> single new commit at the top.
> >>
> >>
> >> However, if he runs the "git rebase" command above, several of the
> >> commits that have changed hashes (they've also changed patch id
> >> slightly, because during the rebase someone fixed a merge conflict)
> >> are treated as new work, and git tries to re-apply them and we get
> >> tons of merge conflicts.
> >>
> >> The git rebase command above is trying to rebase onto:
> >>
> >> revisions = c1452be62cf271a25d3d74cc63cd67eca51a127d..92b2194e3adc29eb3fadd93ddded0ed34513d587
> >>
> >>
> >> These two features should work the same, yet one is choosing a
> >> different commit hash than the other.
> >>
> >> If this is not a bug, I can't find anyone who can explain what's
> >> happening. I'm using git 2.2.1 on mac, but other people on our team
> >> have a variety of older versions and we're all seeing the same result.
> >
> > What version of Git are you using?
> >
> > Does it work if you add the `--fork-point` argument to git-rebase?  If
> > so, does it do the same if you just do "git rebase" with no arguments
> > (see the documentation of `--fork-point` in git-rebase(1) for details of
> > this)?
> 
> 
> 
> -- 
> Mike Botsko
> Lead Dev @ Helion3
> Ph: 1-(503)-897-0155
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
