Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0F5C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 22:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243458AbiEYWeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 18:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245548AbiEYWeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 18:34:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653E1FD3E
        for <git@vger.kernel.org>; Wed, 25 May 2022 15:34:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0E511971E3;
        Wed, 25 May 2022 18:34:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9ZgaxO1VAaB8XIIa2oUlLAib1jG5wKb+Zt/E8+
        4IBGc=; b=d/qLP6EgKfO5wExP4GInuDwzL6a22eQkZfGgc0ekSBb/Hu3iZEIHiT
        uVTvhl4gcgQcLbu/lx7sbOUNESXeEqv+5bxPZ/4JYAg8lDguSmSEphm5O1YlOaZl
        ge2y9jVyMXcIfNZxgu3oYxlkrJ2bLtdoS/I8jyptZhyiJus2dt91Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8C5E1971E2;
        Wed, 25 May 2022 18:34:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 781531971E1;
        Wed, 25 May 2022 18:34:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 2/7] archive --add-virtual-file: allow paths
 containing colons
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <7eebcf27b45eb13541d4abae70a374a0e35ab6b8.1653145696.git.gitgitgadget@gmail.com>
        <xmqq5ylt7473.fsf@gitster.g> <xmqq4k1d5lwj.fsf@gitster.g>
Date:   Wed, 25 May 2022 15:34:05 -0700
In-Reply-To: <xmqq4k1d5lwj.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        25 May 2022 14:42:52 -0700")
Message-ID: <xmqqpmk144yq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C96C9ED6-DC7A-11EC-B3FC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> 	# The PATHNAME variable holds a filename encoded like a
>> 	# string constant in C language (e.g. "\060" is digit "0")
>> 	if test_have_prereq FUNNYNAMES
>> 	then
>> 		PATHNAME=quoted:colon:\\060zero
>> 	...
> Actually, I _think_ that pushes us beyond the "reasonably defensive
> for the current need".  We'd need to prepare how the pathname is
> expected to be unquoted for the later test
>
> 	test_path_is_file "$PATHNAME"
>
> to work.

IOW, I would need to add a new test-tool (attached) and then start
this test like so:

	if ...
	then
		PATHNAME=quoted:colon:\\060zero
	else
		PATHNAME=quoted\\060zero
	fi
	UQPATHNAME=$(test-tool unquote-c-style \""$PATHNAME"\")

and change the last test to

	test_path_is_file "$UQPATHNAME"

if we really wanted to test that the the PATHNAME is treated as a
c-style quoted string.

I am on the fence.  We do not have an immediate need, in the sense
that nobody needs to encode "0" as "\060" and trigger the unquote
codepath in real life.  But it does feel prudent to make sure we can
grok C-quoted pathname as we claim in the documentation.

And the resulting change to the test does not look _too_ bad (and
the new test-tool certainly does not hurt, either).

So...


 Makefile               |  1 +
 t/helper/test-quoted.c | 34 ++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c   |  2 ++
 t/helper/test-tool.h   |  2 ++
 4 files changed, 39 insertions(+)

diff --git c/Makefile w/Makefile
index 298becd5a5..1d544ad46a 100644
--- c/Makefile
+++ w/Makefile
@@ -749,6 +749,7 @@ TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
 TEST_BUILTINS_OBJS += test-progress.o
+TEST_BUILTINS_OBJS += test-quoted.o
 TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-graph.o
diff --git c/t/helper/test-quoted.c w/t/helper/test-quoted.c
new file mode 100644
index 0000000000..15baa55e43
--- /dev/null
+++ w/t/helper/test-quoted.c
@@ -0,0 +1,34 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "quote.h"
+
+int cmd__unquote_c_style(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	while (*++argv) {
+		const char *p = *argv;
+
+		if (unquote_c_style(&buf, p, &p) < 0)
+			error("cannot unquote '%s'", *argv);
+		else
+			printf("%s\n", buf.buf);
+		strbuf_reset(&buf);
+	}
+	return 0;
+}
+
+int cmd__quote_c_style(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	while (*++argv) {
+		const char *p = *argv;
+
+		quote_c_style(p, &buf, NULL, 0);
+		printf("%s\n", buf.buf);
+		strbuf_reset(&buf);
+	}
+	return 0;
+}
+
diff --git c/t/helper/test-tool.c w/t/helper/test-tool.c
index d2eacd302d..5633c98569 100644
--- c/t/helper/test-tool.c
+++ w/t/helper/test-tool.c
@@ -58,6 +58,7 @@ static struct test_cmd cmds[] = {
 	{ "prio-queue", cmd__prio_queue },
 	{ "proc-receive", cmd__proc_receive },
 	{ "progress", cmd__progress },
+	{ "quote-c-style", cmd__quote_c_style },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
 	{ "read-graph", cmd__read_graph },
@@ -81,6 +82,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
 	{ "trace2", cmd__trace2 },
+	{ "unquote-c-style", cmd__unquote_c_style },
 	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "xml-encode", cmd__xml_encode },
diff --git c/t/helper/test-tool.h w/t/helper/test-tool.h
index 960cc27ef7..f5e8929009 100644
--- c/t/helper/test-tool.h
+++ w/t/helper/test-tool.h
@@ -48,6 +48,7 @@ int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
+int cmd__quote_c_style(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
@@ -71,6 +72,7 @@ int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
+int cmd__unquote_c_style(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
