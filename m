Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16989C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93162070A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h1m+qcpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEOVs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 17:48:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63498 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgEOVs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 17:48:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0720D73F5;
        Fri, 15 May 2020 17:48:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oNdoW4IT1mIO3oRlOziA6AqDPoA=; b=h1m+qc
        pAgmJ5EYPnsWyPE/Z/bTSevm2VFnsijV+8L3xXiWj0wyHK7zW6Xma2qSc1y26ssF
        HIW33xTfm8Re9TAUnRhUiVvRYk+TTJaoeSN17tnngOmTiB/9+N6Q6s4mLl5UDUi2
        aFAWU62qtXkC7wU3SL0qSPqH2N6WOqDfiZ4Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xvrzOFkKHilHt3FRNxvmWjt+/3CGT3l5
        rCdt44aE+GRGBM1G2qMdMxAJn9Noswghr3ArP33IhRlx9sJ5Bzsrn/SCI3WEP68m
        ZeIXAX93t1Q/LxZ33mf0r+IF/rhoySh4MB2lkN6VZ+dALYCTGTVd3qyT8MKVy53G
        7L4AVaWOQjE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97CA7D73F0;
        Fri, 15 May 2020 17:48:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D8D6AD73ED;
        Fri, 15 May 2020 17:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, emaste@freebsd.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2] t4210: detect REG_ILLSEQ dynamically
References: <20200513111636.30818-1-carenas@gmail.com>
        <20200515195157.41217-1-carenas@gmail.com>
        <xmqqmu69kktq.fsf@gitster.c.googlers.com>
Date:   Fri, 15 May 2020 14:48:23 -0700
In-Reply-To: <xmqqmu69kktq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 15 May 2020 13:24:49 -0700")
Message-ID: <xmqqblmolviw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD9DCAA6-96F5-11EA-A865-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  	else if (argc < 3)
>>  		usage("test-tool regex --bug\n"
>> -		      "test-tool regex <pattern> <string> [<options>]");
>> +		      "test-tool regex [--silent] <pattern> <string> [<options>]");
>>
>> +	if (!strcmp(argv[1], "--silent")) {
>> +		silent = 1;
>> +		argv++;
>> +	}
>
> This looks fishy---if argc==3 and the first one is "--silent", only
> the <pattern> is left in argv and before taking <string> out of the
> argv, we need to ensure argc is still large enough, but I do not
> think that is done below:
> ...
> Not that it matters _too_ much as this is merely a test helper and
> it would not hurt anybody as long as our callers are careful.

But it still bothers me.  Perhaps like this?  

If I were writing this from scratch, I would probably increment
argv++ once as early as possible and consistently access argv[0]
or *argv++, but that would make the patch even noisier.

 t/helper/test-regex.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index 7a8ddce45b..e68b4f6a73 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -46,16 +46,23 @@ int cmd__regex(int argc, const char **argv)
 	regmatch_t m[1];
 	char errbuf[64];
 
-	if (argc == 2 && !strcmp(argv[1], "--bug"))
-		return test_regex_bug();
-	else if (argc < 3)
-		usage("test-tool regex --bug\n"
-		      "test-tool regex [--silent] <pattern> <string> [<options>]");
+	if (argc < 2)
+		goto usage;
 
+	if (!strcmp(argv[1], "--bug")) {
+		if (argc == 2)
+			return test_regex_bug();
+		else
+			goto usage;
+	}
 	if (!strcmp(argv[1], "--silent")) {
-		silent = 1;
+		silent = 0;
 		argv++;
+		argc--;
 	}
+	if (argc < 3)
+		goto usage;
+
 	argv++;
 	pat = *argv++;
 	str = *argv++;
@@ -84,4 +91,8 @@ int cmd__regex(int argc, const char **argv)
 		return 1;
 
 	return 0;
+
+usage:
+	usage("test-tool regex --bug\n"
+	      "test-tool regex [--silent] <pattern> <string> [<options>]");
 }
