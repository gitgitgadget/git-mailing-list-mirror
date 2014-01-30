From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 02/17] trailer: process trailers from file and arguments
Date: Thu, 30 Jan 2014 07:49:05 +0100
Message-ID: <20140130064921.7504.60878.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 08:38:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8mCY-0005DS-9o
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 08:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbaA3HiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 02:38:09 -0500
Received: from [194.158.98.45] ([194.158.98.45]:37367 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751107AbaA3HiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 02:38:05 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 796545F;
	Thu, 30 Jan 2014 08:37:38 +0100 (CET)
X-git-sha1: ef012f26acd53ebd1db7a59e27534833dda64fdb 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140130064217.7504.473.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241243>

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
index aed25e1..e9ccfa5 100644
--- a/trailer.c
+++ b/trailer.c
@@ -46,3 +46,192 @@ static size_t alnum_len(const char *buf, size_t len)
 	while (--len >= 0 && !isalnum(buf[len]));
 	return len + 1;
 }
+
+static void add_arg_to_infile(struct trailer_item *infile_tok,
+			      struct trailer_item *arg_tok)
+{
+	if (arg_tok->conf->where == WHERE_AFTER) {
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
+		infile_tok = (where == WHERE_AFTER) ? infile_tok->previous : infile_tok->next;
+	} while (check_all);
+	return 1;
+}
+
+static void apply_arg_if_exist(struct trailer_item *infile_tok,
+			       struct trailer_item *arg_tok,
+			       int alnum_len)
+{
+	switch (arg_tok->conf->if_exist) {
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
+			if ((where == WHERE_AFTER ? infile_tok->next : infile_tok->previous) == arg_tok)
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
+	switch (arg_tok->conf->if_missing) {
+	case MISSING_DO_NOTHING:
+		free(arg_tok);
+		break;
+	case MISSING_ADD:
+		where = arg_tok->conf->where;
+		infile_tok = (where == WHERE_AFTER) ? infile_tok_last : infile_tok_first;
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
+		process_infile_tok(infile_tok, arg_tok_first, WHERE_AFTER);
+	}
+
+	update_last(infile_tok_last);
+
+	if (!*arg_tok_first)
+		return;
+
+	/* Process infile from start to end */
+	for (infile_tok = *infile_tok_first; infile_tok; infile_tok = infile_tok->next) {
+		process_infile_tok(infile_tok, arg_tok_first, WHERE_BEFORE);
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
1.8.5.2.201.gacc5987
