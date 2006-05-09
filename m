From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 12:24:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
 <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE> <Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
 <e3p5om$djs$1@sea.gmane.org> <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 21:24:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdXoj-0004Nu-1Y
	for gcvg-git@gmane.org; Tue, 09 May 2006 21:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWEITYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 15:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWEITYS
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 15:24:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750925AbWEITYR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 15:24:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k49JO3tH020591
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 12:24:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k49JO2xC019101;
	Tue, 9 May 2006 12:24:03 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19843>



On Tue, 9 May 2006, Junio C Hamano wrote:
> 
> If we are shooting for "let's not do this again", I do not think
> (4) without some quoting convention is good enough.  Today, we
> are talking about branch names so we could give them artificial
> limits, which could be weaker than what we already have on the
> branch names, but we would later regret that, when we start
> wanting to have other names in the configuration (e.g. people's
> names).

Here's my suggestion as a patch.

NOTE! This patch could be applied right now, and to all the branches (to
make 1.x, 1.2.x and 1.3.x all support the _syntax_). Even if nothing 
actually uses it.

It just makes the syntax be

	[section<space>+"<randomstring>"]

where the only rule for "randomstring" is that it can't contain a newline, 
and if you really want to insert a double-quote, you do it with \".

It turns that into the section name "secion.randomstring".

So you could use this for things like

	[email "torvalds@osdl.org"]
		name = Linus Torvalds

if you wanted to do the "email->name" conversion as part of the config 
file format (I'm not claiming that is sensible, I'm just giving it as an 
insane example). That would show up as the association

	email.torvalds@osdl.org.name -> Linus Torvalds

which is easy to parse (the "." in the email _looks_ ambiguous, but it 
isn't: you know that there will always be a single key-name, so you find 
the key name with "strrchr(name, '.')" and things are entirely 
unambiguous).

Now, it doesn't do any repo-config stuff, since the whole point of this is 
to make this a legal syntax, not actually start _using_ it yet. If people 
think this is an acceptable syntax, then pls apply to everything, and 
worry about usage later.

		Linus

---
diff --git a/config.c b/config.c
index 0f518c9..f3b74e0 100644
--- a/config.c
+++ b/config.c
@@ -134,6 +134,41 @@ static int get_value(config_fn_t fn, cha
 	return fn(name, value);
 }
 
+static int get_extended_base_var(char *name, int baselen, int c)
+{
+	do {
+		if (c == '\n')
+			return -1;
+		c = get_next_char();
+	} while (isspace(c));
+
+	/* We require the format to be '[base "extension"]' */
+	if (c != '"')
+		return -1;
+	name[baselen++] = '.';
+
+	for (;;) {
+		int c = get_next_char();
+		if (c == '\n')
+			return -1;
+		if (c == '"')
+			break;
+		if (c == '\\') {
+			c = get_next_char();
+			if (c == '\n')
+				return -1;
+		}
+		name[baselen++] = c;
+		if (baselen > MAXNAME / 2)
+			return -1;
+	}
+
+	/* Final ']' */
+	if (get_next_char() != ']')
+		return -1;
+	return baselen;
+}
+
 static int get_base_var(char *name)
 {
 	int baselen = 0;
@@ -144,6 +179,8 @@ static int get_base_var(char *name)
 			return -1;
 		if (c == ']')
 			return baselen;
+		if (isspace(c))
+			return get_extended_base_var(name, baselen, c);
 		if (!isalnum(c) && c != '.')
 			return -1;
 		if (baselen > MAXNAME / 2)
