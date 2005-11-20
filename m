From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Sun, 20 Nov 2005 10:09:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 19:10:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edtdh-0005PM-DG
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 19:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKTSKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 13:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKTSKF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 13:10:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750713AbVKTSKE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 13:10:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAKI9tnO009291
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 20 Nov 2005 10:09:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAKI9pWe011446;
	Sun, 20 Nov 2005 10:09:53 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12389>



On Sun, 20 Nov 2005, Johannes Schindelin wrote:
> 
> I just had a crazy idea. Since we have a framework in place to read/write 
> .git/config, I thought that maybe it would be a nice thing to move the 
> information which is in .git/branches or .git/remotes into the config.

I considered it, but thee thing is, it really wants "nested names", ie 
having multi-level base-names for the variables. At the same time, I 
absolutely _abhor_ horrible crap like XML, which make nesting a 
fundamental part of their structure.

XML may be "logical", but it has absolutely zero to do with being 
human-readable and clean. In short, XML is total and absolute CRAP (in 
fact, the "X" in "XML" stands for "Crap", but the XML designers were also 
incredibly bad spellers).

So while the basic notion of the git ini file does support nesting (we 
could just make variable names be "base.level1.final" or any number of 
levels deep), I don't know what a sane format would be. I have one 
suggestion that in my opinion "fits" the .ini file syntax (see below), but 
people may well hate it.

Basically I've considered saying that one or more '.' characters at the 
start of a section name would mean "re-use the previous one", so we could 
have (this is a really bad example, just to show the implications):

	[core]
		[.values]
			fixed = true
			nested = fine
			[..example]
				test = Hell yes
		[.other]
			example = strange
		[.]
			name = hi

	[section]
		example = yet another

and that would result in a parse of

	core.values.fixed = true
	core.values.nested = fine
	core.values.example.test = Hell yes
	core.other.example = strange
	core.name = hi
	secontion.example = yet another

and that seems reasonably clean. I'd also allow explicit 
multi-level section names:

	[core.values]
		fixed = true

so you could always write the above config file in an alternate format:

	[core.values] fixed = true
	[core.values] nested = fine
	[core.values.example] test = Hell yes
	[core.other] example = strange
	[core] name = hi
	[section] example = yet another

instead, using no implicit nesting at all (or, indeed, even re-using 
sections like "core.values").

That would allow things like

	[branches]
		[.origin]
			url = master.kernel.org:/pub/scm/git/git.git
			pull = master:origin
		[.mine]
			url = my.domain.com:/other/repo
			pull = master:mine

(which could also be written as

	[branches.origin]
		url = master.kernel.org:/pub/scm/git/git.git
		pull = master:origin

	[branches.mine]
		url = my.domain.com:/other/repo
		pull = master:mine

and the following mixed-indentation usage would be technically correct, 
but perhaps crazy:

	[branches.origin]
		url = master.kernel.org:/pub/scm/git/git.git
		pull = master:origin

	    [.mine]
		url = my.domain.com:/other/repo
		pull = master:mine

Basically, right now we only allow alphanumeric characters in the base 
name, and a new section name completely clears the old one. The above 
would be a very simple extension of that: we would allow '.' in addition 
to alphanumerics, and any initial '.' characters would _keep_ that many 
levels of the old name.

I dunno. That seems a nice extension, and it would make these things 
very unambiguous. But how do other .ini-file-like things do this?

And I'm not 100% convinced that putting these branches in the config file 
has any real advantages over keeping them as separate files. Having 
everything in one place is nice, of course, and being able to copy just 
one file around might be convenient, but it _does_ make the config file 
more complicated.

Anyway, if you want to play with this, here's a trivial patch that may or 
may not work.

		Linus

----
diff --git a/config.c b/config.c
index 915bb97..3b9f300 100644
--- a/config.c
+++ b/config.c
@@ -136,6 +136,19 @@ static int get_base_var(char *name)
 			return -1;
 		if (c == ']')
 			return baselen;
+		if (c == '.') {
+			if (!baselen || name[baselen-1] == '.') {
+				for (;;) {
+					if (!name[baselen])
+						return -1;
+					if (name[baselen++] == '.')
+						break;
+				}
+				continue;
+			}
+			name[baselen++] = c;
+			continue;
+		}
 		if (!isalnum(c))
 			return -1;
 		if (baselen > MAXNAME / 2)
