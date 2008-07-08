From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Build in merge
Date: Mon, 07 Jul 2008 17:53:23 -0700
Message-ID: <7v1w25yz5o.fsf@gitster.siamese.dyndns.org>
References: <7vhcb14l3m.fsf@gitster.siamese.dyndns.org>
 <1215474140-11220-1-git-send-email-vmiklos@frugalware.org>
 <7v63rhz03x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "To: Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 02:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG1Ta-0000du-TY
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 02:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbYGHAxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbYGHAxi
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 20:53:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbYGHAxh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 20:53:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D0E026ED9;
	Mon,  7 Jul 2008 20:53:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C732126ED2; Mon,  7 Jul 2008 20:53:27 -0400 (EDT)
In-Reply-To: <7v63rhz03x.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Jul 2008 17:32:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B308406-4C88-11DD-997B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87674>

Junio C Hamano <gitster@pobox.com> writes:

> That is not what I meant.  I am afraid perhaps I misunderstood what you
> were talking about.
> ...
> The comparison I gave was between the above two.  But the change you are
> talking about is completely different, isn't it?
>
> The part that records which strategies were specified from the command
> line *in what order* via "-s foo" switches should remain list of pointers
> into "struct strategy", which is called "struct strategy **use_strategies"
> in the code and corresponds to the $use_strategies variable in the
> scripted version.

Here is what I meant to suggest; sorry for confusing you with an initial
typo of having only one pointer in front of use_strategies "array of
pointers".  Applies on top of your previous round.

--

 builtin-merge.c |   58 +++++++++++++++++++++++++++---------------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 7312997..b2e702a 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -44,7 +44,7 @@ static int allow_trivial = 1, have_message;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
 static unsigned char head[20], stash[20];
-static struct strategy *use_strategies;
+static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char *branch;
 
@@ -74,44 +74,44 @@ static int option_parse_message(const struct option *opt,
 	return 0;
 }
 
-static int strategy_lookup(const char *path)
+static struct strategy *get_strategy(const char *name)
 {
 	int i;
 
-	if (!path)
-		return -1;
+	if (!name)
+		return NULL;
 
 	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
-		if (!strcmp(path, all_strategy[i].name))
-			return all_strategy[i].attr;
-	return -1;
+		if (!strcmp(name, all_strategy[i].name))
+			return &all_strategy[i];
+	return NULL;
 }
 
-static inline void append_strategy(const char *name, unsigned attr)
+static void append_strategy(struct strategy *s)
 {
 	ALLOC_GROW(use_strategies, use_strategies_nr + 1, use_strategies_alloc);
-	use_strategies[use_strategies_nr].name = name;
-	use_strategies[use_strategies_nr++].attr = attr;
+	use_strategies[use_strategies_nr++] = s;
 }
 
 static int option_parse_strategy(const struct option *opt,
-	const char *arg, int unset)
+				 const char *name, int unset)
 {
-	int i, attr;
+	int i;
+	struct strategy *s;
 
 	if (unset)
 		return 0;
 
-	attr = strategy_lookup(arg);
+	s = get_strategy(name);
 
-	if (attr >= 0)
-		append_strategy(arg, attr);
+	if (s)
+		append_strategy(s);
 	else {
 		struct strbuf err;
 		strbuf_init(&err, 0);
 		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
 			strbuf_addf(&err, " %s", all_strategy[i].name);
-		fprintf(stderr, "Could not find merge strategy '%s'.\n", arg);
+		fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
 		fprintf(stderr, "Available strategies are:%s.\n", err.buf);
 		exit(1);
 	}
@@ -643,18 +643,18 @@ static void add_strategies(const char *string, unsigned attr)
 	split_merge_strategies(string, &list, &list_nr, &list_alloc);
 	if (list != NULL) {
 		for (i = 0; i < list_nr; i++) {
-			int attr;
+			struct strategy *s;
 
-			attr = strategy_lookup(list[i].name);
-			if (attr >= 0)
-				append_strategy(list[i].name, attr);
+			s = get_strategy(list[i].name);
+			if (s)
+				append_strategy(s);
 		}
 		return;
 	}
 	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
 		if (all_strategy[i].attr & attr)
-			append_strategy(all_strategy[i].name,
-				all_strategy[i].attr);
+			append_strategy(&all_strategy[i]);
+
 }
 
 static int merge_trivial(void)
@@ -903,9 +903,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < use_strategies_nr; i++) {
-		if (use_strategies[i].attr & NO_FAST_FORWARD)
+		if (use_strategies[i]->attr & NO_FAST_FORWARD)
 			allow_fast_forward = 0;
-		if (use_strategies[i].attr & NO_TRIVIAL)
+		if (use_strategies[i]->attr & NO_TRIVIAL)
 			allow_trivial = 0;
 	}
 
@@ -1043,14 +1043,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 		if (use_strategies_nr != 1)
 			printf("Trying merge strategy %s...\n",
-				use_strategies[i].name);
+				use_strategies[i]->name);
 		/*
 		 * Remember which strategy left the state in the working
 		 * tree.
 		 */
-		wt_strategy = use_strategies[i].name;
+		wt_strategy = use_strategies[i]->name;
 
-		ret = try_merge_strategy(use_strategies[i].name,
+		ret = try_merge_strategy(use_strategies[i]->name,
 			common, head_arg);
 		if (!option_commit && !ret) {
 			merge_was_ok = 1;
@@ -1072,7 +1072,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				int cnt = evaluate_result();
 
 				if (best_cnt <= 0 || cnt <= best_cnt) {
-					best_strategy = use_strategies[i].name;
+					best_strategy = use_strategies[i]->name;
 					best_cnt = cnt;
 				}
 			}
@@ -1106,7 +1106,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				"No merge strategy handled the merge.\n");
 		else
 			fprintf(stderr, "Merge with strategy %s failed.\n",
-				use_strategies[0].name);
+				use_strategies[0]->name);
 		return 2;
 	} else if (best_strategy == wt_strategy)
 		; /* We already have its result in the working tree. */
