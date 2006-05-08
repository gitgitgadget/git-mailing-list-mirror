From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 17:05:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 02:05:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FctFo-0006vF-83
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWEHAFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWEHAFc
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:05:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7845 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751239AbWEHAFb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 20:05:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4805QtH021865
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 17:05:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4805QTF029715;
	Sun, 7 May 2006 17:05:26 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1147037659.25090.25.camel@dv>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19726>



On Sun, 7 May 2006, Pavel Roskin wrote:
>
> I think a good implementation should allow any characters in the keys,
> even "=", because the key can be quoted.  Section names may disallow
> square brackets and dots.

That wouldn't help. The thing is designed to not only need no quoting 
(except for the _value_), it also is designed to have both section and key 
names ignore case. So you really aren't supposed to put things like branch 
names (which are potentially case-sensitive, depending on filesystem) in 
either.

And we depend on that (and I think it's important - users normally should 
_not_ care about capitalization)

So you'd need to literally create a different syntax if you want unquoted 
section naming.

> Such limitations make it unpractical to use branch names in section or
> key names.  I'd like to have it fixed.

Here's a possible syntax/patch. I actually think the quoting makes more 
sense in the section name, since you'll usually want several keys under 
each branch, so it makes sense to make the _branch_ be the section.

It basically makes it a special case if you have the section name be 
marked with quotes, like

	["XyZZy"]

and in that case it turns the _real_ section name into the string 
"branch.XyZZy", where the important part is that it does this without 
changing case or limiting the character set (but it will _not_ allow a 
newline) in any way.

So you could have something like

	["Origin"]
		URL = ...
		fetch = master

and it would just turn it into

	branch.Origin.url = ...
	branch.Origin.fetch = master

etc.

No, I'm not sure this is the best possible syntax. It's just a suggestion. 
And it's certainly simple enough.

The downside is that if you start using config files like this, you 
literally can't go back to older git versions. They'll refuse to touch 
such a config file (rather than just ignoring the new entries) and will 
exit with nasty messages. That might be unacceptable.

Instead of quoting with double-quotes, it might be ok to use some 
alternate syntax line "[:$branchname:]" which looks visually reasonable, 
and has the potential advantage that ':' is already an invalid character 
in a branch name, so you don't actually even need any quoting logic at all 
at that point.

I think the

	["branch"]
		...

syntax looks reasonably readable and clean.

		Linus

----
diff --git a/config.c b/config.c
index 41066e4..802e326 100644
--- a/config.c
+++ b/config.c
@@ -134,9 +134,44 @@ static int get_value(config_fn_t fn, cha
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
 		int c = get_next_char();
