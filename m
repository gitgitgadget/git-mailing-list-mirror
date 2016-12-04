Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEBB1FF40
	for <e@80x24.org>; Sun,  4 Dec 2016 00:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751939AbcLDAYZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 19:24:25 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33694 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbcLDAYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 19:24:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id 3so11973950pgd.0
        for <git@vger.kernel.org>; Sat, 03 Dec 2016 16:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NX2IAgJNstZZB3Be9TkF8HPwV+0vgn0myBOnQxVtgXo=;
        b=O4Ycw2Yo2KACi7ZYJMOzWcVBzgiuZPL5d++WK/XaaOUdExiE6htyyVWGL/0mQO1Dkg
         d4r4BXOYWjuFO48fLXL3RTgwVAHwjdG7i7q2bIowiJllC9VYwX3YDn6VX5xlz04hzURJ
         1uN6mQUQRnqiIbDmFhl1dwJpzHYwFH3EK5JgGtknySuJUG/0edYcwgUUW1gG3JiVsWJP
         YIQNJY/r6xJ62l87OmB7IZ8zoU9/PVIPDPuCjIre694WxCLPI/KndqyJ+i7uU0Zi/c1M
         MVTCniBYwqQntVZOhu4vtW2LEFn+EkAnBN87vWQBZmBL6OmeE3H46E75TPOqLHipwAHv
         5i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NX2IAgJNstZZB3Be9TkF8HPwV+0vgn0myBOnQxVtgXo=;
        b=eN9akAv9U0zODm+iwmRqkYsNh2S36GFVnmZjpleI9eSnZlsR24P3qJo3Tr+vxfbb+4
         zbgqVs7HbTW4+k2HMN038hyfoQt24tQz26G3av7JJLnJkKF0I/DkQ74rtY86Lr77VeC2
         dCagttnQv9s4F4Eu7ssmCJ0WK6cdm7y1eJbAvBEG8FeecBxXwiqLJbixhCk3lbDcm6e0
         URzbFdqKcNC7rU6W+b0KTv4/ib66zjsRkW2gFRWBH7j3fuAJi1nsUSrEdTcuR+MXT3oK
         G7wp1mNbT4byX7nVS8mEfwKFLCd+YIwVqDdq71YFUQe9h3z1hKFIRxUC3Bn3sgyzku+1
         JGpw==
X-Gm-Message-State: AKaTC015mFl9WX0edniSHp/q08EvD8SKvZWuhUhDrUS5QWvRbibGmLH4JnkfiXhhlu9eAQ==
X-Received: by 10.99.246.83 with SMTP id u19mr91209181pgj.165.1480811048073;
        Sat, 03 Dec 2016 16:24:08 -0800 (PST)
Received: from localhost.localdomain ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id l3sm17185824pgc.41.2016.12.03.16.24.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 03 Dec 2016 16:24:06 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Git v2.11.0 breaks max depth nested alternates
Date:   Sat,  3 Dec 2016 16:24:02 -0800
Message-Id: <fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent addition of pre-receive quarantining breaks nested  
alternates that are already at the maximum alternates nesting depth.

In the file sha1_file.c in the function link_alt_odb_entries we have  
this:

 > if (depth > 5) {
 >         error("%s: ignoring alternate object stores, nesting too deep.",
 >                         relative_base);
 >         return;
 > }

When the incoming quarantine takes place the current objects directory  
is demoted to an alternate thereby increasing its depth (and any  
alternates it references) by one and causing any object store that was  
previously at the maximum nesting depth to be ignored courtesy of the  
above hard-coded maximum depth.

If the incoming push happens to need access to some of those objects  
to perhaps "--fix-thin" its pack it will crash and burn.

Originally I was not going to include a patch to fix this, but simply  
suggest that the expeditious fix is to just allow one additional  
alternates nesting depth level during quarantine operations.

However, it was so simple, I have included the patch below :)

I have verified that where a push with Git v2.10.2 succeeds and a push  
with Git v2.11.0 to the same repository fails because of this problem  
that the below patch does indeed correct the issue and allow the push  
to succeed.

Cheers,

Kyle

-- 8< --
Subject: [PATCH] receive-pack: increase max alternates depth during quarantine

Ever since 722ff7f876 (receive-pack: quarantine objects until
pre-receive accepts, 2016-10-03, v2.11.0), Git has been quarantining
objects and packs received during an incoming push into a separate
objects directory and using the alternates mechanism to make them
available until they are either accepted and moved into the main
objects directory or rejected and discarded.

Unfortunately this has the side effect of increasing the alternates
nesting depth level by one for all pre-existing alternates.

If a repository is already at the maximum alternates nesting depth,
then this quarantining operation can temporarily push it over making
the incoming push fail.

To prevent the failure we simply increase the allowed alternates
nesting depth by one whenever a quarantine operation is in effect.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

Notes:
    Some alternates nesting depth background:
    
    If base/fork0/fork1/fork2/fork3/fork4/fork5 represents
    seven git repositories where base.git has no alternates,
    fork0.git has base.git as an alternate, fork1.git has
    fork0.git as an alternate and so on where fork5.git has
    only fork4.git as an alternate, then fork5.git is at
    the maximum allowed depth of 5.  git fsck --strict --full
    works without complaint on fork5.git.
    
    However, in base/fork0/fork1/fork2/fork3/fork4/fork5/fork6,
    an fsck --strict --full of fork6.git will generate complaints
    and any objects/packs present in base.git will be ignored.

 cache.h       | 1 +
 common-main.c | 3 +++
 environment.c | 1 +
 sha1_file.c   | 2 +-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index a50a61a1..25c17c29 100644
--- a/cache.h
+++ b/cache.h
@@ -676,6 +676,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
+extern int alt_odb_max_depth;
 
 /*
  * Accessors for the core.sharedrepository config which lazy-load the value
diff --git a/common-main.c b/common-main.c
index c654f955..9f747491 100644
--- a/common-main.c
+++ b/common-main.c
@@ -37,5 +37,8 @@ int main(int argc, const char **argv)
 
 	restore_sigpipe_to_default();
 
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT))
+		alt_odb_max_depth++;
+
 	return cmd_main(argc, argv);
 }
diff --git a/environment.c b/environment.c
index 0935ec69..32e11f70 100644
--- a/environment.c
+++ b/environment.c
@@ -64,6 +64,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
+int alt_odb_max_depth = 5;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/sha1_file.c b/sha1_file.c
index 9c86d192..15b8432e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -337,7 +337,7 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 	int i;
 	struct strbuf objdirbuf = STRBUF_INIT;
 
-	if (depth > 5) {
+	if (depth > alt_odb_max_depth) {
 		error("%s: ignoring alternate object stores, nesting too deep.",
 				relative_base);
 		return;
---
