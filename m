From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Why does git-describe warn about something that you can't control?
Date: Fri, 26 Dec 2008 14:44:44 +0100
Message-ID: <4954DFCC.8010707@lsrfire.ath.cx>
References: <9b18b3110812260350q6870700du982ec3a7a91950e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 14:46:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGD1H-00076V-4M
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 14:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbYLZNou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 08:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbYLZNot
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 08:44:49 -0500
Received: from india601.server4you.de ([85.25.151.105]:55020 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYLZNot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 08:44:49 -0500
Received: from [10.0.1.101] (p57B7E108.dip.t-dialin.net [87.183.225.8])
	by india601.server4you.de (Postfix) with ESMTPSA id BEB032F8003;
	Fri, 26 Dec 2008 14:44:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <9b18b3110812260350q6870700du982ec3a7a91950e2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103940>

demerphq schrieb:
> On the perl.git repo if I use git-describe --all on some commits I get
> warnings like this:
> 
> $ git describe --all 3417e4f8422bcf13f799ce1acef44b27ccbef3d8
> warning: tag 'perl-5.005_04' is really 'tags/perl-5.005_04' here
> perl-5.005_04
> 
> Except there doesnt seem to be any explanation for why the warning is
> being produced (it almost, but not quite looks random for the commits
> im looking at), how to silence it, or how to force git-describe to for
> instance use "tags/perl-5.8.0" instead so the warning is not
> generated.
> 
> I think this behaviour is confusing, either the warning should go
> away, or it should be improved and complemented by a switch to force
> git-describe to use the qualified tagname instead, or at the very
> least a switch to silence the warning (which is really annoying when
> you are doing git-describe on hundreds of commits in a go).

The warning was introduced by 212945d4 ("Teach git-describe to verify
annotated tag names before output") by Shawn (cc:'d).

The following patch should fix your issue by making describe ignore the
"tags/" path prefix of, well, tags, which is only present if you call
it with the option --all.

diff --git a/builtin-describe.c b/builtin-describe.c
index d2cfb1b..3a007ed 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -158,7 +158,7 @@ static void display_name(struct commit_name *n)
 		n->tag = lookup_tag(n->sha1);
 		if (!n->tag || parse_tag(n->tag) || !n->tag->tag)
 			die("annotated tag %s not available", n->path);
-		if (strcmp(n->tag->tag, n->path))
+		if (strcmp(n->tag->tag, all ? n->path + 5 : n->path))
 			warning("tag '%s' is really '%s' here", n->tag->tag, n->path);
 	}
 
