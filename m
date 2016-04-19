From: santiago@nyu.edu
Subject: [PATCH v7 1/6] builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
Date: Tue, 19 Apr 2016 13:47:16 -0400
Message-ID: <1461088041-19264-2-git-send-email-santiago@nyu.edu>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:47:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZkM-0002E9-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbcDSRra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:47:30 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36747 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbcDSRr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:47:28 -0400
Received: by mail-qk0-f174.google.com with SMTP id x7so6797530qkd.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tT1VYanqt4jUJmliwQs0eWvE9GJQaxWpt+YdaaRtbCs=;
        b=PtayvZD0xyE8CcODFTY8rm4RtEIEdGsNSSal/HD0coN7HqLy1vVWBxDdv5kD89MJqI
         ZB5ELFhvB4q14BqNGZntmpBHNH6AgafVIOSN8mBR+6LgLO7QPKcPL8ofEKnH8PL7OzCe
         jFV+1Xrqft2I1Fol1mnd6B5lES1wMio7zKP43QDT4ZL1RZvJunMz2NlYwKTF//u9ZHMf
         cZN4V7XtvIvZq5M7XI+ZKUGcu0RKIosYNH1UX13srt+62QGDR5mryw9yzV1L31YBkIxW
         6/mOcl4MNizfAYte+67O7PlBvO3Jjd9DpfOUkXs5DkhYSpiDE7okZ5t/Z1Jil9yuVyi+
         kxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tT1VYanqt4jUJmliwQs0eWvE9GJQaxWpt+YdaaRtbCs=;
        b=mVgRp3qZm++whuy5fXbz3147oY6zhpgHSAL1iQGRGxb/qzieBq82+TAXP9eXhoyv+U
         CHuVqxL+gz51F4RmQMVgP1jga/yfKcfzGqLkqkXSre9cpr6EpcB04j5OnkNHaHLhFGdK
         QRDm8zRwG+hKIK8KTH4DCpEE0A2IvZ7RfckY+C/4IRnAm9Hk8uAUTbXcK2PSLHXlZG7Z
         O5GK4CRZ+Aryhi2ekVzgpaLZYgrX5nY6ToHQiZbBCnwJYeDEre0TptrrhU4U8UgP5xtp
         +h8sh5/sk2isQMeHwD2e0fKrQW/DrIxbQQzko6GJNBkqWliCDqpCjFDZQ/uqE98Z2PvW
         lffg==
X-Gm-Message-State: AOPr4FXWEBVc4nFHulWYpSpgRMyRpRiYuGA9jhmHJs/KCGdKbr6BFI7vaPhjpNRKTb2EcM/4
X-Received: by 10.55.103.68 with SMTP id b65mr1963258qkc.22.1461088047495;
        Tue, 19 Apr 2016 10:47:27 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id w184sm11073374qkw.4.2016.04.19.10.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 10:47:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291885>

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
