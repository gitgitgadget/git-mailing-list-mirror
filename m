From: Dan Albert <danalbert@google.com>
Subject: [PATCH] Uses git-credential for git-imap-send
Date: Sat, 26 Apr 2014 10:50:26 -0700
Message-ID: <CAFVaGhudmcrh32_h3RPmR_E7e3Jo9xc6AEt5AtN2W5NVbEMg6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 19:50:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6kY-0004j5-ED
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbaDZRuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:50:50 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:46096 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbaDZRut (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:50:49 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so3977848lab.34
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=+P7f4l5qgGSRS4L20I/i8ngvpOVj8T794xdjPA7nlpg=;
        b=AFSvQMdJu3PRIQD/RgvNtx/Cp6bm3XN7X9zl5Ng5cc+zuqndft8XTaOcvGuwm4XbLa
         hnvMtGz5i+jvc5dxidV6vJHJmet+93oehuaFhyINZDgM7RDbsO0DPaH4c5Oibxx1xLZt
         2gw/rlxCwnGq516olJ5Z/8FbBuGIQZ+3NoaESIq/KmmwELxVVmokgpw7tQYvizc1xhU6
         2YDl/NtilONt8dLgtJ01cgpbFVjBN54c9ULEgb1dTgHqIEd4ZoSnDELDvkbRaZ9cstdw
         D/BZPoMlXazmv0yYuRAIQ7e+H0X/1k2MahBWQuVFQlyydbykAkmLwkk2nNNcv+qbwfoF
         5ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=+P7f4l5qgGSRS4L20I/i8ngvpOVj8T794xdjPA7nlpg=;
        b=FL02wGQjWQZXAnlEUqPxhcNASV8wNR/L8mGKzZrYV3tk0v5iU/o6B3W28SJKHznKWP
         xrr6B1FFWBXmoAiV2dCfKnIychUdikI0/GbNIzp65gCiYdl48QTCWfGnw+yMvf4GIeGr
         Sp5pJoHFMr44WqEniwG4Qdm+09BVKZ6VtNnOg/ba2us8bPFf+C+IvkJQRx8kWgaishXa
         SzEa2woepu/4yiOm2wYpf6eVqu3LnaR/W7XF334sj5qqqmuFD1Eb/iOGIB1E3sE2mjNY
         LCIPNIOuCTomnwF+zS0UkS4FyndbbY3IfQi+I6RRJkYDt2C92KjvPT9jiPBpLcWXj752
         M9YA==
X-Gm-Message-State: ALoCoQk35sKZYPF9+xUl1EllGbU01pgupHn8LEg1ayIZWGtNhFYYPia/A9PXaTz0InNeD/gw0RdXV5taU/RjoTbIFoU6C/40nLhMRTKu8DcfQFGlLa5aq0FV26BuHdBijMpi87InDFmv6mHY/IC8whXWDYVOMoW2sE5Ffy1UYdUrB/YFxunPqhsoy+McW87/vvKftpRew2eS
X-Received: by 10.112.85.6 with SMTP id d6mr10354722lbz.8.1398534647001; Sat,
 26 Apr 2014 10:50:47 -0700 (PDT)
Received: by 10.112.168.166 with HTTP; Sat, 26 Apr 2014 10:50:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247172>

git-imap-send was directly prompting for a password rather than using
git-credential. git-send-email, on the other hand, supports git-credential.

This is a necessary improvement for users that use two factor authentication, as
they should not be expected to remember all of their app specific passwords.
---
 imap-send.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 0bc6f7f..262fb9a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,9 +23,9 @@
  */

 #include "cache.h"
+#include "credential.h"
 #include "exec_cmd.h"
 #include "run-command.h"
-#include "prompt.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
@@ -946,6 +946,7 @@ static int auth_cram_md5(struct imap_store *ctx,
struct imap_cmd *cmd, const cha

 static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 {
+ struct credential cred = CREDENTIAL_INIT;
  struct imap_store *ctx;
  struct imap *imap;
  char *arg, *rsp;
@@ -1101,19 +1102,11 @@ static struct imap_store
*imap_open_store(struct imap_server_conf *srvc)
  goto bail;
  }
  if (!srvc->pass) {
- struct strbuf prompt = STRBUF_INIT;
- strbuf_addf(&prompt, "Password (%s@%s): ", srvc->user, srvc->host);
- arg = git_getpass(prompt.buf);
- strbuf_release(&prompt);
- if (!*arg) {
- fprintf(stderr, "Skipping account %s@%s, no password\n", srvc->user,
srvc->host);
- goto bail;
- }
- /*
- * getpass() returns a pointer to a static buffer.  make a copy
- * for long term storage.
- */
- srvc->pass = xstrdup(arg);
+ cred.username = xstrdup(srvc->user);
+ cred.protocol = xstrdup("imap");
+ cred.host = xstrdup(srvc->host);
+ credential_fill(&cred);
+ srvc->pass = xstrdup(cred.password);
  }
  if (CAP(NOLOGIN)) {
  fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
srvc->user, srvc->host);
@@ -1153,10 +1146,18 @@ static struct imap_store
*imap_open_store(struct imap_server_conf *srvc)
  }
  } /* !preauth */

+ if (cred.username)
+ credential_approve(&cred);
+ credential_clear(&cred);
+
  ctx->prefix = "";
  return ctx;

 bail:
+ if (cred.username)
+ credential_reject(&cred);
+ credential_clear(&cred);
+
  imap_close_store(ctx);
  return NULL;
 }
-- 
2.0.0.rc1.1.gce060f5
