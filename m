From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 00/13] fetch submodules in parallel and a preview on parallel "submodule update"
Date: Mon, 21 Sep 2015 15:39:06 -0700
Message-ID: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kA-0006BE-W9
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbbIUWjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:25 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32880 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbbIUWjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:23 -0400
Received: by pacex6 with SMTP id ex6so128681429pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fEhgy/h480kaA/jysIGWf1ZrmodpZ4XfJ4VZ83/SzUc=;
        b=d37yrvjoBvn3X3AUkLij+heiAvScO1yu1Bbo663qMwWRPjDFRz5+Ps++mbFHEyaY8y
         nMZMRxySQ6Pob71gbP2ncwjvc/xjDKRlkF2TnzE2J07S4auL+S2SjJdxJVrgCLHypJlY
         6Gd30Dcf3FQW+/Dr3hxi6WNKPiOhFRP/rccwHx/V+nFSat+RpLnWWOqWAcRA/XEaAdkB
         FD6Qemsj3SH28J+S3RcuBCiykJNujxEZPTz2NZ6V5ZSdowMaM3amOgd4amLklksoPkqG
         eA0S4tgmxnPrnTbEa+PHpTDen7/MiAWbhrU/Jr+MKqvi5FZcpSgbS1OMLfRQYd9Yo96c
         0v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fEhgy/h480kaA/jysIGWf1ZrmodpZ4XfJ4VZ83/SzUc=;
        b=XaG4KqCIujDX5mGkNN8A7On2MgncxkSGVE4q4ydFaQ9ZMR3KQ+/vw+2zJriKtZ7Ulv
         +q1HmkgUjysjsOX5pa/eUtZQdw33T6FD59WEqfS7L+gRCVd/4AXjInN5Msrx7YOVEH4S
         gZs8DoOkWsQnPwz//bHt3m9P3GAyM1R+ZNuBEzz5EqZGicBynz0krAxRQTakq0DcoOEa
         rG1WXisitJVfSaBwdAI5EO29HSzbH3soMVIM8jCdZgHHv3/HIV87msYobxUA32JwklCl
         dkOJb3oZwcYytpr8T1oAHswUGeriTlAPES/nty0TLgiTXTTBJR78W/w9z0VmD6njqmlI
         eNew==
X-Gm-Message-State: ALoCoQkc2qA9QbFsCWny1Fdw71MiOoeVZykhE7WOdc78qpIm9YM22B/dDmtZt9LGe5E5Fn6OhbOe
X-Received: by 10.68.111.129 with SMTP id ii1mr27822527pbb.1.1442875163111;
        Mon, 21 Sep 2015 15:39:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id iy1sm26443244pbb.85.2015.09.21.15.39.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278338>

This build on top of origin/sb/submodule-helper

Patches 1-8 are parallelising fetching submodules.
Thanks Eric, Jeff and Junio for the discussion and review!
Based on your feedback:

Patch 2 is optional and may be spun out as its own mini series.
Instead of spinning we can poll until data are ready on the fd.

Patch 3,4 have been revamped to include your suggestions, having 
xread_nonblock and strbuf_read_once as their own functions not
to be integrated into other existing functions.

Patch 5 was fixed to return 0 or -1 in the error case.
Patch 6 has major syntactically changes such as no slots any more,
but in_use flags. The return code was flipped (1 means there is a child
to be executed, while 0 means we're done).

Patch 7,8 convert git fetch --recuse-submodules to use the fruit of patch 6.

Patches 9 an onwards are RFC, so I could spin them out as their
own series as they convert parts of "submodule update" to C using
the new asynchronous run command code.
Patch 9 adds the update strategy to the submodule cache
Patches 10,11,12 are just moving code around to make cmd_update leaner.
Patch 13 shows how I plan to parallelize updating the submodules for now.

Any feedback welcome,
Thanks,
Stefan

Jonathan Nieder (1):
  Sending "Fetching submodule <foo>" output to stderr

Stefan Beller (13):
  xread: poll on non blocking fds
  xread_nonblock: add functionality to read from fds nonblockingly
  strbuf: add strbuf_read_once to read without blocking
  run-command: factor out return value computation
  run-command: add an asynchronous parallel child processor
  fetch_populated_submodules: use new parallel job processing
  submodules: allow parallel fetching, add tests and documentation
  submodule config: keep update strategy around
  git submodule update: pass --prefix only with a non empty prefix
  git submodule update: cmd_update_recursive
  git submodule update: cmd_update_clone
  git submodule update: cmd_update_fetch
  Rewrite submodule update in C

 Documentation/fetch-options.txt |   7 +
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 +
 builtin/submodule--helper.c     | 247 +++++++++++++++++++++++++++++
 git-compat-util.h               |   1 +
 git-submodule.sh                | 339 ++++++++++++++--------------------------
 run-command.c                   | 329 +++++++++++++++++++++++++++++++++++---
 run-command.h                   |  38 +++++
 strbuf.c                        |  11 ++
 strbuf.h                        |   6 +
 submodule-config.c              |  16 ++
 submodule-config.h              |   1 +
 submodule.c                     | 119 +++++++++-----
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  20 +++
 t/t5526-fetch-submodules.sh     |  70 ++++++---
 test-run-command.c              |  24 +++
 wrapper.c                       |  41 ++++-
 18 files changed, 972 insertions(+), 311 deletions(-)

-- 
2.5.0.275.ge015d2a
