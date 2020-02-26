Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74ABC4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A4624672
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rhzwgqv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBZVBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:01:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65251 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBZVBT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 16:01:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0F6759327;
        Wed, 26 Feb 2020 16:01:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vUGe+RPif360hs9KgMH1mlfK5f8=; b=Rhzwgq
        v7YgBhtvgMLqhGcgXYmSZpHIfyzsTUwfk5MhfXWVL0OXH4b0BuMIhHMXI/99/iVG
        sSehwedrdtHCRc889Jgb5BwrHR/3YStL92SzaCoJ9lPQx4uSy6B+kVtOEYnaShQc
        IPyGae6+5zpVgBKNdWpz82ill/M9XDsVqQ71Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YU6Zp+FxBiyfbaw0PlqSqTgOlepLULRb
        UcmOWLy71juASaYN80QZRx7UN0Dslk0v9ZRwb6xujXnPyj/UyNCP4t0iJAfLdBjB
        RyIA4QdE7oC8bRkSdLaKWG5dpJy4XxXyvxjH6k1UauJNR9sTJkW3y+YnZmr0NSaz
        B5TQJOF8ydU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C75B859326;
        Wed, 26 Feb 2020 16:01:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1659159325;
        Wed, 26 Feb 2020 16:01:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org, vegard.nossum@oracle.com
Subject: Re: Making GitGitGadget conversion lossless
References: <20200226200929.z4aej74ohbkgcdza@chatter.i7.local>
Date:   Wed, 26 Feb 2020 13:01:15 -0800
In-Reply-To: <20200226200929.z4aej74ohbkgcdza@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Wed, 26 Feb 2020 15:09:29 -0500")
Message-ID: <xmqq5zfthxlw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 217C83BE-58DB-11EA-AF79-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> - parent/tree hashes

Isn't this already available by recording the base-commit
information?

> - author/committer information
> - cryptographic attestation (gpgsig)

I think you are aiming to come up with bit-for-bit identical commit
the sender had, and I would imagine that the easiest and least
disruptive way to do so is to add a compressed and ascii-armored
copy of "git cat-file commit" output of the original commit after
the "---" line before the diff/diffstat of the e-mailed patch.  The
receiving end can then act on it when given some option by

 - first recover the contents of the commit object (call it #1);
 - learn the parent commit(s) and check out the tree;
 - apply the patch in the remainder of the patch e-mail to the tree;
 - make sure that the result of patch application gives the tree object
   recorded in #1;
 - run "hash-object -t commit -w" over #1 that gives you a commit
   object that is bit-for-bit identical.

As I said already, I do not think that the desire to get the
bit-for-bit identical commit is compatible with the idea to discuss
e-mailed patches---the pieces of patch e-mail will become "you may
look at them, you may apply them, but it is no use to comment on
them to get them improved".  So, I dunno.
