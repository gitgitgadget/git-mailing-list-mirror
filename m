Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78702035F
	for <e@80x24.org>; Wed,  9 Nov 2016 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbcKIBX0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 20:23:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751677AbcKIBXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 20:23:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47BCF4DBFD;
        Tue,  8 Nov 2016 20:22:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pbwGGIW6xcurLlpFrqVDuj4N5cU=; b=k3rvWp
        5SsI0PSFR8KsUumMx/Mm6FG0W9I4gWvfO5FBvucVfWMjddjBlDvdVtQayREu4FEZ
        hTB+FOx5fQGvDrUJFkrkJuBvhDkERPyuw7uJSrjLiQgoKQo+ddjibzY2EJOHGPZf
        oFaCOfg7y0zdqihCnZQS2NLcfqNCF4jup30uU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aIuJPP/oDXQy8m2cvQCdKXDQ9tP3uIvx
        6Djv0XSEwiJr/j547PXcpupAOhL4QHrA4jSkHGXw4HAW/kU4/NOKTL+xmNofeA47
        6u3eaxPn4nxapcliFBT8VAapPZBOZnk/WlRKr7mWOBg5Ar/sBtWW7bvVmEAZYmZ7
        NPHjCtp6Zcs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E6414DBFC;
        Tue,  8 Nov 2016 20:22:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0AAF4DBFB;
        Tue,  8 Nov 2016 20:22:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Word <argoday@argoday.com>,
        Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org,
        jword@bloomberg.net
Subject: Re: Bug: git config does not respect read-only .gitconfig file
References: <CAD9aWChH14eviop=0_Ma_2Pa-2OyWJp9KjimH8dyqy-XDn9Rhw@mail.gmail.com>
        <40608c85-f870-87f7-daee-7fa98f5d19c1@jump-ing.de>
        <CAD9aWCgZkuaZNMDparVZE_WNFpOp7ud6iyCueGVbnU8s_EYtrQ@mail.gmail.com>
        <20161108200110.zvqdm2nlu5zxfyv5@sigill.intra.peff.net>
Date:   Tue, 08 Nov 2016 17:22:52 -0800
In-Reply-To: <20161108200110.zvqdm2nlu5zxfyv5@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 8 Nov 2016 15:01:10 -0500")
Message-ID: <xmqqk2cdbg5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09A34096-A61B-11E6-BE8A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Probably converting "rename(from, to)" to first check "access(to,
> W_OK)". That's racy, but it's the best we could do.

Hmph, if these (possibly problematic) callers are all following the
usual "lock, write to temp, rename" pattern, perhaps the lock_file()
function can have access(path, W_OK) check before it returns a
tempfile that has been successfully opened?

Having said that, I share your assessment that this is not a code or
design problem.  It is unreasonable to drop the write-enable bit of
a file in a writable directory and expect it to stay unmodified. The
W-bit on the file is not usable as a security measure, and we do not
use it as such.

I do not offhand know how much a new feature "this repository can be
modified by pushing into and fetching from, but its configuration
cannot be modified" is a sensible thing to have.  But it is quite
clear that even if we were to implement such feature, we wouldn't be
using W-bit on .git/config to signal that.

