From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] run-parallel: rename set_nonblocking to set_nonblocking_or_die
Date: Wed,  4 Nov 2015 14:43:48 -0800
Message-ID: <1446677029-10745-2-git-send-email-sbeller@google.com>
References: <563A63BA.9020407@web.de>
 <1446677029-10745-1-git-send-email-sbeller@google.com>
Cc: tboegi@web.de, j6t@kdbg.org, gitster@pobox.com,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: sbeller@google.com
X-From: git-owner@vger.kernel.org Wed Nov 04 23:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu6md-000711-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 23:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031010AbbKDWn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 17:43:56 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33666 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030412AbbKDWny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 17:43:54 -0500
Received: by pabfh17 with SMTP id fh17so65614559pab.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 14:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d7CDZGguf7S0LaLNXFZTlfXaGjn458YeaaTh9QCRo2w=;
        b=OsjqCpvmWhoQiTRYYCZPQ9c4FHKy/OHnNU7O/R0y2a8aEkVhmG+/BfOy8NKpIEoeCq
         DiDXvsS83XW6oKPiQ8bV3Bc6JdtCCf97u4mDz7SBhqwzV7aRbCQVtYIB464cbyUPIef8
         7yq6kS6YTtVwBhRHoPQMCgQGT4FNbfJ5/MIRJvE/qpJ6ZJh81aKJKhxsClNUvFF8H/D4
         BWE4FXC+qI1mjylw4FCvc29IHVA1PorljwW0mTH0xlLhn9mYviuSdvIftVigENgwbgKJ
         97UBuMAQQrCrv4ZG6ePzX9RSF6474Y0B4eX09z+eQv38EhRmv3CPiecJYLKH1xm+E9zg
         C5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d7CDZGguf7S0LaLNXFZTlfXaGjn458YeaaTh9QCRo2w=;
        b=YTPs0Po4SjtiR47PmBwPHtaz5LqAoSQRGzdzGSrS0+ndIvYsSrZNVXU5ZgrmbHX4UR
         6SPlz8uLgX++pvYB4Ei7SZ7qouK/xyUb1P6cHPLX55SeLLbCbX5aRnppzpF0xRtJiLYR
         P7sTY8sM6EyqLmw+1/IIBIJWe1sDEhc9bdxfE67tpVlSmCZr1wan3yiQJcpoYSjdDE23
         kx2DQXaar7s2TUzYD5LjRNldKKc5xgIQpkApoEq11rCcGTEwCv9PfsctnMgdsVqfzGaq
         0XM9qtk7CVg25/oDOFafAK8RBgp2iqmVJ9TR1BbuypRIhvPzgr9SGmpk9xPmVm5fujCM
         X7ug==
X-Gm-Message-State: ALoCoQk3LJ6jNcUXxqbLPV2fCSaZvpWvMcZhe6wJVAnKd4sxoHeRpuWueu+aoRcp4gJVIRmi3xDu
X-Received: by 10.68.163.195 with SMTP id yk3mr4973806pbb.120.1446677033799;
        Wed, 04 Nov 2015 14:43:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e456:40e8:5942:d41e])
        by smtp.gmail.com with ESMTPSA id ix1sm3980593pbd.40.2015.11.04.14.43.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 04 Nov 2015 14:43:53 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446677029-10745-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280890>

Discussion turned out a warning is not enough, but we need to die in case
of blocking output as we can lockup the child processes.

Junio wrote:
> Imagine that we are running two things A and B at the same time.  We
> ask poll(2) and it says both A and B have some data ready to be
> read, and we try to read from A.  strbuf_read_once() would try to
> read up to 8K, relying on the fact that you earlier set the IO to be
> nonblock.  It will get stuck reading from A without allowing output
> from B to drain.  B's write may get stuck because we are not reading
> from it, and would cause B to stop making progress.

> What if the other sides of the connection from A and B are talking
> with each other, and B's non-progress caused the processing for A on
> the other side of the connection to block, causing it not to produce
> more output to allow us to make progress reading from A (so that
> eventually we can give B a chance to drain its output)?  Imagine A
> and B are pushes to the same remote, B may be pushing a change to a
> submodule while A may be pushing a matching change to its
> superproject, and the server may be trying to make sure that the
> submodule update completes and updates the ref before making the
> superproject's tree that binds that updated submodule's commit
> availble, for example?  Can we make any progress from that point?

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 0a3c24e..86fbe50 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1006,15 +1006,13 @@ static void pp_cleanup(struct parallel_processes *pp)
 	sigchain_pop_common();
 }
 
-static void set_nonblocking(int fd)
+static void set_nonblocking_or_die(int fd)
 {
 	int flags = fcntl(fd, F_GETFL);
 	if (flags < 0)
-		warning("Could not get file status flags, "
-			"output will be degraded");
+		die("Could not get file status flags");
 	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
-		warning("Could not set file status flags, "
-			"output will be degraded");
+		die("Could not set file status flags");
 }
 
 /* returns
@@ -1052,7 +1050,7 @@ static int pp_start_one(struct parallel_processes *pp)
 		return code ? -1 : 1;
 	}
 
-	set_nonblocking(pp->children[i].process.err);
+	set_nonblocking_or_die(pp->children[i].process.err);
 
 	pp->nr_processes++;
 	pp->children[i].in_use = 1;
-- 
2.6.1.247.ge8f2a41.dirty
