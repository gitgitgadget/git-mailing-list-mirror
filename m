From: santiago@nyu.edu
Subject: [PATCH v3 1/4] builtin/verify-tag.c: Ignore SIGPIPE on gpg-interface
Date: Sat,  2 Apr 2016 19:16:12 -0400
Message-ID: <1459638975-17705-2-git-send-email-santiago@nyu.edu>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 01:17:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amUmy-0004ZP-OI
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 01:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbcDBXQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 19:16:56 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33662 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbcDBXQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 19:16:55 -0400
Received: by mail-qk0-f196.google.com with SMTP id d3so738140qke.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7/jXPFREr7OA9ugH04J7uzu2LTgXBnzQ0P7gNEwt+Js=;
        b=CboT5V+N8deqYDRCxglgxY0RBToAWMcYWSzo5G9kUdvcKeS7ljQ1ipUZuxNRiBY4L+
         U6FDJA3NF7KBGsB8u1zYvx6IacggvDToV+9Al/hiItWzOwSXnRpFV23vUrLqPNyebbgS
         bABOTBrSJnwuB99h3uvP6rhZVsjBJpHpySNOqhRCTiXzeSUswD2osZIvSr7vofworsld
         6dZYwkA8JyNozzEZCiIjF+6j3yma0L/iuir6YR3jp3HQNjL0/DIz+5nomGzsm1OGbEK7
         b8ewHmBz7zJjUdjazNr1IisG/n0CTzEhV/wmGRkfC6eR5XuZefd5mNUcbs73cm3d01ty
         wi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7/jXPFREr7OA9ugH04J7uzu2LTgXBnzQ0P7gNEwt+Js=;
        b=HWun2wmQpAUHNAiud7/20Si6QUeh0oAodCqoBOGmUrAFAcDKxy2SvQy62BO/fqyJEe
         IEtGYKbfMoNB8kKXH5QKWi3Ns6OGQ9/e7R1hgscE4n/npP11rRYHGAbcXIjH6UW6zV6b
         3g8yyk1zbLo+g1/8T8xDy4zSDXZSpSQWSbB9Tf75BYgGWLP/cmCuzKSsPAmRU5aLD3eM
         bmIEmfkjenPZd7cberkK1+k9/IdxuI9Q/O9V655eghOH27crZRZYcdubx0d4n0LOFbD5
         JTo7Hhy4W6a+rYKWrHYuQgxAn9ltxmdVJSnwaG1mdzqQWWT+Oj0IohELFNESOpXggLeq
         Am9w==
X-Gm-Message-State: AD7BkJK5KbooGOc3oy/D1DiYXlN7J0K46rJl7iiSfRQtUHYRu/RDS17yf0OGLt/+8mI4THIl
X-Received: by 10.55.41.205 with SMTP id p74mr26918143qkp.65.1459639013334;
        Sat, 02 Apr 2016 16:16:53 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id l33sm9199788qge.11.2016.04.02.16.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 16:16:52 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290609>

From: Santiago Torres <santiago@nyu.edu>

The verify_signed_buffer comand might cause a SIGPIPE signal when the
gpg child process terminates early (due to a bad keyid, for example) and
git tries to write to it afterwards. Previously, ignoring SIGPIPE was
done on the builtin/gpg-verify.c command to avoid this issue. However,
any other caller who wanted to use the verify_signed_buffer command
would have to include this signal call.

Instead, we use sigchain_push(SIGPIPE, SIG_IGN) on the
verify_signed_buffer call (pretty much like in sign_buffer()) so
that any caller is not required to perform this task. This will avoid
possible mistakes by further developers using verify_signed_buffer.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
Notes:
 I dropped the multiline comment altogheter.

 builtin/verify-tag.c | 3 ---
 gpg-interface.c      | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 3dc2fe3..c1f6b2d 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -232,6 +232,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	if (gpg_output)
 		gpg.err = -1;
 	args_gpg[3] = path;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
 	if (start_command(&gpg)) {
 		unlink(path);
 		return error(_("could not run gpg."));
@@ -250,6 +252,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	close(gpg.out);
 
 	ret = finish_command(&gpg);
+	sigchain_pop(SIGPIPE);
 
 	unlink_or_warn(path);
 
-- 
2.8.0
