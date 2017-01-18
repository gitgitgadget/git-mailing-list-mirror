Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52A71F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdARS0J (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:26:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60445 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750905AbdARS0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:26:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49A315F730;
        Wed, 18 Jan 2017 13:26:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A0vDAhbrUOx4rX0f3i6nEs64Bjs=; b=JnVYke
        dqW3a4jYT0zhpO59laMJTMtI7goG1pnyuCD2QugP8t28iNV/QJd92Usc3uY6XNoF
        pyt1wle6qBHOth0wk+wBTW11/xsN6pG05rb8766+S/Q6XOvPcOKurAocbHVCETRz
        zE+iQbNzdX4syuNx/F5neWESAaTQdPMbpxGBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mCPVBtouN9Gk47jqg1b8qeZ/+SmV3+sE
        QmppHR4TCXfghZxjtgWEQKaSOxdnNAxWkFPU2qLC8KfDDSMefJB1ndEaNEpS91tF
        JdFSndkk8yh193JT3SDYgDSmwENqjBhhP0bXnZzJRIdOgIEZTA1D1gnDqHOeXD+i
        JHPp526zLlU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F24105F72D;
        Wed, 18 Jan 2017 13:26:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A45935F728;
        Wed, 18 Jan 2017 13:26:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
References: <20170117233723.23897-1-santiago@nyu.edu>
        <20170117233723.23897-5-santiago@nyu.edu>
        <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 18 Jan 2017 10:25:59 -0800
In-Reply-To: <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 17 Jan 2017 16:19:24 -0800")
Message-ID: <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9007A36C-DDAB-11E6-986E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> santiago@nyu.edu writes:
>
>> @@ -428,9 +443,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  	if (filter.merge_commit)
>>  		die(_("--merged and --no-merged option are only allowed with -l"));
>>  	if (cmdmode == 'd')
>> -		return for_each_tag_name(argv, delete_tag);
>> -	if (cmdmode == 'v')
>> -		return for_each_tag_name(argv, verify_tag);
>> +		return for_each_tag_name(argv, delete_tag, NULL);
>> +	if (cmdmode == 'v') {
>> +		if (format)
>> +			verify_ref_format(format);
>> +		return for_each_tag_name(argv, verify_tag, format);
>> +	}
>
> This triggers:
>
>     builtin/tag.c: In function 'cmd_tag':
>     builtin/tag.c:451:3: error: passing argument 3 of
>     'for_each_tag_name' discards 'const' qualifier from pointer target type [-Werror]
>        return for_each_tag_name(argv, verify_tag, format);
>
> Either for-each-tag-name's new parameter needs to be typed
> correctly, or the type of the "format" variable needs to be updated.

Squashing the following into this commit solves this issue with the
former approach.  The lines it touches are all from 4/6 and I view
all of it as general improvement, including type correctness and
code formatting.

diff --git a/builtin/tag.c b/builtin/tag.c
index f81273a85a..fbb85ba3dc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -66,10 +66,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const unsigned char *sha1, void *cb_data);
+				const unsigned char *sha1, const void *cb_data);
 
 static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
-		void *cb_data)
+			     const void *cb_data)
 {
 	const char **p;
 	char ref[PATH_MAX];
@@ -95,7 +95,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 }
 
 static int delete_tag(const char *name, const char *ref,
-				const unsigned char *sha1, void *cb_data)
+		      const unsigned char *sha1, const void *cb_data)
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
@@ -104,10 +104,10 @@ static int delete_tag(const char *name, const char *ref,
 }
 
 static int verify_tag(const char *name, const char *ref,
-				const unsigned char *sha1, void *cb_data)
+		      const unsigned char *sha1, const void *cb_data)
 {
 	int flags;
-	char *fmt_pretty = cb_data;
+	const char *fmt_pretty = cb_data;
 	flags = GPG_VERIFY_VERBOSE;
 
 	if (fmt_pretty)
