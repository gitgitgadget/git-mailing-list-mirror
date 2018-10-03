Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FE041F453
	for <e@80x24.org>; Wed,  3 Oct 2018 11:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJCSaw (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 14:30:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46198 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJCSaw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 14:30:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so4746941ljj.13
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 04:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=duA8inbtKpiUut2mS5fFv25FPf5QFd3r+yniNcHC7VI=;
        b=XjV9meUneauOrxN4c+MY5u/9QRf2Cz1KC9dzhkRplx55SiX/iuDPJran7bGoVls49e
         nI8MXgqW536dwxLqhOrvCbsayg9ofls6S7C9O3FuCdAh7dti5b0KnUhxCvCRX1e9Evc4
         YdHSv5qyEuHjtg9YhGEi/W1q1icV89ftmwKZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duA8inbtKpiUut2mS5fFv25FPf5QFd3r+yniNcHC7VI=;
        b=QQ8JKYf3XDI03QyxR7NQAp11f+JB7XuEYF4F+zgX8qaEVnszR4b9Li8xq78p46qRCy
         P8Llz8KgGBrzIXmElnRza01n75D4neqpoJxr5B5m7OoIUynL/Hl63RSZs/RaLHuPKTOC
         UqQKpDsV4dNVWLRCVyJqrTs24TOE90YZqCjW1VYC4Z1jdVGU7gIDCPu5j2NkjOROmHw2
         guKnQXJMweYvv7+RwN7ttyulEGcsyISBHNhIlbeMx4f4ylEgtHkLQEzzEZmnnPazaSSM
         hfZn008SYBqy6sxJUXMy/uCrZA9apQQ7sCNR/vm/QNdfzEfI+IslDcuxk54cqbX9GeoN
         7JUA==
X-Gm-Message-State: ABuFfognAksKHa9PkrV3Nzgy6y39MFsce9hxkV/3BOwihaDMch9r5a3o
        jGIuLXjv8TJDzFoxnXQeTf+zeB0CV7OpbKkH
X-Google-Smtp-Source: ACcGV62fq+NV95MeszdNgw1H8uDbJL8+r9iYuwtkqv33SYSzd991nFczJbciZDKnpkUtKx/81VhR0w==
X-Received: by 2002:a2e:1615:: with SMTP id w21-v6mr869172ljd.33.1538566967320;
        Wed, 03 Oct 2018 04:42:47 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f22-v6sm279500ljk.11.2018.10.03.04.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 04:42:46 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v3 1/3] help: redirect to aliased commands for "git cmd --help"
Date:   Wed,  3 Oct 2018 13:42:40 +0200
Message-Id: <20181003114242.9858-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
References: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181003114242.9858-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in the thread for v1 of this patch [1] [2], this changes the
rules for "git foo --help" when foo is an alias.

(0) When invoked as "git help foo", we continue to print the "foo is
aliased to bar" message and nothing else.

(1) If foo is an alias for a shell command, print "foo is aliased to
!bar" as usual.

(2) Otherwise, break the alias string into words, and pretend that "git
word0 --help" was called.

At least for me, getting the man page for git-cherry-pick directly with
"git cp --help" is more useful (and how I expect an alias to behave)
than the short "is aliased to" notice. It is also consistent with
"--help" generally providing more comprehensive help than "-h".

I believe that printing the "is aliased to" message also in case (2) has
value: Depending on pager setup, or if the user has help.format=web, the
message is still present immediately above the prompt when the user
quits the pager/returns to the terminal. That serves as an explanation
for why one was redirected to "man git-cherry-pick" from "git cp
--help", and if cp is actually 'cherry-pick -n', it reminds the user
that using cp has some flag implicitly set before firing off the next
command.

It also provides some useful info in case we end up erroring out, either
in the "bad alias string" check, or in the "No manual entry for gitbar"
case.

[1] https://public-inbox.org/git/20180926102636.30691-1-rv@rasmusvillemoes.dk/
[2] https://public-inbox.org/git/20180926184914.GC30680@sigill.intra.peff.net/

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/help.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 8d4f6dd301..e0e3fe62e9 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -415,9 +415,37 @@ static const char *check_git_cmd(const char* cmd)
 
 	alias = alias_lookup(cmd);
 	if (alias) {
-		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
-		free(alias);
-		exit(0);
+		const char **argv;
+		int count;
+
+		/*
+		 * handle_builtin() in git.c rewrites "git cmd --help"
+		 * to "git help --exclude-guides cmd", so we can use
+		 * exclude_guides to distinguish "git cmd --help" from
+		 * "git help cmd". In the latter case, or if cmd is an
+		 * alias for a shell command, just print the alias
+		 * definition.
+		 */
+		if (!exclude_guides || alias[0] == '!') {
+			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
+			free(alias);
+			exit(0);
+		}
+		/*
+		 * Otherwise, we pretend that the command was "git
+		 * word0 --help". We use split_cmdline() to get the
+		 * first word of the alias, to ensure that we use the
+		 * same rules as when the alias is actually
+		 * used. split_cmdline() modifies alias in-place.
+		 */
+		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
+		count = split_cmdline(alias, &argv);
+		if (count < 0)
+			die(_("bad alias.%s string: %s"), cmd,
+			    split_cmdline_strerror(count));
+		free(argv);
+		UNLEAK(alias);
+		return alias;
 	}
 
 	if (exclude_guides)
-- 
2.19.0

