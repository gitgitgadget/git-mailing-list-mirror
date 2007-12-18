From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 17:06:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181703560.23902@racer.site>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
 <4767ED52.9010004@viscovery.net> <4767EE6D.5070509@obry.net>
 <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pascal Obry <pascal@obry.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 18:07:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fu6-0003Jy-6k
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 18:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726AbXLRRG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 12:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757892AbXLRRG0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 12:06:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:45574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757180AbXLRRGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 12:06:25 -0500
Received: (qmail invoked by alias); 18 Dec 2007 17:06:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 18 Dec 2007 18:06:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u4wlxL4nuj4qsPlYYVR79R0TQyzY0uIRlxthx5z
	ogI8taoUSBHEZp
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68784>

Hi,

On Tue, 18 Dec 2007, Linus Torvalds wrote:

> But I obviously think the version by Dscho is better (exactly because it's 
> *not* enough to just clear the name prefix entirely), although I think 
> that one is broken too - using ':' to separate the prefixes is *not* 
> acceptable, since ':' is very possibly part of the prefix.
> 
> So I think you'd need separate arguments for the from/to prefixes, and not 
> try to shoehorn it into one argument. With possibly some simple form to 
> say "no prefix". So maybe something like
> 
>   --src-prefix=<string>		// default "a/"
>   --dst-prefix=<string>		// default "b/"
>   --no-prefix			// shorthand for --src-prefix="" --dst-prefix=""
> 
> would work for everybody?

If this is preferred, please squash this:

-- snipsnap --

 Documentation/diff-options.txt |   11 ++++++++---
 diff.c                         |   24 ++++++++++++++----------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 672a2d0..0d3dccc 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -211,9 +211,14 @@ endif::git-format-patch[]
 --no-ext-diff::
 	Disallow external diff drivers.
 
---prefix=<prefix1>[:<prefix2>]::
-	Show the given path prefixes instead of "a/" and "b/".  Leave
-	it empty to show no prefix at all.
+--src-prefix <prefix>::
+	Show the given source prefix instead of "a/".
+
+--dst-prefix <prefix>::
+	Show the given destination prefix instead of "b/".
+
+--no-prefix::
+	Do not show any source or destination prefix.
 
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
diff --git a/diff.c b/diff.c
index 095bbb5..9bc5fea 100644
--- a/diff.c
+++ b/diff.c
@@ -2317,16 +2317,20 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		else if (40 < options->abbrev)
 			options->abbrev = 40;
 	}
-	else if (!strcmp(arg, "--prefix=")) {
-		char *colon = strchr(arg + 9, ':');
-		options->a_prefix = arg + 9;
-		if (colon) {
-			*colon = '\0';
-			options->b_prefix = colon + 1;
-		}
-		else
-			options->b_prefix = options->a_prefix;
-	}
+	else if (!strcmp(arg, "--src-prefix")) {
+		if (ac < 2)
+			return error("--src-prefix needs a parameter");
+		options->a_prefix = arg + 1;
+		return 2;
+	}
+	else if (!strcmp(arg, "--dst-prefix")) {
+		if (ac < 2)
+			return error("--dst-prefix needs a parameter");
+		options->b_prefix = arg + 1;
+		return 2;
+	}
+	else if (!strcmp(arg, "--no-prefix"))
+		options->a_prefix = options->b_prefix = "";
 	else
 		return 0;
 	return 1;
