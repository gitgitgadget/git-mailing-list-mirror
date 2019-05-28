Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2606D1F462
	for <e@80x24.org>; Tue, 28 May 2019 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfE1Uha (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:37:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62604 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfE1Uh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:37:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B795514AA51;
        Tue, 28 May 2019 16:37:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zz4pHAAliFc+/TXFpx//hmKpbAc=; b=GPXe0U
        vQsM/SSEaa3MGnDaNeskS2+wpuQ0oDBFSRis+ILuCcTcoOY4mcUdD9tlqZnjacOU
        q7mj/i9uBjyPwrQl2Nuz4afdp5Habigsp6CSZlvR9YvCav84lllSYAc2qrAozJyR
        sWEDKSujJsoYfX1WIcXpH0b2sKnNW4X9UMw2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=thfkxe1NNI8i9n3uAK6zlCQkarsf/1ZW
        hCf5cBD9LbAN4/yp6EKF+/G1gWbzQ+8cSidXOk9EeKb4scyUG42SNzN9/xQNVkMg
        033cEjjWnpGrjlQecbij4jA3LDYj1z3i5PJwNrmMNF0b3jn6P0WedZoGcUuqGAwC
        XwqcT4s+edo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF92F14AA50;
        Tue, 28 May 2019 16:37:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 263E714AA4E;
        Tue, 28 May 2019 16:37:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Mike Mueller <mike.mueller@moodys.com>
Subject: Re: [PATCH v2 1/1] p4 unshelve: fix "Not a valid object name HEAD0" on Windows
References: <pull.183.git.gitgitgadget@gmail.com>
        <pull.183.v2.git.gitgitgadget@gmail.com>
        <5e89d1aceb9125231797a355e9465d1a41a1741c.1559067344.git.gitgitgadget@gmail.com>
Date:   Tue, 28 May 2019 13:37:26 -0700
In-Reply-To: <5e89d1aceb9125231797a355e9465d1a41a1741c.1559067344.git.gitgitgadget@gmail.com>
        (Mike Mueller via GitGitGadget's message of "Tue, 28 May 2019 11:15:46
        -0700 (PDT)")
Message-ID: <xmqq7eaa1fjt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67FD3DFE-8188-11E9-BCCC-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mike Mueller <mike.mueller@moodys.com>
>
> git p4 unshelve was failing with these errors:
>
> fatal: Not a valid object name HEAD0
> Command failed: git cat-file commit HEAD^0
>
> (git version 2.21.0.windows.1, python 2.7.16)
>
> The pOpen call used by git-p4 to invoke the git command can take either a
> string or an array as a first argument. The array form is preferred
> because platform-specific escaping of special characters will be
> handled automatically.(https://docs.python.org/2/library/subprocess.html)
> The extractLogMessageFromGitCommit method was, however, using the string
> form and so the caret (^) character in the HEAD^0 argument was not being
> escaped on Windows.  The caret happens to be the escape character, which
> is why the git command was receiving HEAD0.

In the output from

    git grep 'read_pipe_lines("'

together with a few hits to harmless constant command line, we find
this line

    diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))

Would the caret we see there cause a similar problem?  It would end
up running something like

   $ git diff-tree -r -M "HEAD^" "HEAD"

