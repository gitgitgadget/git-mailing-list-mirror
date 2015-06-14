From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 00/19] Make git-pull a builtin
Date: Sun, 14 Jun 2015 16:41:47 +0800
Message-ID: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43Ut-00062j-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbbFNIm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:42:26 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34903 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbbFNImX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:42:23 -0400
Received: by pdbnf5 with SMTP id nf5so51485743pdb.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kxErbxZjnW0w4t9yYUM4IVREem/tTONVl1BLwIMK9ho=;
        b=rXfwxCyBMzy7cJagGBvXKozmT3es30aNSBRoi0MExOin0utxWGRyw3BCyp1b+wRAQY
         G4LbJxHFx5qPVkFwC4QOAHRJLHpXh4OvTrGl/yACZ2CZIpwPYE32h9sP8ZMazm3YknO0
         OH5Nm2JLEE/pouB0lTYrupSYECgFsvQtbKNU59yXTtpIDye1ob/IlhmXjmFlF6dycDEx
         ItOQGMOD3/IsNPRrZWrwmdOtQiPHd4l9byoFPzb6IRbfUpKUIYRdfpSdtizx1ImKMGFQ
         6NRk5+XQJUqyXu2dqjt6ADIvd0A/MVnNZbnCzMkXYr1rPXywE5jWUCSSNENFuiKSwVGK
         JHFw==
X-Received: by 10.66.63.70 with SMTP id e6mr20437912pas.62.1434271343393;
        Sun, 14 Jun 2015 01:42:23 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:42:21 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271614>

This is a re-roll of [v2]. Thanks Junio, Stefan for the reviews last round.

Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/269258
[v2] http://thread.gmane.org/gmane.comp.version-control.git/270639

git-pull is a commonly executed command to check for new changes in the
upstream repository and, if there are, fetch and integrate them into the
current branch. Currently it is implemented by the shell script git-pull.sh.
However, compared to C, shell scripts have certain deficiencies -- they need to
spawn a lot of processes, introduce a lot of dependencies and cannot take
advantage of git's internal caches.

This series rewrites git-pull.sh into a C builtin, thus improving its
performance and portability. It is part of my GSoC project to rewrite git-pull
and git-am into builtins[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (19):
  parse-options-cb: implement parse_opt_passthru()
  parse-options-cb: implement parse_opt_passthru_argv()
  argv-array: implement argv_array_pushv()
  pull: implement skeletal builtin pull
  pull: implement fetch + merge
  pull: pass verbosity, --progress flags to fetch and merge
  pull: pass git-merge's options to git-merge
  pull: pass git-fetch's options to git-fetch
  pull: error on no merge candidates
  pull: support pull.ff config
  pull: check if in unresolved merge state
  pull: fast-forward working tree if head is updated
  pull: implement pulling into an unborn branch
  pull: set reflog message
  pull: teach git pull about --rebase
  pull: configure --rebase via branch.<name>.rebase or pull.rebase
  pull --rebase: exit early when the working directory is dirty
  pull --rebase: error on no merge candidate cases
  pull: remove redirection to git-pull.sh

 Documentation/technical/api-argv-array.txt    |   3 +
 Documentation/technical/api-parse-options.txt |  13 +
 Makefile                                      |   2 +-
 advice.c                                      |   8 +
 advice.h                                      |   1 +
 argv-array.c                                  |   6 +
 argv-array.h                                  |   1 +
 builtin.h                                     |   1 +
 builtin/pull.c                                | 881 ++++++++++++++++++++++++++
 git-pull.sh => contrib/examples/git-pull.sh   |   0
 git.c                                         |   1 +
 parse-options-cb.c                            |  69 ++
 parse-options.h                               |   6 +
 13 files changed, 991 insertions(+), 1 deletion(-)
 create mode 100644 builtin/pull.c
 rename git-pull.sh => contrib/examples/git-pull.sh (100%)

-- 
2.1.4
