From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/3] diff: introduce --stat-lines to limit the stat
 lines
Date: Fri, 27 May 2011 21:46:41 -0700
Message-ID: <7v39jzqvny.fsf@alter.siamese.dyndns.org>
References: <4DC0FD3D.9010004@drmicha.warpmail.net>
 <cover.1306499600.git.git@drmicha.warpmail.net>
 <5da631c64438ec3f669f0c2b7456bcfbc371e2f5.1306499600.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 28 06:54:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQBXF-0001rM-NV
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 06:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799Ab1E1Equ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 00:46:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab1E1Eqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 00:46:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 788AA578A;
	Sat, 28 May 2011 00:48:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hFqEEOF8bvMvmfE3UC7qTdKhuU4=; b=p0LPsl
	/e4LQhLlqgMzVA/psevvOlHWGdGiwCEXhBvNMPXcrslWCTFsbDw7SNCkSPQbp3I9
	calV6M1ougRcMOFnMQ0GMSMSAaYgG6wa4EAm9gQRvCwqMDh9/FUkmszIwZlnbBNN
	XJAeZQ1GgLwvcoubQLtMh0Jzh8O+oB4ffsHa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MyHspQNJ3fHQNZIbJYNWGMgngoEbXH6A
	yihhXyAHjXuBSxIz/Huxwq+NPCdksjtEyNcJfXxlP/zTIVOb/AH4Ului0Mcu+cTc
	/UVPLm/fHUHuj8QkIg8XsfUF3FGDCg7aZne/BivJq2oYQdNij14lSJqvyHZOOwVf
	KVqMqqhknj4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 555615788;
	Sat, 28 May 2011 00:48:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 157315787; Sat, 28 May 2011
 00:48:50 -0400 (EDT)
In-Reply-To: <5da631c64438ec3f669f0c2b7456bcfbc371e2f5.1306499600.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 27 May 2011 14:36:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA3592AE-88E5-11E0-BB90-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174656>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/diff.c b/diff.c
> index 4541939..6a6cbca 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1259,6 +1259,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  
>  	width = options->stat_width ? options->stat_width : 80;
>  	name_width = options->stat_name_width ? options->stat_name_width : 50;
> +	count = options->stat_count ? options->stat_count : data->nr;

It is a tad hard to follow the logic of "count" here. It could be the
ceiling the user gave you, or we may not be constrained at all if the full
diff is smaller.  But then

> @@ -1275,11 +1276,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
>  	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
>  
> -	for (i = 0; i < data->nr; i++) {
> +	for (i = 0; (i < count) && (i < data->nr); i++) {

Here we compare "i" which does not have much to do with how many we
actually have to show (as we may be skipping in the loop) with "count" and
also with data->nr.  In the loop, you compensate for the skipping
(i.e. increment of "i" that should not affect the outcome) by incrementing
"count", so (i < count) part will correctly count towards the limit the
user gave. It may be a correct math, but it is tricky and hard to read.
Especially if we started with the options->stat_count that is larger than
the data->nr, of course "i < count" will always hold true with or without
skipping, which also is correct but even trickier.

>  		struct diffstat_file *file = data->files[i];
>  		uintmax_t change = file->added + file->deleted;
>  		if (!data->files[i]->is_renamed &&
>  			 (change == 0)) {
> +			count++; /* not shown == room for one more */
>  			continue;
>  		}
>  		fill_print_name(file);
> @@ -1292,6 +1294,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		if (max_change < change)
>  			max_change = change;
>  	}
> +	count = i; /* min(count, data->nr) */

This value is mechanically min(count, data->nr) but it is confusing to
explain what it really means.  It is the number of elements you have to
look at in data->files[] array, still skipping irrelevant entries in the
loop, until you show options->stat_count number of entries.

> @@ -1306,7 +1309,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	else
>  		width = max_change;
>  
> -	for (i = 0; i < data->nr; i++) {
> +	for (i = 0; i < count; i++) {

Hence this loop is correct. You ignore everything beyond count in the
array, as their lengths are immaterial to the outcome.

> @@ -1373,6 +1376,19 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		show_graph(options->file, '-', del, del_c, reset);
>  		fprintf(options->file, "\n");
>  	}
> +	if (count < data->nr)
> +		fprintf(options->file, "%s ...\n", line_prefix);

At this point, count is the sum of the number of items you are going to
show and the number of items you are going to skip. If that is smaller
than the total in the original array, there are items that you are not
showing nor skipping. But you terminated the first loop early before
reaching the end of data->file[] array, so you do not know enough to say
"there _are_ more to show but I am not showing", I think.

If

 - data->nr is 3;
 - the data->file[0] is to be shown but other entries in data->file[] are
   not to be shown; and
 - opt->stat_count is 1

then your first loop fills data->file[0]->name, increments i to 1, the
condition (i < count) no longer holds, and stops.  At this point count is
1, data->nr is 3, but data->file[1] and [2] are not to be shown anyway, so
this "there are more but I am not showing them" is not quite right, is it?

> +	for (i = count; i < data->nr; i++) {
> +		uintmax_t added = data->files[i]->added;
> +		uintmax_t deleted = data->files[i]->deleted;
> +		if (!data->files[i]->is_renamed &&
> +			 (added + deleted == 0)) {
> +			total_files--;
> +			continue;
> +		}
> +		adds += added;
> +		dels += deleted;
> +	}

If this loop runs "adds += added" even once, then you have "there are more
but I am not showing" situation, and if all the entries beyond count are
skipped, then you are not limiting the output.

By the way, in this round, you are trying to show only the first N items,
and if there are more to show, then showing "..." after them. I kind of
liked the idea that came up during the discussion in earlier rounds to
show N-1 then "..."  then the last one item, but I do not feel too
strongly about it.

 diff.c                     |    6 ++++--
 t/t4049-diff-stat-count.sh |   25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 82789e3..542ff42 100644
--- a/diff.c
+++ b/diff.c
@@ -1247,6 +1247,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int width, name_width, count;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix = "";
+	int extra_shown = 0;
 	struct strbuf *msg = NULL;
 
 	if (data->nr == 0)
@@ -1376,8 +1377,6 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(options->file, '-', del, del_c, reset);
 		fprintf(options->file, "\n");
 	}
-	if (count < data->nr)
-		fprintf(options->file, "%s ...\n", line_prefix);
 	for (i = count; i < data->nr; i++) {
 		uintmax_t added = data->files[i]->added;
 		uintmax_t deleted = data->files[i]->deleted;
@@ -1388,6 +1387,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 		adds += added;
 		dels += deleted;
+		if (!extra_shown)
+			fprintf(options->file, "%s ...\n", line_prefix);
+		extra_shown = 1;
 	}
 	fprintf(options->file, "%s", line_prefix);
 	fprintf(options->file,
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
new file mode 100755
index 0000000..641e70d
--- /dev/null
+++ b/t/t4049-diff-stat-count.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# Copyright (c) 2011, Google Inc.
+
+test_description='diff --stat-count'
+. ./test-lib.sh
+
+test_expect_success setup '
+	>a &&
+	>b &&
+	>c &&
+	>d &&
+	git add a b c d &&
+	chmod +x c d &&
+	echo a >a &&
+	echo b >b &&
+	cat >expect <<-\EOF
+	 a |    1 +
+	 b |    1 +
+	 2 files changed, 2 insertions(+), 0 deletions(-)
+	EOF
+	git diff --stat --stat-count=2 >actual &&
+	test_cmp expect actual
+'
+
+test_done
