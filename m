Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93CC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA7B21531
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 23:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SjIZeaut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgIZX6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 19:58:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50413 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIZX6a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 19:58:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2393BF70E2;
        Sat, 26 Sep 2020 19:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9ZFlQ2yEIsUYp3xuK94B4ItcjKs=; b=SjIZea
        utFuQc3whH9svmFNyPPdRUZtrttldo9wpMJbiEIxASG5ZijyUbayptz5mkc0bWnG
        O538KqK5Y7MReol1O9NxjbExXRYftBWhptXSY6euw7pYvt6giGIMCe9ffDSx2wkC
        YVbncVEb+FN74sRbp7olRHW7pnst36ePvVugk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jdWw+8WnWOcSkBLeU/IdNJxaoqi+bsYd
        OzF6ccvGZwz3cX0151AuT48F/PsMpKOfZhq8S8B/YN55MjYLHJjXszZKi3vpVbM3
        /vZ+vXFwnaWeFJWgo67J5m30RInrX4r38t8gS/p2jC6z+LdFraZMVmRGRI2dJgce
        RAl+OMVfbJQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C521F70E1;
        Sat, 26 Sep 2020 19:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65750F70E0;
        Sat, 26 Sep 2020 19:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Barret Rhoden <brho@google.com>
Subject: Re: [PATCH 2/4] blame: validate and peel the object names on the
 ignore list
References: <20200925055954.1111389-1-gitster@pobox.com>
        <20200925055954.1111389-3-gitster@pobox.com>
        <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de>
        <xmqqtuvkii1j.fsf@gitster.c.googlers.com>
Date:   Sat, 26 Sep 2020 16:58:22 -0700
In-Reply-To: <xmqqtuvkii1j.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 26 Sep 2020 10:06:48 -0700")
Message-ID: <xmqqsgb4gkf5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29D9B8DA-0054-11EB-81B8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> @@ -66,7 +72,8 @@ void oidset_parse_file(struct oidset *set, const char *path)
>>>  		if (!sb.len)
>>>  			continue;
>>>
>>> -		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
>>> +		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0' ||
>>> +		    (fn && fn(&oid, cbdata)))
>>
>> OK, so this turns the basic all-I-know-is-hashes oidset loader into a
>> flexible higher-order map function.  Fun, but wise?  Can't make up my
>> mind.
>
> Fun and probably useful.  It is a different matter if it is wise to
> use it to (1) peel tags to commits and (2) fail on an nonexistent
> object.  My take on them is (1) is probably true, and (2) is Meh ;-)

If we choose to do (2) differently, we only need the following
one-liner patch.  I might suggest tweaking the semantics of the
callback function a bit to allow it to tell the caller (i.e.
oidset_parse_file_carefully()) that it wants to go on as usual, it
wants to omit the object from the hashtable, it replaced the given
object to something else, or it detected an error and wants to
abort, and if we were doing that, we'd be returning "do not add this
object to the table" signal, instead of 0 that signals "we are good
doing business as usual", from here.


 builtin/blame.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index baa5d979cc..8d7b66e970 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -817,8 +817,19 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 			oidcpy(oid_ret, &oid);
 			return 0;
 		}
+
+		/*
+		 * We can ignore a request to ignore any nonexistent
+		 * objects, trees and blobs by not doing anything
+		 * special, as the blame machinery works with commits,
+		 * so entries in the hashtable from these objects will
+		 * never be looked up.  But we do allow dereferencing
+		 * an annotated tag, as silently ignoring a request to
+		 * ignore v1.0.0 because it is an annotated tag is a
+		 * bit too unfriendly to end-users.
+		 */
 		if (kind != OBJ_TAG)
-			return -1;
+			return 0;
 		obj = deref_tag(r, parse_object(r, &oid), NULL, 0);
 		oidcpy(&oid, &obj->oid);
 	}
