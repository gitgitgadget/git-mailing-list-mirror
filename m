Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67D81F461
	for <e@80x24.org>; Wed,  3 Jul 2019 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfGCSNv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 14:13:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65443 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfGCSNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 14:13:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22DA115B10A;
        Wed,  3 Jul 2019 14:13:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DqubosziGIQp
        hHcXCjpfTSFPzDE=; b=xnQXq2E3dtS8q8SyNm3JcLjneVMgzgyYu0KzOkFa23fl
        7NEoBtSAKO31aMbTI4+FbGQwufPgdI9t91Qcrd8L1GS46dYepOuxaRDskqlocuaI
        YvPMUIJIAIT+czohBd1qZ4bnZoGm6g9ePRJT2NPc3kwp8WpqkgYsHPCiaTQ0P30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TwZxFj
        DI/C1CvHekjbGlf9/xEXcf6/55t0kOarz9HYKR6FhNg/VaxRhtsi//fDKyBCFpLW
        0X6gmVlXLRqLlLXbc7H7lLthJxzM9j+3u2yfG/hgVGmV719f1ereO0+Sin96iz66
        05BVQKM46Gl8itH5ls4AMBbEJBow04oUF5k6Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A76B15B109;
        Wed,  3 Jul 2019 14:13:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71FCE15B107;
        Wed,  3 Jul 2019 14:13:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <xmqqa7dw2k49.fsf@gitster-ct.c.googlers.com>
        <20190703091030.GP21574@szeder.dev>
Date:   Wed, 03 Jul 2019 11:13:45 -0700
In-Reply-To: <20190703091030.GP21574@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 3 Jul 2019 11:10:30 +0200")
Message-ID: <xmqqblyb0yw6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C8773EE-9DBE-11E9-938C-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Jul 02, 2019 at 02:37:42PM -0700, Junio C Hamano wrote:
>> > +test_expect_success 'push --atomic shows all failed refs' '
>> > +	# Make up/master, up/allrefs
>> > +	d=3D$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
>> > +	git init --bare "$d" &&
>> > +	git --git-dir=3D"$d" config http.receivepack true &&
>> > +	up=3D"$HTTPD_URL"/smart/atomic-failed-refs.git &&
>> > +	test_commit allrefs1 &&
>> > +	test_commit allrefs2 &&
>> > +	git branch allrefs &&
>> > +	git push "$up" master allrefs &&
>> > +	# Make master and allrefs incompatible with up/master, up/allrefs
>> > +	git checkout allrefs &&
>> > +	git reset --hard HEAD^ &&
>> > +	git checkout master &&
>> > +	git reset --hard HEAD^ &&
>> > +	# --atomic should complain about both master and allrefs
>> > +	test_must_fail git push --atomic "$up" master allrefs >&output &&
>>=20
>> Don't rely on ">&output", which is an unnecessary bash-ism here.  It
>> breaks test run under shells like dash.
>>=20
>> 	>output 2>&1
>>=20
>> should be OK.
>
> '2>output' would be a tad better, because those refs should be printed
> to stderr.

Yeah; there are many existing uses of ">output 2>&1" in the same
script and I was following the suit.  There also are 2>err and I
agree that it is more appropriate in this case.
