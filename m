Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9995E1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbdJYExc (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:53:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53257 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750921AbdJYExb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:53:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D8A8AD905;
        Wed, 25 Oct 2017 00:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jL/mibfChOZgIYgHBfPTJFMY03g=; b=D4NQB0
        F4ea9QRWfOCB076Hhqix+++CevCaO8OfNSxMag/4BoVoGi7sjIfiHZZk+4btosPM
        FaTKWAzWT6I9323Z4WOH0IvKaQ/pib+nFGNP4yrb3ufQT0rppKPreIjAxdDvxAKm
        +0UA0KfQc6LXQepKFE3U4AFiLfzhm1NL/72p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T9+QAp9TZZ/0Il9uBzsuwhSQIc+x1AVy
        zi563S4tHBlVCf8BzUzXR1HVLemJkwdxf82mRuXfI9xOww4tltxgMqwOTaBXLb4a
        Of+YQEYDCcVTzv9zS31PUJvFxfu2i5gcDKqihmSEYqVIW7kIyPu8nbQTCpgz7HJ0
        hz7cP9WlABY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4634FAD904;
        Wed, 25 Oct 2017 00:53:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA822AD903;
        Wed, 25 Oct 2017 00:53:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Consequences of CRLF in index?
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
        <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
        <xmqq4lqoj8pe.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 25 Oct 2017 13:53:28 +0900
In-Reply-To: <xmqq4lqoj8pe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 25 Oct 2017 10:51:41 +0900")
Message-ID: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71E26A0E-B940-11E7-B816-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I'd be interested to hear what happens when diff-ing across a line
>> ending fixup commit.  Is this an area where Git needs some
>> improvement?  "git merge" knows an -Xrenormalize option to deal with a
>> related problem --- it's possible that "git diff" needs to learn a
>> similar trick.
>
> My knee-jerk reaction is that (1) the end user definitely wants to
> see preimage and postimage lines are different in such a commit by
> default, one side has and the other side lacks ^M at the end., and
> (2) one of the "whitespace ignoring" options (namely, "ignore space
> at eol") may suffice, but if not, it should be easy to invent a new
> one "ignore CR at eol".

Here is a lunch-time hack to add that option.  As you can see from
the lack of docs, tests and a proper log message, I haven't played
with it long enough to know how buggy it is, though.  I am not all
that interested in polishing it to completion myself and prefer to
leave it as #leftoverbits ;-)

Also I didn't bother teaching this to Stefan's color-moved thing, as
the line comparator it uses will hopefully be unified with the one I
am touching in xdiff/ with this patch.

Have fun.

 diff.c            |  5 ++++-
 merge-recursive.c |  2 ++
 xdiff/xdiff.h     |  3 ++-
 xdiff/xutils.c    | 34 ++++++++++++++++++++++++++++++++--
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 6fd288420b..eeca0fd3b8 100644
--- a/diff.c
+++ b/diff.c
@@ -4202,7 +4202,8 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
 	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
-	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
+	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL) ||
+	    DIFF_XDL_TST(options, IGNORE_CR_AT_EOL))
 		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
@@ -4659,6 +4660,8 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
+	else if (!strcmp(arg, "--ignore-cr-at-eol"))
+		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
 	else if (!strcmp(arg, "--indent-heuristic"))
diff --git a/merge-recursive.c b/merge-recursive.c
index 1d3f8f0d22..4a49ec93b1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2251,6 +2251,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		DIFF_XDL_SET(o, IGNORE_WHITESPACE);
 	else if (!strcmp(s, "ignore-space-at-eol"))
 		DIFF_XDL_SET(o, IGNORE_WHITESPACE_AT_EOL);
+	else if (!strcmp(s, "ignore-cr-at-eol"))
+		DIFF_XDL_SET(o, IGNORE_CR_AT_EOL);
 	else if (!strcmp(s, "renormalize"))
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index b090ad8eac..ff16243da9 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -32,7 +32,8 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
-#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
+#define XDF_IGNORE_CR_AT_EOL (1 << 5)
+#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL | XDF_IGNORE_CR_AT_EOL)
 
 #define XDF_PATIENCE_DIFF (1 << 5)
 #define XDF_HISTOGRAM_DIFF (1 << 6)
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04d7b32e4e..8720e272b9 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -156,6 +156,21 @@ int xdl_blankline(const char *line, long size, long flags)
 	return (i == size);
 }
 
+/*
+ * Have we eaten everything on the line, except for an optional
+ * CR at the very end?
+ */
+static int ends_with_optional_cr(const char *l, long s, long i)
+{
+	if (s && l[s-1] == '\n')
+		s--;
+	if (s == i)
+		return 1;
+	if (s == i + 1 && l[i] == '\r')
+		return 1;
+	return 0;
+}
+
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
 	int i1, i2;
@@ -170,7 +185,8 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 
 	/*
 	 * -w matches everything that matches with -b, and -b in turn
-	 * matches everything that matches with --ignore-space-at-eol.
+	 * matches everything that matches with --ignore-space-at-eol,
+	 * which in turn matches everything that matches with --ignore-cr-at-eol.
 	 *
 	 * Each flavor of ignoring needs different logic to skip whitespaces
 	 * while we have both sides to compare.
@@ -204,6 +220,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 			i1++;
 			i2++;
 		}
+	} else if (flags & XDF_IGNORE_CR_AT_EOL) {
+		/* Find the first difference and see how the line ends */
+		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
+			i1++;
+			i2++;
+		}
+		return (ends_with_optional_cr(l1, s1, i1) &&
+			ends_with_optional_cr(l2, s2, i2));
 	}
 
 	/*
@@ -230,9 +254,15 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 		char const *top, long flags) {
 	unsigned long ha = 5381;
 	char const *ptr = *data;
+	int cr_at_eol_only = (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL;
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
-		if (XDL_ISSPACE(*ptr)) {
+		if (cr_at_eol_only) {
+			if (*ptr == '\r' &&
+			    (top <= ptr + 1 || ptr[1] == '\n'))
+				continue;
+		}
+		else if (XDL_ISSPACE(*ptr)) {
 			const char *ptr2 = ptr;
 			int at_eol;
 			while (ptr + 1 < top && XDL_ISSPACE(ptr[1])


