From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v11 02/11] trailer: process trailers from input message and
 arguments
Date: Fri, 25 Apr 2014 21:06:53 +0200
Message-ID: <20140425190703.28550.7233.chriscool@tuxfamily.org>
References: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:08:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlTc-0003SZ-Bi
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbaDYTHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:07:49 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:43417 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754585AbaDYTHp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:07:45 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 5372569;
	Fri, 25 Apr 2014 21:07:43 +0200 (CEST)
X-git-sha1: 9a9dd0ffd7366ff6f765cc3785fb028062f2670c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247095>

Implement the logic to process trailers from the input message
and from arguments.

At the beginning trailers from the input message are in their
own "in_tok" doubly linked list, and trailers from arguments
are in their own "arg_tok" doubly linked list.

The lists are traversed and when an "arg_tok" should be "applied",
it is removed from its list and inserted into the "in_tok" list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/trailer.c b/trailer.c
index db93a63..52108c2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -47,3 +47,201 @@ static size_t alnum_len(const char *buf, size_t len)
 		len--;
 	return len;
 }
+
+static void free_trailer_item(struct trailer_item *item)
+{
+	free(item->conf.name);
+	free(item->conf.key);
+	free(item->conf.command);
+	free((char *)item->token);
+	free((char *)item->value);
+	free(item);
+}
+
+static void add_arg_to_input_list(struct trailer_item *in_tok,
+				  struct trailer_item *arg_tok)
+{
+	if (arg_tok->conf.where == WHERE_AFTER) {
+		arg_tok->next = in_tok->next;
+		in_tok->next = arg_tok;
+		arg_tok->previous = in_tok;
+		if (arg_tok->next)
+			arg_tok->next->previous = arg_tok;
+	} else {
+		arg_tok->previous = in_tok->previous;
+		in_tok->previous = arg_tok;
+		arg_tok->next = in_tok;
+		if (arg_tok->previous)
+			arg_tok->previous->next = arg_tok;
+	}
+}
+
+static int check_if_different(struct trailer_item *in_tok,
+			      struct trailer_item *arg_tok,
+			      int alnum_len, int check_all)
+{
+	enum action_where where = arg_tok->conf.where;
+	do {
+		if (!in_tok)
+			return 1;
+		if (same_trailer(in_tok, arg_tok, alnum_len))
+			return 0;
+		/*
+		 * if we want to add a trailer after another one,
+		 * we have to check those before this one
+		 */
+		in_tok = (where == WHERE_AFTER) ? in_tok->previous : in_tok->next;
+	} while (check_all);
+	return 1;
+}
+
+static void apply_arg_if_exists(struct trailer_item *in_tok,
+				struct trailer_item *arg_tok,
+				int alnum_len)
+{
+	switch (arg_tok->conf.if_exists) {
+	case EXISTS_DO_NOTHING:
+		free_trailer_item(arg_tok);
+		break;
+	case EXISTS_OVERWRITE:
+		free((char *)in_tok->value);
+		in_tok->value = xstrdup(arg_tok->value);
+		free_trailer_item(arg_tok);
+		break;
+	case EXISTS_ADD:
+		add_arg_to_input_list(in_tok, arg_tok);
+		break;
+	case EXISTS_ADD_IF_DIFFERENT:
+		if (check_if_different(in_tok, arg_tok, alnum_len, 1))
+			add_arg_to_input_list(in_tok, arg_tok);
+		else
+			free_trailer_item(arg_tok);
+		break;
+	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
+		if (check_if_different(in_tok, arg_tok, alnum_len, 0))
+			add_arg_to_input_list(in_tok, arg_tok);
+		else
+			free_trailer_item(arg_tok);
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
+static void process_input_token(struct trailer_item *in_tok,
+				struct trailer_item **arg_tok_first,
+				enum action_where where)
+{
+	struct trailer_item *arg_tok;
+	struct trailer_item *next_arg;
+
+	int after = where == WHERE_AFTER;
+	int tok_alnum_len = alnum_len(in_tok->token, strlen(in_tok->token));
+
+	for (arg_tok = *arg_tok_first; arg_tok; arg_tok = next_arg) {
+		next_arg = arg_tok->next;
+		if (!same_token(in_tok, arg_tok, tok_alnum_len))
+			continue;
+		if (arg_tok->conf.where != where)
+			continue;
+		remove_from_list(arg_tok, arg_tok_first);
+		apply_arg_if_exists(in_tok, arg_tok, tok_alnum_len);
+		/*
+		 * If arg has been added to input,
+		 * then we need to process it too now.
+		 */
+		if ((after ? in_tok->next : in_tok->previous) == arg_tok)
+			in_tok = arg_tok;
+	}
+}
+
+static void update_last(struct trailer_item **last)
+{
+	if (*last)
+		while ((*last)->next != NULL)
+			*last = (*last)->next;
+}
+
+static void update_first(struct trailer_item **first)
+{
+	if (*first)
+		while ((*first)->previous != NULL)
+			*first = (*first)->previous;
+}
+
+static void apply_arg_if_missing(struct trailer_item **in_tok_first,
+				 struct trailer_item **in_tok_last,
+				 struct trailer_item *arg_tok)
+{
+	struct trailer_item **in_tok;
+	enum action_where where;
+
+	switch (arg_tok->conf.if_missing) {
+	case MISSING_DO_NOTHING:
+		free_trailer_item(arg_tok);
+		break;
+	case MISSING_ADD:
+		where = arg_tok->conf.where;
+		in_tok = (where == WHERE_AFTER) ? in_tok_last : in_tok_first;
+		if (*in_tok) {
+			add_arg_to_input_list(*in_tok, arg_tok);
+			*in_tok = arg_tok;
+		} else {
+			*in_tok_first = arg_tok;
+			*in_tok_last = arg_tok;
+		}
+		break;
+	}
+}
+
+static void process_trailers_lists(struct trailer_item **in_tok_first,
+				   struct trailer_item **in_tok_last,
+				   struct trailer_item **arg_tok_first)
+{
+	struct trailer_item *in_tok;
+	struct trailer_item *arg_tok;
+
+	if (!*arg_tok_first)
+		return;
+
+	/* Process input from end to start */
+	for (in_tok = *in_tok_last; in_tok; in_tok = in_tok->previous)
+		process_input_token(in_tok, arg_tok_first, WHERE_AFTER);
+
+	update_last(in_tok_last);
+
+	if (!*arg_tok_first)
+		return;
+
+	/* Process input from start to end */
+	for (in_tok = *in_tok_first; in_tok; in_tok = in_tok->next)
+		process_input_token(in_tok, arg_tok_first, WHERE_BEFORE);
+
+	update_first(in_tok_first);
+
+	/* Process args left */
+	while (*arg_tok_first) {
+		arg_tok = remove_first(arg_tok_first);
+		apply_arg_if_missing(in_tok_first, in_tok_last, arg_tok);
+	}
+}
-- 
1.9.1.636.g20d5f34
