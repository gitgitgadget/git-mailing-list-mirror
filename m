Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647951F462
	for <e@80x24.org>; Tue, 28 May 2019 19:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfE1TmH (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 15:42:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61776 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1TmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 15:42:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0A336F7EE;
        Tue, 28 May 2019 15:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m/tItwfow82Mxpai+MYepMBXIuk=; b=PwLg9K
        /QVZsHuVfDrVDwdJygm60MlqrTAai61pq6kZ3i+LE/bwzIbGstQ0NtUMvGShX5BS
        VDUIGA0SCS24wr9fXiSeMT7Uwerg8Mxr62BbI9/dQpvjG4sEe9vu227M6tA+DaNg
        cVi8tQrtkDa9ExxRC0QJuPz18IM6wnTbsJSUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n6LI2I9Efun9pLYao144WoBqrIaUzmGZ
        mMeK/FBF4jCkRtUxQka0gglddzHapu4GeezGildeMdFigJ9Q2aHoWwmG58gq+Gyt
        ndIQX/eyOZ6ftIol2udkNhLfaxUijw7o2SVysqwruwnG/iHR3pT/Jy/usM5SpSjn
        t+d2/E23FHY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A83E86F7ED;
        Tue, 28 May 2019 15:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D281D6F7EB;
        Tue, 28 May 2019 15:42:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] list-objects-filter: disable 'sparse:path' filters
References: <20190525142834.6168-1-chriscool@tuxfamily.org>
Date:   Tue, 28 May 2019 12:41:58 -0700
In-Reply-To: <20190525142834.6168-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sat, 25 May 2019 16:28:34 +0200")
Message-ID: <xmqqo93m1i49.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A95D172C-8180-11E9-9B54-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> If someone wants to use as a filter a sparse file that is in the
> repository, something like "--filter=sparse:oid=<ref>:<path>"
> already works.
>
> So 'sparse:path' is only interesting if the sparse file is not in
> the repository. In this case though the current implementation has
> a big security issue, as it makes it possible to ask the server to
> read any file, like for example /etc/password, and to explore the
> filesystem, as well as individual lines of files.
>
> If someone is interested in using a sparse file that is not in the
> repository as a filter, then at the minimum a config option, such
> as "uploadpack.sparsePathFilter", should be implemented first to
> restrict the directory from which the files specified by
> 'sparse:path' can be read.
>
> For now though, let's just disable 'sparse:path' filters.
>
> Helped-by: Matthew DeVore <matvore@google.com>
> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> Changes since the RFC version are the following:
>
>   - improved the error message when 'sparse:path' is used,
>   - updated "git-completion.bash",
>   - freed "sparse_path_value" field in list_objects_filter_release(),
>   - updated tests (t5317 and t6112).
>
> Thanks to Matthew and Jeff for the suggestions.
>
>  contrib/completion/git-completion.bash |  2 +-
>  list-objects-filter-options.c          | 10 ++--
>  list-objects-filter-options.h          |  2 -
>  list-objects-filter.c                  | 22 --------
>  t/t5317-pack-objects-filter-objects.sh | 71 +++++---------------------
>  t/t6112-rev-list-filters-objects.sh    | 39 +++++---------
>  6 files changed, 33 insertions(+), 113 deletions(-)

What is curious is that this does not touch Documentation/ hierarchy
at all---is that a sign that nobody makes any serious use of the
--filter=... thing and we can freely drop "features" around it when
we see it necessary (like in this case)?

Or do we need something like this on top (or squashed in)?  I can
live with or without "Note that..." myself.

Thanks.


 Documentation/rev-list-options.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ddbc1de43f..73aafea8d6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -725,9 +725,6 @@ specification contained in the blob (or blob-expression) '<blob-ish>'
 to omit blobs that would not be not required for a sparse checkout on
 the requested refs.
 +
-The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
-specification contained in <path>.
-+
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
 at multiple depths in the commits traversed). <depth>=0 will not include
@@ -737,6 +734,9 @@ tree and blobs which are referenced directly by a commit reachable from
 <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
 while also including trees and blobs one more level removed from an
 explicitly-given commit or tree.
++
+Note that the form '--filter=sparse:path=<path>' that wants to read from
+an arbitrary path on the filesystem is not supported, for security reasons.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.


