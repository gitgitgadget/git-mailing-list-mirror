From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test-parse-options: --expect=<string> option to simplify tests
Date: Thu, 05 May 2016 19:57:26 -0700
Message-ID: <xmqqeg9f7v1l.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<20160505215056.28224-1-gitster@pobox.com>
	<20160505215056.28224-4-gitster@pobox.com>
	<CAGZ79kY+9BUjcbpSA8sAqd=qZ5niZ2CDsPeGuXhK+yqZY4hL9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 04:57:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayVxP-0008GZ-E8
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 04:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbcEFC5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 22:57:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755385AbcEFC5a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 22:57:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CA821A7D5;
	Thu,  5 May 2016 22:57:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oh5XmZHonG8sgvUISM6UbkxyPLk=; b=XUbJRe
	VQI5gmAW4pdQNf5pQNmNxFUEQ9XijzMIyIrbgGijfcIzpIpUWFNlRnadgg+77DcB
	omSztGCv9YVVXl5RK4f+jXAuTAgBS+WR1up/aRnDGEC5c8Ne8fEVIFg5GZPxUyub
	u3eWqsrj/KdZT1expx8m2mPxbYHimdZGY3mAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p47iloS1pmr+xsGxD2PtxHj5KbbpCMFD
	mHxvXFc7LfCgk9HtjHZeK+MUC8OvusMk24H5xKkN3sI5/BBF53C5LyWyERmP8mTN
	mM6eequFyvwleGDD5UWoHXTXgW607D6FtEKnVN0vKb5RQmcpgSiD/3d+9K8EKqNR
	tDy2RKrIEAA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94AEA1A7D4;
	Thu,  5 May 2016 22:57:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0780E1A7D3;
	Thu,  5 May 2016 22:57:27 -0400 (EDT)
In-Reply-To: <CAGZ79kY+9BUjcbpSA8sAqd=qZ5niZ2CDsPeGuXhK+yqZY4hL9Q@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 17:41:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 448A3A34-1336-11E6-845C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293735>

Stefan Beller <sbeller@google.com> writes:

> instead of filtering afterwards, i.e. each strbuf_add is guarded by
> an
>
>      if (is_interesting_output(...))
>         strbuf_add(...)

That's a good approach.

The implementation gets a bit trickier than the previous one, but it
would look like this.  Discard 2/3 and 3/3 and replace them with
this one.

The external interface on the input side is no different, but on the
output side, this version has "expected '%s', got '%s'" error, in
the same spirit as the output from "test_cmp", added in.

Instead of checking the entire output line-by-line for each expected
output (in case you did not notice, you can give --expect='quiet: 3'
--expect='abbrev: 7' and both must match), this one will check each
output line against each expected pattern.  We wouldn't have too
many entries in the variable dump and we wouldn't be taking too many
--expect options, so the matching performance would not matter,
though.


 t/t0040-parse-options.sh |  1 +
 test-parse-options.c     | 88 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index dbaee55..d678fbf 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -45,6 +45,7 @@ Standard options
     -v, --verbose         be verbose
     -n, --dry-run         dry run
     -q, --quiet           be quiet
+    --expect <string>     expected output in the variable dump
 
 EOF
 
diff --git a/test-parse-options.c b/test-parse-options.c
index b5f4e90..e3f25df 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -39,6 +39,61 @@ static int number_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int collect_expect(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list *expect;
+	struct string_list_item *item;
+	struct strbuf label = STRBUF_INIT;
+	const char *colon;
+
+	if (!arg || unset)
+		die("malformed --expect option");
+
+	expect = (struct string_list *)opt->value;
+	colon = strchr(arg, ':');
+	if (!colon)
+		die("malformed --expect option, lacking a colon");
+	strbuf_add(&label, arg, colon - arg);
+	item = string_list_insert(expect, strbuf_detach(&label, NULL));
+	if (item->util)
+		die("malformed --expect option, duplicate %s", label.buf);
+	item->util = (void *)arg;
+	return 0;
+}
+
+__attribute__((format (printf,3,4)))
+static void show(struct string_list *expect, int *status, const char *fmt, ...)
+{
+	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
+	va_list args;
+
+	va_start(args, fmt);
+	strbuf_vaddf(&buf, fmt, args);
+	va_end(args);
+
+	if (!expect->nr)
+		printf("%s\n", buf.buf);
+	else {
+		char *colon = strchr(buf.buf, ':');
+		if (!colon)
+			die("malformed output format, output lacking colon: %s", fmt);
+		*colon = '\0';
+		item = string_list_lookup(expect, buf.buf);
+		*colon = ':';
+		if (!item)
+			; /* not among entries being checked */
+		else {
+			if (strcmp((const char *)item->util, buf.buf)) {
+				printf("expected '%s', got '%s'\n",
+				       (char *)item->util, buf.buf);
+				*status = 1;
+			}
+		}
+	}
+	strbuf_reset(&buf);
+}
+
 int main(int argc, char **argv)
 {
 	const char *prefix = "prefix/";
@@ -46,6 +101,7 @@ int main(int argc, char **argv)
 		"test-parse-options <options>",
 		NULL
 	};
+	struct string_list expect = STRING_LIST_INIT_NODUP;
 	struct option options[] = {
 		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
 		OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
@@ -86,34 +142,38 @@ int main(int argc, char **argv)
 		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT__DRY_RUN(&dry_run, "dry run"),
 		OPT__QUIET(&quiet, "be quiet"),
+		OPT_CALLBACK(0, "expect", &expect, "string",
+			     "expected output in the variable dump",
+			     collect_expect),
 		OPT_END(),
 	};
 	int i;
+	int ret = 0;
 
 	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
 
 	if (length_cb.called) {
 		const char *arg = length_cb.arg;
 		int unset = length_cb.unset;
-		printf("Callback: \"%s\", %d\n",
-		       (arg ? arg : "not set"), unset);
+		show(&expect, &ret, "Callback: \"%s\", %d",
+		     (arg ? arg : "not set"), unset);
 	}
-	printf("boolean: %d\n", boolean);
-	printf("integer: %d\n", integer);
-	printf("magnitude: %lu\n", magnitude);
-	printf("timestamp: %lu\n", timestamp);
-	printf("string: %s\n", string ? string : "(not set)");
-	printf("abbrev: %d\n", abbrev);
-	printf("verbose: %d\n", verbose);
-	printf("quiet: %d\n", quiet);
-	printf("dry run: %s\n", dry_run ? "yes" : "no");
-	printf("file: %s\n", file ? file : "(not set)");
+	show(&expect, &ret, "boolean: %d", boolean);
+	show(&expect, &ret, "integer: %d", integer);
+	show(&expect, &ret, "magnitude: %lu", magnitude);
+	show(&expect, &ret, "timestamp: %lu", timestamp);
+	show(&expect, &ret, "string: %s", string ? string : "(not set)");
+	show(&expect, &ret, "abbrev: %d", abbrev);
+	show(&expect, &ret, "verbose: %d", verbose);
+	show(&expect, &ret, "quiet: %d", quiet);
+	show(&expect, &ret, "dry run: %s", dry_run ? "yes" : "no");
+	show(&expect, &ret, "file: %s", file ? file : "(not set)");
 
 	for (i = 0; i < list.nr; i++)
-		printf("list: %s\n", list.items[i].string);
+		show(&expect, &ret, "list: %s", list.items[i].string);
 
 	for (i = 0; i < argc; i++)
-		printf("arg %02d: %s\n", i, argv[i]);
+		show(&expect, &ret, "arg %02d: %s", i, argv[i]);
 
 	return 0;
 }
