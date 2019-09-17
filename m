Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DC31F464
	for <e@80x24.org>; Tue, 17 Sep 2019 22:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfIQWhr (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 18:37:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51930 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQWhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 18:37:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6062531B93;
        Tue, 17 Sep 2019 18:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DkVEYPduoPGal2vkKXsvxqeIe2A=; b=M31yEK
        FWYOcUtHJ9hqgXwkl9al4sF48Klvyfgj3npmKpfD/7U8nG7+cZh9WB6o1nkgxNsa
        74wZMXeBxB0GPmbUVGXCdqnf/F+I3ZxtXO2ufNFbQg+iUDi2VtrfpZlDESXoLT+z
        D9BIOzNcZl06l8VjFq9TudICV6QgfPsmpUvNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VtL+DLsFdgQ+vTtdbLGl9oxeZmQtoDV4
        wpJcIJ17+xFNziBQ0jQra/wXE6Zot7MmjfiqBh2p+hSppOPQU+4P4bKloaLFy+P5
        ursdx+Eea/09qOszK8cEM4hP4mI3bZw+BnUyAWmy6TrVOO2r0aIC65Huysz1f+hX
        R7cGDYMMBy8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5866131B92;
        Tue, 17 Sep 2019 18:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF07E31B91;
        Tue, 17 Sep 2019 18:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [RFC PATCH] merge-recursive: symlink's descendants not in way
References: <xmqqh85a7eax.fsf@gitster-ct.c.googlers.com>
        <20190917223236.149613-1-jonathantanmy@google.com>
Date:   Tue, 17 Sep 2019 15:37:43 -0700
In-Reply-To: <20190917223236.149613-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 17 Sep 2019 15:32:36 -0700")
Message-ID: <xmqq8sqm7dmw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C44C0408-D99B-11E9-ABF6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> In any case, if the working tree has 'foo' as a symlink, Git should
>> not look at or get affected by what 'foo' points at.
>
> Git should not, but it does - there is a call in process_entry() that calls
> lstat() on "foo/bar", which indeed reports that "foo/bar" is a directory. This
> patch adds a check that none of its ancestors are symlinks.

Yeah, I recall having to add has_symlink_leading_path() long time
ago in different codepaths (including "apply").  It is not surprising
to see a similar glitch remaining in merge-recursive (it's a tricky
issue, and it's a tricky code).

