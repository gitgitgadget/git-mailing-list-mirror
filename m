From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] cg-log: make -r id:id show the given id instead of nothing
Date: Sun, 29 May 2005 15:07:20 +0200
Message-ID: <20050529130719.GA16291@diku.dk>
References: <20050520150400.GC27395@diku.dk> <20050529121910.GG1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 15:05:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcNTd-0002Sh-U8
	for gcvg-git@gmane.org; Sun, 29 May 2005 15:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVE2NHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 09:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVE2NHa
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 09:07:30 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:26092 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261228AbVE2NHV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 09:07:21 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 8D24A6E2451; Sun, 29 May 2005 15:06:49 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2D6EB6E243D; Sun, 29 May 2005 15:06:49 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 378C561FE0; Sun, 29 May 2005 15:07:20 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050529121910.GG1036@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> wrote Sun, May 29, 2005:
> Dear diary, on Fri, May 20, 2005 at 05:04:00PM CEST, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> told me that...
> > If cg-log is passed -r cogito-0.10 -r cogito-0.10 no log entries are
> > shown. This patch make it show the log for the given ID.
> > 
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> 
> I don't like such a special case a lot. If you just want to make it
> possible to show up just a single revision by cg-log, what about -R or
> something, so that you don't need to write it twice?

I admit it is a bit weird. The reason for this was to make support for
specifying revisions with something as fuzzy as dates more usable.
Originally I modified commit-id to support it, but I've tried to move
the logic to the new cg-Xnormid to just give an idea. It is suppose to
add support for

	$ cg-log -r '2005-05-12':'1 day ago'

but for some reason it seems to only work as expected for commits by
you. That is it works as expected when I specify the dates for
cogito-0.9 and cogito-0.10.

Of course supporting revisions via date specifications can lead to
ambiguity problems when the date contains `HH:MM' because the colon can
confuse -r option parsing. This means that either a new option needs to
be added (-D?) or the rev1:rev2 case has to be handled after all options
has been parsed so that `-r date1 -r date2' can be handled correctly.

Index: cg-Xnormid
===================================================================
--- c8e987e5e4608c1144293cd3f852210d70b572cb/cg-Xnormid  (mode:100755)
+++ uncommitted/cg-Xnormid  (mode:100755)
@@ -40,6 +40,14 @@
 	fi
 fi
 
+if [ ${#id} -ne 40 ] || [ ! -f .git/objects/${id:0:2}/${id:2} ]; then
+	reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
+
+	if [ "$reqsecs" ]; then
+		id=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)
+	fi
+fi
+
 # If we don't have a 40-char ID by now, it's an error
 if [ ${#id} -ne 40 ] || [ ! -f .git/objects/${id:0:2}/${id:2} ]; then
 	echo "Invalid id: $id" >&2
-- 
Jonas Fonseca
