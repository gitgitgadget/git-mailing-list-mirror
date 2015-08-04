From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 0/3] am: let command-line options override saved options
Date: Tue,  4 Aug 2015 22:05:13 +0800
Message-ID: <1438697116-27799-1-git-send-email-pyokagan@gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 16:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcsI-0000ZF-7M
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 16:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934215AbbHDOHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 10:07:18 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35303 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934029AbbHDOHP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 10:07:15 -0400
Received: by pdrg1 with SMTP id g1so5010643pdr.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PxH8rvN5zXXcdXxOvUuIOKwR0F7Wtb+sT6pwkOzRd/0=;
        b=kCSqXWUNa2pMaakIf0uSMoPT9envSYUR6nThXS4bQZPNB4PIDGbNgZvn1Uwtt6p8EJ
         a6OP56kpwzxCVag1nP3021yM/wiDRMv0W6IwXWo8VvO7pE3goEgQqRJTxcJk1iKJRqGh
         d12cILi/KcPVVkyiiBjCOU5R1a9lZsT5v5ZgNQYn9waxg4sOZL+FZFv/ZgSGs4CnhSk4
         SpHxzKXYkEnbQ+i0JxGHK9tde/MYwuUB4qqjf5mowL6oEUEdR8QlXaWHABwWm8JrKTck
         MWEfaCAGLc8YDJ7SvSU0ggu7QzfpQLVhQ+F8173jYyK4CP01xj9fd65bJ8z5RVKMTWnR
         zHBw==
X-Received: by 10.70.37.77 with SMTP id w13mr8240833pdj.49.1438697235384;
        Tue, 04 Aug 2015 07:07:15 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id wc8sm1574274pab.45.2015.08.04.07.05.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 07:06:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <20150728164311.GA1948@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275321>

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
