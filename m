From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Reuse cmdname->len to store pre-calculated similarity
	indexes
Date: Sat, 30 Aug 2008 19:13:31 +0200
Message-ID: <20080830171331.GA26932@steel.home>
References: <20080828171533.GA6024@blimp.local> <20080828212722.GF6439@steel.home> <7vsksm1pmd.fsf@gitster.siamese.dyndns.org> <81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 19:15:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZU2F-0002Uj-R3
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbYH3RNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 13:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbYH3RNe
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 13:13:34 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:33438 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbYH3RNd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 13:13:33 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf4EK7
Received: from tigra.home (Fad0a.f.strato-dslnet.de [195.4.173.10])
	by post.webmailer.de (klopstock mo28) (RZmta 16.47)
	with ESMTP id 300086k7UE6G5i ; Sat, 30 Aug 2008 19:13:31 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 68D29277AE;
	Sat, 30 Aug 2008 19:13:31 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 36EBF56D2A; Sat, 30 Aug 2008 19:13:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94390>

To avoid doing that while sorting

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Sat, Aug 30, 2008 18:44:15 +0200:
> 2008/8/30 Junio C Hamano <gitster@pobox.com>:
> > I wonder if it makes sense to give an otherwise unused "score" member to
> 
> Hmm, it is a _non-existing_ member of cmdname, isn't it?
> 
> > the "struct cmdname", compute the distance only once per each command, and
> > use that as the sort key (alternatively you can have a separate int[N]
> > array to store similarity values for each item in the cmdnames list, only
> > used inside this codepath).
> 
> I think I'll take the struct cmdname->len over.

 help.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/help.c b/help.c
index 7bfbbcd..70d57a3 100644
--- a/help.c
+++ b/help.c
@@ -287,8 +287,8 @@ static int levenshtein_compare(const void *p1, const void *p2)
 {
 	const struct cmdname *const *c1 = p1, *const *c2 = p2;
 	const char *s1 = (*c1)->name, *s2 = (*c2)->name;
-	int l1 = similarity(s1);
-	int l2 = similarity(s2);
+	int l1 = (*c1)->len;
+	int l2 = (*c2)->len;
 	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
 }
 
@@ -312,6 +312,9 @@ const char *help_unknown_cmd(const char *cmd)
 	memcpy(main_cmds.names + main_cmds.cnt, other_cmds.names,
 		other_cmds.cnt * sizeof(other_cmds.names[0]));
 	main_cmds.cnt += other_cmds.cnt;
+	/* This reuses cmdname->len for similarity index */
+	for (i = 0; i < main_cmds.cnt; ++i)
+		main_cmds.names[i]->len = similarity(main_cmds.names[i]->name);
 
 	levenshtein_cmd = cmd;
 	qsort(main_cmds.names, main_cmds.cnt,
@@ -319,10 +322,9 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (!main_cmds.cnt)
 		die ("Uh oh.  Your system reports no Git commands at all.");
-	best_similarity = similarity(main_cmds.names[0]->name);
+	best_similarity = main_cmds.names[0]->len;
 	n = 1;
-	while (n < main_cmds.cnt &&
-		best_similarity == similarity(main_cmds.names[n]->name))
+	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
 		++n;
 	if (autocorrect && n == 1) {
 		const char *assumed;
-- 
1.6.0.1.149.g9ecb0
