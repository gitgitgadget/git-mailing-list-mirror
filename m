Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A721F404
	for <e@80x24.org>; Tue, 30 Jan 2018 01:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeA3BiE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 20:38:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:33574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752419AbeA3BiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 20:38:02 -0500
Received: (qmail 13751 invoked by uid 109); 30 Jan 2018 01:38:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Jan 2018 01:38:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10124 invoked by uid 111); 30 Jan 2018 01:38:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Jan 2018 20:38:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Jan 2018 20:38:00 -0500
Date:   Mon, 29 Jan 2018 20:38:00 -0500
From:   Jeff King <peff@peff.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] setup: recognise extensions.objectFormat
Message-ID: <20180130013759.GA27694@sigill.intra.peff.net>
References: <cover.1517098675.git.patryk.obara@gmail.com>
 <e430ad029facdd6209927d352f0e7545cdd0e435.1517098675.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e430ad029facdd6209927d352f0e7545cdd0e435.1517098675.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 01:36:17AM +0100, Patryk Obara wrote:

> This extension selects which hashing algorithm from vtable should be
> used for reading and writing objects in the object store.  At the moment
> supports only single value (sha-1).
> 
> In case value of objectFormat is an unknown hashing algorithm, Git
> command will fail with following message:
> 
>   fatal: unknown repository extensions found:
> 	  objectformat = <value>
> 
> To indicate, that this specific objectFormat value is not recognised.

I don't have a strong opinion on this, but it does feel a little funny
to add this extension now, before we quite know what the code that uses
it is going to look like (or maybe we're farther along there than I
realize).

What do we gain by doing this now as opposed to later? By the design of
the extension code, we should complain on older versions anyway. And by
doing it now we carry a small risk that it might not give us the
interface we want, and it will be slightly harder to paper over this
failed direction.

All that said, if people like brian, who are thinking more about this
transition than I am, are onboard, I'm OK with it.

> The objectFormat extension is not allowed in repository marked as
> version 0 to prevent any possibility of accidentally writing a NewHash
> object in the sha-1 object store. This extension behaviour is different
> than preciousObjects extension (which is allowed in repo version 0).

It wasn't intended that anyone would specify preciousObjects with repo
version 0. It's a dangerous misconfiguration (because versions which
predate the extensions mechanism won't actually respect it at all!).

So we probably ought to complain loudly on having anything in
extensions.* when the repositoryformat is less than 1.

I originally wrote it the other way out of an abundance of
backward-compatibility. After all "extension.*" doesn't mean anything in
format 0, and somebody _could_ have added such a config key for their
own purposes. But that's a pretty weak argument, and if we are going to
start marking some extensions as forbidden there, we might as well do
them all.

Something like this:

diff --git a/cache.h b/cache.h
index d8b975a571..259c4a5361 100644
--- a/cache.h
+++ b/cache.h
@@ -921,6 +921,7 @@ struct repository_format {
 	int is_bare;
 	int hash_algo;
 	char *work_tree;
+	int extensions_seen;
 	struct string_list unknown_extensions;
 };
 
diff --git a/setup.c b/setup.c
index 8cc34186ce..85dfcf330b 100644
--- a/setup.c
+++ b/setup.c
@@ -413,6 +413,7 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
+		data->extensions_seen = 1;
 		/*
 		 * record any known extensions here; otherwise,
 		 * we fall through to recording it as unknown, and
@@ -503,6 +504,11 @@ int verify_repository_format(const struct repository_format *format,
 		return -1;
 	}
 
+	if (format->version < 1 && format->extensions_seen) {
+		strbuf_addstr(err, _("extensions found but repo version is < 1"));
+		return -1;
+	}
+
 	if (format->version >= 1 && format->unknown_extensions.nr) {
 		int i;
 
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index ce4cff13bb..9e9f67d756 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -80,9 +80,10 @@ while read outcome version extensions; do
 done <<\EOF
 allow 0
 allow 1
+abort 0 noop
 allow 1 noop
+abort 0 no-such-extension
 abort 1 no-such-extension
-allow 0 no-such-extension
 EOF
 
 test_expect_success 'precious-objects allowed' '
