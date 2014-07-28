From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 00/19] Enable options --signoff, --reset-author for pick, reword
Date: Tue, 29 Jul 2014 01:18:00 +0200
Message-ID: <cover.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDB-0005vq-6H
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbaG1XUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:04 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39637 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbaG1XUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:03 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so5320157wiv.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CjyOFiiCpCyXQ2FQVJiA8dzPW8zBuqBN89VD8fnr6c0=;
        b=buTtApeQ4Ph8gNqBjTvORyJuZ8wEDOkE+xTYtv6cNzZBnV67ps0F/y0i6f1gyODw6b
         08+8WVW+AWfoXUYbdaP1Sx5zET27ouTn7RVAm3ONdrYsZAZOTsXZWKo/lB2yH8aKZAT1
         6PHnTtgdlA0+DnezDsNNXGuj+wYCp7yqFme0449+vnmHOuJlbBQUPZuYi2Dd/LST9QRM
         HaCdME0aJUmLc6lkkMP0o+LVpog/XKvQTVp18wGEG5wE+1L3rA7o+3IwherVpgiTluGr
         OrcIB3iaFR0xrwe8nzJ9UorDiC1UIf48nxwfjii+3FK7HXA0o7XXs5jn1WuDzKwySCMv
         o+qw==
X-Received: by 10.180.85.101 with SMTP id g5mr35602032wiz.51.1406589601534;
        Mon, 28 Jul 2014 16:20:01 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.19.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <53A258D2.7080806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254361>

Hi,

this is a reroll of the patch series that enables rudimentary support
of line options for git-rebase's to-do list commands and reimplements
the well-known commands `reword` and `squash` in terms of a
parameterised `do_pick`.

I tried to address all the issues raised by Junio in this reroll.
Here is a short summary.

 - Test that `reword` behaves like `pick` regarding the `pre-commit`
   hook and executes `commit-msg` for the new log message.

 - Instead of disallowing empty log messages for root commits allow
   empty log messages for all unchanged commits.

 - The patch "root commits are replayed with an unnecessary option"
   does not change the behaviour of git-rebase but it makes the
   subsequent patch easier to read.

   The hidden agenda is to have one git-commit command line in
   `do_pick` that takes care of rewriting commits as they are being
   replayed, be they parentless or not. The advantage of having one
   rewrite command instead of one for root commits and one for
   non-root commits is that changes to the rewrite mechanism entail
   less code changes. As more rewriting mechanisms are being added to
   `do_pick`, it becomes important that they compose well with each
   other to avoid having a series of amending commits. The `-C`
   option conflicts with other ways of substituting the log message,
   like files and strings, which is why it seems not to compose so
   well.

 - The patch "explicitly distinguish replay commands and exec tasks"
   does not change behaviour either but is again a separated
   refactoring patch.

   The distinction of the `exec` command and the replay commands,
   which all share the same line format `command args sha1 rest`,
   allows us to employ the positional parameters feature of the shell
   without introducing another indentation level in `do_pick`.

Thanks for your time,
   Fabian

Fabian Ruch (19):
  rebase -i: failed reword prints redundant error message
  rebase -i: allow rewording an empty commit without complaints
  rebase -i: reword executes pre-commit hook on interim commit
  rebase -i: teach do_pick the option --edit
  rebase -i: implement reword in terms of do_pick
  rebase -i: allow replaying commits with empty log messages
  rebase -i: log the replay of root commits
  rebase -i: root commits are replayed with an unnecessary option
  rebase -i: commit only once when rewriting picks
  rebase -i: do not die in do_pick
  rebase -i: teach do_pick the option --amend
  rebase -i: teach do_pick the option --file
  rebase -i: prepare for squash in terms of do_pick --amend
  rebase -i: implement squash in terms of do_pick
  rebase -i: explicitly distinguish replay commands and exec tasks
  rebase -i: parse to-do list command line options
  rebase -i: teach do_pick the option --reset-author
  rebase -i: teach do_pick the option --signoff
  rebase -i: enable options --signoff, --reset-author for pick, reword

 git-rebase--interactive.sh    | 284 ++++++++++++++++++++++++++++++++++--------
 t/t3404-rebase-interactive.sh |  70 +++++++++++
 t/t3412-rebase-root.sh        |  19 +++
 t/test-lib-functions.sh       |   6 +-
 4 files changed, 325 insertions(+), 54 deletions(-)

-- 
2.0.1
