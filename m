Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A83C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF90206CA
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NcXMDzwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgKWWRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:17:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54101 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgKWWRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:17:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 082F5F11B1;
        Mon, 23 Nov 2020 17:17:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zmDLQ1OwIMxInuIDjRspfysYMLE=; b=NcXMDz
        wd92Z8jVEQNpPG2DJtGxWiq6M6mIzOjk2rSKJ6z10XYRfnH2wJ5nexVKbgVr0QZV
        4j+Bi6WU+0dYOuXFL0CNtIJqH2Dv6FP+FxwSnd32ztiYXmtC/nTQilTfpeq7mWpN
        Yc6T0O8qrt6YAvJGLRVA9doBNL9e8QRypYwEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ljQn4ENd+hroF5x7XZgN7gXGFe8XN8uD
        lY6LCvzefHb6528bXhZRvNCIiOTDR2pkAdwaekq6gijMLJv/9WNVQD4wQrXIAhCn
        YV43g+XeGGaqrje9IaEc9mj2kVu5/tRxZGxa3yAdJsmyi6/iMAyoKXB+Yxf9J4p3
        zdh4pIWTq60=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F22FAF11B0;
        Mon, 23 Nov 2020 17:17:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37D4BF11AB;
        Mon, 23 Nov 2020 17:17:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mktag: don't check SHA-1 object length under SHA-256
References: <20190826014344.16008-11-sandals@crustytoothpaste.net>
        <20201123120111.13567-1-avarab@gmail.com>
        <xmqqlferoq1m.fsf@gitster.c.googlers.com>
        <X7wrbI/pefHJsfdY@coredump.intra.peff.net>
Date:   Mon, 23 Nov 2020 14:17:32 -0800
In-Reply-To: <X7wrbI/pefHJsfdY@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 23 Nov 2020 16:36:44 -0500")
Message-ID: <xmqqft4zn2f7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF9E077A-2DD9-11EB-A6FA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It might just be me, but "object name" makes me think we'd take any name
> (e.g., a refname that resolves to an object), whereas "object id" would
> mean the object's hash specifically. And in this instance we only allow
> the latter.

Yeah, but glossary-content is very much explicit about this.  "name"
is the full hexadecimal hash, "identifier" is a synonym for it.  And
"id" does not even appear to be defined.  We used to call "any name
that refers to an object" an "extended SHA-1", but I haven't seen
the phrase used for a long time on the list.

> I agree very much with your other comments that if we are changing
> these, we should get away from <sha> completely.

Yup.

I've always found it cumbersome that, when I want to mean a full hex
representation, I have to say "40-byte object name".  It is not even
technically correct these days with SHA-256.

We'd probably need to update the glossary to make sure we have ways
to refer to "a way, any way, to name an object" and to "the
hexadecimal representation of the full hash value that refers to an
object".  Here is my attempt to redefine "object ID" to be the
narrower one, while losing "usually a 40-character hex" from "object
name".  I am not sure if I like the result as a whole, but it
certainly is nice to have a word or phrase shorter than "full hex
object name" to refer to it.

Thanks.

 Documentation/glossary-content.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
index 090c888335..e2ab920911 100644
--- c/Documentation/glossary-content.txt
+++ w/Documentation/glossary-content.txt
@@ -262,13 +262,20 @@ This commit is referred to as a "merge commit", or sometimes just a
 	identified by its <<def_object_name,object name>>. The objects usually
 	live in `$GIT_DIR/objects/`.
 
+[[def_object_id]]object ID::
+	Synonym for <<def_object_identifier,object identifier>>.
+
 [[def_object_identifier]]object identifier::
-	Synonym for <<def_object_name,object name>>.
+	An <<def_object_name, object name>> written as an
+	unabbreviated hexadecimal representation of the hash value
+	that uniquely identifies an <<def_object,object>>.
+	Also colloquially called <<def_SHA1,SHA-1>>.
 
 [[def_object_name]]object name::
-	The unique identifier of an <<def_object,object>>.  The
-	object name is usually represented by a 40 character
-	hexadecimal string.  Also colloquially called <<def_SHA1,SHA-1>>.
+	A name that identifies an <<def_object,object>> uniquely,
+	which can be given in various ways, including but not
+	limited to, the object's full <<def_object_identifier,object
+	identifier>>, a <<def_ref,ref>> that refers to the object.
 
 [[def_object_type]]object type::
 	One of the identifiers "<<def_commit_object,commit>>",
