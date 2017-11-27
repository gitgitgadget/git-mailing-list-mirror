Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3AF20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 01:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbdK0Bc4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 20:32:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62518 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752249AbdK0Bc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 20:32:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADC4DBA4EF;
        Sun, 26 Nov 2017 20:32:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ioFQ0YuTHq2qsdF10uq/U+ZQ4uY=; b=f3zapj
        r7rTdHJoxC2k5AayN+BUgIZHaDU4cO2Pqai8CA6BoQOs6Y4Lff9o4FJ3wUg2TcjQ
        xZozdFsEz0ejGe3j98WhCfBydMLwW87CdllnEh/XhgDtrflGNV2wTVDI4laVh441
        z5s2hIGzjoTC6VhMU6ZejKchjWrC4OXoKx8YU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V2X+e3h9+wBdJEDJ++lhzQ22GIZhKiSY
        ejEo5WkVhhpqF//XjQtYlG/YRnBsOeyBEsHYgrop8RVijjNCdDFk4pyh9mlVA36E
        SeiwATpDVf6eIaj8kuTiLJqdqslUwevyOx6UT7z5dwTfdkTkDyHDC4oPxFjZNu4f
        KNGEPgYL15Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4784BA4EE;
        Sun, 26 Nov 2017 20:32:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E8CDBA4ED;
        Sun, 26 Nov 2017 20:32:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     gennady.kupava@gmail.com
Cc:     git@vger.kernel.org, Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH 2/2] trace: improve performance while category is disabled
References: <xmqqvai5lf4a.fsf@gitster.mtv.corp.google.com>
        <20171126201119.24313-1-gennady.kupava@gmail.com>
        <20171126201119.24313-2-gennady.kupava@gmail.com>
        <xmqqpo84fre1.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 27 Nov 2017 10:32:53 +0900
In-Reply-To: <xmqqpo84fre1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 27 Nov 2017 10:21:26 +0900")
Message-ID: <xmqqlgisfquy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E44FA354-D312-11E7-AEEE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> gennady.kupava@gmail.com writes:
>
>> From: Gennady Kupava <gkupava@bloomberg.net>
>>
>> - Do the check if the trace key is enabled sooner in call chain.
>> - Move just enough code from trace.c into trace.h header so all code
>>   necessary to determine that trace is disabled could be inlined to
>>   calling functions.
>
> Makes sense.  Will queue.
>
> Thanks.

Just in case others notice style and whitespace issues, I've applied
the following to fix them, so there is no need to reroll only to fix
these.

diff --git a/trace.h b/trace.h
index db10f2afeb..05395242aa 100644
--- a/trace.h
+++ b/trace.h
@@ -85,29 +85,29 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
 		if (trace_pass_fl(key))					    \
 			trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,   \
 					    __VA_ARGS__);		    \
-	} while(0)
+	} while (0)
 
 #define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
 
 #define trace_argv_printf(argv, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_default_key))			    \
-		       trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,	    \
+			trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,	    \
 					    argv, __VA_ARGS__);		    \
-	} while(0)
+	} while (0)
 
 #define trace_strbuf(key, data)						    \
 	do {								    \
 		if (trace_pass_fl(key))					    \
 			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
-	} while(0)
+	} while (0)
 
 #define trace_performance(nanos, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
 			trace_performance_fl(TRACE_CONTEXT, __LINE__, nanos,\
-					     __VA_ARGS__);  		    \
-	} while(0)
+					     __VA_ARGS__);		    \
+	} while (0)
 
 #define trace_performance_since(start, ...)				    \
 	do {								    \
@@ -115,7 +115,7 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
 			trace_performance_fl(TRACE_CONTEXT, __LINE__,       \
 					     getnanotime() - (start),	    \
 					     __VA_ARGS__);		    \
-	} while(0)
+	} while (0)
 
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
@@ -129,7 +129,8 @@ extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 __attribute__((format (printf, 4, 5)))
 extern void trace_performance_fl(const char *file, int line,
 				 uint64_t nanos, const char *fmt, ...);
-inline int trace_pass_fl(struct trace_key *key) {
+inline int trace_pass_fl(struct trace_key *key)
+{
 	return key->fd || !key->initialized;
 }
 
