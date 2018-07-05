Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C171F62D
	for <e@80x24.org>; Thu,  5 Jul 2018 18:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeGESoN (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 14:44:13 -0400
Received: from s019.cyon.net ([149.126.4.28]:42206 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753801AbeGESoM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 14:44:12 -0400
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2018 14:44:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=x+F34IioU5i0IevNh0r24nkb6XEvqOW39uspwNV8m0I=; b=KeS3FV6ekPtsWWJWnl+5pjC2m4
        p6JGQ/QqAZOUQvqm9bBEQm/6BoIcLdtB8AQU2Trvpi7mW6l7x1G1GD0/G6X2lBd/7zc272m3MxeRl
        WVN+DcIoS5IZ0Y3M+fcwFDkRAHb3A3nOONNS96OSUArY0fgu1laByGVnpoV0w6rpfKMK6rm72DWI8
        Ck2XkG4wwS/6JfVufCEqQXvuk2GDSosKAtwRi3PpzR8R7mhRQa40EVJEvF+bc3NQG25FXd1OvEUp8
        fj/9qEcsBHx/uPKotzJKXL89Yl0eIixf7cKeQEoLmp7jHevk3e53VLssAXjmcA6mQ5bp1NxJ8GUPv
        Sr8AFHxw==;
Received: from [10.20.10.233] (port=64172 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fb95v-003ZMB-7a; Thu, 05 Jul 2018 20:35:09 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id DD665201B8; Thu,  5 Jul 2018 20:35:05 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>,
        Taylor Blau <me@taylorr.com>
Subject: [PATCH] builtin/config: work around an unsized array forward declaration
Date:   Thu,  5 Jul 2018 20:34:45 +0200
Message-Id: <20180705183445.30901-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported here[0], Microsoft Visual Studio 2017.2 and "gcc -pedantic"
don't understand the forward declaration of an unsized static array.
They insist on an array size:

    d:\git\src\builtin\config.c(70,46): error C2133: 'builtin_config_options': unknown size

The thread [1] explains that this is due to the single-pass nature of
old compilers.

To work around this error, introduce the forward-declared function
usage_builtin_config() instead that uses the array
builtin_config_options only after it has been defined.

Also use this function in all other places where usage_with_options() is
called with the same arguments.

[0]: https://github.com/git-for-windows/git/issues/1735
[1]: https://groups.google.com/forum/#!topic/comp.lang.c.moderated/bmiF2xMz51U

Fixes https://github.com/git-for-windows/git/issues/1735

Reported-By: Karen Huang (via GitHub)
Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 builtin/config.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index b29d26dede..2c93a289a7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -67,7 +67,7 @@ static int show_origin;
 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
 	PARSE_OPT_NONEG, option_parse_type, (i) }
 
-static struct option builtin_config_options[];
+static NORETURN void usage_builtin_config(void);
 
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
@@ -111,8 +111,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		 * --type=int'.
 		 */
 		error("only one type at a time.");
-		usage_with_options(builtin_config_usage,
-			builtin_config_options);
+		usage_builtin_config();
 	}
 	*to_type = new_type;
 
@@ -157,11 +156,16 @@ static struct option builtin_config_options[] = {
 	OPT_END(),
 };
 
+static NORETURN void usage_builtin_config(void)
+{
+	usage_with_options(builtin_config_usage, builtin_config_options);
+}
+
 static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
 	error("wrong number of arguments");
-	usage_with_options(builtin_config_usage, builtin_config_options);
+	usage_builtin_config();
 }
 
 static void show_config_origin(struct strbuf *buf)
@@ -596,7 +600,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
 		error("only one config file at a time.");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_builtin_config();
 	}
 
 	if (use_local_config && nongit)
@@ -660,12 +664,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error("--get-color and variable type are incoherent");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_builtin_config();
 	}
 
 	if (HAS_MULTI_BITS(actions)) {
 		error("only one action at a time.");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_builtin_config();
 	}
 	if (actions == 0)
 		switch (argc) {
@@ -673,25 +677,24 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		case 2: actions = ACTION_SET; break;
 		case 3: actions = ACTION_SET_ALL; break;
 		default:
-			usage_with_options(builtin_config_usage, builtin_config_options);
+			usage_builtin_config();
 		}
 	if (omit_values &&
 	    !(actions == ACTION_LIST || actions == ACTION_GET_REGEXP)) {
 		error("--name-only is only applicable to --list or --get-regexp");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_builtin_config();
 	}
 
 	if (show_origin && !(actions &
 		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
 		error("--show-origin is only applicable to --get, --get-all, "
 			  "--get-regexp, and --list.");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_builtin_config();
 	}
 
 	if (default_value && !(actions & ACTION_GET)) {
 		error("--default is only applicable to --get");
-		usage_with_options(builtin_config_usage,
-			builtin_config_options);
+		usage_builtin_config();
 	}
 
 	if (actions & PAGING_ACTIONS)
-- 
2.15.0.rc1.299.gda03b47c3

