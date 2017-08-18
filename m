Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B609208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 16:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbdHRQog (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 12:44:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63042 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752363AbdHRQof (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 12:44:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C085A93C32;
        Fri, 18 Aug 2017 12:44:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ItlOp50W/nNt
        R9vhhmB9c7PG/pY=; b=GGRGvTeaZRncZFQrWXZpMHWy//B5x9WYTrIysSihJbT8
        dUVCNUpZ+aWdAiPgf/0fmTN0kKsxsHGzn0HvvClqSUe9T2yXxAv7jBCI0AEqvdka
        9Kfaglc1JwPzNaLDz67+tpgBbcEnz0suv4XdqfyC+uo9ZggGY7vlrb2sjsC8wkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MAWc6v
        SV331fUBkTAOHGCduKw/9imJtzWjek9T3oYE6hTnRboUMW7fb3O4zYrIfCpi1DqU
        UqF/S1NdEHK4US0fkifOiEHoLHLm9Rgw4DDFQEAs/e6XS6mFCJPaD+p8f/YEPJuG
        4tWpIZ3mTHwY2Xsu7H22SDwKz0hhfWjHjb4gI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B97B893C31;
        Fri, 18 Aug 2017 12:44:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26F7493C30;
        Fri, 18 Aug 2017 12:44:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 4/4] commit: rewrite read_graft_line
References: <cover.1503020338.git.patryk.obara@gmail.com>
        <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
        <20170818064335.h5sr5iz7mh64axji@sigill.intra.peff.net>
        <xmqqziaxcobp.fsf@gitster.mtv.corp.google.com>
        <CAJfL8+SHSAhgrMY6ONVHLMWEHcT0mhm4oKMmq6D=89SErDKiMA@mail.gmail.com>
Date:   Fri, 18 Aug 2017 09:44:32 -0700
In-Reply-To: <CAJfL8+SHSAhgrMY6ONVHLMWEHcT0mhm4oKMmq6D=89SErDKiMA@mail.gmail.com>
        (Patryk Obara's message of "Fri, 18 Aug 2017 13:30:23 +0200")
Message-ID: <xmqqd17sddvz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83C19894-8434-11E7-A62B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>>
>> If I were doing the two-pass thing, I'd probably write a for loop
>> that runs exactly twice, where the first iteration parses into a
>> single throw-away oid struct only to count, and the second iteration
>> parses the same input into the allocated array of oid struct.  That
>> way, you do not have to worry about two phrases going out of sync.
>
> Two passes would still differ in error handling due to xmalloc between =
them=E2=80=A6

I am not sure if I follow.  What I meant was something along these
lines:

	struct commit_graft *graft =3D NULL;
        char *line =3D ... what you read from the file ...;
        int phase; /* phase #0 counts, phase #1 fills */

	for (phase =3D 0; phase < 2; phase++) {
		int count;
		char *scan;
		strucut object_id dummy_oid, *oid;

		for (scan =3D line, count =3D 0;
                     *scan;
		     count++) {
                	oid =3D graft ? &graft->parent[count] : &dummy_oid;
			if (parse_oid_hex(scan, oid, &scan))
				return error(...);
			switch (*scan) {
			case ' ':
				scan++;
				continue; /* there are more */
			case '\0':
				break; /* we are done */
			default:
				return error(...);
			}
		}

		if (!graft)
			graft =3D xmalloc(... with 'count' parentes ...);
	}

        /* now we have graft with parent[count] all filled */
	return graft;

The inner for() loop will do the same parsing for both passes,
leaving little chance for programming errors to make the two passes
decide there are different number of fake parents.  I suspect I may
have botched some details in that loop, but both passes will even
share the same buggy counting when the code is structured that
way ;-)

That is what I meant by "not have to worry about two phases going
out of sync".
