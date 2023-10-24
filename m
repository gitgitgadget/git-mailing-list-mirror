Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430E2D600
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5VgQsnL"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B3E8
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:55:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F9A521512;
	Tue, 24 Oct 2023 17:55:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+I3ygq2mDyRVaRZseSKgzzL/j17a2NIkmprZZk
	u8bfs=; b=L5VgQsnLHXzg3LOjuULprcGe2H/U/LU07pwpVxC9YKoYvoqPFXvvob
	Lmeb4CiTbZerqGXuyjgNmDKN9VWHkj+x3uwVg1aiwULbSl6wHyn9zAZFmeiMVr4t
	vzGNVMdXpQ+wlO9N8hQeGIu26rZgKI75BsET76pPttOYWdj59AojI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 614CD21511;
	Tue, 24 Oct 2023 17:55:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D29682150D;
	Tue, 24 Oct 2023 17:55:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Jeff King <peff@peff.net>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move validation code below
 process_address_list
In-Reply-To: <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com> (Michael
	Strawbridge's message of "Tue, 24 Oct 2023 16:19:43 -0400")
References: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
	<xmqq1qe0lui2.fsf@gitster.g>
	<20231011221844.GB518221@coredump.intra.peff.net>
	<xmqqzg0oiy4s.fsf@gitster.g>
	<20231011224753.GE518221@coredump.intra.peff.net>
	<b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
	<20231020064525.GB1642714@coredump.intra.peff.net>
	<20231020071402.GC1642714@coredump.intra.peff.net>
	<20231020100343.GA2194322@coredump.intra.peff.net>
	<xmqqil71otsa.fsf@gitster.g>
	<20231023185152.GC1537181@coredump.intra.peff.net>
	<393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
	<ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
Date: Tue, 24 Oct 2023 14:55:09 -0700
Message-ID: <xmqqmsw73cua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00D819DE-72B8-11EE-8CE2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Michael Strawbridge <michael.strawbridge@amd.com> writes:

> Subject: [PATCH] send-email: move validation code below process_address_list
>
> Move validation logic below processing of email address lists so that
> email validation gets the proper email addresses.

Hmph, without this patch, the tip of 'seen' passes t9001 on my box,
but with it, it claims that it failed 58, 87, and 89.

Here is how #58 fails (the last part of "cd t && sh t9001-*.sh -i -v").

expecting success of 9001.58 'In-Reply-To without --chain-reply-to':
        clean_fake_sendmail &&
        echo "<unique-message-id@example.com>" >expect &&
        git send-email \
                --from="Example <nobody@example.com>" \
                --to=nobody@example.com \
                --no-chain-reply-to \
                --in-reply-to="$(cat expect)" \
                --smtp-server="$(pwd)/fake.sendmail" \
                $patches $patches $patches \
                2>errors &&
        # The first message is a reply to --in-reply-to
        sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
        test_cmp expect actual &&
        # Second and subsequent messages are replies to the first one
        sed -n -e "s/^Message-ID: *\(.*\)/\1/p" msgtxt1 >expect &&
        sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
        test_cmp expect actual &&
        sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
        test_cmp expect actual

0001-Second.patch
0001-Second.patch
0001-Second.patch
(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
OK. Log says:
Sendmail: /usr/local/google/home/jch/w/git.git/t/trash directory.t9001-send-email/fake.sendmail -i nobody@example.com author@example.com one@example.com two@example.com committer@example.com
From: Example <nobody@example.com>
To: nobody@example.com
Cc: A <author@example.com>,
        One <one@example.com>,
        two@example.com,
        C O Mitter <committer@example.com>
Subject: [PATCH 1/1] Second.
Date: Tue, 24 Oct 2023 21:52:27 +0000
Message-ID: <20231024215229.1787922-1-nobody@example.com>
X-Mailer: git-send-email 2.42.0-705-g1a1f985ecc
In-Reply-To: <unique-message-id@example.com>
References: <unique-message-id@example.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
OK. Log says:
Sendmail: /usr/local/google/home/jch/w/git.git/t/trash directory.t9001-send-email/fake.sendmail -i nobody@example.com author@example.com one@example.com two@example.com committer@example.com
From: Example <nobody@example.com>
To: nobody@example.com
Cc: A <author@example.com>,
        One <one@example.com>,
        two@example.com,
        C O Mitter <committer@example.com>
Subject: [PATCH 1/1] Second.
Date: Tue, 24 Oct 2023 21:52:28 +0000
Message-ID: <20231024215229.1787922-2-nobody@example.com>
X-Mailer: git-send-email 2.42.0-705-g1a1f985ecc
In-Reply-To: <unique-message-id@example.com>
References: <unique-message-id@example.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
OK. Log says:
Sendmail: /usr/local/google/home/jch/w/git.git/t/trash directory.t9001-send-email/fake.sendmail -i nobody@example.com author@example.com one@example.com two@example.com committer@example.com
From: Example <nobody@example.com>
To: nobody@example.com
Cc: A <author@example.com>,
        One <one@example.com>,
        two@example.com,
        C O Mitter <committer@example.com>
Subject: [PATCH 1/1] Second.
Date: Tue, 24 Oct 2023 21:52:29 +0000
Message-ID: <20231024215229.1787922-3-nobody@example.com>
X-Mailer: git-send-email 2.42.0-705-g1a1f985ecc
In-Reply-To: <unique-message-id@example.com>
References: <unique-message-id@example.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
--- expect      2023-10-24 21:52:29.115044899 +0000
+++ actual      2023-10-24 21:52:29.119045306 +0000
@@ -1 +1 @@
-<20231024215229.1787922-1-nobody@example.com>
+<unique-message-id@example.com>
not ok 58 - In-Reply-To without --chain-reply-to
#
#               clean_fake_sendmail &&
#               echo "<unique-message-id@example.com>" >expect &&
#               git send-email \
#                       --from="Example <nobody@example.com>" \
#                       --to=nobody@example.com \
#                       --no-chain-reply-to \
#                       --in-reply-to="$(cat expect)" \
#                       --smtp-server="$(pwd)/fake.sendmail" \
#                       $patches $patches $patches \
#                       2>errors &&
#               # The first message is a reply to --in-reply-to
#               sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
#               test_cmp expect actual &&
#               # Second and subsequent messages are replies to the first one
#               sed -n -e "s/^Message-ID: *\(.*\)/\1/p" msgtxt1 >expect &&
#               sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
#               test_cmp expect actual &&
#               sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
#               test_cmp expect actual
#
1..58

