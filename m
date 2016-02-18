From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv13 0/7] Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 15:33:11 -0800
Message-ID: <1455838398-12379-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 00:33:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWY4d-0003rg-Vc
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948678AbcBRXdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:33:23 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33858 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946440AbcBRXdW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:33:22 -0500
Received: by mail-pa0-f46.google.com with SMTP id fy10so39090097pac.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+HEe+y+44iHM9wKqrYywuyZ1VGmcTCwhGVSga/eN8t8=;
        b=AHmYm4+JEAhL34uPRcDa1Y14qUghdi4IZRLm7cq8Wq9EtJ8IkR4nHy+mMqpGXpV339
         NOSm5ZNTIAN0JzgN0J/n8pTLOJfjCmPDgqIlwzvs6LiH25jZqdDLOg8OdMqWnbcj5m5W
         9dzEZlcsM0Y0geyRW/ypI8vS7YJ0YsYlIL9NqMmgXPyTj1A/THIX+7LMUuvSmZhFXb9+
         Jr/jJ4rxatLIFatsi1R4Po8qbS6rj02hQsvGB6+qXC42OjzJqgZIewYXWYZ5qqn5hFDG
         ZT8vhpNg7IZf1ge+0yvgUGo/RfFmSSTxpvIoeaxjY40F5Ug3AH/KukX3wcbIyY57hcJ2
         7c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+HEe+y+44iHM9wKqrYywuyZ1VGmcTCwhGVSga/eN8t8=;
        b=TcrmBPUAkxh96EZN59freLIsLc1f7ObomPTzIGjIs/R0eNXc8UEJbGy5N24Edxe1IW
         sXNYG8kJquEOY2w9K4UQrPTd7gvNjcgf2nQ92NxE1XiNXzB9141KAoWWn/vZ1DMQSrOQ
         aIJYhUtFu+hgTWLFGVjIWxP+kgu+y6Ka/7cL1/EXK0a6eqvrwS2jXs6KObjSWeGz2HYq
         gW85wLebwhprLpmDPeWxbKjB7Gryh2eXiX/kxz5aWr9mmtuCFdfffMkpZ1F69BggRIyn
         S1557BKUonGNwOUSLXIIrPEHa5JSKvLcdX0eAMWVCgIJttltpzNiJaI5pq0ilp0GdaO4
         lNvw==
X-Gm-Message-State: AG10YOTSflD/VekP6DIyesKVrg6+cDdvwHOqVuCt3fiEQ9ltfTzaqqObRIEoQNIhE5HH6WD+
X-Received: by 10.67.6.226 with SMTP id cx2mr13927598pad.93.1455838401970;
        Thu, 18 Feb 2016 15:33:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id y15sm12869508pfi.16.2016.02.18.15.33.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 15:33:21 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286646>


Thanks Junio, for the discussion about the last issue!
I changed to check for '!' in the code as well as addressing the
cleanup afterwards.

Thanks,
Stefan

Interdiff to v11(! not v12)

diff --git a/submodule-config.c b/submodule-config.c
index 02bcaa7..9fa2269 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -59,6 +59,7 @@ static void free_one_config(struct submodule_entry *entry)
 {
        free((void *) entry->config->path);
        free((void *) entry->config->name);
+       free((void *) entry->config->update_strategy.command);
        free(entry->config);
 }
 
diff --git a/submodule.c b/submodule.c
index 263cb2a..c1211d7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -219,6 +219,7 @@ void gitmodules_config(void)
 int parse_submodule_update_strategy(const char *value,
                struct submodule_update_strategy *dst)
 {
+       free((void*)dst->command);
        dst->command = NULL;
        if (!strcmp(value, "none"))
                dst->type = SM_UPDATE_NONE;
@@ -228,9 +229,10 @@ int parse_submodule_update_strategy(const char *value,
                dst->type = SM_UPDATE_REBASE;
        else if (!strcmp(value, "merge"))
                dst->type = SM_UPDATE_MERGE;
-       else if (skip_prefix(value, "!", &dst->command))
+       else if (value[0] == '!') {
                dst->type = SM_UPDATE_COMMAND;
-       else
+               dst->command = xstrdup(value + 1);
+       } else
                return -1;
        return 0;
 }

Stefan Beller (7):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  fetching submodules: respect `submodule.fetchJobs` config option
  submodule update: direct error message to stderr
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 239 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 submodule-config.c              |  19 +++-
 submodule-config.h              |   2 +
 submodule.c                     |  37 ++++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 405 insertions(+), 49 deletions(-)

-- 
2.7.0.rc0.34.g65aed89
