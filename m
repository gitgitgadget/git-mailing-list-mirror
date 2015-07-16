From: Dave Borowitz <dborowitz@google.com>
Subject: Bug: send-pack does not respect http.signingkey
Date: Thu, 16 Jul 2015 12:45:16 -0700
Message-ID: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 21:45:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFp6E-0003CF-J0
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 21:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbGPTpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 15:45:38 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37168 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbbGPTph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 15:45:37 -0400
Received: by igbpg9 with SMTP id pg9so21838906igb.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3gV7e4vk1zVLSumzJlS2INIgbaRae/1kpornIFS2+Cw=;
        b=ekrnBLaSTKIl4CDxEpEuWTbDLvq46SxdQ2oo4CH/KlCoPEv9numXU03xsiVebOJmm/
         iRaw3jmaYIf4szh7wV0xIkywlZmwTs/q7wIpgddx3OxsTyYy5vVYUXoL+8aOhc0tuVRf
         xtLssYQ3zJZatjz5RCqqFYroDOMiMZq0ZqMOoHY1uAae21dxdGFITfiU3gb4GpI8AIOS
         hZeUmGGQSVXaDUU09BKv7JgQ2wq/O+wvlwkuOJ7Ih+00cyS5dugfRDLuTxYcwnQI/FWS
         QDrk8gzdUymrL4O5wWW0aDJmXmFZWdBY5MaFvWT4HsVDXBViKUPmKxEAPDGrZtGrRUwE
         K7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=3gV7e4vk1zVLSumzJlS2INIgbaRae/1kpornIFS2+Cw=;
        b=EVQnLWaSb08vsUqshmxWVDw+aO/f0iK5Nzyo6QswnOxKuNyoQkT/vGaR0lsfqIZbzm
         +EnQDWGAQkc3rZY7OI4jDKbAKvXVmt7S1dVETTSxa6RdCGLFr3x2XFT2ZIKBdAFENOZt
         326MQ51EgEoDXO/wCFFQXU2HJv3pLT/gX453Hols7q4RtBoTRLPH4McWI3vE5LEQ6A+P
         wbUVqINL6yA/ACRwm6TjVsMrLFGP/Y4GD4tz7nhXEsuMAPQRDvTpKMMcHu/5SMlD+hdO
         3ewRz7UA+wg3Ru2SPmicuftHwKqLgHQcmt8AxIhhHc+FWB59AgprTaZlRo49RGN66Hh2
         3kFg==
X-Gm-Message-State: ALoCoQmN17O76splV5mxqoi+9xFyF9NoXA8+spMA4xMOhnMebRC8x8tje8S8rjY1afuzgaZkjOut
X-Received: by 10.107.132.7 with SMTP id g7mr13898722iod.9.1437075936341; Thu,
 16 Jul 2015 12:45:36 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Thu, 16 Jul 2015 12:45:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274038>

When git-send-pack is exec'ed, as is done by git-remote-http, it does
not reread the config, so it does not respect the configured
http.signingkey, either from the config file or -c on the command
line. Thus it is currently impossible to specify a signing key over
HTTP, other than the default one matching the "Name <email>" format in
the keyring.

This is not an issue for git:// as send-pack is executed directly in
the same process that reads the config.

---
 gpg-interface.c | 1 +
 run-command.c   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 68b0c81..e0ffcb0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -87,6 +87,7 @@ void set_signing_key(const char *key)
 int git_gpg_config(const char *var, const char *value, void *cb)
 {
  if (!strcmp(var, "user.signingkey")) {
+ fprintf(stderr, "setting %s\n", value);
  set_signing_key(value);
  }
  if (!strcmp(var, "gpg.program")) {
diff --git a/run-command.c b/run-command.c
index 4d73e90..39ae8d5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
+#include "gpg-interface.h"
 #include "exec_cmd.h"
 #include "sigchain.h"
 #include "argv-array.h"
@@ -344,7 +345,7 @@ fail_pipe:
  cmd->err = fderr[0];
  }

- trace_argv_printf(cmd->argv, "trace: run_command:");
+ trace_argv_printf(cmd->argv, "trace: run_command (%s):", get_signing_key());
  fflush(NULL);

 #ifndef GIT_WINDOWS_NATIVE
-- 
2.4.3.573.g4eafbef
