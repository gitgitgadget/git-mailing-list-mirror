X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/2] Allow '-' in config variable names
Date: Mon, 30 Oct 2006 08:25:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 16:34:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30502>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeZxm-0005GK-4Q for gcvg-git@gmane.org; Mon, 30 Oct
 2006 17:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964977AbWJ3Q0J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 11:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWJ3Q0J
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 11:26:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60073 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S964977AbWJ3Q0G (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 11:26:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9UGPbPo006866
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 30
 Oct 2006 08:25:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9UGPad2026181; Mon, 30 Oct
 2006 08:25:37 -0800
To: Junio C Hamano <junkio@cox.net>, Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org


I need this in order to allow aliases of the same form as "ls-tree", 
"rev-parse" etc, so that I can use

	[alias]
		my-cat=--paginate cat-file -p

to add a "git my-cat" command.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This will be followed by another patch to "builtin-push.c" to allow me to 
make a useful (to me) "push-all" alias.

diff --git a/config.c b/config.c
index e8f0caf..3cae390 100644
--- a/config.c
+++ b/config.c
@@ -103,6 +103,11 @@ static char *parse_value(void)
 	}
 }
 
+static inline int iskeychar(int c)
+{
+	return isalnum(c) || c == '-';
+}
+
 static int get_value(config_fn_t fn, char *name, unsigned int len)
 {
 	int c;
@@ -113,7 +118,7 @@ static int get_value(config_fn_t fn, cha
 		c = get_next_char();
 		if (c == EOF)
 			break;
-		if (!isalnum(c))
+		if (!iskeychar(c))
 			break;
 		name[len++] = tolower(c);
 		if (len >= MAXNAME)
@@ -181,7 +186,7 @@ static int get_base_var(char *name)
 			return baselen;
 		if (isspace(c))
 			return get_extended_base_var(name, baselen, c);
-		if (!isalnum(c) && c != '.')
+		if (!iskeychar(c) && c != '.')
 			return -1;
 		if (baselen > MAXNAME / 2)
 			return -1;
@@ -573,7 +578,7 @@ int git_config_set_multivar(const char*
 			dot = 1;
 		/* Leave the extended basename untouched.. */
 		if (!dot || i > store.baselen) {
-			if (!isalnum(c) || (i == store.baselen+1 && !isalpha(c))) {
+			if (!iskeychar(c) || (i == store.baselen+1 && !isalpha(c))) {
 				fprintf(stderr, "invalid key: %s\n", key);
 				free(store.key);
