Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F993C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 23:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiGKXZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiGKXZS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 19:25:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A627B8AB17
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 16:25:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93CE5136B68;
        Mon, 11 Jul 2022 19:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qq6fdk2GAGK1
        tRVW+aowviSe1roEYeDA9XYS7KzU+ZU=; b=d0Qjqk4U58EJmXcIxZPFdqLMNiDG
        gu0D3IUoxlfUMNrw7KAOI8oCm/fUFTlYVm7GWPIEipRtNIsZnZz5oqD7RhK9z+1/
        WGcj+oZ+VLo2lHm7qqNHmmUEUTjSGGb1Nq2dfpLHCKkOK45eDnnqa69/B3fPUkdG
        I5G5IQqbhfhb4n8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B74C136B66;
        Mon, 11 Jul 2022 19:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E573C136B64;
        Mon, 11 Jul 2022 19:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/1] fsck: do not dereference NULL while checking
 resolve-undo data
References: <xmqqfskdieqz.fsf@gitster.g>
Date:   Mon, 11 Jul 2022 16:25:14 -0700
In-Reply-To: <xmqqfskdieqz.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        09 Jun 2022 16:44:20 -0700")
Message-ID: <xmqq35f7kzad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B85ED954-0170-11ED-A13B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we found an invalid object recorded in the resolve-undo data,
we would have ended up dereferencing NULL while fsck.  Reporting the
problem and going on to the next object is the right thing to do
here.

Noticed by SZEDER G=C3=A1bor <szeder.dev@gmail.com>.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4b17ccc3f4..6c73092f10 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -784,6 +784,7 @@ static int fsck_resolve_undo(struct index_state *ista=
te)
 				error(_("%s: invalid sha1 pointer in resolve-undo"),
 				      oid_to_hex(&ru->oid[i]));
 				errors_found |=3D ERROR_REFS;
+				continue;
 			}
 			obj->flags |=3D USED;
 			fsck_put_object_name(&fsck_walk_options, &ru->oid[i],
--=20
2.37.0-248-g2505070554

