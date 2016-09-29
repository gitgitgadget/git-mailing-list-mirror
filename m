Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B06207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934086AbcI2VAc (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57324 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934225AbcI2VAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7895A429EB;
        Thu, 29 Sep 2016 17:00:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=JMnA
        6TkaMr8YjQRejk7j7gRbkGw=; b=xwQNm+BhXzraa8WZuFQsSW+ycJ2Bk8sHOmdx
        C2kG/ljl9eeZoDCvEijrhwVfV/yx3nMhqvFdLj//UtLT7AtmW3IFWVkKDKtRw7hd
        i/8xqgc6lMpMflZvlQzk9kO+NqTs0yEU6UvLub6NG1voORc3NaCuj/tEZNUj6cEE
        Av4+bco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=bp8WRF
        iQnUgFsXWv1X9KOH9wxWKVrUN7aab1Td1hma6LSr8hbQATT+UTdBYHiZyzwQg5tg
        rinEzZvOMLIYtLQIGQihqERxiSeQ5EgjhmsIXih1Nom/ExaRoPUDuWpY+e7HlD0z
        xuasC3AUPyZY8je2FQrOiZqiozaR5GWBd7J0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71890429EA;
        Thu, 29 Sep 2016 17:00:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F083D429E9;
        Thu, 29 Sep 2016 17:00:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 5/9] t1300: disable system-wide config for tests that wants to read from -c
Date:   Thu, 29 Sep 2016 14:00:10 -0700
Message-Id: <20160929210014.3874-6-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: BFEB3F88-8687-11E6-821A-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test wants to do

	git -c x.two=2 config --get-regexp ^x\.*

and see x.two that came from the one-shot configuration in its
output.  This form cannot be limited with "--local", as it limits
the input to the local configuration file and makes these one-shot
settings ignored.  At this point, the test knows that there is no
variable that match x.* in its local configuration, and it also was
OK to assume that there is nothing in the system-wide config or
global one.

Make sure that assumption holds by using the GIT_CONFIG_NOSYSTEM
environment, as we may add anything to t/gitconfig-for-test later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-repo-config.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 940469339bd2..95734034e0d5 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1093,6 +1093,7 @@ test_expect_success 'multiple git -c appends config' '
 	x.one 1
 	x.two 2
 	EOF
+	GIT_CONFIG_NOSYSTEM=1 \
 	git -c x.one=1 x >actual &&
 	test_cmp expect actual
 '
-- 
2.10.0-589-g5adf4e1

