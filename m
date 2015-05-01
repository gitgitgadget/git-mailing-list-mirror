From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri,  1 May 2015 15:35:37 -0700
Message-ID: <1430519737-6224-1-git-send-email-sbeller@google.com>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat May 02 00:35:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJXB-0006cw-QB
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbbEAWfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:35:43 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38238 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbEAWfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:35:43 -0400
Received: by igbhj9 with SMTP id hj9so48641705igb.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cpdqn8G8Am95jaWpNqIALUXVdA899vKb7rKQ6ghTPo8=;
        b=nOXvplr3TDv2ZxHvXSFVihv9/LRz+2gy+BDcEYd2uGLNUfxLcMqQjSehclw/VWoNeB
         5OcFeZRIdIikVF1yAHn3+J7Vm8egwI676gCvkdoVCA4E8CBfxm/iuO8p5TO/W1CcSFL9
         waVL0xVFDED8GO2VGgO4+h6ENzqsbxSSA/HiVGoIPwfSnl4s+Yp8kMWjvwjQuAyqj5Vg
         7Ch2QjYlpGCQOm3TFzVuktLrp7gArS2JFupYCgtWPMjS2T/ITUuP9WuEJOoA276CNLG5
         hF4q5YF4EHngPVErPjSGr+AFy5ujty2Qh+BY21WkRnh/MmGds4Usu+6HX/tO3fh38ypN
         pmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cpdqn8G8Am95jaWpNqIALUXVdA899vKb7rKQ6ghTPo8=;
        b=Xv6p7X8X3ejNkYA1lbnrkRogrYyYtNCbefL4+GJJV2Igeg+MR9QMOVzpPrblZPvMKS
         V8ccjn8qtfWxYFxYj07P6sS/jwGcxQ4dtQ+fG9haAP8XSqUF6CqIZNqbZbSTa5FesoAJ
         RlAalH8FuoU+wRXCLSyeWugHpcxOFToeUIXUwuZCtyL/6xP/WQQN3E9PJT7SP4vuIxw7
         rRF4jpUtIlXy7ecjY4wzuKe7uXzK7oC0odubkoLCVGpmNDlZ+/ES28ZeRw19dWyKYijO
         fyCbkcssZDbeWFpbRZfxj8ER2L7QJMVcBTx3lBomGiJn+dvjnI06zixzEyBgZqSQ6DqP
         Yc7w==
X-Gm-Message-State: ALoCoQmWONY4Psni3Iy4vwwWgAYPUv1ChlWqPjm0YPtFWxYxv+GNQ39tu2IIxgcV0YOw/oFj6g9m
X-Received: by 10.43.95.71 with SMTP id cb7mr10947678icc.71.1430519742386;
        Fri, 01 May 2015 15:35:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:b91d:b254:2e9c:5ed9])
        by mx.google.com with ESMTPSA id 9sm4382699iom.29.2015.05.01.15.35.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 May 2015 15:35:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.16.g0ab00b9
In-Reply-To: <1430508507-14016-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268182>

It's safe to free the char pointer `p` unconditionally.

The pointer is assigned just 2 lines earlier as a return from
prefix_path, which allocates new memory for its return value.

Then it is used in checkout_file, which passes the pointer on to
cache_name_pos and write_tempfile_record, both of which do not store
the pointer in any permanent record.
So the condition on when to free the pointer is just "always".

Looking at the history this behavior must be fixed since at least
(f5114a40c0d0, 2011-08-04, git-check-attr: Normalize paths), where
the result of prefix_path is freed unconditionally.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout-index.c | 6 ++----
 builtin/update-index.c   | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9ca2da1..5325f92 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -249,8 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
 		checkout_file(p, prefix);
-		if (p < arg || p > arg + strlen(arg))
-			free((char *)p);
+		free((char *)p);
 	}
 
 	if (read_from_stdin) {
@@ -269,8 +268,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
 			checkout_file(p, prefix);
-			if (p < buf.buf || p > buf.buf + buf.len)
-				free((char *)p);
+			free((char *)p);
 		}
 		strbuf_release(&nbuf);
 		strbuf_release(&buf);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6271b54..584efa5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -534,8 +534,7 @@ static int do_unresolve(int ac, const char **av,
 		const char *arg = av[i];
 		const char *p = prefix_path(prefix, prefix_length, arg);
 		err |= unresolve_one(p);
-		if (p < arg || p > arg + strlen(arg))
-			free((char *)p);
+		free((char *)p);
 	}
 	return err;
 }
-- 
2.4.0.rc3.16.g0ab00b9
