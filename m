Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FDF11F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 22:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbcH3Wfn (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 18:35:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50224 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751593AbcH3Wfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 18:35:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C921E3ADFD;
        Tue, 30 Aug 2016 18:35:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oz8aswxiXs97SKJkpp7HeOg5Bfw=; b=UR7k2u
        EcAt3nxHI0ezyN0hRe8MyXCaVeubV5WEZjjB6ZK1oMxotgNO+PpzaUT8IEMkas6B
        e2VcjklHgFROTbUj0yFcu5BfjKCK7YY0tj/vzHx4mu2QAkkuZaXUT+/ouLA2/V4o
        MB/42sKngKYngpXwY3KGIv1OxdZe+bML2GpX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ybjlekazCRNLZkG3vPa6QarfhsgaM72Q
        SRD36OoQJ+obRUal/q/QpDcS5m9fbGgXL6Qo89SEFw4ZJefHwimhcgU87J0Bz7Wc
        KrolNaBbLxwtNccCogJ9bIJQ6L0iaqatUJV33pKIPnrmphf5tCqlyLRLHolRUfZ2
        Bw0hdg2Bw58=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1F583ADFC;
        Tue, 30 Aug 2016 18:35:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BE003ADFB;
        Tue, 30 Aug 2016 18:35:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/22] sequencer: prepare for rebase -i's commit functionality
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <1d83fa095c03eac9abfd1038ff7791bae8ace984.1472457609.git.johannes.schindelin@gmx.de>
        <xmqq8tvf8dmz.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608300836030.129229@virtualbox>
        <xmqqfupm5fix.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 30 Aug 2016 15:35:38 -0700
In-Reply-To: <xmqqfupm5fix.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 30 Aug 2016 10:32:22 -0700")
Message-ID: <xmqqinuh3mx1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1456F154-6F02-11E6-ACED-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Two functions with the same name reading from the same format, even
> when they expect to produce the same result in different internal
> format, without even being aware of each other is a bad enough
> "regression" in maintainability of the code.  One of them not even
> using sq_dequote() helper and reinventing is even worse.

So, here is what I did as a lunch-break-hack.  The "same result in
different internal format" calls for a fairly light-weight mechanism
to convey the necessary information that can be shared by callers
with different needs, and I chose string-list for that.

Totally untested, but parse_key_value_squoted() would be a good
foundation to build on.  The caller in "am" deliberately wants to be
strict (e.g. it wants to error out when the user mucked with the
file, so it insists on the three variables to appear in a known
order and rejects input that violates its assumption), but the
function does not mind if other callers want to be more lenient.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 30 Aug 2016 12:36:42 -0700
Subject: [PATCH] am: refactor read_author_script()

By splitting the part that reads from a file and the part that
parses the variable definitions from the contents, make the latter
can be more reusable in the future.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 103 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 45 insertions(+), 58 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 739b34d..b36d1f0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
+#include "string-list.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -258,38 +259,29 @@ static int read_state_file(struct strbuf *sb, const struct am_state *state,
 }
 
 /**
- * Reads a KEY=VALUE shell variable assignment from `fp`, returning the VALUE
- * as a newly-allocated string. VALUE must be a quoted string, and the KEY must
- * match `key`. Returns NULL on failure.
- *
- * This is used by read_author_script() to read the GIT_AUTHOR_* variables from
- * the author-script.
+ * Take a series of KEY='VALUE' lines where VALUE part is
+ * sq-quoted, and append <KEY, VALUE> at the end of the string list
  */
-static char *read_shell_var(FILE *fp, const char *key)
+static int parse_key_value_squoted(char *buf, struct string_list *list)
 {
-	struct strbuf sb = STRBUF_INIT;
-	const char *str;
-
-	if (strbuf_getline_lf(&sb, fp))
-		goto fail;
-
-	if (!skip_prefix(sb.buf, key, &str))
-		goto fail;
-
-	if (!skip_prefix(str, "=", &str))
-		goto fail;
-
-	strbuf_remove(&sb, 0, str - sb.buf);
-
-	str = sq_dequote(sb.buf);
-	if (!str)
-		goto fail;
-
-	return strbuf_detach(&sb, NULL);
-
-fail:
-	strbuf_release(&sb);
-	return NULL;
+	while (*buf) {
+		struct string_list_item *item;
+		char *np;
+		char *cp = strchr(buf, '=');
+		if (!cp)
+			return -1;
+		np = strchrnul(cp, '\n');
+		*cp++ = '\0';
+		item = string_list_append(list, buf);
+
+		buf = np + (*np == '\n');
+		*np = '\0';
+		cp = sq_dequote(cp);
+		if (!cp)
+			return -1;
+		item->util = xstrdup(cp);
+	}
+	return 0;
 }
 
 /**
@@ -311,44 +303,39 @@ static char *read_shell_var(FILE *fp, const char *key)
 static int read_author_script(struct am_state *state)
 {
 	const char *filename = am_path(state, "author-script");
-	FILE *fp;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list kv = STRING_LIST_INIT_DUP;
+	int retval = -1; /* assume failure */
+	int fd;
 
 	assert(!state->author_name);
 	assert(!state->author_email);
 	assert(!state->author_date);
 
-	fp = fopen(filename, "r");
-	if (!fp) {
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
 		if (errno == ENOENT)
 			return 0;
 		die_errno(_("could not open '%s' for reading"), filename);
 	}
+	strbuf_read(&buf, fd, 0);
+	close(fd);
+	if (parse_key_value_squoted(buf.buf, &kv))
+		goto finish;
 
-	state->author_name = read_shell_var(fp, "GIT_AUTHOR_NAME");
-	if (!state->author_name) {
-		fclose(fp);
-		return -1;
-	}
-
-	state->author_email = read_shell_var(fp, "GIT_AUTHOR_EMAIL");
-	if (!state->author_email) {
-		fclose(fp);
-		return -1;
-	}
-
-	state->author_date = read_shell_var(fp, "GIT_AUTHOR_DATE");
-	if (!state->author_date) {
-		fclose(fp);
-		return -1;
-	}
-
-	if (fgetc(fp) != EOF) {
-		fclose(fp);
-		return -1;
-	}
-
-	fclose(fp);
-	return 0;
+	if (kv.nr != 3 ||
+	    strcmp(kv.items[0].string, "GIT_AUTHOR_NAME") ||
+	    strcmp(kv.items[1].string, "GIT_AUTHOR_EMAIL") ||
+	    strcmp(kv.items[2].string, "GIT_AUTHOR_DATE"))
+		goto finish;
+	state->author_name = kv.items[0].util;
+	state->author_email = kv.items[1].util;
+	state->author_date = kv.items[2].util;
+	retval = 0;
+finish:
+	string_list_clear(&kv, !!retval);
+	strbuf_release(&buf);
+	return retval;
 }
 
 /**
-- 
2.10.0-rc2-246-g4fd2c60

