From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-am applies half of a patch
Date: Tue, 9 Jan 2007 08:02:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701090748020.3661@woody.osdl.org>
References: <45A36D6B.4010303@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 17:03:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4JRL-0000or-I4
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 17:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbXAIQDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 11:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbXAIQDE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 11:03:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49687 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170AbXAIQDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 11:03:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l09G2pWi010640
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Jan 2007 08:02:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l09G2oAC008737;
	Tue, 9 Jan 2007 08:02:51 -0800
To: Jeff Garzik <jeff@garzik.org>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <45A36D6B.4010303@garzik.org>
X-Spam-Status: No, hits=-0.667 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36370>



On Tue, 9 Jan 2007, Jeff Garzik wrote:
>
> I ran
> 
> 	git-am --signoff --utf8 /g/tmp/mbox
> 
> on the attached file, to apply a patch to libata-dev.git#upstream, and it
> wound up only applying a portion of the patch:
> 
> > [jgarzik@pretzel libata-dev]$ git-am --signoff --utf8 /g/tmp/mbox 
> > Applying 'Add pci class code for SATA AHCI'
> > 
> > error: patch fragment without header at line 35: @@ -862,7 +862,7 @@
> > error: patch fragment without header at line 50: @@ -15,6 +15,8 @@
> > Wrote tree 5d6f3a93bea932c950ac880deca173dd3e84dfcc
> > Committed: 317b180bad43133027dc07455f1600f4e8a47d76
> 
> It seems quite bad to apply a patch that git-am KNOWS is incomplete.

It doesn't actually "know" it. What is going on is that the "patch" 
program generally allows random crap in between multiple patches, and 
while git-apply is normally stricter than "patch" ever is, git-apply does 
allow this "garbage between patches" thing too.

Sometimes the garbage is just commentary (some people say things in 
between patches), but quite often it's also stuff like "Index: " (and in 
fact, git considers the "diff " line at the head to be "garbage" too, 
unless it's a native git diff that has the "diff --git" signature).

So what git is actually doing is seeing that you have _garbage_ after the 
real patch, but then it _warns_ about the garbage containing what looks 
like a patch fragment. And the reason it's garbage (rather than a real 
patch) is obviously because your patch was so heavily whitespace-damaged 
that the header that was supposed to start it wasn't a valid header at 
all..

But if you'd like to make it fatal, the patch is certainly simple..

Junio - I certainly wouldn't mind making this a fatal error, but it's 
ultimately your decision.

		Linus

---
diff --git a/builtin-apply.c b/builtin-apply.c
index 1c35837..d3fdf7e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -811,7 +811,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			error("patch fragment without header at line %d: %.*s", linenr, (int)len-1, line);
+			die("patch fragment without header at line %d: %.*s", linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
