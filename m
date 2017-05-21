Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CBDF201A7
	for <e@80x24.org>; Sun, 21 May 2017 05:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbdEUFRJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 01:17:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34259 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdEUFRI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 01:17:08 -0400
Received: by mail-io0-f193.google.com with SMTP id 12so10834986iol.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 22:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZTe28/n/Hfwq0fOEAfCnus/EGLZFSWq4+2cYkLM9TLE=;
        b=JwDgBee/l+gVv6loS3iXbvCIr0s1gYFIQQRQlQgx6U2QMAbjjJdTHaaqwQLcXdFZCY
         kmTS+4kP21N2AB6vanDBY3d6gDPIvdmWQIYmB8Qe+/9kCNEslGTSSQfU9DQwiJosw0cV
         40o9+FIhhZ8Ybk5HH8PaGnlCHkjqXUAEp+C7ggLRqv4ZeMOVCfO0r0yDh9p1s9uJSvLw
         15LSXoOTYOVKuex5gE8E/hWNg4o7n/+6AnBpC+MM95HOneUmSiOA2iJxfdKZVAeIg+z4
         XB/Z+1JGZt3xzKsr7V0x9TapDynRXEnKmFi6+vlwy574ycvIvQJZk9aIXPRDTf+gWBm+
         vxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZTe28/n/Hfwq0fOEAfCnus/EGLZFSWq4+2cYkLM9TLE=;
        b=Lt5B6TfPr3Ga0y/4kzLkLANoqwYC13EYe4PWa/JUnxmwClE619lpEHl8Sc6WVJFwio
         cRygBe6bf3vXNOp+QMW4qv9dmZMb0EFvf0ORYgW4U7CUtc6JrHHhw6VvxmQ/b80QARq0
         JtxKQXRtyZ+67wOxYMFJOkbrKYKBTnG5xEV2fObCr7x05xUV+XzBGn98reT3OA4hR47P
         cpZOXPPZpYwYePJrxl1lSO2DkDuRVlaz6Tps2A9jzAm+4a2k9hUjmaOJM9s2VEBMXZdd
         V6iSV6nlZBMi6WX0ZA2kckI5mp8UrbfmwPcVdv2WsNTDOZMD19iuNkweLRicqRdlLpNU
         zYLA==
X-Gm-Message-State: AODbwcBMVcjaXDIdZpvOPuE2lWoE2lkrFgwQxyvHGngaacTVLoOAO9eZ
        GEM9ZNqAqaEm1vlsgca0KbvOAApWb6xQZYY=
X-Received: by 10.107.4.200 with SMTP id 191mr19437376ioe.223.1495343827151;
 Sat, 20 May 2017 22:17:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.18 with HTTP; Sat, 20 May 2017 22:17:06 -0700 (PDT)
From:   Tyler Brazier <tylerbrazier@gmail.com>
Date:   Sun, 21 May 2017 00:17:06 -0500
Message-ID: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
Subject: `pull --rebase --autostash` fails when fast forward in dirty repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This script explains and tests what's going on:
https://gist.github.com/tylerbrazier/4478e76fe44bf6657d4d3da6c789531d

pull is failing because it shortcuts to --ff-only then calls
run_merge(), which does not know how to autostash. Removing the
shortcut fixes the problem:

diff --git a/builtin/pull.c b/builtin/pull.c
index dd1a4a94e..225a59f5f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -868,11 +868,6 @@ int cmd_pull(int argc, const char **argv, const
char *prefix)
      head = lookup_commit_reference(orig_head.hash);
      commit_list_insert(head, &list);
      merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
-     if (is_descendant_of(merge_head, list)) {
-         /* we can fast-forward this without invoking rebase */
-         opt_ff = "--ff-only";
-         return run_merge();
-     }
      return run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
  } else {
      return run_merge();
