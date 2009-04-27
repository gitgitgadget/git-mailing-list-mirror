From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git grep '(' = segfault
Date: Mon, 27 Apr 2009 11:10:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904271059060.22156@localhost.localdomain>
References: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:12:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyVJe-0003XE-Gn
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026AbZD0SMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 14:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755740AbZD0SMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:12:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39563 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754051AbZD0SMH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 14:12:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RIAO2g006171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2009 11:11:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RIAOFB006149;
	Mon, 27 Apr 2009 11:10:24 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.456 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117698>



On Mon, 27 Apr 2009, Dmitry Potapov wrote:
> 
> I have tried a few version of Git and got "Segmentation fault" when
> run:
> 
> $ git grep '('
> 
> I am not very familiar with grep code and don't have time to dig
> into it right now. So, maybe someone else can take a look at it.

Good job.

Something like this should fix it.

		Linus

---
 grep.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index f3a27d7..04c777a 100644
--- a/grep.c
+++ b/grep.c
@@ -72,6 +72,8 @@ static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 	struct grep_expr *x;
 
 	p = *list;
+	if (!p)
+		return NULL;
 	switch (p->token) {
 	case GREP_PATTERN: /* atom */
 	case GREP_PATTERN_HEAD:
@@ -84,8 +86,6 @@ static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 	case GREP_OPEN_PAREN:
 		*list = p->next;
 		x = compile_pattern_or(list);
-		if (!x)
-			return NULL;
 		if (!*list || (*list)->token != GREP_CLOSE_PAREN)
 			die("unmatched parenthesis");
 		*list = (*list)->next;
@@ -101,6 +101,8 @@ static struct grep_expr *compile_pattern_not(struct grep_pat **list)
 	struct grep_expr *x;
 
 	p = *list;
+	if (!p)
+		return NULL;
 	switch (p->token) {
 	case GREP_NOT:
 		if (!p->next)
@@ -372,6 +374,8 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 	int h = 0;
 	regmatch_t match;
 
+	if (!x)
+		die("Not a valid grep expression");
 	switch (x->node) {
 	case GREP_NODE_ATOM:
 		h = match_one_pattern(x->u.atom, bol, eol, ctx, &match, 0);
