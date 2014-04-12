From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] transport-helper: serious crash fix
Date: Sat, 12 Apr 2014 15:33:27 -0500
Message-ID: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4mT-0004Oy-Qf
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbaDLUnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:43:40 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:37724 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbaDLUne (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:43:34 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so7511467obc.24
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=O1V3HgPr/Viqzwc0UUWEW7+uWaMBGD8Ewel8PNCVJvM=;
        b=m3xkB+DkZUz9DlOTr9TdpFCpGOq+XdgbqPsqhRUJBMrlyRFDUAMzGn0hJU8bVuAmeJ
         U4/d4KSRH23Hi7lpecvwFG6MViWwswBO10yZVhmt/onP8AGxTRMQ1V9rMHB3WvDLWjfL
         k/0crLRgIRUd7jhn5LjzlJkKVR5ajChlY4wlG/uRF97pgoIh5NDubbTrv/Wfm+VUEgwL
         duB9IX6ih3Gy9UQxy1hMwBujF+f20R3FfA0GVoknTVWr9Ld71bG3NLId6UY3obwR89b7
         gMv4OtvBNp31LDfBk2gU9G1N9S/2qJXrUrTVEPjt8wfU0xEy62531HqZFrKTZndArU/a
         Yipg==
X-Received: by 10.60.17.132 with SMTP id o4mr15215982oed.34.1397335413470;
        Sat, 12 Apr 2014 13:43:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm49144187oex.6.2014.04.12.13.43.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:43:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246187>

One of the most serious recurring issues[1][2][3] with remote helpers is that
marks get out of sync. The way to analize and reproduce these wasn't trivial,
but the culprit seems to be a crash while doing `git push`. It has been known
already how exactly that happens, but no simple way how to fix it.

This is the simplest way so far; tell `git fast-export` to export the marks to
a temporary file, and move it to the right location only *after* the remote
helper has finished its job without errors.

Since the code wasn't prepared for a change like this, some reorganization
changes are needed. More changes might be welcome to further propagate the
errors properly through the code, but for the moment the errors are propagated
to the right location, in order to fix this specific problem.

[1] http://article.gmane.org/gmane.comp.version-control.git/223962
[2] http://article.gmane.org/gmane.comp.version-control.git/241707
[3] https://github.com/felipec/git/issues/56

Felipe Contreras (5):
  transport-helper: remove barely used xchgline()
  remote-helpers: make recvline return an error
  transport-helper: propagate recvline() error pushing
  transport-helper: trivial cleanup
  transport-helper: fix sync issue on crashes

 t/t5801-remote-helpers.sh | 17 ++++++++++-
 transport-helper.c        | 72 ++++++++++++++++++++++++++++-------------------
 2 files changed, 59 insertions(+), 30 deletions(-)

-- 
1.9.1+fc3.9.gc73078e
