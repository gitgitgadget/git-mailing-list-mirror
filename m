Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002D01F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 21:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753472AbdAZVM2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 16:12:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60448 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751880AbdAZVM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 16:12:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1454662235;
        Thu, 26 Jan 2017 16:12:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C6viyrx4fLLpFOVqUrNvWPwqkqM=; b=VIogMf
        g3w24naqu3To94Yx6XOSJO/d7tCjKdRQXIlk11owIQhB/9wVmtESesoUs2tWjSBW
        zERxEP8ooV0kAvk9pyUaGTQiPl23HoCTj2/1EmwlhwD5BrpRJr2jAQA8zFz6Msip
        2BX4LH39WSw0SEmXlpP4nFVmRjbZQXdsAw6/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A9bw2slHO1Sl4PWyPO1tmYMy/+R5Tg1G
        Efm0tJIA9KmH0BEAZHN/oZ94wkE1La8QdLolu8oTI5A6sGVEDsYXVbdvINyGvMkZ
        AGPYd39vpxO1GD4SgH3hVErUeRlTF8qJ++lwbPvswwlxJ69Xf1wgdLLTImoF7DUd
        HKiNARricNc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09FEF62234;
        Thu, 26 Jan 2017 16:12:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56B2862233;
        Thu, 26 Jan 2017 16:12:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v3 4/4] urlmatch: allow globbing for the URL host part
References: <20170125095648.4116-1-patrick.steinhardt@elego.de>
        <20170123130635.29577-1-patrick.steinhardt@elego.de>
        <20170125095648.4116-5-patrick.steinhardt@elego.de>
        <xmqq7f5h4kng.fsf@gitster.mtv.corp.google.com>
        <xmqq37g54kdz.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 26 Jan 2017 13:12:23 -0800
In-Reply-To: <xmqq37g54kdz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 26 Jan 2017 12:49:12 -0800")
Message-ID: <xmqqo9yt34qw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 221245E4-E40C-11E6-BCE6-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +	while (url_len && pat_len) {
>> +		const char *url_next = end_of_token(url, '.', url_len);
>> +		const char *pat_next = end_of_token(pat, '.', pat_len);
>> + ...
>>  	}
>>  
>> +	return 1;
>
> Embarrassing.  The last one must be "have they both run out?" i.e.
>
> 	return (!url_len && !pat_len);

OK, here is my second try.  The added test piece is to catch the
silly mistake I made above.

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index ec545e0929..33fd59fbb3 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1177,7 +1177,7 @@ test_expect_success 'urlmatch' '
 	test_cmp expect actual
 '
 
-test_expect_success 'glob-based urlmatch' '
+test_expect_success 'urlmatch with wildcard' '
 	cat >.git/config <<-\EOF &&
 	[http]
 		sslVerify
@@ -1210,6 +1210,10 @@ test_expect_success 'glob-based urlmatch' '
 		echo http.sslverify false
 	} >expect &&
 	git config --get-urlmatch HTTP https://good.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.sslverify >expect &&
+	git config --get-urlmatch HTTP https://more.example.com.au >actual &&
 	test_cmp expect actual
 '
 
diff --git a/urlmatch.c b/urlmatch.c
index 53ff972a60..0e007a3e07 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -63,36 +63,47 @@ static int append_normalized_escapes(struct strbuf *buf,
 	return 1;
 }
 
+static const char *end_of_token(const char *s, int c, size_t n)
+{
+	const char *next = memchr(s, c, n);
+	if (!next)
+		next = s + n;
+	return next;
+}
+
 static int match_host(const struct url_info *url_info,
 		      const struct url_info *pattern_info)
 {
-	char *url = xmemdupz(url_info->url + url_info->host_off, url_info->host_len);
-	char *pat = xmemdupz(pattern_info->url + pattern_info->host_off, pattern_info->host_len);
-	char *url_tok, *pat_tok, *url_save, *pat_save;
-	int matching;
-
-	url_tok = strtok_r(url, ".", &url_save);
-	pat_tok = strtok_r(pat, ".", &pat_save);
-
-	for (; url_tok && pat_tok; url_tok = strtok_r(NULL, ".", &url_save),
-				   pat_tok = strtok_r(NULL, ".", &pat_save)) {
-		if (!strcmp(pat_tok, "*"))
-			continue; /* a simple glob matches everything */
-
-		if (strcmp(url_tok, pat_tok)) {
-			/* subdomains do not match */
-			matching = 0;
-			break;
-		}
+	const char *url = url_info->url + url_info->host_off;
+	const char *pat = pattern_info->url + pattern_info->host_off;
+	int url_len = url_info->host_len;
+	int pat_len = pattern_info->host_len;
+
+	while (url_len && pat_len) {
+		const char *url_next = end_of_token(url, '.', url_len);
+		const char *pat_next = end_of_token(pat, '.', pat_len);
+
+		if (pat_next == pat + 1 && pat[0] == '*')
+			/* wildcard matches anything */
+			;
+		else if ((pat_next - pat) == (url_next - url) &&
+			 !memcmp(url, pat, url_next - url))
+			/* the components are the same */
+			;
+		else
+			return 0; /* found an unmatch */
+
+		if (url_next < url + url_len)
+			url_next++;
+		url_len -= url_next - url;
+		url = url_next;
+		if (pat_next < pat + pat_len)
+			pat_next++;
+		pat_len -= pat_next - pat;
+		pat = pat_next;
 	}
 
-	/* matching if both URL and pattern are at their ends */
-	matching = (url_tok == NULL && pat_tok == NULL);
-
-	free(url);
-	free(pat);
-
-	return matching;
+	return (!url_len && !pat_len);
 }
 
 static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
