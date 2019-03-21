Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC0120248
	for <e@80x24.org>; Thu, 21 Mar 2019 21:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCUVQy (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 17:16:54 -0400
Received: from siwi.pair.com ([209.68.5.199]:20201 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfCUVQy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 17:16:54 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5479F3F408A;
        Thu, 21 Mar 2019 17:16:53 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 33DE63F4088;
        Thu, 21 Mar 2019 17:16:52 -0400 (EDT)
Subject: Re: [PATCH v3 0/1] Write trace2 output to directories
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <cover.1552519463.git.steadmon@google.com>
 <cover.1553202340.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fc057cb5-c1c9-5466-1d45-c7d1e89a9894@jeffhostetler.com>
Date:   Thu, 21 Mar 2019 17:16:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <cover.1553202340.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/21/2019 5:09 PM, Josh Steadmon wrote:
> Persistently enabling trace2 output is difficult because it requires
> specifying a full filename. This series teaches tr2_dst_get_trace_fd()
> to create files underneath a given directory provided as the target of
> the GIT_TR2_* envvars.
> 
> Changes since V2:
> * No longer appends a suffix to filenames on the first creation attempt.
> * Renamed function & constant now that randomization is no longer used.
> * Simplified strbuf usage.
> 
> Changes since V1:
> * No longer supports timestamp templates.
> * No longer supports filename prefixes.
> * Always creates filenames based on the final component of the trace2
>    SID.
> 
> Josh Steadmon (1):
>    trace2: write to directory targets
> 
>   Documentation/technical/api-trace2.txt |  5 ++
>   t/t0210-trace2-normal.sh               | 15 ++++++
>   trace2/tr2_dst.c                       | 63 +++++++++++++++++++++++++-
>   3 files changed, 81 insertions(+), 2 deletions(-)
> 
> Range-diff against v2:
> 1:  59d8c6511b ! 1:  ce5258610f trace2: write to directory targets
>      @@ -23,8 +23,8 @@
>        
>       +	If the target already exists and is a directory, the traces will be
>       +	written to files (one per process) underneath the given directory. They
>      -+	will be named according to the last component of the SID followed by a
>      -+	counter to avoid potential collisions.
>      ++	will be named according to the last component of the SID (optionally
>      ++	followed by a counter to avoid filename collisions).
>       +
>        `af_unix:[<socket_type>:]<absolute-pathname>`::
>        
>      @@ -37,7 +37,7 @@
>        	test_cmp expect actual
>        '
>        
>      -+test_expect_success 'randomized filename' '
>      ++test_expect_success 'automatic filename' '
>       +	test_when_finished "rm -r traces actual expect" &&
>       +	mkdir traces &&
>       +	GIT_TR2="$(pwd)/traces" test-tool trace2 001return 0 &&
>      @@ -71,9 +71,9 @@
>        #define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"
>        
>       +/*
>      -+ * How many attempts we will make at creating a random trace output path.
>      ++ * How many attempts we will make at creating an automatically-named trace file.
>       + */
>      -+#define MAX_RANDOM_ATTEMPTS 10
>      ++#define MAX_AUTO_ATTEMPTS 10
>       +
>        static int tr2_dst_want_warning(void)
>        {
>      @@ -82,45 +82,47 @@
>        	dst->need_close = 0;
>        }
>        
>      -+static int tr2_dst_try_random_path(struct tr2_dst *dst, const char *tgt_prefix)
>      ++static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
>       +{
>       +	int fd;
>       +	const char *last_slash, *sid = tr2_sid_get();
>      -+	struct strbuf base_path = STRBUF_INIT, final_path = STRBUF_INIT;
>      ++	struct strbuf path = STRBUF_INIT;
>      ++	size_t base_path_len;
>       +	unsigned attempt_count;
>       +
>       +	last_slash = strrchr(sid, '/');
>       +	if (last_slash)
>       +		sid = last_slash + 1;
>       +
>      -+	strbuf_addstr(&base_path, tgt_prefix);
>      -+	if (!is_dir_sep(base_path.buf[base_path.len - 1]))
>      -+		strbuf_addch(&base_path, '/');
>      -+	strbuf_addstr(&base_path, sid);
>      ++	strbuf_addstr(&path, tgt_prefix);
>      ++	if (!is_dir_sep(path.buf[path.len - 1]))
>      ++		strbuf_addch(&path, '/');
>      ++	strbuf_addstr(&path, sid);
>      ++	base_path_len = path.len;
>       +
>      -+	for (attempt_count = 0; attempt_count < MAX_RANDOM_ATTEMPTS; attempt_count++) {
>      -+		strbuf_reset(&final_path);
>      -+		strbuf_addbuf(&final_path, &base_path);
>      -+		strbuf_addf(&final_path, ".%d", attempt_count);
>      ++	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
>      ++		if (attempt_count > 0) {
>      ++			strbuf_setlen(&path, base_path_len);
>      ++			strbuf_addf(&path, ".%d", attempt_count);
>      ++		}
>       +
>      -+		fd = open(final_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
>      ++		fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
>       +		if (fd != -1)
>       +			break;
>       +	}
>       +
>       +	if (fd == -1) {
>       +		if (tr2_dst_want_warning())
>      -+			warning("trace2: could not open '%s' for '%s' tracing: %s",
>      -+				base_path.buf, dst->env_var_name, strerror(errno));
>      ++			warning("trace2: could not open '%.*s' for '%s' tracing: %s",
>      ++				(int) base_path_len, path.buf,
>      ++				dst->env_var_name, strerror(errno));
>       +
>       +		tr2_dst_trace_disable(dst);
>      -+		strbuf_release(&base_path);
>      -+		strbuf_release(&final_path);
>      ++		strbuf_release(&path);
>       +		return 0;
>       +	}
>       +
>      -+	strbuf_release(&base_path);
>      -+	strbuf_release(&final_path);
>      ++	strbuf_release(&path);
>       +
>       +	dst->fd = fd;
>       +	dst->need_close = 1;
>      @@ -140,7 +142,7 @@
>       -		return tr2_dst_try_path(dst, tgt_value);
>       +	if (is_absolute_path(tgt_value)) {
>       +		if (is_directory(tgt_value))
>      -+			return tr2_dst_try_random_path(dst, tgt_value);
>      ++			return tr2_dst_try_auto_path(dst, tgt_value);
>       +		else
>       +			return tr2_dst_try_path(dst, tgt_value);
>       +	}
> 

Looks good.  Thanks.
Jeff
