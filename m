Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE731F667
	for <e@80x24.org>; Tue, 22 Aug 2017 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdHVT43 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 15:56:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51403 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752451AbdHVT42 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 15:56:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2FEC8D873;
        Tue, 22 Aug 2017 15:56:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ImyP90BlmGLEZk9140fLTShNmvI=; b=t9CJok
        L8v+90NF+okGzFKLgmcWa8RXUiEWeoRQwjNXOv+O2h47PESHh1rvZM7duDCV4BYU
        +7aoj3mpsdzxGv3OH/v3ZJ28jAfOFSWGBnY78haPPoLamMdv8x5Kmd39tiLFiHzL
        vVzTmeop0n5AsbmFVPpvT9fEhOWWKds8ozWj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j/PLjXb0NRkwkErkFznoINp5o3L/zU5J
        TPZyVnqne1FYiv/H2LbWrlztDIyf/Gi+5+ZJnZpp5OO/kWiDxblUy4EdHDaOrJxc
        xqZpFzGJ16n8rYhEz6SYrF6lg2w/DFp+VeQCu2HiQjoXWC8LGpxnr5TLNHHJmsH7
        aJIrzDFtskM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB2F88D872;
        Tue, 22 Aug 2017 15:56:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C1F78D871;
        Tue, 22 Aug 2017 15:56:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Doc: clarify that pack-objects makes packs, plural
References: <20170822182242.20862-1-jonathantanmy@google.com>
Date:   Tue, 22 Aug 2017 12:56:25 -0700
In-Reply-To: <20170822182242.20862-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 22 Aug 2017 11:22:42 -0700")
Message-ID: <xmqqbmn72x7a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBB42776-8773-11E7-BD34-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The documentation for pack-objects describes that it creates "a packed
> archive of objects", which is confusing because it may create multiple
> packs if --max-pack-size is set. Update the documentation to clarify
> this.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> It took me quite some time before I realized that pack-objects actually
> may write multiple packs, the opening lines of the doc confusing me.
> Here's a doc update.
> ---

I have a mixed feeling about this one.  

Yes, the command _can_ be told to split a packfile into multiple
with an option, but the actual benefit of doing so is rather
dubious.  On boxes with smaller address space, I thought windowed
mmap access into large packfiles work just fine.  I also think the
motivation behind the "max-size" thing was to split into smaller
pieces so that sneaker-netting on multiple CD-ROMs becomes easier or
something (silly) like that---there should be a more suitable tool
that is not specific to Git for such usecase, I would imagine.

So I am OK with "and writes either one or more" in the description,
but I'd prefer to see that "--max-pack-size" thing gets described as
an aberration, not a norm.

IOW,

 - I think the "NAME" part that gives a single line summary of what
   the command is about can and should stay as before.  A single
   archive is the norm, and we do not particularly recommend people
   to think it is a good idea to produce multiple packfiles.

 - The change in this patch for description part, which should give
   a fairly complete view of what it can do, is good.

 - The change for 'base-name' documentation that stresses that
   .pack/.idx come in pairs and share the same <SHA-1> is good.

 - There should be an update to say max-pack-size is not something
   normal users would ever want.

For the last one, perhaps something like this:


 Documentation/git-pack-objects.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8973510a41..3aa6234501 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -108,9 +108,13 @@ base-name::
 	is taken from the `pack.windowMemory` configuration variable.
 
 --max-pack-size=<n>::
-	Maximum size of each output pack file. The size can be suffixed with
+	In unusual scenarios, you may not be able to create files
+	larger than certain size on your filesystem, and this option
+	can be used to tell the command to split the output packfile
+	into multiple independent packfiles and what the maximum
+	size of each packfile is. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
-	If specified, multiple packfiles may be created, which also
+	This option
 	prevents the creation of a bitmap index.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
