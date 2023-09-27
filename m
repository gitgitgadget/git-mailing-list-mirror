Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4378AE80A84
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 04:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjI0Ewz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 00:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjI0EwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 00:52:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB977683
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 21:15:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D47B2EF0A;
        Wed, 27 Sep 2023 00:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=g
        KAVBm22rC5n+W2UyZnW2S9EJ6b78Wr44SogS0YgB5g=; b=i32wiwtav5rt6sqhh
        z0dqBg9b/3Ydp/AyNvXJKHrP8KA3G5Hllaenf8gd2npSpbFOY7W7fTYpI2qTpN6k
        9AvC94WXc05aWzGEsF6faMrCbC9ZkS17u7PGQm0YmAhD8PWjaOzarQM5a5U2Vwh8
        JG4e9vy5q77aNCAg6XrdNLiMWQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 060EC2EF09;
        Wed, 27 Sep 2023 00:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2D8F2EF07;
        Wed, 27 Sep 2023 00:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [silly] loose, pack, and another thing?
Date:   Tue, 26 Sep 2023 21:15:53 -0700
Message-ID: <xmqqbkdometi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D3ED228-5CEC-11EE-9DF2-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just wondering if it would help to have the third kind of object
representation in the object database, sitting next to loose objects
and packed objects, say .git/objects/verbatim/<hex-object-name> for
the contents and .git/objects/verbatim/<hex-object-name>.type that
records "blob", "tree", "commit", or "tag" (in practice, I would
expect huge "blob" objects would be the only ones that use this
mechanism).

The contents will be stored verbatim without compression and without
any object header (i.e., the usual "<type> <length>\0") and the file
could be "ln"ed (or "cow"ed if the underlying filesystem allows it)
to materialize it in the working tree if needed.

"fsck" needs to be told about how to verify them.  Create the object
header in-core and hash that, followed by the contents of that file,
and make sure the result matches the <hex-object-name> part of the
filename, or something like that.
