From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 0/7]  Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 14:19:17 -0800
Message-ID: <1455833964-3629-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 18 23:19:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWvE-0005Zk-T1
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946839AbcBRWTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:19:30 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35209 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946730AbcBRWT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:19:28 -0500
Received: by mail-pf0-f177.google.com with SMTP id c10so39995276pfc.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 14:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=D+bC9iXEK4ChVFw6f8LU3jWmG+c7QewF2QwA2dMSJEg=;
        b=nVQlNZHrDhQj525rOCYJYaQL/PiVlK/rJCojMpsuuM1oQD8c5b6DMItxhmRfo3GcAj
         EztIEuVclKfeQeeGnE1i+7kHNKz19WfxtFE3fl0DcxRkuyPGHg+t9YBeOVbvwlG6pdsl
         +X0G/heNYqnUHMvHWrsauIUUvqD6DQifKawpB8PvTDZ7dZXZCzGiZAkHz2Z1YaBvrT8l
         H8YP87ue0ztug2tpTL7SVNP/GajSz+CD95fnBkYuk0U4UaSnjwNHTyTLkx54t4XqoQAq
         4AbnjIij+7USw5UEMZWIqwJ9OwhkXV2dHGd85+mztQUGbDAN2ua9z0UgpPE1CE/10wXS
         2A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D+bC9iXEK4ChVFw6f8LU3jWmG+c7QewF2QwA2dMSJEg=;
        b=EtwrdQBFZukUv7ins3VD2NNzNHHeRCvNPB01L0M9rsJudevOPwmlKQAwpzABRuqP8W
         MpT6Oz3W0FEJAmr8uKKdYZQl8yzcSOR8HEMVSKm7atIunH3p5WYJdOLgkTlBONRpz7QI
         CpJtHPN/hTcVu/0M/gnhUduUUzeKyResPj9rAWvN/MLPgYVv6TMqvSJm5Zl08ycjgMxu
         YRCS8jjObpOgPYV02OK/X3I3ZHWLYszLNXP9+oOS9kr435eifdlIvockNG01VR+n47j2
         For/vBvL81LwMVQqo4QSbq5Ds6khOYyvO6BaGtZKi8YOdc+0aJ/jafA9zkfqjmBVpmXK
         EtXg==
X-Gm-Message-State: AG10YOQ4IMhgpxcJBKaaGKq/4+swLv6nLzKUXlvaOgHZoecNBA/cFmX47lHlx1CvNF5qKG8I
X-Received: by 10.98.42.207 with SMTP id q198mr13820872pfq.103.1455833967393;
        Thu, 18 Feb 2016 14:19:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id s197sm12598706pfs.62.2016.02.18.14.19.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 14:19:26 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286627>

Thanks Junio for a review of v11!

I addressed the memory issue with the interdiff (in patch 1/7) as follows:
Interdiff to v11:

diff --git a/submodule.c b/submodule.c
index 263cb2a..45d0967 100644
--- a/submodule.c
+++ b/submodule.c
@@ -219,6 +219,9 @@ void gitmodules_config(void)
 int parse_submodule_update_strategy(const char *value,
                struct submodule_update_strategy *dst)
 {
+       const char *com;
+
+       free((void*)dst->command);
        dst->command = NULL;
        if (!strcmp(value, "none"))
                dst->type = SM_UPDATE_NONE;
@@ -228,9 +231,10 @@ int parse_submodule_update_strategy(const char *value,
                dst->type = SM_UPDATE_REBASE;
        else if (!strcmp(value, "merge"))
                dst->type = SM_UPDATE_MERGE;
-       else if (skip_prefix(value, "!", &dst->command))
+       else if (skip_prefix(value, "!", &com)) {
                dst->type = SM_UPDATE_COMMAND;
-       else
+               dst->command = xstrdup(com);
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
 submodule-config.c              |  18 ++-
 submodule-config.h              |   2 +
 submodule.c                     |  39 ++++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 406 insertions(+), 49 deletions(-)

-- 
2.7.0.rc0.34.g65aed89
