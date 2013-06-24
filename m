From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] commit: make it work with status.short
Date: Mon, 24 Jun 2013 18:15:12 +0530
Message-ID: <1372077912-18625-3-git-send-email-artagnon@gmail.com>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 24 14:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur6CW-0004ZQ-0n
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 14:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101Ab3FXMsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 08:48:45 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64311 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3FXMsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 08:48:43 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so10966696pab.39
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KPzL4ahzLdV9RGApi7+Gbad5arw/AMd6/qtK08Bh9mw=;
        b=eDF14XvJZUNLulfhq/4E/Z9hSTzHUo0I4/PFEz1wPF5fROqdtYJmqUtqZRLmo7DVQY
         bbFdL7MkX2Uv7M2clKr/Jl2VMZbmTiCP9fG8l0+Q6FP23Z6xq4DwUl8+Xduow/rd6AvP
         GsiZvUwFK/buzmyqmuVUhGa/zskGvsgQ5jJ/WaBfTk6y7tOsB83o4SD6KnCAuLq8hvcK
         9Jaj62rzFIA86bEuO+yDhipy5QziJeGfMveG6FO9ydHS9yshtPr56rd7t9fpcl2zlfOM
         Yw7BeYNbdMdoR9IwY34PvVxdNCCB1v/PEdm4m0lwkGDhWeqaBwRhvob9ZYuIhFIjmONr
         Z8ZA==
X-Received: by 10.66.141.104 with SMTP id rn8mr8261603pab.52.1372078122771;
        Mon, 24 Jun 2013 05:48:42 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id yj2sm18024267pbb.40.2013.06.24.05.48.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 05:48:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.550.gd96f26e.dirty
In-Reply-To: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228810>

50e4f75 (status: introduce status.short to enable --short by default,
2013-06-11) introduced a regression in git commit; it is now impossible
to commit with status.short set.

This happens because commit internally runs run_status() to set
s->commitable and determine whether or not there is something to
commit.  The problem arises from the fact that only STATUS_FORMAT_NONE
(or STATUS_FORMAT_LONG) is equipped to set s->commitable.
7c9f7038 (commit: support alternate status formats, 2009-09-05) clearly
states that --short and --porcelain imply --dry-run and are therefore
only intended for display purposes.

The bigger problem is that it is impossible to differentiate between a
status_format set by the command-line option parser versus that set by
the config parser.  So these two are exactly equivalent:

  $ git -c status.short=true commit
  $ git commit --short

To alleviate this problem, clear status_format as soon as the config
parser has finished its work to nullify the effect of parsing
status.short, and get commit to work again.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 896f002..dc5ed7d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1448,6 +1448,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 	gitmodules_config();
 	git_config(git_commit_config, &s);
+	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	determine_whence(&s);
 	s.colopts = 0;
 
-- 
1.8.3.1.550.gd96f26e.dirty
