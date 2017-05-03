Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8BE207B3
	for <e@80x24.org>; Wed,  3 May 2017 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdECD3v (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 23:29:51 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34421 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdECD3p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 23:29:45 -0400
Received: by mail-yw0-f196.google.com with SMTP id u70so13433319ywe.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 20:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vBXOAnv4TqyI5nqYsuo+udw5It8wUhv1doQQxwBCflc=;
        b=fBnM9S4zKLXLuZgMi3rij9ycokH7ywJ/BPr7m/rTVNID6ppmqu6PdTP6XEZral5w7M
         QlEPsyqmwiP6mkdTpAip/1kRoKHs/8dysb7MToojYwWwXVGhhbhwRmlvL7gUx08wThw+
         OvE0FvhNTCIPH8TI6pal8/MtMNvk1eVVW4vIkyjl41GGUZoKsFzI6f40HYDCPkhSMDOD
         vPPN/NUpbKc6SwSrRxSl8JlJKWKNWh+26H+6CioeYfVTWQULwYPPN/QM5iDeACUfEZhd
         8xTdhq+eU7vKC5JgxIL5Se/XNxSLMxFc0sbBC32sA9wECy8XKqKSZ49788KUYgHhhC/m
         jvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vBXOAnv4TqyI5nqYsuo+udw5It8wUhv1doQQxwBCflc=;
        b=pZeWF+4ytQEm7D9RsN3msOzIGnkVNFpmvJrKKhf+/MyJynhYP8N0jElSAhKyBd3tmO
         UeTqUienG8UY1n1od+Y3/vl8sI37JRO0RmOvVQBmnBAA7QK6oSzVTENuOwz01KYrzTah
         GWEQxl67Cte02U1psBu+ZMoDg85jPEiX3ZZlnoFnyFIKpxMmnqAtMKkT2U4H1eaxKSan
         5B8IGFHKLn6oAMMlW42S3Ik/REDAm9M+MKcyVc1ocquKSYz4D6b3rvKtnB6CRspwYQgM
         a3FNk6AOb8Flbbehrh5ghopts+7Tz3iQl/Md91Gcxo4MiSAERyiWpgQj8FgilTsPFwIH
         EHgQ==
X-Gm-Message-State: AN3rC/7vF7u48rpmDGdd6+QjS3wBBhYSgxVSNIYaZYcvj6hNymsBSWrZ
        IwYdFNdqpN+LSG0p
X-Received: by 10.129.129.1 with SMTP id r1mr27047883ywf.245.1493782184183;
        Tue, 02 May 2017 20:29:44 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.23])
        by smtp.gmail.com with ESMTPSA id v3sm11329586ywi.79.2017.05.02.20.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 20:29:43 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 2/7] dir: recurse into untracked dirs for ignored files
Date:   Tue,  2 May 2017 22:29:27 -0500
Message-Id: <20170503032932.16043-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
 <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We consider directories containing only untracked and ignored files to
be themselves untracked, which in the usual case means we don't have to
search these directories. This is problematic when we want to collect
ignored files with DIR_SHOW_IGNORED_TOO, though, so we teach
read_directory_recursive() to recurse into untracked directories to find
the ignored files they contain when DIR_SHOW_IGNORED_TOO is set. This
has the side effect of also collecting all untracked files in untracked
directories as well.
---
 dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f451bfa48..6bd0350e9 100644
--- a/dir.c
+++ b/dir.c
@@ -1784,7 +1784,12 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			dir_state = state;
 
 		/* recurse into subdir if instructed by treat_path */
-		if (state == path_recurse) {
+		if ((state == path_recurse) ||
+				((get_dtype(cdir.de, path.buf, path.len) == DT_DIR) &&
+				 (state == path_untracked) &&
+				 (dir->flags & DIR_SHOW_IGNORED_TOO))
+				)
+		{
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
-- 
2.12.2

