From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/5] branch: Fix --track on a remote-tracking non-branch
Date: Fri,  6 Sep 2013 12:40:37 +0200
Message-ID: <1378464042-17476-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 12:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHtTr-00009X-Eg
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 12:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab3IFKlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 06:41:09 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:58723 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3IFKlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 06:41:06 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so2583528lab.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 03:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=hl2XqcUAJkNvQMjrKDZ5ObIKIVUiU/Y9sS7Ool87ppc=;
        b=E08yJaQvhuIKSM+6zuHw68dYEwS49YGE888ACZJaTxqcfjY1Y8niKdQzniqmv9J7MT
         pgaf91Xw/f0HxLuexfD+uS0ug3sb7wDu7wByo++knPyrHpj23dd2YReAKn7kSmqNlWRX
         U09H60iZJvd4wqvMXGFgETxmhYhfnb3PyjychD2ZMZt6aHz4wRhikxX6CvJQFlODW/m8
         BbTrG+KSS8oz2wAqb/fo+dns5ZgUf8/0HvW6PUbdcLruCxHMriOaJZrUuMilcvkNoABI
         UGJ1sQnZQpan5Jmq5w9N9z1884P+2/hKtLM2yubJXyt14Mo3T8oh25mZR6HtiPy35OHI
         /uTg==
X-Received: by 10.112.77.134 with SMTP id s6mr877802lbw.38.1378464065213;
        Fri, 06 Sep 2013 03:41:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-222-129.bredband.comhem.se. [80.216.222.129])
        by mx.google.com with ESMTPSA id vs11sm1000794lac.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 03:41:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234033>

Hi,

Per Cederqvist alerted me to a change in v1.8.3.2 that broke his
build/test infrastructure. Specifically, before 41c21f2 (branch.c:
Validate tracking branches with refspecs instead of refs/remotes/*)
Git allowed a local branch to --track anything within refs/remotes/*,
and in 41c21f2, I changed the rules to require a configured remote
with a matching fetch refspec when setting up the upstream configuration
variables (so that there was no ambiguity on how to set
branch.<name>.remote and branch.<name>.merge).

So far so good.

However, in addition to requiring a matching remote/refspec, I also
(for reasons that are still unclear to me) added a requirement that
the resulting remote ref name (to be stored into branch.<name>.merge)
must start with "refs/heads/" (see the last line of
branch.c:check_tracking_branch()).

Although it is typically the case that an upstream branch is a proper
(refs/heads/*) branch in the remote repo (which explains why we have
not noticed this until now), I think it is _wrong_ of Git to _require_
this when configuring the upstream.

Per's setup that triggered this series is described in more detail in
patch #4/5 (which introduces a testcase illustrating the breakage),
and the actual fix (which simply removes the extra refs/heads/*
requirement on the remote ref) is in patch #5/5.

The two first patches are unrelated trivial fixes that I encountered
while working on this, and patch #3 is a small documentation update
suggested by Per.

...Johan


Johan Herland (4):
  t2024: Fix inconsequential typos
  t3200: Minor fix when preparing for tracking failure
  Refer to branch.<name>.remote/merge when documenting --track
  t3200: Add test demonstrating minor regression in 41c21f2

Per Cederqvist (1):
  branch.c: Relax unnecessary requirement on upstream's remote ref name

 Documentation/git-branch.txt |  6 ++++--
 branch.c                     |  3 +--
 t/t2024-checkout-dwim.sh     |  4 ++--
 t/t3200-branch.sh            | 37 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 43 insertions(+), 7 deletions(-)

--
1.8.3.GIT
