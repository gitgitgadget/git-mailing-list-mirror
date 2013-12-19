From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/21] Support multiple worktrees
Date: Thu, 19 Dec 2013 21:12:41 +0700
Message-ID: <CACsJy8BV6uerMyHNHviL0Jy8s+_jca8NM-hVfnM=u4cr-=JX1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 15:13:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VteLo-0003z9-AI
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 15:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab3LSONO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 09:13:14 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:64717 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab3LSONM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 09:13:12 -0500
Received: by mail-qa0-f47.google.com with SMTP id w5so4792856qac.20
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 06:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=LWhilfVhqmcMUzGussGXmw6ZbAZuH2rBWEsbFu3kzPE=;
        b=Xgk4k0oCjVE+itt2wPfi6FY+hs9mjKQJImRUJgkv/G1VXpIP1PngEM9SJ/czU6ZcLa
         xXux1ER6pJvoN12gJX72wwnCQf6RhXtflExXZAStHhUwQRGTDToXGOj2iMJms0RJCymZ
         HPDIc4sisocUqNOk3UuNh1/AAy1CDrXlPtT08h/fv0kNTXO5Rg1zwOkNOXLHGnlRU4RT
         H4SykAMo7hUG7cpSpEjPjqlkMDIx27x0+71HYh7vCvRxDgAOalanm6wxXaGhZQckFJxT
         MCc8u1GNVHDOVY7+NT2kzHs7BI/CnjaNqPZ79hbzpHDo/spLxSsxtPxcLtmoLHowuGQo
         4uBw==
X-Received: by 10.224.51.7 with SMTP id b7mr3277010qag.74.1387462392321; Thu,
 19 Dec 2013 06:13:12 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 19 Dec 2013 06:12:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239520>

I've got a better version [1] that fixes everything I can think of
(there's still some room for improvements). I'm going to use it a bit
longer before reposting again. But here's its basic design without
going down to code

New .git file format includes two lines:
-- 8< --
gitid: <id>
gitdir: <path>
-- 8< --

Which would set $GIT_COMMON_DIR to <path> and $GIT_DIR to
<path>/repos/<id>. Repository split is the same as before, worktree
stuff in $GIT_DIR, the rest in $GIT_COMMON_DIR. This .git file format
takes precedence over core.worktree but can still be overriden with
$GIT_WORK_TREE. The main interface to create new worktree is "git
checkout --to".

"repos" belongs to $GIT_COMMON_DIR (i.e. shared across all checkouts).
The new worktrees (which I call "linked checkouts") can also access
HEAD of the original worktree via a virtual path "main/HEAD". This
makes it possible for a linked checkout to detach HEAD of the main
one.

There are three entries in repos/<id>: "gitdir" should point to the
.git file that points it back here. Every time a linked checkout is
used, git should update mtime of this "gitdir" file to help pruning.
It should update the file content too if the repo is moved. "link" is
a hardlink to .git file, if supported, again for pruning support.
"locked", if exists, means no automatic pruning (e.g. the linked
checkout is on a portable device).

The interesting thing is support for third party scripts (or hooks,
maybe) so that they could work with both old and new git versions
without some sort of git version/feature detection. Of course old git
versions will only work with ordinary worktrees. To that end, "git
rev-parse --git-dir" behavior could be changed by two environment
variables. $GIT_ONE_PATH makes 'rev-parse --git-dir' return the .git
_file_ in this case, which makes it much easier to pass the repo's
checkout view around with "git --git-dir=... ".$GIT_COMMON_DIR_PATH
makes 'rev-parse --git-dir' return $GIT_COMMON_DIR if it's from a
linked checkout, or $GIT_DIR otherwise. This makes 'rev-parse
--git-dir' falls back safely when running using old git versions. The
last patch in [1] that updates git-completion.bash could demonstrate
how it's used.

[1] https://github.com/pclouds/git.git checkout-new-worktree
-- 
Duy
