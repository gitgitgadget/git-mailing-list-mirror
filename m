Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFFE1F461
	for <e@80x24.org>; Wed, 15 May 2019 01:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEOBgg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:36:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65348 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEOBgg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:36:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F76A13A1CF;
        Tue, 14 May 2019 21:36:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=SX1q5Gn+bbxQL
        yDKpeX+X3d2Sxo=; b=TH7MYdRkYCSvD+fXQaimm4iS/2vm9VPjjWwihKXdbotwB
        +w28kpPM0TYYz2L0u3xYBCrB5zE0ZYzUDaXroQA5rg6C6vzWsMTIuK9fRNO5z4L0
        pXk/qe7PUkfQML/AXX4m/ymSCEiEfIaqVShoslWYBz4lWivq36WRfctZyxKs9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=rEYYXo+
        0r7GiGUT/NKK2/YiSrF3WZFnYv61J9YaOsHI0n1iN1nqEqufJvd8SlkubjcrB4mp
        ySJJqBDupB2e1U8p9bYb/a9gK2CA4a6UOggGjxZzAUmbZUARRnoWdcz6VLVpla25
        HhcvLqG9kOjiIO1oGTZrux+ycQfTr/XO91ZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0603C13A1CE;
        Tue, 14 May 2019 21:36:36 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 752E613A1CD;
        Tue, 14 May 2019 21:36:35 -0400 (EDT)
Date:   Tue, 14 May 2019 21:36:33 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] test-lib: try harder to ensure a working jgit
Message-ID: <20190515013633.GQ3654@pobox.com>
References: <20190514020520.GI3654@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190514020520.GI3654@pobox.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: E047D468-76B1-11E9-8C03-E828E74BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The JGIT prereq uses `type jgit` to determine whether jgit is present.
While this is usually sufficient, it won't help if the jgit found is
badly broken.  This wastes time running tests which fail due to no fault
of our own.

Use `jgit --version` instead, to guard against cases where jgit is
present on the system, but will fail to run, e.g. because of some JRE
issue, or missing Java dependencies.  Checking that it gets far enough
to process the '--version' argument isn't perfect, but seems to be good
enough in practice.  It's also consistent with how we detect some other
dependencies, see e.g. the CURL and UNZIP prerequisites.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
As promised, I stole the second paragraph from =C6var nearly verbatim. :)

 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 908ddb9c46..599fd70e14 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1522,7 +1522,7 @@ test_lazy_prereq NOT_ROOT '
 '
=20
 test_lazy_prereq JGIT '
-	type jgit
+	jgit --version
 '
=20
 # SANITY is about "can you correctly predict what the filesystem would
--=20
Todd
