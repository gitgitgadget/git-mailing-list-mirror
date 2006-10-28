X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Update information about <format> in git-for-each-ref
Date: Sat, 28 Oct 2006 13:33:46 -0700
Message-ID: <7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
References: <200610281930.05889.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 20:33:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610281930.05889.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 28 Oct 2006 19:30:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30394>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdusI-0004ga-N5 for gcvg-git@gmane.org; Sat, 28 Oct
 2006 22:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964817AbWJ1Udr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWJ1Udr
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 16:33:47 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63661 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S964817AbWJ1Udr
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 16:33:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028203346.YOKT13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 16:33:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fwZq1V00V1kojtg0000000 Sat, 28 Oct 2006
 16:33:51 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> By the way one thing missing from git-for-each-ref to use it
> in gitweb without changing its output is ablility to sort on
> "epoch", i.e. taggerdate for tags and committerdate for commits.
> This is needed to sort heavyweight and lightweight tags together
> on epoch in "summary" and "tags" views in gitweb. (It is not
> needed for heads/branches, but it is the tags sorting that
> cripples gitweb "summary" view performance.)

I guess something like this, but I haven't tested it heavily.
If you want it in "next" please ack (with necessary fix-up
patches if any).

-- >8 --
[PATCH] for-each-ref: epoch and epochdate

This adds "epoch" (which is parallel to "tagger" or "committer")
and "epochdate" (corresponds to "taggerdate" and
"committerdate").

As other "date" fields, "epochdate" sorts numerically
and displays human readably

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 698618b..3dc68cc 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -59,6 +59,8 @@ static struct {
 	{ "taggername" },
 	{ "taggeremail" },
 	{ "taggerdate", FIELD_TIME },
+	{ "epoch" },
+	{ "epochdate", FIELD_TIME },
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
@@ -401,6 +403,29 @@ static void grab_person(const char *who,
 		else if (!strcmp(name + wholen, "date"))
 			grab_date(wholine, v);
 	}
+
+	/* For a tag or a commit object, if "epoch" or "epochdate" is
+	 * requested, do something special.
+	 */
+	if (strcmp(who, "tagger") && strcmp(who, "committer"))
+		return; /* "author" for commit object is not wanted */
+	if (!wholine)
+		wholine = find_wholine(who, wholen, buf, sz);
+	if (!wholine)
+		return;
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &val[i];
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+
+		if (!strcmp(name, "epochdate"))
+			grab_date(wholine, v);
+		else if (!strcmp(name, "epoch"))
+			v->s = copy_line(wholine);
+	}
 }
 
 static void find_subpos(const char *buf, unsigned long sz, const char **sub, const char **body)
