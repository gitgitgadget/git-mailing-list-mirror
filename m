Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C60C208E3
	for <e@80x24.org>; Fri,  8 Sep 2017 01:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbdIHB0t (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 21:26:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56138 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753535AbdIHB0s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 21:26:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC36693B13;
        Thu,  7 Sep 2017 21:26:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F7RhtQa6Je1gNcyRguoSe48pPDg=; b=v6yppV
        dupC9n2+6Dhq+yCguCzr2zEq62hx9kHu1IbcX4al2UXw9sN4dd/JJXih7ps5LRba
        P9uwMZuIcmLZaIGc1kVwIKdCG5nyNbj5dcYwerKa/ZUx6ypBYCNoVy9bsUqXW8AK
        zZk/D/tCscbYLxEa8syQSDVv4K9r5RSxX+/GU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xw1DIRuPRCc86zfqawLZ1i+WA97ui18Q
        WFPhsukSS0IUskmUbO/zUk2j3syMCQ/N0oIWeFUD7+3i/RHTipWD7fZYSTnvtQfq
        tEyux3d9vvto5baCxgTXT3pnW/Wal9z7YoYPglWpBGDw+q3POdGT8NbSLNdVM2AZ
        SByBJkh+GmM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E412993B12;
        Thu,  7 Sep 2017 21:26:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 507CF93B11;
        Thu,  7 Sep 2017 21:26:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olaf Klischat <olaf.klischat@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff <commit> doesn't quite work as documented?
References: <0696f94d-28c2-1f4b-03ee-16553d97f318@gmail.com>
Date:   Fri, 08 Sep 2017 10:26:46 +0900
In-Reply-To: <0696f94d-28c2-1f4b-03ee-16553d97f318@gmail.com> (Olaf Klischat's
        message of "Thu, 7 Sep 2017 18:31:58 +0200")
Message-ID: <xmqqfuby0yll.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C80B089A-9434-11E7-A72E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olaf Klischat <olaf.klischat@gmail.com> writes:

> `git diff --help' says:
>
> git diff [--options] <commit> [--] [<path>...]
>            This form is to view the changes you have in your
>            working tree relative to the named <commit>.

That help text is poorly phrased.  

When "git diff" talks about files in your working tree, it always
looks them _through_ the index.  As far as the command is concerned,
a cruft left in your working tree that is not in the index does
*not* exist.

So when your index does not have bar.txt, even if you have an
untracked bar.txt in your directory, i.e.

> oklischat@oklischat:/tmp/gittest$ git status
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
> 	bar.txt

and you have a commit that _has_ that file, then the command thinks
<commit> has the path, and your working tree does *not*.  IOW, this
is...

> oklischat@oklischat:/tmp/gittest$ git diff bar-added
> diff --git a/bar.txt b/bar.txt
> deleted file mode 100644

... totally expected and intended output.

Hope the above explanation clarifies.  A documentation update might
be helpful to new users.

Thanks.
