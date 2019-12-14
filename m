Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED30C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 23:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37B220706
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 23:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m11oGG2H";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="xQO9xEbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfLNXAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 18:00:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51718 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNXAn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 18:00:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A677229C0;
        Sat, 14 Dec 2019 18:00:41 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fXnTe4M2Jvhb
        1xd+qZ4QdzHhPFU=; b=m11oGG2HqYT8gOrPlBs2dChMDEyGnQcEe5F3Y9ARbKsC
        rd/RQq7PTcvk2M6kxlQGDpJOI4xxw7yFajAj7sovtL43EjYHUDdLMKX5zeotXJVW
        ll67XCUo6fEhwqHYKeRd9ZSay8qpi7P1H2QZz9K6NOyt4F8aticVO9mg7e0BlN4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5327A229BF;
        Sat, 14 Dec 2019 18:00:41 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:subject:in-reply-to:references:date:message-id:mime-version:content-type:content-transfer-encoding; s=mesmtp; bh=kI0vU27F7S7qI22thCOr5iKc/efIworv/TJnyJ4N65g=; b=xQO9xEburXzPhLa2uu3/QeChinQI/+ud/jY3OcBGkCCRe0FSfwea1C+PYIVMqK8bZjr+KvpEQVBjaD6f03VepxpB3UNMmfKQOIASs/Qq4DzT9He3l0dEp6yuqACqzSnT29wrCd74rZuomSptuTfs4qhOeEt+OVjTRfc/6PBSEhc=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAAE6229BE;
        Sat, 14 Dec 2019 18:00:39 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Chrissy Wainwright <chrissy@sixfeetup.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Stash does not save rename information
In-Reply-To: <296B296B-EBA0-4F1E-AFEA-ADC232E84656@sixfeetup.com>
References: <296B296B-EBA0-4F1E-AFEA-ADC232E84656@sixfeetup.com>
Date:   Sat, 14 Dec 2019 23:00:38 +0000
Message-ID: <87immizf55.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Pobox-Relay-ID: 8C2943E6-1EC5-11EA-B102-D1361DBA3BAF-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chrissy Wainwright <chrissy@sixfeetup.com> writes:

> This seems to be a bug:
> =C2=A0
> 	1	Use `git mv` to rename a file
> 	2	`git status` shows the file was renamed
> 	3	Stash the changes
> 	4	Pop the stash
> 	5	`git status` shows the file change as deleted/new file instead of a re=
name

You can see very similar behavior with just a deleted file rather than a
deleted/new file pair (which is displayed as a rename depending on your
configuration):

    $ git init
    $ touch foo && git add foo && git commit -mfoo
    $ git stash
    $ git stash apply
    Removing foo
    On branch master
    Changes not staged for commit:
    	    deleted:    foo

    no changes added to commit

I believe the key thing is that by default 'git stash {apply,pop}' will
apply your change to the working tree but not the index [*].  If you
pass the --index flag, you should see the behavior you're after:

    $ git reset --hard
    HEAD is now at c023af6 foo
    $ git stash apply --index
    Removing foo
    On branch master
    Changes to be committed:
    	    deleted:    foo


[*] When I initially tried your example, I was confused that the new
    file was added to the index by default, but it seems new files
    receive special treatment, as Jeff King mentions at
    https://lore.kernel.org/git/20161206142446.5ba3wc625p5o6nct@sigill.intr=
a.peff.net/
