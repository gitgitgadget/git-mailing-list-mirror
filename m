Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F280420899
	for <e@80x24.org>; Fri, 11 Aug 2017 16:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbdHKQhu (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 12:37:50 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:49924 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753401AbdHKQhs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Aug 2017 12:37:48 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id B0E643C000747;
        Fri, 11 Aug 2017 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:in-reply-to
        :references; s=jupiterrise.com; bh=U7zQ4e/mN/gZbw/Ywj974SLecIs=; b=
        PtzAnbqgpkW9V96/prQtdvM5HOy2tLOCzg8DcdQ27LJ3+XccbnD0L2BkJ3SolwCO
        FmtlQDYgLqxrxPNrh+2Hn1H97XXW4dg04A6rHqPtvFeD+mzmxXkg1RRiot6Mbfvz
        k13CabfzkVu4hjv0juVUMICR+tLonae5jkJHKzjNYcA=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id 711153C000741;
        Fri, 11 Aug 2017 09:37:47 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet.jupiterrise.com [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id E6AD3605ED;
        Fri, 11 Aug 2017 18:37:44 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id D0AF26ECA8; Fri, 11 Aug 2017 18:37:44 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: [PATCH 2/2] http: use a feature check to enable GSSAPI delegation control
Date:   Fri, 11 Aug 2017 18:37:34 +0200
Message-Id: <b037d7116bb6eac965a5cba2357611b156c07b8d.1502462884.git.tgc@jupiterrise.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1502462884.git.tgc@jupiterrise.com>
References: <cover.1502462884.git.tgc@jupiterrise.com>
In-Reply-To: <cover.1502462884.git.tgc@jupiterrise.com>
References: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com> <cover.1502462884.git.tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn the version check into a feature check to ensure this functionality
is also enabled with vendor supported curl versions where the feature
may have been backported.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 http.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 569909e8a..a3ae58f13 100644
--- a/http.c
+++ b/http.c
@@ -91,7 +91,7 @@ static struct {
 	 * here, too
 	 */
 };
-#if LIBCURL_VERSION_NUM >= 0x071600
+#ifdef CURLGSSAPI_DELEGATION_FLAG
 static const char *curl_deleg;
 static struct {
 	const char *name;
@@ -356,7 +356,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.delegation", var)) {
-#if LIBCURL_VERSION_NUM >= 0x071600
+#ifdef CURLGSSAPI_DELEGATION_FLAG
 		return git_config_string(&curl_deleg, var, value);
 #else
 		warning(_("Delegation control is not supported with cURL < 7.22.0"));
@@ -727,7 +727,7 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif
 
-#if LIBCURL_VERSION_NUM >= 0x071600
+#ifdef CURLGSSAPI_DELEGATION_FLAG
 	if (curl_deleg) {
 		int i;
 		for (i = 0; i < ARRAY_SIZE(curl_deleg_levels); i++) {
-- 
2.14.1

