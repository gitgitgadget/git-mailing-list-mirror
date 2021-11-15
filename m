Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7942C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28B563217
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhKOGau (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:30:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52322 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKOGar (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 01:30:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAD291523D8;
        Mon, 15 Nov 2021 01:27:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AFww4L6clSwooDMWPZKWkRvJTNw4Qk+UmLwZ8n
        GmGWA=; b=r5JYOxE0/C98JiqPp2plvMyrEkRw4QroPOVNouyfoJw3qT1ZYcGwI1
        R7P4ZlxUSuHtC4VNhdXU2lQuaz1XnGCPEoXVqhNaWOuruJhvmJ1kbo7IqSpzwy1t
        wulaCchWMW807neE3W6rG3yDVC/Cf8eBMqDLe3oX7JAmiT4RvmSuc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6DF51523D6;
        Mon, 15 Nov 2021 01:27:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D30091523D5;
        Mon, 15 Nov 2021 01:27:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] revision: use C99 declaration of variable in for() loop
References: <20211113122833.174330-1-gotlouemail@gmail.com>
        <20211113130508.zziheannky6dcilj@gmail.com>
        <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
        <xmqq7ddbme7q.fsf@gitster.g>
        <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
        <xmqqilwulims.fsf@gitster.g>
Date:   Sun, 14 Nov 2021 22:27:45 -0800
In-Reply-To: <xmqqilwulims.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        14 Nov 2021 10:03:23 -0800")
Message-ID: <xmqqpmr2j5lq.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25F8CD76-45DD-11EC-A3F3-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are certain C99 features that might be nice to use in our code
base, but we've hesitated to do so in order to avoid breaking
compatibility with older compilers. But we don't actually know if
people are even using pre-C99 compilers these days.

One way to figure that out is to introduce a very small use of a
feature, and see if anybody complains, and we've done so to probe
the portability for a few features like "trailing comma in enum
declaration", "designated initializer for struct", and "designated
initializer for array".  A few years ago, we tried to use a handy

    for (int i = 0; i < n; i++)
	use(i);

to introduce a new variable valid only in the loop, but found that
some compilers we cared about didn't like it back then.  Two years
is a long-enough time, so let's try it agin.

If this patch can survive a few releases without complaint, then we
can feel more confident that variable declaration in for() loop is
supported by the compilers our user base use.  And if we do get
complaints, then we'll have gained some data and we can easily
revert this patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 9dff845bed..44492f2c02 100644
--- a/revision.c
+++ b/revision.c
@@ -43,10 +43,8 @@ static inline int want_ancestry(const struct rev_info *revs);
 
 void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
-	const char *p;
-
 	fprintf(out, "%s ", oid_to_hex(&obj->oid));
-	for (p = name; *p && *p != '\n'; p++)
+	for (const char *p = name; *p && *p != '\n'; p++)
 		fputc(*p, out);
 	fputc('\n', out);
 }
-- 
2.34.0-rc2-165-g9b3c04af29

