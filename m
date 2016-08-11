Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D70F20193
	for <e@80x24.org>; Thu, 11 Aug 2016 17:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbcHKRWF (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 13:22:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbcHKRWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 13:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C807A32BC8;
	Thu, 11 Aug 2016 13:22:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nNsQ2PtSVo5mqnxGWWkTF5h4ofY=; b=KSvsWk
	49iFrIkttPC9jvxaebA3mQ17NJk9wj8gDYZ3Xl+qKlOfbRF7YjTruOWaLK7R0CaF
	47k56PGSwDFeEthUqQqiq6+xIdTqXRKGRKUCq+bMnni2e0eaSQu2A1DZUyLy9bRK
	QXBIVWagZocx31nmm9cpmf2YUN5FDUEP6ipWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vPw8pQc8jCgtCcR+Mr6j+vVBYKSlcLrO
	5lH9onkwaZykmgPq4m3Jmotr8RoDedumaTpUot46KBAHM+YuUfHdaQspI9WTjSuc
	W6qCJZSOwvuWFmHoZq2Q4Niw3d48P1cjV0MWURvhsNe6tE2+Yd9jg5kMg1RDbCo8
	h+m4YDn6Dls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF5F532BC7;
	Thu, 11 Aug 2016 13:22:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40F7832BC3;
	Thu, 11 Aug 2016 13:22:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v4 1/2] diff: add --line-prefix option for passing in a prefix
References: <20160810231908.26330-1-jacob.e.keller@intel.com>
Date:	Thu, 11 Aug 2016 10:22:00 -0700
In-Reply-To: <20160810231908.26330-1-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Wed, 10 Aug 2016 16:19:07 -0700")
Message-ID: <xmqqh9ar2pc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E0FC1E0-5FE8-11E6-B65B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

>  const char *diff_line_prefix(struct diff_options *opt)
>  {
>  	struct strbuf *msgbuf;
> +
>  	if (!opt->output_prefix)
> -		return "";
> +		if (opt->line_prefix)
> +			return opt->line_prefix;
> +		else
> +			return "";
>  
>  	msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
> +	/* line prefix must be printed before the output_prefix() */
> +	if (opt->line_prefix)
> +		strbuf_insert(msgbuf, 0, opt->line_prefix, strlen(opt->line_prefix));
>  	return msgbuf->buf;
>  }

The result of applying this change leaves the semantics of the
line_prefix field, the output_prefix() callback, and the
output_prefix_length field in the diff_options structure a bit
tricky to reason about.

The code pretends as if the remainder of the system does not even
care about the presence of line_prefix (i.e. output_prefix_length is
not updated), but its only user of output_prefix_length cares, I
think.  It is in diff.c::show_stats() where it auto-computes the
allowed display width for the stat portion:

        if (options->stat_width == -1)
                width = term_columns() - options->output_prefix_length;

The output_prefix_length is initialized to be 0, but when --graph is
in effect, it is set to the width of the graph portion of the output
in the output_prefix callback, diff_output_prefix_callback().

So the above change is clearly wrong in that it needs to add the
number of display columns needed to show opt->line_prefix to the
output_prefix_length, but I wonder if a better "fix" to this is to
get rid of output_prefix_length field from diff_options struct as a
preparatory step.  That would make the bug in this patch disappear.

Perhaps like this.  I do not know if Lucian is still interested in,
or remembers what did for, Git in 2012, but this updates his code
and replaces it with what I hope is an equivalent, so I added him
to the Cc: line.

-- >8 --
Subject: diff.c: remove output_prefix_length field

"diff/log --stat" has a logic that determines the display columns
available for the diffstat part of the output and apportions it for
pathnames and diffstat graph automatically.

5e71a84a (Add output_prefix_length to diff_options, 2012-04-16)
added the output_prefix_length field to diff_options structure to
allow this logic subtract the display columns used for display the
history graph part from the total "terminal width"; this matters
when the "git log --graph -p" option is in use.

The field be set to the number of display columns needed to show the
output from the output_prefix() callback.  Any new output_prefix()
callback must also update the field accordingly, which is error
prone.  As there is only one user of the field, and the user has the
actual value of the prefix string, let's get rid of the field and
have the user count the display width itself.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 diff.c  | 2 +-
 diff.h  | 1 -
 graph.c | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index b43d3dd..ae069c3 100644
--- a/diff.c
+++ b/diff.c
@@ -1625,7 +1625,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 */
 
 	if (options->stat_width == -1)
-		width = term_columns() - options->output_prefix_length;
+		width = term_columns() - strlen(line_prefix);
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
diff --git a/diff.h b/diff.h
index 125447b..49e4aaa 100644
--- a/diff.h
+++ b/diff.h
@@ -174,7 +174,6 @@ struct diff_options {
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
 	diff_prefix_fn_t output_prefix;
-	int output_prefix_length;
 	void *output_prefix_data;
 
 	int diff_path_counter;
diff --git a/graph.c b/graph.c
index dd17201..a468038 100644
--- a/graph.c
+++ b/graph.c
@@ -197,7 +197,6 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 	assert(opt);
 	assert(graph);
 
-	opt->output_prefix_length = graph->width;
 	strbuf_reset(&msgbuf);
 	graph_padding_line(graph, &msgbuf);
 	return &msgbuf;
@@ -245,7 +244,6 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 */
 	opt->diffopt.output_prefix = diff_output_prefix_callback;
 	opt->diffopt.output_prefix_data = graph;
-	opt->diffopt.output_prefix_length = 0;
 
 	return graph;
 }








