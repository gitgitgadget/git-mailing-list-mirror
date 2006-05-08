From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 17:18:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071713410.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 02:18:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FctSL-00006f-Q0
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWEHAS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWEHAS1
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:18:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751240AbWEHAS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 20:18:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k480INtH022196
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 17:18:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k480INgj029921;
	Sun, 7 May 2006 17:18:23 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19727>



On Sun, 7 May 2006, Linus Torvalds wrote:
>
> And it's certainly simple enough.

Well, simple enough to be buggy.

>  static int get_base_var(char *name)
>  {
>  	int baselen = 0;
> +	int c = get_next_char();
> +
> +	if (c == '"')
> +		return get_branch_name(name);
>  
>  	for (;;) {
>  		int c = get_next_char();

You also need to move the "int c = get_next_char()" in the for() loop down 
to the end of the loop (removing the "int", of course).

So here's the fixed thing in case people care (and this time I actually 
looked at whether it might even work, not just compile ;)

		Linus
---
diff --git a/config.c b/config.c
index 41066e4..69d451a 100644
--- a/config.c
+++ b/config.c
@@ -134,12 +134,46 @@ static int get_value(config_fn_t fn, cha
 	return fn(name, value);
 }
 
+static int get_branch_name(char *name)
+{
+	int baselen = 7;
+	int quote = 0;
+
+	memcpy(name, "branch.", 7);
+	for (;;) {
+		int c = get_next_char();
+		if (c == EOF)
+			return -1;
+		if (c == '\n')
+			return -1;
+		if (!quote) {
+			if (c == '"')
+				break;
+			if (c == ']')
+				return -1;
+			if (c == '\\') {
+				quote = 1;
+				continue;
+			}
+		}
+		name[baselen++] = c;
+		if (baselen > MAXNAME / 2)
+			return -1;
+	}
+	if (get_next_char() != ']')
+		return -1;
+	return baselen;
+}
+
 static int get_base_var(char *name)
 {
 	int baselen = 0;
+	int c = get_next_char();
+
+	if (c == '"')
+		return get_branch_name(name);
 
 	for (;;) {
-		int c = get_next_char();
 		if (c == EOF)
 			return -1;
 		if (c == ']')
@@ -149,6 +183,7 @@ static int get_base_var(char *name)
 		if (baselen > MAXNAME / 2)
 			return -1;
 		name[baselen++] = tolower(c);
+		c = get_next_char();
 	}
 }
 
