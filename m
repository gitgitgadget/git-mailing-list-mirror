From: Han <laughinghan@gmail.com>
Subject: Two potential bugs in aliases that expand to shell commands
Date: Wed, 3 Apr 2013 19:05:33 -0700
Message-ID: <CACE=nd1dwhCyrKdzFq7O4UgD1TH8-c5R+4L2rH0NGW-jWqLr_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 04:06:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNZZN-0005Hy-TV
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 04:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882Ab3DDCF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 22:05:58 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:39519 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932779Ab3DDCFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 22:05:53 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so2039185obb.23
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 19:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:from:date:x-google-sender-auth
         :message-id:subject:to:content-type;
        bh=R7et9TZ/TaFn1Aj8mQO8nBeCjW+OI7G1JvuetfR2+iM=;
        b=KtFChgcVsn7K0LaWVOsEBLyj5re/dNUQsdKo4nV0aUDpYAdQJfdzgm0xnO29yNVluX
         S8yNIrrvpz9xVqyh71gUK5zR2CTxU5NN2y7Q6S2jaUN9RYvGIO+MMYrfxswGnakmth88
         4E83mM3JMND465KIWm02b590TOjF631SomAvZTT2R1RPSQYtnYzWw2uUZ66Kr8PMfc4T
         JhF7Sk6ULc/3cBigdf82L4jNaJgZ8CQbMFJ6a9ivSfw6TIUSDHAwaeK4CK7GMMnPVqUe
         Eg0XsWUDXLSlD3biMsArBBxagjIwRzpX5fZrjRg/vcCRBLA2ReWfYiGYRlW5dzs01gLA
         ogSg==
X-Received: by 10.182.86.162 with SMTP id q2mr2800287obz.35.1365041153215;
 Wed, 03 Apr 2013 19:05:53 -0700 (PDT)
Received: by 10.76.153.100 with HTTP; Wed, 3 Apr 2013 19:05:33 -0700 (PDT)
X-Google-Sender-Auth: MqWtKkn4_LQgIWDmpn5xLMrTIxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219985>

These might just be documentation bugs.

Aliases that expand to shell commands are only documented fairly
superficially, but `git help config` does say: "If the alias expansion
is prefixed with an exclamation point, it will be treated as a shell
command."

It also says, nearer the beginning: "String values may be entirely or
partially enclosed in double quotes. You need to enclose variable
values in double quotes if you want to preserve leading or trailing
whitespace, or if the variable value contains comment characters (i.e.
it contains # or ;)."

There appears to be another case string values need to be enclosed in
quotes, which is a shell command where you want to preserve quote
characters (not leading or trailing); a minimal example is

  shortcut = !cd "" && pwd

will act like you ran, in bash,

$ cd  && pwd

and print your homedir path, whereas

  shortcut = !"cd \"\" && pwd"

will act like you ran, in bash,

$ cd "" && pwd

and stay in the top-level directory of the repo (which is where
aliases that expand to shell commands are run from).

This is problematic precisely because aliases that expand to shell
commands are run from the top-level directory of the repo: if you had
an alias that worked great at the top-level directory, like

  shortcut = !do_something

but it was doing the wrong thing in subdirectories, my first instinct,
at least, upon reading "Note that shell commands will be executed from
the top-level directory of a repository, which may not necessarily be
the current directory. GIT_PREFIX is set as returned by running git
rev-parse --show-prefix from the original current directory.", is to
do

  shortcut = !cd "$GIT_PREFIX" && do_something

which will now do the right thing in subdirectories, but at the
top-level directory of the repo, $GIT_PREFIX is undefined/the empty
string, and it cds to your homedir.

The other bug I'm much more confused by. If you have an alias like

  shortcut = !"echo -n lol; echo wut"

it will, in fact, print

-n lol
wut

which is, uh, not what bash prints. Is git special-casing echo?

(I discovered these while adding something semi-jokingly to my
.gitconfig: https://github.com/laughinghan/dotfiles/commit/34f5528825b287ff40acfe57808b32931a87261c
)

Han
