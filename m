Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91585C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 21:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjAAVL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 16:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjAAVL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 16:11:27 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BD4E03
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672607481; bh=x7cjfZ7KMeM2SwlWMYB/78/G1wZPqyNuZVlFjQP5EUQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=QVXgpgmaxBGpAUcB3nN5B7XaNTk3SAGKu6fzAIiJyVXI9tletjYFpjzI40FzmiKXG
         rGz2CAbNhYlEbkokSeAhH7rBovqceO7hn8moj+uHAf5TG24zzwDE2lw1yUeLAiQO9t
         gN23XnTjIaGs2gZKPMtlx0JQ7dOBUvdISEnP+lPXCDKVlzhdClcV/piISg173GVfp8
         ZWjE5pCzFPQ2vH+/o3i0DrXW6JQCDkJqvB7sgMYSkVK9uqFCa/sZaDqhSR02NBnzgV
         sWHEbwRnmsib0D2C35SUltZKxO6Md2mM1ZSrBKTQj4++DLkvI8ZCXeZ80lMMI1TPRA
         nBUQqTHc+Wn5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sG3-1okbvL3hct-018Llz; Sun, 01
 Jan 2023 22:11:20 +0100
Message-ID: <4f161041-b299-f79a-e01b-cc00e2880850@web.de>
Date:   Sun, 1 Jan 2023 22:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [PATCH v2 2/4] do full type check in BARF_UNLESS_COPYABLE
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
In-Reply-To: <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8s/nIL0LvrfGmQmCp3A15ct3jjIeInVy9e7Kq0Q6pA+dSlAfQ09
 HTBhK2bnGIon4rJB4DP7Yka33I9oAxccyrqhjycaeVfgjiNB3pKWuaHp+N4yOoowdoE01m9
 ToX/8pPfPXJWtRYzpm+Ig35FKsK+NXT6HDtUWvJGhb1m/GxW+/nqOtb2J/fhrINCAsMh74n
 11ZjcHgHnaoTrTs2RippA==
UI-OutboundReport: notjunk:1;M01:P0:NO++KzPp9RI=;z1pus/KYyaPshvugbanmiSoVWJW
 bzCxxPjpoUy+JoScEvRJIuJ2BrIqcj5A6DcNrsOi3B+LqVKmAKsn+PLV2813RpOwbogvtTRNw
 Ch1rzkrWBAYRr5GOIcxUQNeDOIkYkJBmHsu8ubddPAITA7HVH686yQRuEDkAebIPheHHtuNBW
 XT+P4SXORhytksO09phaV1RsDj1m2t4IXH2vfOt9nYOENqBSLnaEfFz4/xXr0V6lU5+Th0pWw
 EnUWDbkN4q+8FGhcwCf2OcrnFk23L9ct0fKbPVM/HOdL9gvEfGv9OHxfb+6hTINbzJCdwdG3u
 QwtUe0jGJ+v9XJ/oXlsadWZ5fFFR/c/g8TciqjmYZcO0v3kYMnOYR5X5peJqAKJy45toIOBnt
 H6nm3TFv6nhz9Pyes2UNFRbvKmQJDySI+hSTWTj1nD4UZ2TGzkA5dYIDg4w3bPEk8Icd5JgR3
 NA8nHEcKDrWe5XWyKXA0Vnin0/vdBoTyzCTC0HC1fynq9WlZEJkET2t1SydaqzfI1ekjVJH6d
 rIkAYYxYZarhAGDxkQqwKqsXjRFHG/AOrfzRenjCd4o9zsfRy2R8COqFnZTJsf8FJp/IkdWpz
 zduAyS3yE2u4JXmq1xmNuS2FIG3L4ih52xr4ylKBBwEdNanKWfSHXV36xrlSrxOgcuphz9S/t
 ShGqKsdDeyloWGiSI6nSFrcso4cdFxC4UOK87YKDwDAxJEP5Se31Hb2RaVwhJTInMvr/e35Ur
 YTuFrK5AiGrd7Ss7uzNyCeup3t2LZj/4LX6oH0bZvLo8pz49SPtOkUQrGMln3vvqzqqb0c8W2
 KqRo7CtZWTUy6HZyg0lk0BCrcc+w7W4JD3YHfUAadweOIfDykKQuxlFD+PCtv+7yTlFrraDnt
 JdGqfXGuRNtT5rcIia0kDftXXp0Sz8cRqBM3lCsMMl0HdYQXBJqs3f5mztT/E10461mhTVFkf
 Z0QtU2RKgmCuPTuqd9MGKNYt2QU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use __builtin_types_compatible_p to perform a full type check if
possible.  Otherwise fall back to the old size comparison, but add a
non-evaluated assignment to catch more type mismatches.  It doesn't flag
copies between arrays with different signedness, but that's as close to
a full type check as it gets without the builtin, as far as I can see.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 940d03150c..e81bb14fc9 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -97,8 +97,14 @@ struct strbuf;
 # define BARF_UNLESS_AN_ARRAY(arr)						\
 	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(arr), \
 							   __typeof__(&(arr)[0])))
+# define BARF_UNLESS_COPYABLE(dst, src) \
+	BUILD_ASSERT_OR_ZERO(__builtin_types_compatible_p(__typeof__(*(dst)), \
+							  __typeof__(*(src))))
 #else
 # define BARF_UNLESS_AN_ARRAY(arr) 0
+# define BARF_UNLESS_COPYABLE(dst, src) \
+	BUILD_ASSERT_OR_ZERO(0 ? ((*(dst) =3D *(src)), 0) : \
+				 sizeof(*(dst)) =3D=3D sizeof(*(src)))
 #endif
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
@@ -1093,9 +1099,6 @@ int xstrncmpz(const char *s, const char *t, size_t l=
en);
 #define CALLOC_ARRAY(x, alloc) (x) =3D xcalloc((alloc), sizeof(*(x)))
 #define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), st_mult(sizeof(*(x)=
), (alloc)))

-#define BARF_UNLESS_COPYABLE(dst, src) \
-	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) =3D=3D sizeof(*(src)))
-
 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(ds=
t)) + \
 	BARF_UNLESS_COPYABLE((dst), (src)))
 static inline void copy_array(void *dst, const void *src, size_t n, size_=
t size)
=2D-
2.39.0
