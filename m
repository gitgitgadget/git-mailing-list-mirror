From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Q] Abbreviated history graph?
Date: Mon, 3 Nov 2008 12:34:06 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031233430.3419@nehalem.linux-foundation.org>
References: <200811031439.12111.brian.foster@innova-card.com> <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031211180.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:36:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx6A5-0003is-Ph
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 21:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbYKCUfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 15:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYKCUfV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 15:35:21 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50098 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754301AbYKCUfU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 15:35:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3KY7dZ026464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 12:34:08 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3KY6JT017815;
	Mon, 3 Nov 2008 12:34:06 -0800
In-Reply-To: <alpine.LFD.2.00.0811031211180.3419@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99990>



On Mon, 3 Nov 2008, Linus Torvalds wrote:
> 
> Side note: it's certainly possible that we could improve on this. Right 
> now, "--simplify-namespace" will totally override any path simplification, 
> so you can't get a combination of pathnames _and_ naming commits. I don't 
> know exactly what the rules should be, but I could imagine that we could 
> do something like:
> 
>  - if no pathnames are given, work the way the current patch-series works.
> 
>  - if path-names are given, make rev_compare_tree() truen 
>    REV_TREE_DIFFERENT if a name decoration _or_ a tree difference exists.

The incremental diff to do this would be something like the appended.

		Linus
---
 revision.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index b48e626..1b716c7 100644
--- a/revision.c
+++ b/revision.c
@@ -311,7 +311,10 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 	if (revs->simplify_namespace) {
 		struct name_decoration *name;
 		name = lookup_decoration(&name_decoration, &commit->object);
-		return name ? REV_TREE_DIFFERENT : REV_TREE_SAME;
+		if (name)
+			return REV_TREE_DIFFERENT;
+		if (!revs->prune_data)
+			return REV_TREE_SAME;
 	}
 	if (!t2)
 		return REV_TREE_DIFFERENT;
