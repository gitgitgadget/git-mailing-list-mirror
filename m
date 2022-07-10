Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5313FC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 08:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGJIOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJIOE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 04:14:04 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Jul 2022 01:14:03 PDT
Received: from impout004.msg.chrl.nc.charter.net (impout004aa.msg.chrl.nc.charter.net [47.43.20.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE6011816
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 01:14:03 -0700 (PDT)
Received: from localhost.localdomain ([97.71.114.58])
        by cmsmtp with ESMTPA
        id AS3Ho8LP3lJREAS3LopDXL; Sun, 10 Jul 2022 08:12:31 +0000
Authentication-Results: sunshineco.com; none
X-Authority-Analysis: v=2.4 cv=Ctusz10D c=1 sm=1 tr=0 ts=62ca89ef
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=MQzyZ3sn3-HCdPjj7zMA:9 a=jYKBPJSq9nmHKCndOPe9:22
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Han Xin <chiyutianyi@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] unpack-objects: fix compilation warning/error due to missing braces
Date:   Sun, 10 Jul 2022 04:11:35 -0400
Message-Id: <20220710081135.74964-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.37.0.236.gcef32db0b6.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKRnJM/aj8nxfeiIURVjpYh78LrIHL71sFKoCMKi1N5BdDgT08l+yqr4Tqxc9ip4cXVCHfJO8Nbm+Gp5NKPFJXbht6OR0SmHOFdcH8V6gFqxawLSfvOj
 sBP3DmcAlWBbe8JAaC3JGOHRJzPDCJmGyaRaMnhR/gDuCplwcsBGspzE4KkLhk3Bz7vqCQvSGAgUkEi1XoXEvSZP9JSit4RzJR9slcUxAfqbwMh3AGWFTngT
 QvxQ0hQMd8GvJkhhNJ6I/LgAZimEgMZ1BTghu+o17M+lcuwox5aEEenkJDPrTHHJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On macOS High Sierra (10.13), Apple's `clang`[1] complains about missing
braces around initialization of a subobject, which is problematic when
building with `DEVELOPER=YesPlease` which enables `-Werror`:

    builtin/unpack-objects.c:388:26: error: suggest braces around
        initialization of subobject [-Werror,-Wmissing-braces]
            git_zstream zstream = { 0 };

[1]: `cc --version` => "Apple LLVM version 10.0.0 (clang-1000.10.44.4)"

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    This is atop 'hx/unpack-streaming' which is already in 'next'.
    All the CI builds are fine with this change.

    As I understand it, this should be a safe change; the fields which
    follow `z_stream z` in `git_zstream` will be initialized to zero
    since the first field has an explicit initializer.

 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef2..c606c92e37 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -385,7 +385,7 @@ static const void *feed_input_zstream(struct input_stream *in_stream,
 
 static void stream_blob(unsigned long size, unsigned nr)
 {
-	git_zstream zstream = { 0 };
+	git_zstream zstream = {{ 0 }};
 	struct input_zstream_data data = { 0 };
 	struct input_stream in_stream = {
 		.read = feed_input_zstream,
-- 
2.37.0.236.gcef32db0b6.dirty

