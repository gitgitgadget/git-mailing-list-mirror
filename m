Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73D2C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6A220829
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VdfSe8bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMSUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:20:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55271 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:20:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1CC4DD02D;
        Thu, 13 Aug 2020 14:20:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MePGIGYqLbxI
        un1i6dr9Y1uMrf4=; b=VdfSe8bPJHb4tWjFdoranJezf5zYoG9GFPy9xp706RDn
        rvHuCW8ANz5zq2bP24CYnU75N33nuPzoPyaNxELQr7d/V+e8t/vLvt0dI4nTZvgh
        Sd43GUI8erNL/KZ+QilsmWxaviTd3fu5fdNzLSDa3E4YzM7Y23phSF0St+35Dfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OsT3GN
        azsgAHMvNahahx6ntKV383BQtbWmamk7LkYnsKdLiMT6kEOK5KlQQOs9PynrfZhd
        sJ2Eiz4wUYkymJIlsJtzx0UErxr++FW72UFuJ4sCzy/tqOpu9gr5aLcqbJjnBpyb
        wMD5r1vMG4faCk4iQ/Dzi4mfMOCMufoLykjdI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABEA1DD02C;
        Thu, 13 Aug 2020 14:20:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3978DD029;
        Thu, 13 Aug 2020 14:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fast-export: factor out print_oid()
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
        <20200813151856.GE2244@syl.lan>
Date:   Thu, 13 Aug 2020 11:19:58 -0700
In-Reply-To: <20200813151856.GE2244@syl.lan> (Taylor Blau's message of "Thu,
        13 Aug 2020 11:18:56 -0400")
Message-ID: <xmqqmu2y2ysx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 993843B2-DD91-11EA-81F3-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +static void print_oid(const struct object_id *oid, int anonymize)
>> +{
>> +	const char *oid_hex =3D oid_to_hex(oid);
>> +	if (anonymize)
>> +		oid_hex =3D anonymize_oid(oid_hex);
>> +	fputs(oid_hex, stdout);
>> +}
>> +
>
> The fact that this calls fputs makes this patch (in my own opinion)
> noisier than it needs to be. This is because of all of the factoring ou=
t
> of the other printfs. I'd expect that this looks something more like:
>
>   -				       anonymize ?
>   -				       anonymize_oid(oid_to_hex(&spec->oid)) :
>   -				       oid_to_hex(&spec->oid));
>   +				       anonymize_oid(anonymize, &spec->oid));
>
> without moving around all of the other printf code.
> ...
> So, I guess what I'm trying to say is that this patch doesn't look
> wrong, other than that it seems more invasive than I would have expecte=
d
> it to be.

Yes, that matches my knee-jerk reaction.  I also shared Peff's
reaction that the code to generate the message is now even more
fragmented into pieces.

Just for comparison purposes, I tried to fold anonymize_oid()'s body
into Ren=C3=A9's print_oid() and adjusted the calling sites, which did
not look too bad.

So, I dunno.

 builtin/fast-export.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f37895d4c..bef2c01bd8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -413,11 +413,16 @@ static char *generate_fake_oid(void *data)
 	return hash_to_hex_algop_r(hex, out, the_hash_algo);
 }
=20
-static const char *anonymize_oid(const char *oid_hex)
+static const char *anonymize_oid(const struct object_id *oid, int anonym=
ize)
 {
-	static struct hashmap objs;
-	size_t len =3D strlen(oid_hex);
-	return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
+	const char *oid_hex =3D oid_to_hex(oid);
+	if (anonymize) {
+		static struct hashmap objs;
+		size_t len =3D strlen(oid_hex);
+		return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
+	} else {
+		return oid_hex;
+	}
 }
=20
 static void show_filemodify(struct diff_queue_struct *q,
@@ -476,9 +481,7 @@ static void show_filemodify(struct diff_queue_struct =
*q,
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s ", spec->mode,
-				       anonymize ?
-				       anonymize_oid(oid_to_hex(&spec->oid)) :
-				       oid_to_hex(&spec->oid));
+				       anonymize_oid(&spec->oid, anonymize));
 			else {
 				struct object *object =3D lookup_object(the_repository,
 								      &spec->oid);
@@ -726,10 +729,7 @@ static void handle_commit(struct commit *commit, str=
uct rev_info *rev,
 		if (mark)
 			printf(":%d\n", mark);
 		else
-			printf("%s\n",
-			       anonymize ?
-			       anonymize_oid(oid_to_hex(&obj->oid)) :
-			       oid_to_hex(&obj->oid));
+			printf("%s\n", anonymize_oid(&obj->oid, anonymize));
 		i++;
 	}
=20
