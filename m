Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ABD01F428
	for <e@80x24.org>; Sun, 31 Dec 2017 02:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbdLaCcj (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 21:32:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56585 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750806AbdLaCci (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 21:32:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C52AC2362;
        Sat, 30 Dec 2017 21:32:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=QRzve56ptuh5eMcSXOmmK8Fzm4E
        =; b=YwSw1NZsJ/mJ55Qe4dgsbo0+23azYvds6SjnN8M6Iu+LBAU6MVZOIsKMoGG
        Ythi82H2Bm1F2oXHP2kE21beXWlpk/Q7oFbqdBzhPU/Q4e11hkQE9BR8WolE1Nxb
        rXJ30hme6gK1cxBfiStxpGLkK36HdZBlo7wsJ65DZ9SR1irc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=UZvFnZB2888D6X4N8BoFV
        rZyJvyqrqYDLMdgglnspuB02+YCeQsKx+i88qgmWRZzpg6bx8FdRhrqut7b+QgUJ
        GpJkZ6xumgbWQPn89YTQpn7ynpVHL7Hbod8UCZ4rmIa1GCqBu0hK0XKlgyLK9bzF
        p97pGzDOosL45+PRQ/XXvA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55243C2361;
        Sat, 30 Dec 2017 21:32:37 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.86.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA30EC2360;
        Sat, 30 Dec 2017 21:32:36 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] http: fix v1 protocol tests with apache httpd < 2.4
Date:   Sat, 30 Dec 2017 21:32:34 -0500
Message-Id: <20171231023234.21215-1-tmz@pobox.com>
X-Mailer: git-send-email 2.16.0.rc0
X-Pobox-Relay-ID: DD3DDF24-EDD2-11E7-80E9-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The apache config used by tests was updated to use the SetEnvIf
directive to set the Git-Protocol header in 19113a26b6 ("http: tell
server that the client understands v1", 2017-10-16).

Setting the Git-Protocol header is restricted to httpd >= 2.4, but
mod_setenvif and the SetEnvIf directive work with lower versions, at
least as far back as 2.0, according to the httpd documentation:

    https://httpd.apache.org/docs/2.0/mod/mod_setenvif.html

Drop the restriction.  Tested with httpd 2.2 and 2.4.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

These tests fail with 2.16.0-rc0 on CentOS-6, which uses
httpd-2.2.

I removed the version restriction entirely rather than adjust
the version.  I believe SetEnvIf works on httpd >= 2.0.  I'm
not sure if we aim to support anything less than httpd 2.0,
but I'm betting not.  If that's incorrect, I can add some
IfVersion conditions.

As noted in the commit message, I only tested with httpd 2.2
and 2.4 (on CentOS 6/7 and Fedora 26-28).  If anyone has older
httpd systems which need support, it would be great if they
could test this before 2.16.0 is finalized, so we can avoid
shipping with any failing tests.

 t/lib-httpd/apache.conf | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index df19436314..724d9ae462 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -25,6 +25,9 @@ ErrorLog error.log
 <IfModule !mod_headers.c>
 	LoadModule headers_module modules/mod_headers.so
 </IfModule>
+<IfModule !mod_setenvif.c>
+	LoadModule setenvif_module modules/mod_setenvif.so
+</IfModule>
 
 <IfVersion < 2.4>
 LockFile accept.lock
@@ -67,9 +70,6 @@ LockFile accept.lock
 <IfModule !mod_unixd.c>
 	LoadModule unixd_module modules/mod_unixd.so
 </IfModule>
-<IfModule !mod_setenvif.c>
-	LoadModule setenvif_module modules/mod_setenvif.so
-</IfModule>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
@@ -79,9 +79,7 @@ PassEnv ASAN_OPTIONS
 PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
 
-<IfVersion >= 2.4>
-	SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
-</IfVersion>
+SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
 
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
-- 
2.16.0.rc0

