From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [WRONG/PATCH 1/3] revisions: clarify handling of --no-walk and
 --do-walk
Date: Thu, 21 Apr 2011 05:39:26 -0500
Message-ID: <20110421103926.GA16260@elie>
References: <20110421102241.GA16185@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 12:39:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCrIT-0005T0-Lu
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 12:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab1DUKjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 06:39:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41503 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab1DUKjf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 06:39:35 -0400
Received: by iyb14 with SMTP id 14so1288162iyb.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=oR2I+Bhg8ueP9LG3gZhOzR3p9K2t1O1kHYj83KEp+ZE=;
        b=ppl0wKbTvDPKlzr5STejEkAiz3RtpJ7wQRlll7dKxFOYqtcDziq4pvviujskPEJr4+
         lgetzsaUu5ahJONT5ScGiWok5EUudg7REdlRlb8m9go+8jaWxbwpeRGz4FgVvobbL2wI
         TotVMPjvsQwehF6exR2mXyibom4Qqff8B6pQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YKdchcIazEkK73kNXchf1tD+ljAl60qW6yDeF+q5CqzDy1UwjHhTgD1/SBH9MJMBuq
         vUhqMkKDFZ/tYEjIEWZuP4Blryq1mZOqsuYDBsXDK7MqCLYLNXvNhIIjkjw5j2mypc/r
         i9cuDO3MYsyrQ5Y19hgJmJzhaKHMRSQmGJgJ0=
Received: by 10.42.228.133 with SMTP id je5mr460512icb.107.1303382373727;
        Thu, 21 Apr 2011 03:39:33 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id uf10sm654215icb.5.2011.04.21.03.39.32
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 03:39:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110421102241.GA16185@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171898>

As v1.6.0-rc2~42 (Allow "non-option" revision options in
parse_option-enabled commands, 2008-07-31) explains, commands which
use parse_options() but also call setup_revisions() do their parsing
in two stages:

 1. first, they parse all options. Anything unknown goes to
    parse_revision_opt() (which calls handle_revision_opt), which
    may claim the option or say "I don't recognize this"

 2. the non-option remainder goes to setup_revisions() to
    actually get turned into revisions

Some revision options, like --all and --not, are "non-options" in that
they must be parsed in order with their revision counterparts in
setup_revisions().  It would be nice if --no-walk and --do-walk fell
in this category and set a flag only for revs coming after them on the
command line, but they do not, so move parsing of --no-walk and
--do-walk to the first "global options" stage for clarity.

---
Wait, the above is not actually the full story.  If I do

	git show maint..master

then this turns on walking automatically, to give the commit range
meaning.  Likewise

	git log --no-walk maint..master

will, in fact walk, but

	git log maint..master --no-walk

will not.  Which I should have understood from v1.6.0-rc2~42
(2008-07-31) already.  Will think more; sorry for the nonsense.

 revision.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 0f38364..7b87bd0 100644
--- a/revision.c
+++ b/revision.c
@@ -1177,7 +1177,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
 	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
 	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
-	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
 	    !strcmp(arg, "--bisect"))
 	{
 		unkv[(*unkc)++] = arg;
@@ -1334,6 +1333,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->unpacked = 1;
 	} else if (!prefixcmp(arg, "--unpacked=")) {
 		die("--unpacked=<packfile> no longer supported.");
+	} else if (!strcmp(arg, "--no-walk")) {
+		revs->no_walk = 1;
+	} else if (!strcmp(arg, "--do-walk")) {
+		revs->no_walk = 0;
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
 		DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
@@ -1622,14 +1625,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				flags ^= UNINTERESTING;
 				continue;
 			}
-			if (!strcmp(arg, "--no-walk")) {
-				revs->no_walk = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--do-walk")) {
-				revs->no_walk = 0;
-				continue;
-			}
 			if (!strcmp(arg, "--stdin")) {
 				if (revs->disable_stdin) {
 					argv[left++] = arg;
-- 
1.7.5.rc3
