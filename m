From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 0/3] am: let command-line options override saved options
Date: Tue,  4 Aug 2015 22:08:48 +0800
Message-ID: <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 16:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMctu-0001L9-4m
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 16:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934280AbbHDOJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 10:09:00 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34941 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934241AbbHDOI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 10:08:59 -0400
Received: by pasy3 with SMTP id y3so9498696pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PxH8rvN5zXXcdXxOvUuIOKwR0F7Wtb+sT6pwkOzRd/0=;
        b=JKNw83ICOqzRIAPwl8Qd2b7CGr/zWEpcIiOqcsxh4Wtx5Wqhr3des8fA2eqekYWLrP
         ss1UHnZ6ueNsix6GKNQLs3Zj0x/5tqw3nCgt1sUy6GPxsCGysiD6ZWWEOq/ImIhhIR2i
         E61OVWJP7lGvvolFBIptIht0bLkmyjceT7yOPqZChtkEHiXh6lfJdKpW47iKwsqKQTWl
         /1Ajzv2YIz2O9XT1fRTdddi8P20+yHHRB5IMIt+loF38tWS5BnvLuY0f1pEM263RWfn7
         nPY2scMRosAcKNc/Q/sTg60kXC0BlpZgajYgNP89l8MTDQTgAcZyXrstF5Lv63zz51D6
         jP1Q==
X-Received: by 10.68.173.97 with SMTP id bj1mr8219020pbc.122.1438697338674;
        Tue, 04 Aug 2015 07:08:58 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id qc9sm561141pab.18.2015.08.04.07.08.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 07:08:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <20150728164311.GA1948@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275322>

Let command-line options override saved options in git-am when resuming

This is a re-roll of [v1]. Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/274789

When resuming, git-am mistakenly ignores command-line options.

For instance, when a patch fails to apply with "git am patch", subsequently
running "git am --3way" would not cause git-am to fall back on attempting a
threeway merge.  This occurs because by default the --3way option is saved as
"false", and the saved am options are loaded after the command-line options are
parsed, thus overwriting the command-line options when resuming.

[PATCH 1/3] tweaks test-terminal.perl to redirect the stdin of the child
process to a pty. This is to support the tests in [PATCH 2/3].

[PATCH 2/3] fixes builtin/am.c, enabling command-line options to override saved
options. However, even with this patch, the following command-line options have
no effect when resuming:

* --signoff overriding --no-signoff

* --no-keep overriding --keep

* --message-id overriding --no-message-id

* --scissors overriding --no-scissors

This is because they are only taken into account during the mail-parsing stage,
which is skipped over when resuming.

[PATCH 3/3] adds support for the --signoff option when resuming by recognizing
that we can (re-)append the signoff when the user explicitly specifies the
--signoff option.

Since the --keep, --message-id and --scissors options are handled by
git-mailinfo, it is tricky to implement support for them without introducing
lots of code complexity, and thus this patch series does not attempt to.

Furthermore, it is hard to imagine a use case for e.g. --scissors overriding
--no-scissors, and hence it might be preferable to wait until someone comes
with a solid use case, instead of implementing potentially undesirable behavior
and having to support it.


Paul Tan (3):
  test_terminal: redirect child process' stdin to a pty
  am: let command-line options override saved options
  am: let --signoff override --no-signoff

 builtin/am.c                       |  42 ++++++++++++---
 t/t4153-am-resume-override-opts.sh | 102 +++++++++++++++++++++++++++++++++++++
 t/test-terminal.perl               |  25 +++++++--
 3 files changed, 158 insertions(+), 11 deletions(-)
 create mode 100755 t/t4153-am-resume-override-opts.sh

-- 
2.5.0.280.gd88bd6e
