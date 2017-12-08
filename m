Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E8820C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbdLHPi5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:38:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60883 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754179AbdLHPiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:38:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66176A436A;
        Fri,  8 Dec 2017 10:38:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uf5FvPiHkMm6n9Dnrh5H6dNd/qI=; b=nQ8CUn
        YIN9F3ZAynJxsmyO8xkqkmiV14nPvRqCCskWDJRRiIjz+Ixj+KTrAhkrNflZvV/5
        BVStWnGrNXLhbipsOE6aC7gYtvjgwpDJ3UscL4cPssoNh3qfcVovvI0+Wf8tMaRd
        hZ27RKaTMHQF9vr7yLABDR20sLGwSC4WgM7eA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hGs6Yak8HQ8zzJXZOZFAl/2Ljqbij8Mv
        2Z4ftIXFx0F63TJ6mAXpNgsmycsnL+aNLPoM4yZjHPbYYuZbAUPICqc2cYjDdAcV
        XynsT4uxgiREUslmPpjCQMP/bTwfB5rbk9+XTMra6mnOLtT5G1fi1sBPex4ikAXK
        QHXV49SaYo0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C7DAA4369;
        Fri,  8 Dec 2017 10:38:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FDCBA4367;
        Fri,  8 Dec 2017 10:38:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elazar Leibovich <elazar.leibovich@oracle.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        idan brown <idan.brown@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Eyal Moscovici <eyal.moscovici@oracle.com>,
        nikita.leshchenko@oracle.com
Subject: Re: Unfortunate interaction between git diff-index and fakeroot
References: <0190ae30-b6c8-2a8b-b1fb-fd9d84e6dfdf@oracle.com>
        <xmqqzi6ueern.fsf@gitster.mtv.corp.google.com>
        <a770d158-c472-206f-dcdc-55cea0cf308f@oracle.com>
Date:   Fri, 08 Dec 2017 07:38:47 -0800
In-Reply-To: <a770d158-c472-206f-dcdc-55cea0cf308f@oracle.com> (Elazar
        Leibovich's message of "Fri, 8 Dec 2017 11:48:40 +0200")
Message-ID: <xmqqwp1x9qm0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E23CF3AE-DC2D-11E7-A7EE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elazar Leibovich <elazar.leibovich@oracle.com> writes:

> ignore unused information, such as commit
> 2cb45e95438c113871fbbea5b4f629f9463034e7
> which ignores st_dev, because it doesn't actually matter, or

I do not think it ignores because "it doesn't matter".  st_dev is
known not to be stable (e.g. across reboots and reconnects nfs), so
it is a poor indicator to use as a quick measure to see if the file
contents may have changed since we last checked.  On the other hand,
in a sane (it is of course open to debate "by whose definition")
environment, the fact that the owner of the file has changed _is_ a
significant enough sign to suspect that the file contents have
changed (i.e. the file is suspect to be dirty; you can actually
check and refresh, of course, though).

> commit e44794706eeb57f2ee38ed1604821aa38b8ad9d2 which ignores
> mode changes not relevant to the owner.

And that one is not even about the cached stat information used for
the quick "dirty-ness" check.  The change is about the mode bits in
recorded history.

File's mtime is not recorded in the history, either, but we do care
and record it in the index, because it can be used as a good (albeit
a bit too coarse grained) indicator that the contents of a file may
have changed.  

The owner and group fall into the same category.

