Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A5DC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 17:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DD0611AB
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 17:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhDORyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:54:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64705 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhDORyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 13:54:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D6971224BB;
        Thu, 15 Apr 2021 13:53:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IuvOiltf/Yy1heifu96JTuTWgv0=; b=CxQrH2
        lwfd9k1gMlQfYKsQdgJB7jt63Ou/7ZORwjGg9QGpSaCnDYqEvkfedhWecqVy2K4m
        amv4C0xe6viSp7Pswv2VLKVEgr9oYobDG6U6+6kuiZMjU44fJIrzj7CaaHsvVJRR
        PIOJxGPjnalwYzNqXrJrt/zzzsGsoDrTeFZpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X4388kVFovbTYGm7Mscawvbsxm8Z2ObG
        O2BHF2xQ72bVWgXNqs0UztEpyo5RZiHelL77R6htLAqJOT1kiWkRCBjQebO3Nlwe
        cJv9pcUrN5Zaovr9+vSXlGSKuuWy1YoqDJFtORKmpMhMEjTIQElkVMtmCLfYO1b9
        4Ym8FEHD+zE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54C811224BA;
        Thu, 15 Apr 2021 13:53:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99A0F1224B7;
        Thu, 15 Apr 2021 13:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
References: <cover.1617967252.git.ps@pks.im> <cover.1618234575.git.ps@pks.im>
        <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
        <xmqqfsztlwxb.fsf@gitster.g> <YHbZNL0gzw0+1k5h@ncase>
        <xmqqmtu0y3r8.fsf@gitster.g>
        <YHgOCUI++AY/7zwX@coredump.intra.peff.net>
Date:   Thu, 15 Apr 2021 10:53:45 -0700
In-Reply-To: <YHgOCUI++AY/7zwX@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 15 Apr 2021 05:57:29 -0400")
Message-ID: <xmqqczuvsac6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 874CC324-9E13-11EB-891F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, as somebody who has added or touched a lot of those paths, I've
> often wondered this myself: what would break if you asked for blobs but
> not trees? I think it does not work like you'd expect, because
> list-objects.c:process_tree() will not recurse the trees at all (and
> hence you'd never see any blob).

Ah, OK, that much I figured.  I was wondering if it is worth
"fixing", IOW, if we see blobs being asked without trees being
asked, perhaps process_tree() should be taught to descend---even if
it won't show the trees themselves, blobs contained within would.

>> And, the above led to the question---the patches in your series
>> apparently do a lot more (even if we discount the option parsing
>> part), and I was wondering if that is because the independence
>> between these three bits the existing code aspires to maintain is
>> broken.
> ...
> Anyway. I do think this all could be done using the existing bits in
> rev_info. But there is value in making it all part of the modular
> filtering system.

Yes, I do not have a problem with the approach to add new features
as part of the "modular filtering system".  But that leads me to
wonder into a different direction---coalesce (tag|tree|blob)_objects
members into a single bit, say all_objects, have "--objects" and
friends set that single bit, and update places like these to check
that single bit.

The patch is for illustration purposes; I didn't even aim to cover
the entirety of these two files.

 builtin/rev-list.c | 9 ++++-----
 pack-bitmap.c      | 4 +---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git c/builtin/rev-list.c w/builtin/rev-list.c
index 7677b1af5a..b6f0d7e9a3 100644
--- c/builtin/rev-list.c
+++ w/builtin/rev-list.c
@@ -424,8 +424,7 @@ static int try_bitmap_count(struct rev_info *revs,
 	 * commits to traverse, since we don't know which objects go with which
 	 * commit.
 	 */
-	if (revs->max_count >= 0 &&
-	    (revs->tag_objects || revs->tree_objects || revs->blob_objects))
+	if (revs->max_count >= 0 && revs->all_objects)
 		return -1;
 
 	/*
@@ -439,9 +438,9 @@ static int try_bitmap_count(struct rev_info *revs,
 		return -1;
 
 	count_bitmap_commit_list(bitmap_git, &commit_count,
-				 revs->tree_objects ? &tree_count : NULL,
-				 revs->blob_objects ? &blob_count : NULL,
-				 revs->tag_objects ? &tag_count : NULL);
+				 revs->all_objects ? &tree_count : NULL,
+				 revs->all_objects ? &blob_count : NULL,
+				 revs->all_objects ? &tag_count : NULL);
 	if (max_count >= 0 && max_count < commit_count)
 		commit_count = max_count;
 
diff --git c/pack-bitmap.c w/pack-bitmap.c
index d7e9f14f92..918c80a391 100644
--- c/pack-bitmap.c
+++ w/pack-bitmap.c
@@ -801,9 +801,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 			continue;
 
 		obj = eindex->objects[i];
-		if ((obj->type == OBJ_BLOB && !revs->blob_objects) ||
-		    (obj->type == OBJ_TREE && !revs->tree_objects) ||
-		    (obj->type == OBJ_TAG && !revs->tag_objects))
+		if (!revs->all_objects && obj->type != OBJ_COMMIT)
 			continue;
 
 		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
