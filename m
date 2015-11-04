From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] run-parallel: Run sequential if nonblocking I/O is unavailable
Date: Wed,  4 Nov 2015 14:43:49 -0800
Message-ID: <1446677029-10745-3-git-send-email-sbeller@google.com>
References: <563A63BA.9020407@web.de>
 <1446677029-10745-1-git-send-email-sbeller@google.com>
Cc: tboegi@web.de, j6t@kdbg.org, gitster@pobox.com,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: sbeller@google.com
X-From: git-owner@vger.kernel.org Wed Nov 04 23:44:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu6mk-000787-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 23:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031011AbbKDWn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 17:43:59 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33686 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031007AbbKDWnz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 17:43:55 -0500
Received: by pabfh17 with SMTP id fh17so65615119pab.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 14:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S0vQgLXbgOP+5KmKv/gfUuoi5Q5HvIpvt9qdVowxRwo=;
        b=VrU9FMfAPnBY7QIg/inLHBNxraILQ+SudhIOvIKVzn+9Rzff2IIuXk7PLBvyXQJN/9
         CkkuQZM8dgyT1/wgrWhmOqPnKHMBqiNrcK+X2lF8qN/peNAceK5O8QcQAVt/KoVCuasU
         rj3d5K0t46XSEjYS+g7BAo8UAuy8UnuGgshtyVxLKlIcGh1L4WJV53Zta46kR0GrJ9Fr
         XwtNSX6SZNXfcZFemXClvluQkd2IHcSCCBsZ/cqf/fxgssbQxpV1vvcb+pMwPfUDJ6rH
         yB5cUMxwcM9ZpvZmsoVd0DbUhL4SzXRFbopbxpuPK/0vO3QUSaflejJEgbtgrazkPzpo
         b+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S0vQgLXbgOP+5KmKv/gfUuoi5Q5HvIpvt9qdVowxRwo=;
        b=RI50bJGAlnY/sEsvoLlyzfSsa2m/3dbMPbeXbgqvUCiZKILD8plKpLKfnNJPY/zzvV
         bNdOzaxvXJO7ZV8sEOA8tqgJw9clC0nlfzE8E9zaOgAkEFlG/yglADCRpp/ocROxCKwz
         7whC51m3E9Yfuw8O6WgpcTqFEEeTS2Cg6QtOBae26PNt0blPCcPeZAPGd0wbQV4QBV9K
         /xrLAqtmrfXStbClY5oJZEogKzBQEstrmnXmp6uRVLU9m4s+L9W4WdTjBQGmbCGjVkvY
         v0JGwnjMZ32XN9rCblrp6NEthk9PczZX6lYGIFPpdMspf0zpTCFJXGCL6BO7UDnx1St0
         jq6w==
X-Gm-Message-State: ALoCoQnkufVuoxHWD8ITLJWoBBFeRzE5OQvVl6k8T1adZoDAewxiFXAi6pzbY9RBwbu7b73sF3kH
X-Received: by 10.68.182.130 with SMTP id ee2mr4954541pbc.156.1446677035326;
        Wed, 04 Nov 2015 14:43:55 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e456:40e8:5942:d41e])
        by smtp.gmail.com with ESMTPSA id sx1sm3986649pbc.36.2015.11.04.14.43.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 04 Nov 2015 14:43:54 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446677029-10745-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280891>

Windows doesn't have O_NONBLOCK nor F_GETFL defined, so we need cannot run
in parallel there. Instead the children will output directly to our stderr
and we run one child at a time.

Bonus: We are setting process.err = -1; which we previously expected the
get_next_task callback to do. It is easy to forget that part in the callback
leading to hard to debug errors.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 86fbe50..19de253 100644
--- a/run-command.c
+++ b/run-command.c
@@ -958,6 +958,10 @@ static struct parallel_processes *pp_init(int n,
 	if (n < 1)
 		n = online_cpus();
 
+#if !(defined (O_NONBLOCK) && defined (F_GETFL))
+	n = 1;
+#endif
+
 	pp->max_processes = n;
 	pp->data = data;
 	if (!get_next_task)
@@ -1006,6 +1010,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 	sigchain_pop_common();
 }
 
+#if defined (O_NONBLOCK) && defined (F_GETFL)
 static void set_nonblocking_or_die(int fd)
 {
 	int flags = fcntl(fd, F_GETFL);
@@ -1014,6 +1019,7 @@ static void set_nonblocking_or_die(int fd)
 	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
 		die("Could not set file status flags");
 }
+#endif
 
 /* returns
  *  0 if a new task was started.
@@ -1031,6 +1037,12 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		die("BUG: bookkeeping is hard");
 
+#if defined (O_NONBLOCK) && defined (F_GETFL)
+	pp->children[i].process.err = -1;
+#else
+	pp->children[i].process.err = 2;
+#endif
+
 	if (!pp->get_next_task(&pp->children[i].data,
 			       &pp->children[i].process,
 			       &pp->children[i].err,
@@ -1049,8 +1061,9 @@ static int pp_start_one(struct parallel_processes *pp)
 		strbuf_reset(&pp->children[i].err);
 		return code ? -1 : 1;
 	}
-
+#if defined (O_NONBLOCK) && defined (F_GETFL)
 	set_nonblocking_or_die(pp->children[i].process.err);
+#endif
 
 	pp->nr_processes++;
 	pp->children[i].in_use = 1;
-- 
2.6.1.247.ge8f2a41.dirty
