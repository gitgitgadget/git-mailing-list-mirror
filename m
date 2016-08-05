Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47F51F859
	for <e@80x24.org>; Sat,  6 Aug 2016 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbcHFVKP (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 17:10:15 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36095 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcHFVKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 17:10:14 -0400
Received: by mail-pf0-f172.google.com with SMTP id h186so106962629pfg.3
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 14:10:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:references;
        bh=tR9zKi2rJ1ldn7rENtuHSWU8+UJTyYw7Io46Uk7gWZU=;
        b=G+l0NW9VKsJEUh6NN4Cai6qvvMs/74r67OaX0yWve7pyMhEk/Oi7kRJ68085HkG00A
         SAKGXGd9I8yczUtN/eLciQj50hq3O9fX+0WRYTUuwK3XCU7Y9vvIgu3EytQjFPgNIOQF
         QcJIl47+iXxdXajPBOP6VoSr5gBv6LbemLxFL5PLj7Ymcw1SnHkblmS0x27npuSdZJBj
         K/WvTNfklLri5WbmFcvzRxEhRk+eVfxpC8B9qKxCTsU8TJx50FgStUJNtaCLjw4q6rat
         ZinoMi4F8AX/9znkZKagdXCSoTOc10rlYhKIF6Ay6IEs9AzcCqDqg1B7ubkq8oCm9r80
         q5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references;
        bh=tR9zKi2rJ1ldn7rENtuHSWU8+UJTyYw7Io46Uk7gWZU=;
        b=gGRewbbmnXnVtSSxNpJjPRFE0v4ErbSVGNA0vvSdoXwIOGIrjKHY45iMkvkkqY6W9w
         7saKvEVWYNN8mYmEwZtvqJmwQDk2P1pHd4X7krgo/NKdfZGW+cDuQ6kqo8b39SuoEeC5
         /wotb0wWEzQpWMm925SUzFLsuS7DYrumn086vK5b8PqX1l/seeiEeNntfMC1EdDfkf4M
         wG5D6wx55OSSIAHYLXj1m+S3nEaCA5qr5clVZ1NpBW5ihajM7HjJaPnZtJGORadMsbwI
         xaNzfWDNuMIUS2gbnMgsHSMSsE+0FcL16e0VcdzIW3Bk89L8fhmRuq48IntzN51vjaVM
         wY2g==
X-Gm-Message-State: AEkoouu03OFLj5zEzXqPkHMdGzR6SM5vF1+yY4lKpKl9QxXJfvOQqNnM2dqcCYlA80pUUvtS
X-Received: by 10.98.94.6 with SMTP id s6mr121333173pfb.31.1470439608091;
        Fri, 05 Aug 2016 16:26:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c0da:b815:bea9:a8ab])
        by smtp.gmail.com with ESMTPSA id h1sm30462776pay.48.2016.08.05.16.26.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 16:26:47 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Rename detection within in files WAS: [PATCH 2/6] t7408: merge short tests, factor out testing method
Date:	Fri,  5 Aug 2016 16:26:43 -0700
Message-Id: <20160805232643.23837-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
References: <20160804195159.7788-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When moving code around, we usually get large chunks of text. If the contributor
is not 100% trustworthy, we need to review all the code without much intelectual
joy. Essentially the reviewer is just making sure the parts of the text are the
same.

I'd like to propose a new addition to the diff format that makes this use case
easier. The idea is to mark up lines that were just moved around in the file
instead of adding and removing them.

Currently we have 3 characters that
are allowed to start a line within a hunk:
' ' to indicate context
'+' to add a line
'-' to remove a line

I'd propose to add the following characters:
'*' which is the same as '+', but it indicates that the line was moved
    from somewhere else without change.
'X' The same as '-', with the addition that this line was moved to a different
    place without change.

The patch below uses these new '*' and 'X'. Each hunk that makes use of these
additions, is followed other sections, [moved-from, moved-to] that indicate
where the corresponding line is.

There are multiple things to tackle when going for such an addition:
* How to present this to the user (it's covered in this email)
* how to find the renamed lines algorithmically.
  (there are already approaches to that, e.g. https://github.com/stefanbeller/duplo
  which is http://duplo.sourceforge.net/ with no substantial additions)

Any comments welcome,

Thanks,
Stefan

---
 t/t7408-submodule-reference.sh | 50 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 29 deletions(-), 6 moved lines

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index afcc629..1416cbd 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -10,6 +10,16 @@ base_dir=$(pwd)

 U=$base_dir/UPLOAD_LOG

+test_alternate_usage()
+{
+	alternates_file=$1
+	working_dir=$2
+	test_line_count = 1 $alternates_file &&
*	echo "0 objects, 0 kilobytes" >expect &&
*	git -C $working_dir count-objects >current &&
*	diff expect current
+}
+
 test_expect_success 'preparing first repository' '
 	test_create_repo A &&
 	(
@@ move-source 42,6 @@ test_expect_success 'that reference gets used with add' '
 test_expect_success 'that reference gets used with add' '
 	(
 		cd super/sub &&
X		echo "0 objects, 0 kilobytes" > expected &&
X		git count-objects > current &&
X		diff expected current
 	)
 '
@@ -42,44 +52,20 @@ test_expect_success 'preparing superproject' '
 	)
 '

-test_expect_success 'submodule add --reference' '
+test_expect_success 'submodule add --reference uses alternates' '
 	(
 		cd super &&
 		git submodule add --reference ../B "file://$base_dir/A" sub &&
 		git commit -m B-super-added
-	)
-'
-
-test_expect_success 'after add: existence of info/alternates' '
-	test_line_count = 1 super/.git/modules/sub/objects/info/alternates
-'
-
-test_expect_success 'that reference gets used with add' '
-	(
-		cd super/sub &&
X		echo "0 objects, 0 kilobytes" > expected &&
X		git count-objects > current &&
X		diff expected current
-	)
-'
-
-test_expect_success 'cloning superproject' '
-	git clone super super-clone
-'
-
@@ move-to 10,6 @@ test_alternate_usage
+	alternates_file=$1
+	working_dir=$2
+	test_line_count = 1 $alternates_file &&
*	echo "0 objects, 0 kilobytes" >expect &&
*	git -C $working_dir count-objects >current &&
*	diff expect current
+}
+
--
2.9.2.572.g9d9644e.dirty
