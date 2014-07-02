From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 00/19] Enable options --signoff, --reset-author for pick, reword
Date: Wed,  2 Jul 2014 19:47:52 +0200
Message-ID: <cover.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:49:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OeW-0005uz-75
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbaGBRs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:48:59 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:52002 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbaGBRs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:48:59 -0400
Received: by mail-we0-f177.google.com with SMTP id u56so11546588wes.36
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jW2mZbUVyI10XOXVNCSpaP0Xm/kMAvtzGUBR9A8sPRw=;
        b=lg4e66EtcFkKmm7gRAW3isTbziplKE9oeQmygYuDo2wASZs65tRqkch9ohVqCNzQMt
         88iQpYmNNzLf+h+E/wDlHvNSAKMPZ8g10eK31uldaLq7wRIIrzC5u0voo6GcvAqXkKir
         g8I7fJ/xnohIeXCZz6GZaSeSD8XKTT/98p86TiZFrHs/nQA/YDrQG3ZSe8LJfGFhb6Xe
         oXiVQ+d4NFYq1usywToCq5M0gdv5mOXdEJ7wOTd9lBQGIxpm9KTOfLm3/iH/bmnAw96A
         E9T+fMPNXWMbk8RhtSqNjF3Rxbh8WVvqu2ve+/nnTRgyJgWD47CLWs+tVGk1R4GfJjbT
         /ABg==
X-Received: by 10.180.75.47 with SMTP id z15mr5689031wiv.80.1404323337590;
        Wed, 02 Jul 2014 10:48:57 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.48.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:48:56 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <53A258D2.7080806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252804>

Hi,

this reroll applies the comments from Eric, Junio and Michael. In
particular,

 * It turned out that `pick_one` does not need option handling at all
   and the option-like argument `-n` determines whether `pick_one` or
   `do_pick` creates the replay commit. The latter happens if the
   task wants to rewrite the commit being picked (f.i., for the
   purpose of editing the log message or resetting the authorship).

   `do_pick` still seems to require a flexible parsing of options,
   i.e. a relatively expensive loop, since it receives the
   whitelisted user-supplied options. Unsupported and unknown options
   are treated as an "unknown command" error.

 * The `do_pick` options are documented in the same order they are
   listed in the function signature. Moreover, it is mentioned which
   options rewrite commits being picked.

 * The test cases output differing actual values as changes to the
   expected values and not the other way around. Moreover, the failed
   rebases are not cleaned up until the respective test succeeds.

Two stages (and two sub-stages) can be identified in the rerolled
patch series:

 1. Route primary to-do list commands through `do_pick`

     a. Implement reword in terms of do_pick (5/19)
     b. Implement squash in terms of do_pick (14/19)

 2. Add user options to main commands

    Enable options --signoff, --reset-author for pick, reword (19/19)

The last stage was added in this reroll. It enables the parsing of
line options for to-do list commands, which is still restricted to
options without arguments because it is unclear how spaces can be
parsed as characters rather than separators where needed. For
instance, if we were to support

    pick --author="A U Thor" fa1afe1 Some changes

then read(1) would hand us the tokens `--author="A`, `U` and `Thor"`
instead of `--author=A U Thor`, which we would want to relay to
`do_pick`. Interpreting the shell quoting would help. However,
eval(1) seems to disqualify itself as an interpreter because the
to-do list entry could potentially contain any shell command line.
This could be both a security and a usability issue. For this reason,
the patch series still hasn't graduated from being RFC.

   Fabian

Fabian Ruch (19):
  rebase -i: Failed reword prints redundant error message
  rebase -i: reword complains about empty commit despite --keep-empty
  rebase -i: reword executes pre-commit hook on interim commit
  rebase -i: Teach do_pick the option --edit
  rebase -i: Implement reword in terms of do_pick
  rebase -i: Stop on root commits with empty log messages
  rebase -i: The replay of root commits is not shown with --verbose
  rebase -i: Root commits are replayed with an unnecessary option
  rebase -i: Commit only once when rewriting picks
  rebase -i: Do not die in do_pick
  rebase -i: Teach do_pick the option --amend
  rebase -i: Teach do_pick the option --file
  rebase -i: Prepare for squash in terms of do_pick --amend
  rebase -i: Implement squash in terms of do_pick
  rebase -i: Explicitly distinguish replay commands and exec tasks
  rebase -i: Parse to-do list command line options
  rebase -i: Teach do_pick the option --reset-author
  rebase -i: Teach do_pick the option --signoff
  rebase -i: Enable options --signoff, --reset-author for pick, reword

 git-rebase--interactive.sh    | 277 ++++++++++++++++++++++++++++++++++--------
 t/t3404-rebase-interactive.sh |   8 ++
 t/t3412-rebase-root.sh        |  39 ++++++
 3 files changed, 273 insertions(+), 51 deletions(-)

-- 
2.0.0
