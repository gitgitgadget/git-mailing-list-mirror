Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40152202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 05:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbdJQFEO (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 01:04:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50535 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753123AbdJQFEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 01:04:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3699B2385;
        Tue, 17 Oct 2017 01:04:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=4
        /om8Yw+E8CUZt8kewTbl8KjnRI=; b=qd0l4y3k2+WXXLeQlxDJRFf60Oly++irT
        ePcD0lFhdcRakwrLmEgwpdk/xlinpkGLo32s8IlfApAzw1oX6CP8us1E8Iy3FpKp
        KkB7+aPBYAQAcsq4dCCxUZHGXNrhwxwn3F/uH+FGhJBvQ9oHHVqVQiFBevFptRha
        IkO9QAHX/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=lbz
        S5MHYyLHHhIQDUZzxtM9n2gG7IWauDp4aW9yDYsdM65/9cRjdvGLDHiEJ8CFLbdV
        sWU8FxguBrtSDGKZIpaXkJ1PY78+ra4bfDRHTA/uWgEaCMPBqQd7hk70Nmas4moA
        TY2XBubeMsyQxShriFwADRO5ecZtI96RacGrW7C8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98C69B2384;
        Tue, 17 Oct 2017 01:04:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 059E4B2383;
        Tue, 17 Oct 2017 01:04:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Is t5601 flaky for anybody else?
Date:   Tue, 17 Oct 2017 14:04:10 +0900
Message-ID: <xmqq376ipdpx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D65FEA0-B2F8-11E7-A747-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I seem to be seeing sporadic errors with this test, and today I got
annoyed enough to do

	cd t && while sh t5601-clone.sh -i -v; do :; done

I saw an error from "cp" saying "plink.exe - text file busy" or
something like that at around test #45; here is an workaround that
seems to work (the above loop is spinning without problem for
several minutes now).

 t/t5601-clone.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9c56f771b6..50e40abb11 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -308,6 +308,7 @@ test_expect_success 'clone checking out a tag' '
 
 setup_ssh_wrapper () {
 	test_expect_success 'setup ssh wrapper' '
+		rm -f "$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
 			"$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper$X" &&
@@ -318,6 +319,7 @@ setup_ssh_wrapper () {
 }
 
 copy_ssh_wrapper_as () {
+	rm -f "${1%$X}$X" &&
 	cp "$TRASH_DIRECTORY/ssh-wrapper$X" "${1%$X}$X" &&
 	GIT_SSH="${1%$X}$X" &&
 	export GIT_SSH
