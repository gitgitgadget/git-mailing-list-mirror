From: santiago@nyu.edu
Subject: [PATCH v8 1/6] builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
Date: Fri, 22 Apr 2016 10:52:00 -0400
Message-ID: <1461336725-29915-2-git-send-email-santiago@nyu.edu>
References: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:52:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcRU-0005C3-Sd
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbcDVOwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:52:14 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36695 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbcDVOwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:52:12 -0400
Received: by mail-qg0-f43.google.com with SMTP id d90so27831511qgd.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tT1VYanqt4jUJmliwQs0eWvE9GJQaxWpt+YdaaRtbCs=;
        b=gZDhnscSzKSAsXh8FpJ0jlZxq47rJjE2TQ8Vhfffx4PoHOOD/JVh4AJgbUIoUE6ECO
         Bopw5CxIVkNDFh+fTZ8KQaphOAl/JqALqBmt2B6o+Y41EH4zzkc+sHx4GN5WQyWJODcF
         ff/LDnoNIO2mgOF0grMZlSiU6ODdkkZ0sgKJ8UyJxarEF7aOmhzd+XfQ/EKVzgd36q/O
         azMs9ha+Zoi1jlzfDynNV1KFKXBATPk09VRqOalkuozJCnPlzIqHP0EkT0vhSB7SlAZ2
         dajzCXAZWLByBxM4ER6kuROyZoK5/xGw4+gvFpAagXO4GSbMg0PlOuqwRsSuOLeK53mY
         8cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tT1VYanqt4jUJmliwQs0eWvE9GJQaxWpt+YdaaRtbCs=;
        b=LLm2qacbGPAnbMO4DS/FHR/EFgHTq+Ej0RFsIrIuXmfNjo3MkPdi7qd3f92OJFyaK0
         LibtfCVBynxKPvD6W7v7g3nozVsdVDZbyK7gvzgyiProcl452RTbzfOnzvWYZBvLGkHq
         7wIFKWnq3sflCS9sYRAHqW+A/N/TcG9kpei6PLu3bXYSy3hsD6v7tTg5SouD6F1JvK4c
         hDeQlD2AzeWf4Uc3493zI67vwMspMga1zSyFbBKa/LyMi33PXtQZbhi3Uhmd6UoOZRWg
         /l+gNuICNxiMArl1+Z511b7dliEwfNuPUV6PkitxnhHbKmXuyLB47WLNTFzVwnmPuPrt
         ZxoA==
X-Gm-Message-State: AOPr4FUtxw6dQ2X+PAxhn77iQtuDtZF6zTa5vuvsX68QgN+8BGgBj5grgsJX6UqWTb6eGkE7
X-Received: by 10.140.202.81 with SMTP id x78mr22978533qha.15.1461336731910;
        Fri, 22 Apr 2016 07:52:11 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id s67sm2583005qgs.48.2016.04.22.07.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 07:52:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292222>

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
