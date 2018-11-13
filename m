Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FBE71F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 13:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbeKMXdV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 18:33:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55017 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeKMXdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 18:33:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 278B122CB2;
        Tue, 13 Nov 2018 08:35:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kvaTdjzkhPjaViTQHoLX/mXWEqk=; b=R4CB0Y
        qM+h3luz3gLVSce/PEWQF7Y50K/V8lEb4Nuwm7lHCkm16aiX7prpNIpZGmJ4WkCY
        CzgU9PJO5f6WS+qFhl6aqXQrVYXXNIYOiGQicTV+e/ihmYY6Rbp8spPrWGA8TE6G
        jb7sZHWM2VoxkUI2y3QbnF1k4p7Tn6qFKvFls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rDTmAasTpYfSMP2dYYZ6b1uy7MECAgOU
        EEmisYJF49S7qApszdCtg85KSjfu5Ig6gJo1wJxeksEF4q2CdzHOmJTOzquJKBIw
        L7l3RJSiCG7YluUXMpUuNHa3NjDyh9V+nxp61NWgxZEGxTmxwP9ivuiRtqCMC0zG
        4/voVdMSTjg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1BA7E22CB0;
        Tue, 13 Nov 2018 08:35:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BC9522CAE;
        Tue, 13 Nov 2018 08:35:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
References: <cover.1539305180.git.steadmon@google.com>
        <cover.1542059029.git.steadmon@google.com>
        <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
Date:   Tue, 13 Nov 2018 22:35:04 +0900
In-Reply-To: <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
        (steadmon's message of "Mon, 12 Nov 2018 13:49:05 -0800")
Message-ID: <xmqqd0r9umlz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEB4236A-E748-11E8-9FF1-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> +	if (tmp_allowed_versions[0] != config_version)
> +		for (int i = 1; i < nr_allowed_versions; i++)
> +			if (tmp_allowed_versions[i] == config_version) {
> +				enum protocol_version swap =
> +					tmp_allowed_versions[0];
> +				tmp_allowed_versions[0] =
> +					tmp_allowed_versions[i];
> +				tmp_allowed_versions[i] = swap;
> +			}

Here is what coccicheck suggests.

diff -u -p a/protocol.c b/protocol.c
--- a/protocol.c
+++ b/protocol.c
@@ -111,11 +111,8 @@ void get_client_protocol_version_adverti
 	if (tmp_allowed_versions[0] != config_version)
 		for (int i = 1; i < nr_allowed_versions; i++)
 			if (tmp_allowed_versions[i] == config_version) {
-				enum protocol_version swap =
-					tmp_allowed_versions[0];
-				tmp_allowed_versions[0] =
-					tmp_allowed_versions[i];
-				tmp_allowed_versions[i] = swap;
+				SWAP(tmp_allowed_versions[0],
+				     tmp_allowed_versions[i]);
 			}
 
 	strbuf_addf(advert, "version=%s",
