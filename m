Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E0F1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 19:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdHCTua (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 15:50:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751696AbdHCTua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 15:50:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1059B8A3ED;
        Thu,  3 Aug 2017 15:50:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=15dbuMcwtZE/xGBRtP14vLhpD4c=; b=iWU9fO
        A4vTCtK0rW0JksqOLm/x/zSt7iyNbn3ua6JgrxHIHKXgRZIf7ZQFJNqmnrDDhdMl
        actz42uD/EMPqxlL8M/AC1tUlJd2yOB+Ahm/3awkBbNyFTYIkqP6EyeRgLOhvWHq
        pMRVbfoYHz9K3rwTok0I7xlzvHcbo5P3TfSQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wr7E0W4p/xPpWqxEsHtKPGChWHO+crS4
        Ycf05307xMl36zh90kWQnUT8+Kd0wMuO53zV8mEHcxXPLGYUbqEBlInaiMxQFF3U
        kkVKNRTJnc3vcICuZR5DwZ6kWq8n9vnLqo4YT2Y0/0b1BZk63+eAfVHXA1zNcLXP
        Ip4iwkgGN64=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05BD48A3E7;
        Thu,  3 Aug 2017 15:50:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25A7E8A3E4;
        Thu,  3 Aug 2017 15:50:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 13/40] external odb: add 'put_raw_obj' support
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-14-chriscool@tuxfamily.org>
Date:   Thu, 03 Aug 2017 12:50:27 -0700
In-Reply-To: <20170803091926.1755-14-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 3 Aug 2017 11:18:59 +0200")
Message-ID: <xmqqbmnwxwfw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFE58266-7884-11E7-9237-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Add support for a 'put_raw_obj' capability/instruction to send new
> objects to an external odb. Objects will be sent as they are (in
> their 'raw' format). They will not be converted to Git objects.
>
> For now any new Git object (blob, tree, commit, ...) would be sent
> if 'put_raw_obj' is supported by an odb helper. This is not a great
> default, but let's leave it to following commits to tweak that.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

I thought in an earlier step that I saw this thing initialized in
the codepath that adds alternate object stores, which are read-only
places we "borrow" from.  Being able to write into it is good, but
conceptually it no longer feels correct to initialize it from the
alternate object database initialization codepath.

Another way to say it is that an object store, whether it is local
or external, is not "alt" if it will result in storing new objects
we locally create.  It's just an extension of our local object
store.

