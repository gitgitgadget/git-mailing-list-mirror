From: santiago@nyu.edu
Subject: [PATCH v6 1/6] builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
Date: Sun, 17 Apr 2016 18:26:56 -0400
Message-ID: <1460932021-27633-2-git-send-email-santiago@nyu.edu>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:27:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arvA9-00055l-QK
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 00:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbcDQW1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 18:27:23 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34136 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcDQW1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 18:27:18 -0400
Received: by mail-qk0-f171.google.com with SMTP id r184so51919457qkc.1
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tT1VYanqt4jUJmliwQs0eWvE9GJQaxWpt+YdaaRtbCs=;
        b=IQcUNBnkAnvo1YQLPD/8vQQQWRGXJIFMVJR0FkT1PmNhMV+SeVt2yB5oTS2EcxPQwA
         kMGRRhKhbS8r2GiA6LywGJh2VLcrFXBl2j49F1ZJpssinfyaR3xhydfP3L4Y3WyfuI3N
         lv/yTFl9nllzu7C9QwWJkHdcxxIUKHXa+Ne0jBDo9Z8LkHERgRCTF8m56bPCAtVn5BOs
         LwsHtdMg7/TamCmDZRVSPACwCWd+Z0Fu/YlUK5JNyeh050E0GSferP9HNTlVSN+2iHs3
         OpOJ8oFyqsakgd115IxtyZazpBehIfLo4Pmp9s5z22vmzsIWdBq1rnq0s6aDpkYxj4Yf
         pzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tT1VYanqt4jUJmliwQs0eWvE9GJQaxWpt+YdaaRtbCs=;
        b=Lp2DWp9dWGSXsimiKicND+/ViWymsqXo7T9Zy2mlYnmE40ZDu424Ran/CKKrK5Md8W
         mCvnL6mi/BaTt1hx65Io21buFZVFjra9wLThJzLT7mg98LvyuQG+aXDGjpIHSAkSXIlh
         CwjQ0oya9Ff02c8yDSpiMnxN5lfEoc2qxfLmQgeOzOMfyNdN3hoHHRjt4We9FYRR/n8c
         NvzLJuJNIBSh2MLjiRO/1YUTuVTAdmesgaMOzVLEusydyzS2+Xj4svhO44H0uIlz0ESY
         hY+Y/KezNaZxIhPDMHFjWILV0pKT4K1foDeryo41C/a5bDfZo8MfBbXvKjsVgJ+LsBR+
         +TUQ==
X-Gm-Message-State: AOPr4FUUQYB45stsGitj+v8rB8HLaYq5YwwGCUSsP/TprUjUV1DuHobLSR38t9QN1pZtoAB2
X-Received: by 10.55.79.17 with SMTP id d17mr40137839qkb.56.1460932032496;
        Sun, 17 Apr 2016 15:27:12 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id j75sm5120767qgd.19.2016.04.17.15.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 15:27:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291783>

From: Santiago Torres <santiago@nyu.edu>

The verify_signed_buffer() function may trigger a SIGPIPE when the
GPG child process terminates early (due to a bad keyid, for example)
and Git tries to write to it afterwards.  Previously, ignoring
SIGPIPE was done in builtin/verify-tag.c to avoid this issue.

However, any other caller who wants to call verify_signed_buffer()
would have to do the same.

Use sigchain_push(SIGPIPE, SIG_IGN) in verify_signed_buffer(),
pretty much like in sign_buffer(), so that any caller is not
required to perform this task.

This will avoid possible mistakes by further developers using
verify_signed_buffer().

Signed-off-by: Santiago Torres <santiago@nyu.edu>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/verify-tag.c | 3 ---
 gpg-interface.c      | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 00663f6..77f070a 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -95,9 +95,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	/* sometimes the program was terminated because this signal
-	 * was received in the process of writing the gpg input: */
-	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
 		if (verify_tag(argv[i++], flags))
 			had_error = 1;
diff --git a/gpg-interface.c b/gpg-interface.c
index 3dc2fe3..2259938 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -237,6 +237,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		return error(_("could not run gpg."));
 	}
 
+	sigchain_push(SIGPIPE, SIG_IGN);
 	write_in_full(gpg.in, payload, payload_size);
 	close(gpg.in);
 
@@ -250,6 +251,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	close(gpg.out);
 
 	ret = finish_command(&gpg);
+	sigchain_pop(SIGPIPE);
 
 	unlink_or_warn(path);
 
-- 
2.8.0
