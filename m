Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8A3207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 18:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934026AbcJLSUb (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 14:20:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58116 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933901AbcJLSU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 14:20:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0103D43289;
        Wed, 12 Oct 2016 14:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+2rTswZZ021WoIXL3guYedOtHE8=; b=siJ9Ch
        Isi69gYqHNrppSajoVJqKutpII5PYE0bLxSjY2lvfbznaPaNhQmcajPE0fQjpmra
        d8fBlhEqo10xcq9ZPjb1RgqVEzwSwVIpA22Gg4xdYCNvwLWqmmTWEpX5Db3dwHY1
        Ak36ydYBL6mS174yRWserlUWPnDqSjHWmxBes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZUnKC1KOPSS2Pu9a5XTCpZ7MAj+hMXmL
        pifq28kwR064AnTZ/us00T13DvA9sQgnDO0sbsIz4p/MD6WeL9E3zn4YhQlXvWDb
        xpAqdwjfgdt/TH94GQpMZSNtStzhROg/7bTTXFlWGHF5xl11CyEZKSq6gbFcJ1mh
        b9pQ5KUgOL8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBE2843288;
        Wed, 12 Oct 2016 14:20:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3122543287;
        Wed, 12 Oct 2016 14:20:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re* [PATCH v3 05/25] sequencer: eventually release memory allocated for the option values
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <a67af02ef363311b526bddba864c7f1ca9087b43.1476120229.git.johannes.schindelin@gmx.de>
        <xmqqzimbc0gw.fsf@gitster.mtv.corp.google.com>
        <xmqq4m4ic0gw.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610121405410.3492@virtualbox>
Date:   Wed, 12 Oct 2016 11:20:23 -0700
In-Reply-To: <alpine.DEB.2.20.1610121405410.3492@virtualbox> (Johannes
        Schindelin's message of "Wed, 12 Oct 2016 14:06:09 +0200 (CEST)")
Message-ID: <xmqqk2dd4efs.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B963BE0-90A8-11E6-B093-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 11 Oct 2016, Junio C Hamano wrote:
>
>> The only reason why the OPT_STRDUP appeared convenient was because
>> options[] element happened to use a field in the structure directly.
>> The patch under discussion does an equivalent of
>> 
>>     app.x_field = xstrdup_or_null(opt_x);
>
> Oh, that xstrdup_or_null() function slipped by me. My local patches use it
> now.

It has slipped many people ;-)

-- >8 --
Subject: cocci: refactor common patterns to use xstrdup_or_null()

d64ea0f83b ("git-compat-util: add xstrdup_or_null helper",
2015-01-12) added a handy wrapper that allows us to get a duplicate
of a string or NULL if the original is NULL, but a handful of
codepath predate its introduction or just weren't aware of it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/xstrdup_or_null.cocci | 7 +++++++
 git.c                                    | 3 +--
 imap-send.c                              | 6 ++----
 mailmap.c                                | 6 ++----
 refs.c                                   | 3 +--
 send-pack.c                              | 3 +--
 trailer.c                                | 9 +++------
 7 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/contrib/coccinelle/xstrdup_or_null.cocci b/contrib/coccinelle/xstrdup_or_null.cocci
new file mode 100644
index 0000000000..3fceef132b
--- /dev/null
+++ b/contrib/coccinelle/xstrdup_or_null.cocci
@@ -0,0 +1,7 @@
+@@
+expression E;
+expression V;
+@@
+- if (E)
+-    V = xstrdup(E);
++ V = xstrdup_or_null(E);
diff --git a/git.c b/git.c
index 0f1937fd0c..f914490e14 100644
--- a/git.c
+++ b/git.c
@@ -35,8 +35,7 @@ static void save_env_before_alias(void)
 	orig_cwd = xgetcwd();
 	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
 		orig_env[i] = getenv(env_names[i]);
-		if (orig_env[i])
-			orig_env[i] = xstrdup(orig_env[i]);
+		orig_env[i] = xstrdup_or_null(orig_env[i]);
 	}
 }
 
diff --git a/imap-send.c b/imap-send.c
index 0f5f4760e9..9514ddc565 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1082,10 +1082,8 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 			cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
 			cred.host = xstrdup(srvc->host);
 
-			if (srvc->user)
-				cred.username = xstrdup(srvc->user);
-			if (srvc->pass)
-				cred.password = xstrdup(srvc->pass);
+			cred.username = xstrdup_or_null(srvc->user);
+			cred.password = xstrdup_or_null(srvc->pass);
 
 			credential_fill(&cred);
 
diff --git a/mailmap.c b/mailmap.c
index b5c521fdea..c1a79c100c 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -103,10 +103,8 @@ static void add_mapping(struct string_list *map,
 	} else {
 		struct mailmap_info *mi = xcalloc(1, sizeof(struct mailmap_info));
 		debug_mm("mailmap: adding (complex) entry for '%s'\n", old_email);
-		if (new_name)
-			mi->name = xstrdup(new_name);
-		if (new_email)
-			mi->email = xstrdup(new_email);
+		mi->name = xstrdup_or_null(new_name);
+		mi->email = xstrdup_or_null(new_email);
 		string_list_insert(&me->namemap, old_name)->util = mi;
 	}
 
diff --git a/refs.c b/refs.c
index b4e7cac7b2..62055ab091 100644
--- a/refs.c
+++ b/refs.c
@@ -791,8 +791,7 @@ struct ref_update *ref_transaction_add_update(
 		hashcpy(update->new_sha1, new_sha1);
 	if (flags & REF_HAVE_OLD)
 		hashcpy(update->old_sha1, old_sha1);
-	if (msg)
-		update->msg = xstrdup(msg);
+	update->msg = xstrdup_or_null(msg);
 	return update;
 }
 
diff --git a/send-pack.c b/send-pack.c
index 90f2ac51a7..6195b43e9a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -181,8 +181,7 @@ static int receive_status(int in, struct ref *refs)
 			hint->status = REF_STATUS_REMOTE_REJECT;
 			ret = -1;
 		}
-		if (msg)
-			hint->remote_status = xstrdup(msg);
+		hint->remote_status = xstrdup_or_null(msg);
 		/* start our next search from the next ref */
 		hint = hint->next;
 	}
diff --git a/trailer.c b/trailer.c
index c6ea9ac64d..aecaf9232a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -428,12 +428,9 @@ static int set_if_missing(struct conf_info *item, const char *value)
 static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
 {
 	*dst = *src;
-	if (src->name)
-		dst->name = xstrdup(src->name);
-	if (src->key)
-		dst->key = xstrdup(src->key);
-	if (src->command)
-		dst->command = xstrdup(src->command);
+	dst->name = xstrdup_or_null(src->name);
+	dst->key = xstrdup_or_null(src->key);
+	dst->command = xstrdup_or_null(src->command);
 }
 
 static struct trailer_item *get_conf_item(const char *name)
