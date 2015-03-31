From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/6] wt-status.c: fix a memleak
Date: Mon, 30 Mar 2015 18:22:09 -0700
Message-ID: <1427764931-27745-5-git-send-email-sbeller@google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	knittl89+git@googlemail.com, worldhello.net@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:22:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yckt6-0008Tx-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbbCaBWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:22:32 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38719 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbbCaBWU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:22:20 -0400
Received: by igbqf9 with SMTP id qf9so4980939igb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFXsFbPSbsEkUO5KvuEqgW3Rn5zO+MXlBCBSWgZUSsA=;
        b=oEaftrFDy1ktvvwGNg3CDs7SJ5vrKMOC3YXRlD/6AOOzEUbCGT2MUHwRwNwUHKi1LK
         C5qsKHmEnoWLp5P/VYpqiYWwOyQ4gc++ihqr8ocOIK9n/MKy8NCFdsZP+40yUyz3h6Gp
         GZ8Qd/ZU29z8PzG3Sn0JWGTJqPSnYOYfaNdqxkf9DBMXkJqvMBFlSL8YPtn3hS7losDl
         PXi41cnKW5mzv/13Tsf0KiFRn4VNQ0WYRKLFsaQvinbO6C9dZXwolHdD+DQyg9WTRqTz
         a3z/H7A3OzBQ7OU081cu3468kVGLhate6WJDvD/unDLAiD3sHGb/ULkD9miQEFfMV+Cn
         pVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vFXsFbPSbsEkUO5KvuEqgW3Rn5zO+MXlBCBSWgZUSsA=;
        b=AkjZj/hiuHMW5ftT30jYuf32Tn4aj5ynuNlzan1bqAdxn6O+vvJiC69EU9joPq9saQ
         /O5QqxWzK4AUDNGvRt1vL/fx7vovZboXK0Z6/WrRbchLkk+18cGZ+6VokShbq9chbaFl
         kaSrxHu/wU5xkAT3tZQBO/uwuvHboEda4uwopBTP9vkRo65YkOYwYf5v1ZPVh+hy+90T
         MEM08wLYR135O0/gVtm10+pvJ1UMELXQ8zLZZLGqeBVq0JX5qP84MyiY9qjUoCi3D9wg
         5cRYgC/qiS2PxVzT8CmxJbwP6Q+pfv2+wjWl4pw43ZD/7Sswau5s5ysIqXRQDt3fDJ0q
         Yfzw==
X-Gm-Message-State: ALoCoQnLXZN3rYTyf4uab/hxvDFOCXsh0Vd2kw4CurjhMRJjPuztsR6cBl8njlWiid2DiXFMyIcs
X-Received: by 10.107.134.9 with SMTP id i9mr51610505iod.90.1427764938469;
        Mon, 30 Mar 2015 18:22:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3c88:d48a:4382:4b5])
        by mx.google.com with ESMTPSA id d19sm8634282ioj.37.2015.03.30.18.22.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 18:22:18 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427764931-27745-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266502>

In any code path of shorten_unambiguous_ref the return value is a
xstrdup(some string), so it is safe to free the variable `base`
in any codepath.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 wt-status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wt-status.c b/wt-status.c
index 853419f..38cb165 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1550,6 +1550,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	base = shorten_unambiguous_ref(base, 0);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
+	free((char *)base);
 
 	if (!upstream_is_gone && !num_ours && !num_theirs) {
 		fputc(s->null_termination ? '\0' : '\n', s->fp);
-- 
2.3.0.81.gc37f363
