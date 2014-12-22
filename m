From: Mike Hommey <mh@glandium.org>
Subject: Supporting a few more usecases with remote helpers
Date: Mon, 22 Dec 2014 10:07:26 +0900
Message-ID: <20141222010726.GA4817@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 02:08:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2rTj-0006Ig-M4
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 02:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbaLVBHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 20:07:35 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:53713 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbaLVBHe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 20:07:34 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Y2rT4-0003RI-Lp
	for git@vger.kernel.org; Mon, 22 Dec 2014 10:07:26 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261635>

Hi,

As you may or may not know, I'm working on a remote-helper to interact
with mercurial servers, with the main focus being to make it work with
developer workflows at Mozilla.

I think remote-helpers, in the context of non-git remotes, can be
leveraged to improve git user experience with non-git remotes.

- While git doesn't support this[1], mercurial allows to pull a specific
  commit. That's quite commonly used at Mozilla. It makes it desirable
  to be able to `git fetch origin sha1`, where sha1 could actually be
  considered as fake head name. But that currently can't work because
  only refs returned by the `list` command of the remote-helper are
  considered, and we can't realistically list all the remote changesets
  there.
- A lot of places (bug logs, CI, etc.) will list mercurial changesets
  or, more commonly, their abbreviated form. It is quite common to look
  at those locally. When using a git clone of a mercurial repository,
  it adds a level of indirection where the user first needs a command to
  resolve that mercurial changeset to the corresponding git commit, then
  run whatever command they wanted to run with that git commit. This
  could be worked around by adding e.g. tags for both abbreviated and
  long form of the changesets, but we'd be looking at more than 400k
  refs for a typical Mozilla repository. That doesn't quite scale.
- On the opposite side of the above, it can be necessary to find out
  what mercurial changeset a git commit corresponds to, and while, like
  the above, there can be a command to resolve those, that's a level
  of indirection that is not very nice for users.

Here's my thoughts on how I think this could be done, but before I dive
in the code to actually implement it, I'd like to get feedback whether
it makes sense.

- I think the first and second use cases could both use the same 
  "feature". We could add a new `list` option to the remote-helpers
  that would make it list a limited set of refs, and giving it the
  opportunity to reply with heads it wouldn't give normally. For
  example, this would look like this:
    git fetch origin 7b33ee7fd162d784f382250d3fa811e86a1b7348
      > list ref refs/heads/7b33ee7fd162d784f382250d3fa811e86a1b7348
      ? refs/heads/7b33ee7fd162d784f382250d3fa811e86a1b7348
    git show ba0dc109a8f8
      > list ref refs/heads/ba0dc109a8f8
      1d1c70ecefa26e5fa859366ac989497843a3f8ff refs/heads/ba0dc109a8f8
- For the latter, I was thinking the decorate code (for git log
  --decorate) could request ref names to the remote-helper, like this:
      > ref short 1d1c70ecefa26e5fa859366ac989497843a3f8ff
      1d1c70ecefa26e5fa859366ac989497843a3f8ff ba0dc109a8f8
      > ref full 1d1c70ecefa26e5fa859366ac989497843a3f8ff
      1d1c70ecefa26e5fa859366ac989497843a3f8ff ba0dc109a8f86ca831866a5933cf863d379434cd
  Then the decorate code would display helper-prefix::ba0dc109a8f8 or
  helper-prefix::ba0dc109a8f86ca831866a5933cf863d379434cd depending on
  the --decorate value.

Calling remote-helpers for the above would be triggered by the presence
of one or more remotes with helper:: prefixed urls.

Thoughts?

Mike

1. I think it should, as long as the given sha1 is reachable from the
public heads, but that's offtopic here.
