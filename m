From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 17:17:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605081905240.6713@iabervon.org>
 <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
 <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE> <Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
 <e3p5om$djs$1@sea.gmane.org> <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
 <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 02:18:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdcPk-00041d-Om
	for gcvg-git@gmane.org; Wed, 10 May 2006 02:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWEJASQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 20:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWEJASQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 20:18:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5815 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932343AbWEJASP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 20:18:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4A0HxtH001403
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 17:17:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4A0HwEX028888;
	Tue, 9 May 2006 17:17:58 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19864>



On Tue, 9 May 2006, sean wrote:
>
> I really tried to like your patch ;o)  But it breaks the repo-config command
> line and causes mixing of some branches using old style [branch.xyz] and new
> style [branch "XYZ"] which just doesn't seem to be the right thing to do.

Well, obviously it's _simpler_ to have the machine-readable format as-is, 
and say "don't try to make it human-readable". But the repo-config patch 
to make it human-readable isn't that hard.

And it's _not_ that hard to make repo-config do the right thing.

Here's a pretty lightly tested patch (on top of my previous one) that does 
exactly that.

(The first part just fixes an indentation bug)

		Linus
---
diff --git a/config.c b/config.c
index f3b74e0..12c51b1 100644
--- a/config.c
+++ b/config.c
@@ -372,10 +372,12 @@ static int store_aux(const char* key, co
 			store.offset[store.seen] = ftell(config_file);
 			store.state = KEY_SEEN;
 			store.seen++;
-		} else if (strrchr(key, '.') - key == store.baselen &&
+		} else {
+			if (strrchr(key, '.') - key == store.baselen &&
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
 					store.offset[store.seen] = ftell(config_file);
+			}
 		}
 	}
 	return 0;
@@ -383,8 +385,30 @@ static int store_aux(const char* key, co
 
 static void store_write_section(int fd, const char* key)
 {
+	const char *dot = strchr(key, '.');
+	int len1 = store.baselen, len2 = -1;
+
+	dot = strchr(key, '.');
+	if (dot) {
+		int dotlen = dot - key;
+		if (dotlen < len1) {
+			len2 = len1 - dotlen - 1;
+			len1 = dotlen;
+		}
+	}
+			
 	write(fd, "[", 1);
-	write(fd, key, store.baselen);
+	write(fd, key, len1);
+	if (len2 >= 0) {
+		write(fd, " \"", 2);
+		while (--len2 >= 0) {
+			unsigned char c = *++dot;
+			if (c == '"')
+				write(fd, "\\", 1);
+			write(fd, &c, 1);
+		}
+		write(fd, "\"", 1);
+	}
 	write(fd, "]\n", 2);
 }
 
@@ -458,7 +482,7 @@ int git_config_set(const char* key, cons
 int git_config_set_multivar(const char* key, const char* value,
 	const char* value_regex, int multi_replace)
 {
-	int i;
+	int i, dot;
 	int fd = -1, in_fd;
 	int ret;
 	char* config_filename = strdup(git_path("config"));
@@ -483,16 +507,23 @@ int git_config_set_multivar(const char* 
 	 * Validate the key and while at it, lower case it for matching.
 	 */
 	store.key = (char*)malloc(strlen(key)+1);
-	for (i = 0; key[i]; i++)
-		if (i != store.baselen &&
-				((!isalnum(key[i]) && key[i] != '.') ||
-				 (i == store.baselen+1 && !isalpha(key[i])))) {
-			fprintf(stderr, "invalid key: %s\n", key);
-			free(store.key);
-			ret = 1;
-			goto out_free;
-		} else
-			store.key[i] = tolower(key[i]);
+	dot = 0;
+	for (i = 0; key[i]; i++) {
+		unsigned char c = key[i];
+		if (c == '.')
+			dot = 1;
+		/* Leave the extended basename untouched.. */
+		if (!dot || i > store.baselen) {
+			if (!isalnum(c) || (i == store.baselen+1 && !isalpha(c))) {
+				fprintf(stderr, "invalid key: %s\n", key);
+				free(store.key);
+				ret = 1;
+				goto out_free;
+			}
+			c = tolower(c);
+		}
+		store.key[i] = c;
+	}
 	store.key[i] = 0;
 
 	/*
