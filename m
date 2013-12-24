From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/9] trailer: process trailers from file and arguments
Date: Tue, 24 Dec 2013 07:37:18 +0100
Message-ID: <20131224063726.19560.26042.chriscool@tuxfamily.org>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 24 07:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvLeQ-00026m-DH
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 07:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097Ab3LXGik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 01:38:40 -0500
Received: from [194.158.98.14] ([194.158.98.14]:50270 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985Ab3LXGii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 01:38:38 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 7A2F346;
	Tue, 24 Dec 2013 07:38:17 +0100 (CET)
X-git-sha1: 0c04cfd5e869c1e56bd0de0aaa66d7cc982ac8a8 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239665>

This patch implements the logic that process trailers
from file and arguments.

At the beginning trailers from file are in their own
infile_tok doubly linked list, and trailers from
arguments are in their own arg_tok doubly linked list.

The lists are traversed and when an arg_tok should be
"applied", it is removed from its list and inserted
into the infile_tok list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/trailer.c b/trailer.c
index ccbcfb0..bd6595d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -45,3 +45,192 @@ static size_t alnum_len(const char *buf, size_t len) {
 	while (--len >= 0 && !isalnum(buf[len]));
 	return len + 1;
 }
+
+static void add_arg_to_infile(struct trailer_item *infile_tok,
+			      struct trailer_item *arg_tok)
+{
+	if (arg_tok->conf->where == AFTER) {
+		arg_tok->next = infile_tok->next;
+		infile_tok->next = arg_tok;
+		arg_tok->previous = infile_tok;
+		if (arg_tok->next)
+			arg_tok->next->previous = arg_tok;
+	} else {
+		arg_tok->previous = infile_tok->previous;
+		infile_tok->previous = arg_tok;
+		arg_tok->next = infile_tok;
+		if (arg_tok->previous)
+			arg_tok->previous->next = arg_tok;
+	}
+}
+
+static int check_if_different(struct trailer_item *infile_tok,
+			      struct trailer_item *arg_tok,
+			      int alnum_len, int check_all)
+{
+	enum action_where where = arg_tok->conf->where;
+	do {
+		if (!infile_tok)
+			return 1;
+		if (same_trailer(infile_tok, arg_tok, alnum_len))
+			return 0;
+		/*
+		 * if we want to add a trailer after another one,
+		 * we have to check those before this one
+		 */
+		infile_tok = (where == AFTER) ? infile_tok->previous : infile_tok->next;
+	} while (check_all);
+	return 1;
+}
+
+static void apply_arg_if_exist(struct trailer_item *infile_tok,
+			       struct trailer_item *arg_tok,
+			       int alnum_len)
+{
+	switch(arg_tok->conf->if_exist) {
+	case EXIST_DO_NOTHING:
+		free(arg_tok);
+		break;
+	case EXIST_OVERWRITE:
+		free((char *)infile_tok->value);
+		infile_tok->value = xstrdup(arg_tok->value);
+		free(arg_tok);
+		break;
+	case EXIST_ADD:
+		add_arg_to_infile(infile_tok, arg_tok);
+		break;
+	case EXIST_ADD_IF_DIFFERENT:
+		if (check_if_different(infile_tok, arg_tok, alnum_len, 1))
+			add_arg_to_infile(infile_tok, arg_tok);
+		else
+			free(arg_tok);
+		break;
+	case EXIST_ADD_IF_DIFFERENT_NEIGHBOR:
+		if (check_if_different(infile_tok, arg_tok, alnum_len, 0))
+			add_arg_to_infile(infile_tok, arg_tok);
+		else
+			free(arg_tok);
+		break;
+	}
+}
+
+static void remove_from_list(struct trailer_item *item,
+			     struct trailer_item **first)
+{
+	if (item->next)
+		item->next->previous = item->previous;
+	if (item->previous)
+		item->previous->next = item->next;
+	else
+		*first = item->next;
+}
+
+static struct trailer_item *remove_first(struct trailer_item **first)
+{
+	struct trailer_item *item = *first;
+	*first = item->next;
+	if (item->next) {
+		item->next->previous = NULL;
+		item->next = NULL;
+	}
+	return item;
+}
+
+static void process_infile_tok(struct trailer_item *infile_tok,
+			       struct trailer_item **arg_tok_first,
+			       enum action_where where)
+{
+	struct trailer_item *arg_tok;
+	struct trailer_item *next_arg;
+
+	int tok_alnum_len = alnum_len(infile_tok->token, strlen(infile_tok->token));
+	for (arg_tok = *arg_tok_first; arg_tok; arg_tok = next_arg) {
+		next_arg = arg_tok->next;
+		if (same_token(infile_tok, arg_tok, tok_alnum_len) &&
+		    arg_tok->conf->where == where) {
+			/* Remove arg_tok from list */
+			remove_from_list(arg_tok, arg_tok_first);
+			/* Apply arg */
+			apply_arg_if_exist(infile_tok, arg_tok, tok_alnum_len);
+			/*
+			 * If arg has been added to infile,
+			 * then we need to process it too now.
+			 */
+			if ((where == AFTER ? infile_tok->next : infile_tok->previous) == arg_tok)
+				infile_tok = arg_tok;
+		}
+	}
+}
+
+static void update_last(struct trailer_item **last)
+{
+	if (*last)
+		while((*last)->next != NULL)
+			*last = (*last)->next;
+}
+
+static void update_first(struct trailer_item **first)
+{
+	if (*first)
+		while((*first)->previous != NULL)
+			*first = (*first)->previous;
+}
+
+static void apply_arg_if_missing(struct trailer_item **infile_tok_first,
+				 struct trailer_item **infile_tok_last,
+				 struct trailer_item *arg_tok)
+{
+	struct trailer_item **infile_tok;
+	enum action_where where;
+
+	switch(arg_tok->conf->if_missing) {
+	case MISSING_DO_NOTHING:
+		free(arg_tok);
+		break;
+	case MISSING_ADD:
+		where = arg_tok->conf->where;
+		infile_tok = (where == AFTER) ? infile_tok_last : infile_tok_first;
+		if (*infile_tok) {
+			add_arg_to_infile(*infile_tok, arg_tok);
+			*infile_tok = arg_tok;
+		} else {
+			*infile_tok_first = arg_tok;
+			*infile_tok_last = arg_tok;
+		}
+		break;
+	}
+}
+
+static void process_trailers_lists(struct trailer_item **infile_tok_first,
+				   struct trailer_item **infile_tok_last,
+				   struct trailer_item **arg_tok_first)
+{
+	struct trailer_item *infile_tok;
+	struct trailer_item *arg_tok;
+
+	if (!*arg_tok_first)
+		return;
+
+	/* Process infile from end to start */
+	for (infile_tok = *infile_tok_last; infile_tok; infile_tok = infile_tok->previous) {
+		process_infile_tok(infile_tok, arg_tok_first, AFTER);
+	}
+
+	update_last(infile_tok_last);
+
+	if (!*arg_tok_first)
+		return;
+
+	/* Process infile from start to end */
+	for (infile_tok = *infile_tok_first; infile_tok; infile_tok = infile_tok->next) {
+		process_infile_tok(infile_tok, arg_tok_first, BEFORE);
+	}
+
+	update_first(infile_tok_first);
+
+	/* Process args left */
+	while (*arg_tok_first) {
+		arg_tok = remove_first(arg_tok_first);
+		apply_arg_if_missing(infile_tok_first, infile_tok_last, arg_tok);
+	}
+}
-- 
1.8.4.1.616.g07f5c81
