From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv14 0/7] Expose submodule parallelism to the user
Date: Fri, 19 Feb 2016 10:17:06 -0800
Message-ID: <1455905833-7449-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 19:17:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpcd-00015c-1k
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992737AbcBSSRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 13:17:20 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34107 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992705AbcBSSRR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:17:17 -0500
Received: by mail-pa0-f48.google.com with SMTP id fy10so54120669pac.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xy5cRrUmuj2yc1o+tVUH5do+oovjoh1ldY1TY3KLLHo=;
        b=XBbkgBcarA75+/10/qUedrcCKQ+fxZhNuyyCpFvm5nK6Xj0o0bkL5l1oX4Z/ySlDG8
         CEIcD1VkHZh8Hk/nGBSJY7hBnP6K1vHVI3MfVMPrnO5lkoBZt50pmXYDa04Vdfs4IlOw
         8KSh5mAmq4OZ7yvzZ+8WDjXzZWC4BHirSZNx13MnT9vDBsuuU/Gw/Z8SMiUc0s1M4g1J
         IA/Rhw36Q2U1Umjx++gMsxvcSZG8u0woEk0hNCZm09gGlRPQqFtFdwO7nVN/5/dLfxcc
         1va1acnKhc8jzxa0krvZ344iGp1saP9wFQvXUsy1/Eh5suLgMppuR7nt5i1xM7TpsEcD
         QLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xy5cRrUmuj2yc1o+tVUH5do+oovjoh1ldY1TY3KLLHo=;
        b=VbyetUvjHPK4qNQ0Pt3zNZwTg4t9mwxeWY+KDyhgsY0h/TSZv+VQnGUBVXj6QoMATM
         uiAFsw42phG4CWxV7B/PfJfg01rGmn1Oxni4IeYReSF8lVCPQGNTsJE3pQMAoBez26k+
         C0LFtqyRssQ67DSkp67lVCsSUjDk8eK9uvkx4rwNxg6G3jSwa8Fo3+ie5YDNQLhFs0Dg
         5IeOIqty4RYOlzBmVxK7fqTh35QrwnV0el8c9dyn5SvyS4xj2BJNZNOPLtMgbz95k+UJ
         PFpIBEVBGVG0KcNv8GkMeaRRbmTP29MkNLXYLj0Y6Ex8zMP86kYbDOXqPUOG59w02coe
         JqmA==
X-Gm-Message-State: AG10YORwZdW4qj/mE7aaOSK7P7/xFoAvgJk28/POBt39NVq8s6e8tfba1CcvhzGK1IxTD9sR
X-Received: by 10.66.146.100 with SMTP id tb4mr19387563pab.99.1455905837038;
        Fri, 19 Feb 2016 10:17:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id n68sm19313780pfj.46.2016.02.19.10.17.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 10:17:15 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286730>

Thanks Junio, Jeff and Eric for reviewing once again!

* fixes as proposed by Junio for readability in parse_submodule_update_strategy
* Do not leak the `url`, as found by Jeff.
  (I dug into the code of argv_array_pushl and you're obviously correct)

Thanks,
Stefan

Interdiff to v13:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 65bdc14..c435c53 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -356,13 +356,11 @@ static int update_clone_inspect_next_task(struct child_process *cp,
 
                argv_array_pushl(&cp->args, "--path", sub->path, NULL);
                argv_array_pushl(&cp->args, "--name", sub->name, NULL);
-               argv_array_pushl(&cp->args, "--url", strdup(url), NULL);
+               argv_array_pushl(&cp->args, "--url", url, NULL);
                if (pp->reference)
                        argv_array_push(&cp->args, pp->reference);
                if (pp->depth)
                        argv_array_push(&cp->args, pp->depth);
-
-
        }
 
 cleanup:
diff --git a/submodule.c b/submodule.c
index b54d92d..051f722 100644
--- a/submodule.c
+++ b/submodule.c
@@ -219,7 +219,7 @@ void gitmodules_config(void)
 int parse_submodule_update_strategy(const char *value,
                struct submodule_update_strategy *dst)
 {
-       free((void*)dst->command);
+       free((void *)dst->command);
        dst->command = NULL;
        if (!strcmp(value, "none"))
                dst->type = SM_UPDATE_NONE;
@@ -229,9 +229,9 @@ int parse_submodule_update_strategy(const char *value,
                dst->type = SM_UPDATE_REBASE;
        else if (!strcmp(value, "merge"))
                dst->type = SM_UPDATE_MERGE;
-       else if (value[0] == '!') {
+       else if (skip_prefix(value, "!", &value)) {
                dst->type = SM_UPDATE_COMMAND;
-               dst->command = xstrdup(value + 1);
+               dst->command = xstrdup(value);
        } else
                return -1;
        return 0;

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
 builtin/submodule--helper.c     | 237 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 submodule-config.c              |  19 +++-
 submodule-config.h              |   2 +
 submodule.c                     |  37 ++++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 403 insertions(+), 49 deletions(-)

-- 
2.7.0.rc0.34.ga06e0b3.dirty
